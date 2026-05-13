# Reactive cleanup

Two contained code-health changes applied to [app.R](../app.R) and two
source files under [source/](../source). Companion to
[PERFORMANCE.md](PERFORMANCE.md).

## 1. Removed `observe(input$xxx)` calls nested inside other reactives

### What was wrong

Many reactive bodies contained lines like:

```r
RelevelFile1 <- reactive({
  ...
  observe(input$addVarsOpt)   # <-- nested observer inside a reactive
  ...
})
```

The author's intent was almost certainly *"make this reactive depend on
`input$addVarsOpt`"*. But `observe()` does not establish a dependency in
the enclosing reactive. What it actually does:

1. Each time the outer reactive runs, **a brand-new observer is
   created** with `input$addVarsOpt` as its dependency.
2. The new observer's body is the bare expression `input$addVarsOpt` —
   it does nothing.
3. The observer is **never destroyed** for the lifetime of the session,
   because nothing holds a reference to it. Shiny's garbage collector
   only frees observers that are tied to a destination domain (output,
   reactive, etc.). Orphaned observers stay alive.

So every fire of the outer reactive leaves another empty observer in
memory, all still listening for `input$addVarsOpt` to change. Over a
session this is a slow memory leak and adds work to every input
invalidation.

Inside an `eventReactive()` the bug is even more obvious: `eventReactive`
*only* invalidates on its trigger (e.g. `input$varsDone`) regardless of
what happens in the body, so the nested `observe()` cannot achieve the
intended dependency at all — it is pure dead code with a leak attached.

### The fix

Every such call has been deleted. The dependencies that the outer
reactive actually relies on were already established by the surrounding
code (the reactive body reads the input via plain references like
`input$addVarsOpt == "Yes"`), so removing the lines does not change
behaviour — it just stops creating ghost observers.

### Sites cleaned up

| File | Original line | Pattern |
| --- | --- | --- |
| [app.R](../app.R) | inside `RelevelFile1 <- reactive(...)` | `observe(input$addVarsOpt)` |
| [app.R](../app.R) | inside `RelevelFile1.2 <- reactive(...)` | `observe(input$addVarsOpt)` |
| [src01e_GraphTypeChoices.R](../source/src01e_GraphTypeChoices.R) | inside `FacVars <- eventReactive(...)` | `observe(input$facetingOpt)` |
| [src01e_GraphTypeChoices.R](../source/src01e_GraphTypeChoices.R) | inside `output$GpforRelevel <- renderText(...)` | `observe(input$addVarsOpt)` |
| [src01e_GraphTypeChoices.R](../source/src01e_GraphTypeChoices.R) | inside `selVarsReLevelGp <- eventReactive(...)` | `observe(input$addVarsOpt)` |
| [src01e_GraphTypeChoices.R](../source/src01e_GraphTypeChoices.R) | inside `CatGp <- eventReactive(...)` | `observe({ input$addVarsOpt })` |
| [src01e_GraphTypeChoices.R](../source/src01e_GraphTypeChoices.R) | inside `ShapeLevs <- eventReactive(...)` | `observe({ input$ShapesOpt })` |
| [src01e_GraphTypeChoices.R](../source/src01e_GraphTypeChoices.R) | inside `output$ShapeLevs <- renderText(...)` | `observe(input$varsDone)` |
| [src03b_emmeans.R](../source/src03b_emmeans.R) | 11 instances inside `reactive(...)`, `renderUI(...)`, `render_gt(...)` | `observe(c(input$emm_type, input$addVarsOpt))` and similar |

Total: **19 orphan observers removed.**

A quick way to confirm none remain:

```sh
grep -rn 'observe(input$\|observe({input$\|observe({c(input$\|observe(c(input$' app.R source/ | grep -v '^.*:[[:space:]]*#'
# (no output expected)
```

## 2. Collapsed paired `graphType` / `Xnum` observers in app.R

### What was wrong

The server function had 12 single-purpose observers in 6 pairs, all
keyed on the same input. Example:

```r
observe({                                            # observer #1
  if (input$graphType == "Point & Errorbar")
    updateNumericInput("sym_size", value = 5, ...)
})
observe({                                            # observer #2
  if (input$graphType != "Point & Errorbar")
    updateNumericInput("sym_size", value = 3, ...)
})
```

Both observers re-fire on every change of `input$graphType`, but only
one ever does work. The other evaluates its `if` condition to `FALSE`
and exits. The pattern is repeated for `colpal`, `box_alpha`,
`sym_size`, `sym_alpha`, `sym_jitter`, and `text_angle`.

### The fix

Each pair has been collapsed into a single observer using `if`/`else`
or a single computed value. The semantics are preserved exactly —
including the deliberate **no-op zone** for `box_alpha` when
`graphType` is `"Numeric XY 1"` or `"Numeric XY 2"`, where the
original code intentionally did not update the input (neither observer
in the pair fired). The new version uses `else if` so that case still
falls through with no update.

The three Point & Errorbar pairs (`sym_size`, `sym_alpha`,
`sym_jitter`) shared an identical trigger, so they were merged into a
single observer that updates all three inputs in one pass.

### Result

| Before | After |
| --- | --- |
| 12 observers in 6 pairs | 4 single observers |
| each `input$graphType` change → 10 observers re-run | each `input$graphType` change → 3 observers re-run |
| ~155 lines | ~30 lines |

See [app.R:470-524](../app.R#L470-L524).

## Things deliberately *not* changed in this pass

- The observers in [src01f_Optional_GraphSettings.R](../source/src01f_Optional_GraphSettings.R)
  and the three terminal observers in [src03b_emmeans.R](../source/src03b_emmeans.R)
  (which switch `emm_type` choices based on the design). These are
  legitimate top-level `observe({...})` blocks — not nested inside
  another reactive — and they do real work in the body.
- `bindCache()` on `output$plotChosenGraph` — still worth doing
  separately when you next look at plot-update latency.

## How to verify behaviour after this change

There are no automated tests for the app, so manual smoke test:

1. `shiny::runApp(".")`.
2. Click **Start** without uploading anything (loads the default
   `cell_death.csv`).
3. Pick X-axis, Y-axis, click **Done with variables**.
4. Cycle through every `graphType`: Boxplot, Bar graph, Violin plot,
   Point & Errorbar, Density plot, Histogram plot, Numeric XY 1,
   Numeric XY 2. Confirm `box_alpha`, `sym_size`, `sym_alpha`,
   `sym_jitter`, `text_angle`, and `colpal` defaults change as
   expected (or stay put for the Numeric XY box_alpha case).
5. Run an ANOVA and toggle `emm_type` between Pairwise / Levelwise /
   Compare-to-reference. Confirm the formulas and tables still
   compute.
6. Toggle `addVarsOpt` between Yes / No and confirm the relevel
   selectors still update.
