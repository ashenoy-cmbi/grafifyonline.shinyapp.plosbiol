# Performance notes

This document explains the startup-time optimisation applied to [app.R](../app.R).

## Symptom

Initial connection to the app (the first paint after navigating to the
website) felt slow, especially on shinyapps.io.

## Root cause

The server function in `app.R` was sourcing **27 R files** on every new
session:

```r
server <- function(input, output, session) {
  ...
  source("./source/src01e_GraphTypeChoices.R", local = TRUE, echo = TRUE)
  source("./source/src01f_Optional_GraphSettings.R", local = TRUE)
  source("./source/src02_headers_help.R",  local = TRUE, echo = TRUE)
  ...  # 24 more
}
```

Two costs were paid per new visitor:

1. **Re-parsing** — `source()` re-parses the file each time it is called.
   R's parser is not free, and across ~5000 lines of code spread over 27
   files the cost adds up on the cold-connect path.
2. **`echo = TRUE`** — most of those calls also echoed every parsed
   expression back to the R console, which is pure I/O overhead in
   production (and console spam).

Both costs were on the critical path between a user hitting the URL and
the WebSocket session being ready to receive input.

## Fix

The 27 source files are now **parsed once at app boot** into a list of
expression objects, and the per-session server function just `eval()`s
those pre-parsed expressions in its own local environment.

```r
# At app startup (top level of app.R):
srvr_src_files <- c(
  "./source/src01e_GraphTypeChoices.R",
  "./source/src01f_Optional_GraphSettings.R",
  ...
)
srvr_src_exprs <- setNames(
  lapply(srvr_src_files, function(f) parse(file = f, keep.source = FALSE)),
  srvr_src_files
)
load_srv <- function(path) {
  eval(srvr_src_exprs[[path]], envir = parent.frame())
}

# Inside server():
server <- function(input, output, session) {
  ...
  load_srv("./source/src01e_GraphTypeChoices.R")
  load_srv("./source/src01f_Optional_GraphSettings.R")
  ...
}
```

### Why this is safe

- `source(file, local = TRUE)` is conceptually `parse()` + `eval()` in
  the caller's environment. We split the two steps: parse once, eval
  many times.
- `eval(..., envir = parent.frame())` evaluates the expression in the
  caller's environment, which is `server()`'s local scope. Reactives
  defined inside the sourced files (`FacVars <- eventReactive(...)`,
  `output$boxPlot_out <- renderPlot(...)`, etc.) still get bound to the
  per-session `input` / `output` / `session` exactly as before.
- Expression objects in R are immutable; sharing them across sessions
  is fine — each session gets its own evaluation, its own reactives,
  its own bindings.
- `echo = TRUE` is dropped. It was only useful for development.

### Files left untouched

The four `source()` calls at the **top of `app.R`** (UI setup —
`src01e_menu_links.R`, `src01eFeb08_mainbar_parts.R`,
`src01g_Help_n_Images.R`, `src01e_landing_page_bulletlist.R`) are
unchanged. They already run only once at app boot, so they do not
affect per-session connect time.

## Things deliberately *not* changed

These are real optimisations but they target other symptoms, not the
"website call feels slow" one:

- **`bindCache()` / `renderCachedPlot()`** — would speed up *plot
  updates* (the user clicks "Make graph" again with the same inputs),
  not the initial connect. Worth doing later if plot regeneration
  feels slow.
- **Merging the paired `observe()` blocks** in `app.R` (e.g.
  `graphType == "Violin plot"` vs `!= "Violin plot"`) — they could
  collapse into single observers, but the win is small and the risk
  of subtly changing reactive timing is non-trivial.
- **Rewriting in C++ / multi-threading R** — the heavy work is already
  in compiled code under `grafify` / `ggplot2` / `lmerTest` / `emmeans`.
  The Shiny app is a UI wrapper; rewriting it would be months of work
  for negligible gain.

## If startup still feels slow after this

Profile the cold connect with `profvis`:

```r
profvis::profvis(shiny::runApp("."))
# then open the app in a browser
```

Look for time spent inside `server()` on first-session setup. Likely
remaining suspects:

- Package load time (`library(grafify)` etc. at the top of `app.R`).
  Use `requireNamespace()` + `::` for libraries used in only one
  source file, deferring their load until a session actually triggers
  that code path.
- `includeHTML("source/head_copilot.html")` — currently re-read from
  disk on every UI build. Cache the contents in a string at app boot
  if it shows up in the profile.
- Bootstrap / theme assets (page weight, not server time) — inspect
  the network tab in the browser.
