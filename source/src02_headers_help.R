# effi - start
output$dataHelpOpen <- renderText({
  HTML(paste0(tags$div(
    
    tags$h4("Quick Instructions"),
    tags$h6("(If using `grafify` for the first time, please read the full Instructions from the navigation bar. These steps are for users already somewhat familiar with the app.)"),
    
    tags$ol(
      
      tags$li(
        "Upload your data using the 'Start here' panel (top right). ",
        "You can upload a CSV/Excel file or click ", tags$strong("'Start'"), " to use example data. ",
        "If unsure about long-format tables, see ", tags$strong("Instructions"), "."
      ),
      
      tags$li(
        "If formatting is correct a data preview will appear. Column names will be updated automatically to remove unallowed characters  (no spaces/special characters in column names). ",
        "Variable names will populate dropdowns in ", tags$strong("Boxes 1–3"), "."
      ),
      
      tags$li(
        "Select variables in ", tags$strong("Boxes 1–3"), "."
      ),
      
      tags$li(
        tags$strong("Box 1: "),
        "Select the X-axis variable (usually categorical, e.g., Genotype or Treatment). ",
        "Numeric variables (e.g., time, concentration) can also be used."
      ),
      
      tags$li(
        tags$strong("Box 2: "),
        "Select the Y-axis variable (must be numeric). ",
        "This is the response/dependent variable."
      ),
      
      tags$li(
        tags$strong("Boxes 3 and 3.1: "),
        "Optional grouping variable (for two-way ANOVA). ",
        "Choose 'Yes' in Box 3, then select a variable in Box 3.1.",
        tags$br(),
        tags$strong("Note: "),
        "If X (Box 1) is numeric, a grouping variable is required."
      ),
      
      tags$li(
        "Selected variables are used in both Graphs and ANOVA analyses."
      ),
      
      tags$li(
        "Go to the 'Graphs' tab and choose options in ", tags$strong("Boxes 4–8"), "."
      ),
      
      tags$li(
        tags$strong("Example data description: "),
        "Cell death (%) over time in CONTROL vs CASP4 miRNA-expressing cells. ",
        "Experiments were repeated 5 times (Exp_no). ",
        "Time_h_num is numeric; Time_h is categorical - they will give different results in the analyses."
      ),
      
      tags$li(
        tags$strong("Example option 1: "),
        "Box 1: miRNA, Box 2: Cell_death_percent; Box 3: No; ",
        "Box 4: Time_h; Box 5: optional."
      ),
      
      tags$li(
        tags$strong("Example option 2: "),
        "Box 1: Time_h, Box 2: Cell_death_percent; ",
        "Box 3: Yes (miRNA); Box 4: No."
      ),
      
      tags$li(
        tags$strong("Example option 3: "),
        "Box 1: Time_h_num (numeric), Box 2: Cell_death_percent; ",
        "Box 3: Yes (miRNA)."
      ),
      
      tags$li(
        "After selecting variables, click ", tags$strong("'Variables chosen'"),
        ", then click ", tags$strong("'grafify my data'"), " to plot graphs."
      ),
      
      tags$li(
        "See further instructions on Graphs and ANOVAs tabs."
      )
      
    )
  )))
})

output$graphsHelpOpen <- renderText({
  HTML(paste0(tags$div(
    
    tags$ol(
      
      tags$li(
        "Choose optional variables (Boxes 4–5) and graph settings (Boxes 6–8). ",
        "Variables must be selected first in Boxes 1–3."
      ),
      
      tags$li(
        tags$strong("Boxes 4 and 4.1: "),
        "Faceting variables split the graph into panels. ",
        "Select 'Yes' in Box 4, then choose variables in Box 4.1.",
        tags$br(),
        tags$strong("Note: "),
        "Faceting affects graph appearance only - not the ANOVA result."
      ),
      
      tags$li(
        tags$strong("Boxes 5 and 5.1: "),
        "Choose a Shapes/Matching variable (optional). ",
        "Matching variables are required for Before-after plots.",
        tags$br(),
        "Up to 25 groups are allowed for shapes."
      ),
      
      tags$li(
        "Click ", tags$strong("'Variables chosen'"),
        " to enable graph types in Box 6."
      ),
      
      tags$li(
        tags$strong("Box 6: "),
        "Select a graph type and click ", tags$strong("'grafify my data'"),
        " to plot."
      ),
      
      tags$li(
        tags$strong("Boxes 7.1 and 7.2: "),
        "Reorder or drop groups.",
        tags$br(),
        tags$strong("Note: "),
        "Dropped groups are excluded from ANOVA analyses."
      ),
      
      tags$li(
        tags$strong("Numeric X-Y case: "),
        "Additional options appear to show means/medians, dispersion, and smoothing (loess/linear)."
      ),
      
      tags$li(
        tags$strong("Box 8: "),
        "Adjust appearance (colours, fonts, transparency, log scale, etc.)."
      ),
      
      tags$li(
        tags$strong("Note: "),
        "After any change, click ", tags$strong("'grafify my data'"),
        " to update the graph."
      ),
      
      tags$li(
        "Download graphs as PDF using ", tags$strong("'Save as PDF'"), ". ",
        "Increase width/height for a better layout."
      ),
      
      tags$li(
        tags$strong("Tip: "),
        "Large graphs may look compressed on screen but export correctly with larger PDF size."
      ),
      
      tags$li(
        tags$strong("Log scale: "),
        "If applied, log-transformed data are used in ANOVA."
      ),
      
      tags$li(
        "To run analyses, go to the ANOVA tab and choose options in ",
        tags$strong("Boxes 9–10"), "."
      )
      
    )
  )))
})

output$ANOVAsHelpOpen <- renderText({
  HTML(paste0(tags$div(
    
    tags$ol(
      
      tags$li(
        "ANOVA and post-hoc comparisons are available after choosing variables on the 'Graphs' tab and clicking ",
        tags$strong("'Variables chosen'"), " and ", tags$strong("'grafify my data'"), 
        "These step are required even if you are only interested in analyses and not plotting."
      ),
      
      tags$li(
        tags$strong("Box 9: "),
        "Choose the analysis type (Simple or Mixed effects), then click ",
        tags$strong("'Analyse my data'"), " to view results."
      ),
      
      tags$li(
        tags$strong("Boxes 9.1 and 9.2: "),
        "These options appear when 'Mixed' is selected.",
        tags$br(),
        "Mixed models require a random factor (e.g., experiment, matching, repeated measures) selected in Box 9.1."
      ),
      
      tags$li(
        "You can choose whether values within levels of the random factor are averaged (Box 9.2). ",
        "See Instructions for details on handling technical replicates."
      ),
      
      tags$li(
        "If you change variables (Boxes 1–3) or apply log-transformation (Box 8), ",
        "click ", tags$strong("'Variables chosen'"), " on the Graphs tab, then click ",
        tags$strong("'Analyse my data'"), " to update results."
      ),
      
      tags$li(
        tags$strong("Model diagnostics:"),
        tags$br(),
        tags$strong("QQ plot: "),
        "Points close to the diagonal line suggest approximately normal residuals and a good model fit. ",
        "Large deviations may indicate a poor fit.",
        tags$br(),
        tags$strong("Density plot: "),
        "Residuals should be roughly symmetric around 0.",
        tags$br(),
        "Proceed to post-hoc comparisons if diagnostics are acceptable."
      ),
      
      tags$li(
        tags$strong("Box 10: "),
        "Select post-hoc comparisons: 'Pairwise', 'Compare to reference', or 'Levelwise'. ",
        "See Instructions for details."
      ),
      
      tags$li(
        "The ", tags$strong("'Linear Model'"), " tab shows the model summary, including formula, ",
        "fixed/random variables, and transformations."
      ),
      
      tags$li(
        "The ", tags$strong("'Data used for analyses'"), " tab shows the dataset used in the model."
      ),
      
      tags$li(
        tags$strong("Suggested example: "),
        "Use ANOVA with example options 2 or 3.",
        tags$br(),
        "Example 1 is not appropriate because no grouping variable was selected (Box 3) even though the experiment design included one. ",
        "Faceting (Box 4) does not affect analysis.",
        tags$br(),
        "For Mixed models, use Exp_no as the random factor (Box 9.1). ",
        "There are no technical replicates, so averaging (Box 9.2) has little effect.",
        tags$br(),
        "Use Levelwise - Grouping variable or Levelwise - X-variable for post-hoc comparisons."
      )
      
    )
    
  )))
})

# effi - end

output$tab_header <- renderText({ #in use Data tab
  if (input$startBtn > 0) {
    HTML(paste0("<h4>", "Your data table", "</h3>"))
  }
})

output$qq_head <- renderText({ #in use in ANOVA tab
  if (input$startBtn > 0) {
    HTML(paste0("<h4>", "QQ plot of residuals from linear model.", "</h3>"))
  }
})


output$anova_head <- renderText({ #in use ANOVA tab
  if (input$startBtn > 0) {
    HTML(
      paste0(
        "<h4>",
        "ANOVA table",
        "</h3>",
        "<h6>",
        "Type II SS. Kenward-Roger method for degrees of freedom.",
        "</h6>"
      )
    )
  }
  ifelse(input$logTrans %in% c("log10", "log2"),
         HTML(
           paste0(
             "<h4>",
             "ANOVA table",
             "</h3>",
             "<h6>",
             "Note: you used log-transformation.",
             "</h4>",
             "<h6>",
             "Type II SS. Kenward-Roger method for degrees of freedom.",
             "</h6>"
           )
         ),
         HTML(
           paste0(
             "<h4>",
             "ANOVA table",
             "</h3>",
             "<h6>",
             "Type II SS. Kenward-Roger method for degrees of freedom.",
             "</h6>"
           )
         ))
})

output$emmeans_head <- renderText({ #in use in ANOVA tab
  if (input$startBtn > 0) {
    HTML(
      paste0(
        "<h4>",
        "Estimated Marginal Means.",
        "</h3>",
        "<h6>",
        "Kenward-Roger method for degrees of freedom.",
        "</h6>"
      )
    )
  }
  ifelse(input$logTrans %in% c("log10", "log2"),
         HTML(
           paste0(
             "<h4>",
             "Estimated Marginal Means.",
             "</h3>",
             "<h6>",
             "Note: emmeans are back-transformed to the original scale.",
             "</h4>",
             "<h6>",
             "Kenward-Roger method for degrees of freedom. Confidence level used: 0.95 ",
             "</h6>"
           )
         ),
         HTML(
           paste0(
             "<h4>",
             "Estimated Marginal Means.",
             "</h3>",
             "<h6>",
             "Kenward-Roger method for degrees of freedom. Confidence level used: 0.95 ",
             "</h6>"
           )
         ))
})

output$contrasts_head <- renderText({ #in use in ANOVA tab
  if (input$startBtn > 0) {
    HTML(
      paste0(
        "<h4>",
        "Post-hoc comparisons",
        "</h3>",
        "<h6>",
        "P values are FDR adjusted. Kenward-Roger method for degrees of freedom.",
        "</h6>"
      )
    )
  }
  ifelse(input$logTrans %in% c("log10", "log2"),
         HTML(
           paste0(
             "<h4>",
             "Post-hoc comparisons",
             "</h3>",
             "<h6>",
             "Note: the ratio is on the original scale (i.e., back-transformation from log-scale).",
             "</h4>",
             "<h6>",
             "P values are FDR adjusted. Kenward-Roger method for degrees of freedom.",
             "</h6>"
           )
         ),
         HTML(
           paste0(
             "<h4>",
             "Post-hoc comparisons",
             "</h3>",
             "<h6>",
             "P values are FDR adjusted. Kenward-Roger method for degrees of freedom.",
             "</h6>"
           )
         ))
})

# Instructions tabs
# effi - start
output$Instr_Data <- renderText({
  HTML(paste0(tags$div(
    
    tags$h5("Uploading data and picking variables:"),
    
    tags$ol(
      
      tags$li(
        "Upload a CSV or Excel file containing your data in long format. ",
        "Each column should represent one variable (categorical or numeric) used for plotting or analysis."
      ),
      
      tags$ul(
        tags$li(
          "To try example data, click ", tags$strong("Start"), " and proceed directly."
        ),
        tags$li(
          tags$strong("Important: "),
          "Column names should not contain spaces, start with numbers, or begin with a dot. ",
          "Use underscores (_) instead. Special characters will be replaced automatically."
        )
      ),
      
      tags$li(
        "Your data must be in long format.",
        tags$br(),
        "See the example below."
      ),
      
      tags$ul(
        tags$li(
          "Example of a ", tags$strong("long format table (required):")
        ),
        tags$br(),
        
        layout_columns(col_widths = 12, card("", tagList(
          tags$img(
            src = "shiny7_long_table.png",
            align = "left",
            width = "50%"
          ),
          tags$h6(
            "Each column represents one variable. Numeric columns are treated as numeric automatically. ",
            "If you have values such as Experiment 1, 2, 3, use labels like Exp_1, Exp_2 so they are treated as categorical. ",
            "Random variables for mixed models must be categorical."
          )
        )))
      ),
      
      tags$li(
        "Example of a ", tags$strong("wide format table (not compatible):")
      ),
      
      tags$br(),
      
      layout_columns(col_widths = 12, card("", tagList(
        tags$img(
          src = "shiny8_wide_table.png",
          align = "left",
          width = "60%"
        ),
        tags$h6(
          "Data spread across columns is not suitable. ",
          "Long format stores variables in columns and observations in rows."
        )
      ))),
      
      tags$li(
        "Click ", tags$strong("Start"),
        ". A preview of your data will appear, along with dropdown menus for variable selection."
      ),
      
      tags$li(
        "For Excel files, select a sheet first, then click ", tags$strong("Start"), "."
      ),
      
      tags$li(
        "Choose variables from your dataset:",
        tags$br(),
        tags$strong("Box 1:"), " X-axis",
        tags$br(),
        tags$strong("Box 2:"), " Y-axis",
        tags$br(),
        tags$strong("Boxes 3 and 3.1:"), " optional grouping variable"
      ),
      
      tags$br(),
      
      tags$ul(
        tags$li("See example below for Boxes 1–3."),
        tags$br(),
        
        layout_columns(col_widths = 12, card("", tagList(
          tags$img(
            src = "boxes1-3.png",
            align = "left",
            width = "35%"
          ),
          tags$h6("Dropdowns show variable names from your dataset.")
        )))
      )
      
    ),
    
    tags$br(),
    
    tags$div(
      tags$h5("Requirements for plotting:"),
      
      tags$ol(
        
        tags$li(
          "At least two variables are required: one for X-axis (Box 1) and one for Y-axis (Box 2)."
        ),
        
        tags$li(
          "A grouping variable (Box 3.1) is optional when the X-axis variable is categorical.",
          tags$br(),
          "If used, it must also be categorical."
        ),
        
        tags$li(
          "If both X and Y variables are numeric (e.g., time vs concentration), ",
          tags$strong("a grouping variable is required."),
          " It can be categorical or numeric."
        ),
        
        tags$li(
          tags$strong("Important: "),
          "Variables selected in Boxes 1–3 and log-transformation (Box 8) are used in analyses. ",
          "If levels are removed in Boxes 7.1–7.2, they are also excluded from analyses."
        )
        
      )
    ),
    
    tags$div(
      tags$h5("Additional variables for graphs:"),
      
      tags$ol(
        
        tags$li(
          "Choose optional variables in ", tags$strong("Boxes 4–5"), "."
        ),
        
        tags$li(
          tags$strong("Box 4: "),
          "Faceting variables (any number). Choose 'No' if not required."
        ),
        
        tags$li(
          tags$strong("Box 5: "),
          "Shapes or Matching variable (only one)."
        ),
        
        tags$li(
          "Click ", tags$strong("'Variables chosen'"), "."
        ),
        
        tags$li(
          tags$strong("Note: "),
          "Variables in Boxes 4–5 affect only the graph appearance and are not used in analyses."
        )
        
      )
    ),
    
    tags$br(),
    
    layout_columns(col_widths = 12, card("", tagList(
      tags$img(
        src = "boxes4-5.png",
        align = "left",
        width = "80%"
      ),
      tags$h6(
        "Optional variables are configured in Boxes 4–5."
      )
    ))),
    
    tags$div(
      tags$h5("Plotting a graph"),
      
      tags$ol(
        
        tags$li(
          "After selecting variables, available graph types will appear in ",
          tags$strong("Box 6"), "."
        ),
        
        tags$li(
          "Select a graph type and click ",
          tags$strong("'grafify my data'"), " to display the plot."
        ),
        
        tags$li(
          "Graph appearance can be customised and downloaded (see Graphs Instructions)."
        )
        
      )
    )
    
  )))
})

output$Instr_Graphs <- renderText({
  HTML(paste0(
    
    tags$div(
      tags$h5("Types of Graphs"),
      mainPanel2.1
    ),
    
    tags$div(
      tags$h5("Plotting and customising graphs:"),
      
      tags$ol(
        
        tags$li(
          "Select variables in ",
          tags$strong("Boxes 1–5"),
          " and click ",
          tags$strong("'Variables chosen'"),
          " before proceeding."
        ),
        
        tags$li(
          tags$strong("Box 6: "),
          "Select a graph type from the dropdown."
        ),
        
        tags$li(
          tags$strong("Important: "),
          "Graphs do not update automatically. After any change, click ",
          tags$strong("'grafify my data'"),
          "."
        ),
        
        tags$li(
          tags$strong("Note: "),
          "Groups are ordered alphabetically by default (e.g., KO appears before WT)."
        ),
        
        tags$li(
          tags$strong("Boxes 7.1 and 7.2: "),
          "Reorder or remove groups.",
          tags$ul(
            tags$li(
              "Dropped groups are excluded from ANOVA analyses."
            ),
            tags$li(
              tags$strong("Check that the graph shows all data you want to analyse.")
            )
          )
        ),
        
        tags$li(
          tags$strong("Box 8: "),
          "Change graph appearance (colours, fonts, log scale, etc.). ",
          "Click ",
          tags$strong("'grafify my data'"),
          " after any change."
        ),
        
        tags$li(
          "Download graphs as ", tags$strong("PDF files"),
          ". Adjust width and height for best layout."
        ),
        
        tags$li(
          tags$strong("PDF size tips:")
        ),
        
        tags$ul(
          tags$li(
            "Start with ~12 cm height and increase width depending on the number of groups."
          ),
          tags$li(
            "Graphs may look 'squished' on screen but will export correctly with larger dimensions."
          ),
          tags$li(
            "Add ~8 cm to height and width for each additional faceting panel."
          ),
          tags$li(
            tags$strong("You do NOT need to click 'grafify my data' when changing PDF size.")
          ),
          tags$li(
            "Changing PDF size does not affect how the graph appears on screen."
          )
        )
        
      )
    ),
    
    tags$div(
      tags$h5("Examples of graphs based on variables (Boxes 1–5):"),
      mainPanel2.2
    ),
    
    tags$div(
      tags$h5("Descriptions of graph types:"),
      
      tags$ol(
        
        tags$li(
          tags$strong("Box & whiskers: "),
          tags$em(
            "Shows all data points with boxplot (median, IQR, whiskers = 1.5×IQR). ",
            "Colours of boxes and points match. Shapes can be added (≤25 groups)."
          )
        ),
        
        tags$li(
          tags$strong("Violin + box & whiskers: "),
          tags$em(
            "As above, with violin plots showing data distribution."
          )
        ),
        
        tags$li(
          tags$strong("Bar graph: "),
          tags$em(
            "Bars show mean; points show data. ",
            "Error bars = SD (default), or SEM/CI95."
          )
        ),
        
        tags$li(
          tags$strong("Point & errorbars: "),
          tags$em(
            "Mean shown as square; points show data. ",
            "Error bars = SD/SEM/CI95."
          )
        ),
        
        tags$li(
          tags$strong("Density / Histogram: "),
          tags$em(
            "Distribution of data (categorical X only). ",
            "Histogram bins can be adjusted."
          )
        ),
        
        tags$li(
          tags$strong("Before-after plot: "),
          tags$em(
            "Requires matching variable. Points are connected to show paired changes."
          )
        ),
        
        tags$li(
          tags$strong("Numeric XY (1 & 2): "),
          tags$em(
            "For numeric X-axis (e.g., time). Requires grouping variable."
          )
        )
        
      )
    ),
    
    tags$div(
      
      tags$h5("Changing graph appearance:"),
      
      layout_columns(col_widths = 12, card("", tagList(
        tags$img(
          src = "boxes8.png",
          align = "left",
          width = "60%"
        ),
        tags$h6(
          "Customisation options are in ",
          tags$strong("Box 8"),
          "."
        )
      ))),
      
      tags$ol(
        
        tags$li(
          "Options in Box 8 vary by graph type (e.g., error bars, bins)."
        ),
        
        tags$li(
          tags$em(
            tags$strong("Colours: "),
            "Colourblind-friendly palettes are available. ",
            "Use fewer colours if many groups."
          ),
          tags$ul(
            tags$li("Colours map to groups along the X-axis."),
            tags$li("Single-colour plots can improve clarity for many groups.")
          )
        ),
        
        tags$div(mainPanel2.3),
        
        tags$li(
          tags$em(
            tags$strong("Fonts and labels: "),
            "Default = 18 pt. Recommended 18–20. ",
            "Adjust label angle to avoid overlap."
          )
        ),
        
        tags$li(
          tags$em(
            tags$strong("Log axes: "),
            "Apply log10/log2 to axes. ",
            "This also affects ANOVA analyses."
          )
        ),
        
        tags$li(
          tags$em(
            tags$strong("Symbols and shapes: "),
            "Adjust size (1–10) and transparency (0–1). ",
            "Error bar type and width can also be changed."
          )
        ),
        
        tags$li(
          tags$em(
            tags$strong("Binsizes: "),
            "Adjust for histogram plots."
          )
        ),
        
        tags$li(
          tags$em(
            tags$strong("Data scatter: "),
            "Controls spread of overlapping points (0 = aligned)."
          )
        )
        
      )
    )
    
  ))
})

output$Instr_ANOVA <- renderText({
  HTML(paste0(tags$div(
    
    tags$h5("Fitting linear models (ANOVA) and post-hoc comparisons:"),
    
    tags$ol(
      
      tags$li(
        "Variables selected for the X-axis and optional grouping variable (Boxes 1 and 3.1) are used as predictors (independent variables) in ANOVA."
      ),
      
      tags$ul(
        tags$li(
          "These are also called ", tags$strong("Fixed factors"), "."
        ),
        tags$li(
          "In the example below, ",
          tags$strong("Genotype"),
          " and ",
          tags$strong("Treatment"),
          " are Fixed factors."
        )
      ),
      
      tags$li(
        "The Y-axis variable (Box 2) is the response (dependent variable) and must be numeric."
      ),
      
      tags$ul(
        tags$li(
          "In the example below, ",
          tags$strong("Cell_viability_percent"),
          " should be used as the Y variable."
        )
      ),
      
      tags$br(),
      
      layout_columns(col_widths = 12, card("", tagList(
        tags$img(
          src = "shiny7_long_table.png",
          align = "left",
          width = "50%"
        ),
        tags$ul(
          tags$li(
            tags$strong("Treatment"),
            " has two levels: 'Untreated' and 'Drug'."
          ),
          tags$li(
            tags$strong("Genotype"),
            " has two levels: WT and KO."
          ),
          tags$li(
            "The variable ",
            tags$strong("Experiment_num"),
            " represents experimental blocks and is used as the ",
            tags$strong("Random factor (Box 9.1).")
          )
        )
      ))),
      
      tags$li(
        "You can fit either a ",
        tags$strong("Simple"),
        " or ",
        tags$strong("Mixed effects"),
        " model."
      ),
      
      tags$ul(
        tags$li(
          tags$strong("Simple model: "),
          "Choose 'No' in Box 9. Assumes all observations are independent."
        ),
        tags$li(
          tags$strong("Mixed model: "),
          "Choose 'Yes' in Box 9 and select a random factor (Box 9.1), e.g., Experiment."
        ),
        tags$li(
          "Click ",
          tags$strong("'Analyse my data'"),
          " to view results."
        )
      ),
      
      layout_columns(col_widths = 12, card("", tagList(
        tags$img(
          src = "boxes9.png",
          align = "left",
          width = "80%"
        )
      )))
      
    ),
    
    tags$div(
      
      tags$h5("Technical replicates:"),
      
      tags$ol(
        
        tags$li(
          "Technical replicates are repeated measurements within the same experiment (e.g., TechRep1, TechRep2)."
        ),
        
        tags$br(),
        
        layout_columns(col_widths = 12, card("", tagList(
          tags$img(
            src = "shiny7_long_table_techs.png",
            align = "left",
            width = "70%"
          ),
          tags$ul(
            tags$li(
              "Technical replicates are indicated in ",
              tags$strong("Tech_Rep_num"),
              "."
            ),
            tags$li(
              tags$strong("Important: "),
              "Technical replicates are NOT independent observations."
            )
          )
        ))),
        
        tags$li(
          tags$strong("Important: "),
          "Using technical replicates directly can lead to pseudoreplication (incorrect results)."
        ),
        
        tags$li(
          "`grafify` averages replicates within levels of the random factor (Box 9.1) before fitting mixed models."
        ),
        
        tags$li(
          tags$strong("Note: "),
          "For Simple models, you must average replicates before uploading data."
        ),
        
        tags$li(
          "Use the experimental block (e.g., Experiment_num) as the random factor.",
          tags$br(),
          tags$strong("Do NOT use technical replicate ID as the random factor.")
        ),
        
        tags$li(
          "Best practice: upload averaged data from independent experiments."
        ),
        
        tags$li(
          "More advanced mixed models are possible in R, but not available in `grafify`."
        ),
        
        tags$li(
          tags$strong("Important: "),
          "Mixed models do NOT automatically fix issues such as pseudoreplication."
        ),
        
        tags$ul(
          tags$li("Ensure data contain independent observations."),
          tags$li("Ensure correct experimental hierarchy is represented.")
        )
        
      )
    ),
    
    tags$div(
      
      tags$h5("Variables used in analysis:"),
      
      tags$ol(
        
        tags$li(
          "Only variables in Boxes 1–3 are used in ANOVA analyses."
        ),
        
        tags$li(
          "Faceting and Shapes variables (Boxes 4–5) affect only graph appearance."
        ),
        
        tags$li(
          tags$strong("Important: "),
          "If groups are removed from the graph (Boxes 7.1–7.2), they are also removed from the analysis."
        ),
        
        tags$li(
          "Always review the dataset shown at the bottom of the ANOVA tab."
        ),
        
        tags$li(
          "Apply transformations (Box 8) before running analysis.",
          tags$br(),
          "Selected transformations are used in both graphs and analyses."
        )
        
      )
      
    ),
    
    tags$div(
      
      tags$h5("Results and diagnostics:"),
      
      tags$ol(
        
        tags$li(
          "After changing variables, click ",
          tags$strong("'Variables chosen'"),
          " and then ",
          tags$strong("'Analyse my data'"),
          " to update results."
        ),
        
        tags$li(
          tags$strong("QQ plot: "),
          "Points close to the diagonal indicate approximately normal residuals."
        ),
        
        tags$li(
          tags$strong("If residuals deviate strongly: "),
          "The model may not be appropriate. Consider transforming the data."
        ),
        
        tags$li(
          "For Mixed models, additional plots show variation across experimental blocks."
        ),
        
        tags$li(
          "Post-hoc comparison options appear after model fitting."
        ),
        
        tags$li(
          "The ", tags$strong("'Linear Model'"),
          " tab shows the fitted model summary."
        ),
        
        tags$li(
          "Info buttons provide additional details on ANOVA, EMMEANS, and comparisons."
        )
        
      )
      
    )
    
  )))
})

output$Instr_FAQs <- renderText({
  HTML(paste0(tags$div(
    tags$br(),
    tags$h5("Tips to avoid errors:"),
    
    tags$ol(
      
      tags$li(
        tags$strong("Data upload error: "),
        "Ensure your data is in long format and column names contain no spaces. ",
        "Use '_' instead (e.g., Cell_count). ",
        "Avoid special characters (e.g. +, $, Greek letters). ",
        "Maximum size: ~20 columns and 20,000 rows."
      ),
      
      tags$li(
        tags$strong("App disconnected/stopped: "),
        "Refresh or reload the page. Errors may occur if variables are changed repeatedly ",
        "or if the dataset contains missing values."
      ),
      
      tags$li(
        tags$strong("No graph or ANOVA result: "),
        "Make sure you clicked the buttons in this order:",
        tags$br(),
        tags$strong("'Variables chosen' → 'grafify my data' → 'Analyse my data'.")
      ),
      
      tags$li(
        tags$strong("Two-way ANOVA failed: "),
        "If your grouping variable (Box 3.1) is numeric (e.g., 10, 20, 30), ",
        "it will be treated as continuous.",
        tags$br(),
        "Convert to categorical labels (e.g., 10min, 20min)."
      ),
      
      tags$li(
        tags$strong("Compare to reference not working: "),
        "This option requires a categorical X variable. ",
        "If X is numeric, use a grouping variable or choose a different comparison."
      ),
      
      tags$li(
        tags$strong("Wrong reference group selected: "),
        "Reference levels follow the order shown in the graph (or Boxes 7.1–7.2). ",
        "Reorder groups there if needed."
      ),
      
      tags$li(
        tags$strong("Graph looks squished or incomplete: "),
        "This is due to screen size limitations.",
        tags$br(),
        "Increase PDF width/height and click ",
        tags$strong("'Save as PDF'"),
        ". The downloaded graph will be correct."
      ),
      
      tags$li(
        tags$strong("Missing groups in ANOVA: "),
        "If groups are removed in Boxes 7.1–7.2, they are also removed from analysis."
      )
      
    ))
    
  ))
})
# effi - end