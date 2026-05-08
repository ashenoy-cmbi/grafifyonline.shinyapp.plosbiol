output$dataHelpOpen <- renderText({ #in use on landing page
  HTML(paste0(tags$div(
    tags$h4("Quick Instructions", (
      tags$h6("(If using `grafify` for the first time, please read detailed ", tags$strong("Instructions"), " through the link on navigation bar before starting. These quick-steps are for users who are somewhat familiar with the app.)")
    )),
    tags$ol(
      tags$li(
        "Use the 'Start here' panel on the top right corner to upload a long format table saved as a csv or Excel file, and click", tags$strong ("'Start'"),". To use example data for a trial run, just click 'Start'. If you are not familiar with a long format table, see ",
        tags$strong("Instructions"),
        "."
      ),
      tags$li(
          "If the table is in the correct format (and column names do not have special characters/spaces), the app will show a preview of the data table, and a list of variables (column names) from your table will appear in dropdown menus in",
          tags$strong("Boxes 1-3"),
          " on bottom left of the 'Data & Variables' pane. If you are using an Excel file, you can select a sheet from your file before pressing 'Start'."
          ),
      tags$li(
        "Then select options in dropdown menus in ",
        tags$strong(" Boxes 1-3.")
        ),
      tags$li(
        tags$strong("Box 1:"), 
        "Pick a variable to plot on the X-axis of the graph. Typically, this is a categorical variable (e.g., Genotype, Treatment, etc.). This variable is also called the 'independent' variable. You can also plot a numeric variable (e.g., time, concentration).",
      ),
      tags$li(
        tags$strong("Box 2:"), 
        "Pick a numeric (quantitative) variable from your data table to plot on the Y-axis of the graph. This is also called the 'dependent' or 'response' variable.",
      ),
      tags$li(
        tags$strong("Boxes 3 and 3.1:"), 
        "These allow you to add an optional Grouping variable if (e.g., for two-way ANOVA). Choose 'Yes' in Box 3 and then select a variable in Box 3.1. ", 
        tags$strong("Note:"), " if you chose a numeric variable in Box 1, you must also choose a Grouping variable in Box 3.1.",
      ),
      tags$li(
        "All variables selected on this page will be used on Graphs and in the ANOVA analyses.",
      ),
      tags$li(
        "After selecting variables go to the 'Graphs' tab and choose options in ",
        tags$strong("Boxes 4-8"),
        "."
      ),
      tags$li(
        "If using example data with a categorical X-axis, try the following: Box 1: manufacturer, Box 2: displ; Box 3: Yes, Box 3.1: drv. Or for a numeric XY plot try: Box 1: cty, Box 2: hwy, Box 3: Yes and Box 3.1: either manufacturer or displ.")
    )
  )))
})

output$graphsHelpOpen <- renderText({ #in use on Graphs landing 
  HTML(paste0(tags$div(
    tags$ol(
      tags$li("Here you can choose optional variables for graphs (Boxes 4-5) and change graph type and appearance (Boxes 6-8). You should have chosen variables in Boxes 1-3 to proceed."),
      tags$li(
        tags$strong("Boxes 4 and 4.1:"), 
        "Choose optional variables for faceting graphs. Choose 'Yes' in Box 4 and then select one or more variables from the dropdown list in Box 4.1. The variables chosen in Box 4.1 can also be reordered.", 
        tags$strong("Note:"), "this choice only affects the appearance of the graph and is not included in linear model analysis.",
      ),
     tags$li(
        tags$strong("Boxes 5 and 5.1:"),
        "Pick a Shapes or Matching variable (only 1) from the dropdown list in Box 5.1, or choose 'No' in Box 5 before proceeding. A matching factor is essential for 'Before-after' plots (this variable can have any number of groups). The Shapes variable can also be used to change the shape of data points  in graphs other than 'Before-after plots'. In this case, there should be fewer than 25 groups within this variable (because only 25 different symbol shapes are available).",
      ),
      tags$li("Then press ", tags$strong("'Variables chosen'"), " to see graph types available in Box 6."),
      tags$li(
        tags$strong("Box 6:"),
        "This provides a list of Graphs types, which will depend on the type (categorical or numeric) and number of variables (one-way or two-way ANOVAs). Make a selection and press ",
        tags$strong("'grafify my data'"),
        "to see the Graph. The default is a Boxplot or Numeric XY1.",
      ),
      tags$li(
        tags$strong("Boxes 7.1 and 7.2:"),
        "Reorder groups along the X-axis and/or the grouping factor in these boxes. Some groups may also be dropped completely from the graph.", tags$strong("Note:"), "dropping groups also removes them from the linear model analyses."
      ),
      tags$li(
        tags$strong("Box 7.1:"),
        "A different kind of Box 7.1 and related boxes appear when both X and Y are numeric variables. These boxes contain options to show central tendancy (mean/median) and dispersion (SD/SEM/CI95/box & whiskers). A loess or linear smooth line can also be addded."
      ),
     tags$li(
       "Press ",
       tags$strong("'grafify my data'"),
       "to see the (default) graph. If you then go back and pick a different graph type in Box 6, press 'grafify my data' to see the new graph."
     ),
      tags$li(
        tags$strong("Box 8:"),
        "These optional settings change the appearance of the graph (e.g., colours, fonts, error bar type, transparency of symbols and colours, log-transformation etc). Please see Instructions for further details. If you change any setting, remember to press ",
        tags$strong("'grafify my data'"),
        " to update graph."
      ),
     tags$li("Download your graph as a high-resolution PDF by clicking ",
        tags$strong("'Save as PDF'"),
        " See Instructions for detailed information on sizing the page of the PDF fie to fit the entire graph on it. Briefly, the appearance of graphs online is limited by the size of your screen, but a large enough PDF page dimension can fit graphs of any size even if they appear 'squished' on the screen."),
     tags$li(tags$strong("Note:"),
             " If you use log-transformation in Box 8, the graph will be shown on a log scale, and log-transformed data will be used in the linear model analyses."),
     tags$li(
        "Graphs and ANOVAs will not update automatically if you change variables (i.e., choices in Boxes 1-5). Please remember to press ",
        tags$strong("'Variables chosen'"),
        " to update Graph and ANOVA variables."
      ),
     tags$li(
        "For linear model fitting, go to the 'ANOVAs (linear models) and Comparisons' tab and choose options in ",
        tags$strong("Boxes 9-10"),
        "."
      )
    )
  )))
})
output$ANOVAsHelpOpen <- renderText({ #in use on ANOVA landing
  HTML(paste0(tags$div(
    tags$ol(
      tags$li(
        "ANOVA and post-hoc comparisons can be performed only after picking optional variables on 'Graphs' tab and clicking ",
        tags$strong("'Variables chosen'"),
        ". This step is also required even if you are not interested in plotting your data and only want to perform linear model analyses."
      ),
      tags$li(
        tags$strong("Box 9:"),
        "Choose the type of analysis (Simple or Mixed effects). Results will appear after making a selection and clicking ",
        tags$strong("'Analyse my data'"),
        "."
      ),
     tags$li(
        tags$strong("Boxes 9.1 and 9.2:"),
        "If you choose 'Mixed' in Box 9, two new options appear. Mixed effects analysis requires a random factor, e.g., experimental blocks, matching, pairing, repeated-measures, which is provided in Box 9.1."),
      tags$li("You can also choose whether values within levels of the random factor are averaged in ",
              tags$strong("Box 9.2."),
              "Please see Instructions for details on averaging technical replicates."
      ),
      tags$li(
        "After one round of analyses, if you then go back and change variables in ",
        tags$strong("Boxes 1-3"),
        " or use log-transformation in", 
        tags$strong("Box 8,"),
        "remember to press ",
        tags$strong("'Variables chosen'"),
        "on 'Graphs' tab and then click ",
        tags$strong("'Analyse my data'"), "to update ANOVA results."
      ),
    tags$li(
      "For model diagnostics, a QQ (Quantile-Quantile) plot of model residuals and a smooth density plot of residuals will be shown. The QQ plot should residuals close to the diagonal straight line suggesting approximal normal distribution of residuals and an acceptable fit of the linear model to the observed data. If the points deviate a lot from the line, this could indicate that the residuals are skewed and model is not appropriate for the data. Similarly, approximately normally distributed residuals show a nearly symmetric smooth density plot around the mean of 0. See Instructions for further details. Proceed to post-hoc comparisons if the model diagnostics are acceptable."),
      tags$li(
        tags$strong("Box 10:"),
        "Choose the type of post-hoc comparisons: 'Pairwise', 'Comparison to reference' or 'Levelwise'. See Instructions for details."
      ),
      tags$li(
        "The 'Linear Model' tab below shows the model summary, including the 'formula', which shows fixed and random variables, log-transformation etc, if used."),
    tags$li(
      "The 'Data used for analyses' tab shows the variables used for the graph and analyses.")
      )
  )))
})

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
             "Note: the ratio is on the original scale.",
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
output$Instr_Data <- renderText({ #in use in Instructions Data tab
  HTML(paste0(tags$div(
    tags$h5("Uploading data and picking variables:"),
    tags$ol(
      tags$li(
        "To get started, upload a csv or Excel file containing your table in long-format. This means each column should contain one categorical or one numeric variable that you want to plot/use in analyses."
      ),
      tags$ul(
      tags$li(
          "If you would like to use example data, click", tags$strong("Start"), " directly and proceed to choosing variables."
        ),
      tags$li(tags$strong("Important: column names should not have space between words. Please use an `_` (underscore) instead. You may have to edit the name later when you prepare figures in Powerpoint or other software you use."))),
      tags$li(
        "Your data should be in long format. If you are not familiar with long-format tables, see the image below for an example of a long-format table."
      ),
      tags$ul(
      tags$li("See image below of an example of", tags$strong("long"), " table that ", tags$strong("is the required"), "format for `grafify`."),
      tags$br(),
      layout_columns(col_widths = 12, card("", tagList(
        #h4("Types of graphs with grafify"),
        tags$img(
          src = "shiny7_long_table.png",
          align = "left",
          width = "50%"
        ),
        tags$h6(
          "The data table should be long-format with one variable (either categorical or numeric) per column. Note that columns with numbers are automatically assumed to be numeric. If you have a column to indicate Experiment 1, 2, 3, and so on, enter them as Exp_1, Exp_2 etc. so that R 'reads' them as categorical variables. The random variable for mixed effects analyses should be a categorical variable. It is easy to add another variable as another column."
        )))),
      tags$li("See image below of an example of", tags$strong("wide"), " table format that", tags$strong("is not compatible"), "with `grafify`."),
      tags$br(),
      layout_columns(col_widths = 12, card("", tagList(
        tags$img(
          src = "shiny8_wide_table.png",
          align = "left",
          width = "60%"
        ),
        tags$h6(
          "In this case, data spread across multiple columns, and the hierarchy in data is apparent only after scanning across columns. Adding another variable makes the table even more 'wider'."
        )
      )))),
      tags$li(
        "Then press", tags$strong("Start"), ". If all goes OK, your table should appear below. You should also see dropdown menus that let you select variables from your table."
      ),
      tags$li(
        "If you upload an Excel file, a dropdown list of sheets within the file will appear. Pick a sheet and press 'Start'."
      ),
      tags$li(
        "Pick variables (names of columns from your data table) to plot on X-axis in ", tags$strong("Box 1"), ", Y-axis in ", tags$strong("Box 2"), " and a grouping variable, if required in ", tags$strong("Boxes 3 and 3.1")
      ),
      tags$br(),
      tags$ul(
        tags$li("See image below with example dataset in", tags$strong("Boxes 1 - 3"), "."),
        tags$br(),
        layout_columns(col_widths = 12, card("", tagList(
          #h4("Types of graphs with grafify"),
          tags$img(
            src = "boxes1-3.png",
            align = "left",
            width = "35%"
          ),
          tags$h6(
            "Drop down lists will show names of columns from your data table."
          )))))
    ),
    tags$br(),
    tags$div(
      tags$h5("Requirement for plotting data:"),
      tags$ol(
        tags$li(
          "At least 2 variables must be chosen: one each for the X- and Y-axis of Graphs, i.e., Boxes 1 and 2."
        ),
        tags$li(
          "A third Grouping variable (e.g., for 2-way ANOVA designs) is optional when the X-axis variable is categorical. To be able to choose this, say 'Yes' in Box 3 and then choose a variable in Box 3.1. With categorical X-axis variables, the Grouping variable has to be a categorical variable."
        ),
        tags$li(
          "If the X- and Y- axis variables are both numeric (e.g., X-axis is Time or concentration), the Grouping variable is mandatory. In this case the grouping varaible can be either categorical or numeric."
        ),
        tags$li(
          tags$strong(
            "Note: all variables chosen in Boxes 1-3, and log-transformation used from Box 8 (if selected), will be used in data analyses. If any levels within categorical variables are dropped from graphs in Boxes 7.1 and 7.2 (see Instructions: Graphs), they will not be used in analyses."
          )
        )
      )
    ),
    tags$div(
      tags$h5("Additional variables for graphs:"),
      tags$ol(
        tags$li("These are chosen in ", tags$strong("Boxes 4-5"),"."),
        tags$li(
          tags$strong("Box 4"),
          " is for choosing Faceting variables (any number), or choose 'No' before proceeding."
        ),
        tags$li(
          tags$strong("Box 5"),
          " lets you pick a Shapes or Matching variable (only 1) from a dropdown list, or choose 'No'."
        ),
        tags$li("Then press ", tags$strong("'Variables chosen'"), "."),
        tags$li(tags$strong("Note: variables chosen in Boxes 4-5 are not used in the analyses - these only change the appearance of the graph."))
        )),
    tags$br(),
    layout_columns(col_widths = 12, card("", tagList(
      #h4("Types of graphs with grafify"),
      tags$img(
        src = "boxes4-5.png",
        align = "left",
        width = "80%"
      ),
      tags$h6(
        "Optional variables for graphs can be chosen in", tags$strong("Boxes 4-5"), "."
      )))),
   tags$div(
     tags$h5("Plotting a graph"),
     tags$ol(
       tags$li(
         "Once selections are made in Boxes 1-5, the types of Graphs that can be plotted based on variables chosen will appear in", tags$strong("Box 6")), 
       tags$li("Make a selection and press ",
         tags$strong("'grafify my data'"),
         "to see the Graph."
       ),
       tags$li(
         "The appearance of graphs can be changed using various options, and the graph downloaded (see Instructions:Graphs)."
       ),
       tags$br()
     )
   ) 
  )))
})

output$Instr_Graphs <- renderText({ #in use
  HTML(paste0(
    tags$div(tags$h5("Types of Graphs"), 
             mainPanel2.1), #from src01g_Help_n_Images

    tags$div(
      tags$h5("Plotting and customising graphs:"),
      tags$ol(
        tags$li(
          "You must have chosen variables in",
          tags$strong("Boxes 1-5"), "to proceed and pressed ", tags$strong("Variables chosen"), " to proceed."
        ),
        tags$li(
        tags$strong("Box 6"),
          " will show a dropdown menu of Graph types. Instructions below explain graph types and their customisations."
        ),
        tags$li(
          "Graphs do not automatically update if you change appearance or variables - please click ", tags$strong("grafify my data"), "to update the graph."
        ),
        tags$li(
          tags$strong("Note:"),
          "R and ggplot2 use alphabetically ordering based on group (levels) within categorical variables (e.g., if groups are labelled WT and KO, the KO group will appear before WT along the X-axis)."
        ),
        tags$li(
          tags$strong("Note:"),
            " You can reorder groups or plot only those you are interested in by using options in ",
            tags$strong("Boxes 7.1 and 7.2"),
            ".",
            tags$ul(
            tags$li("When reordering groups, if you drop some levels within the factor (i.e., there were 10 groups in your data, but you plot only 3), those levels will not be used in the ANOVA analyses (i.e., only those 3 groups will be analysed in the ANOVA)."),
            tags$li(tags$strong("Check that the Graph contains all the data you want to analyse.")))
          
        ),
        tags$li(
          "Appearance of graphs can be changed using options in ",
          tags$strong("Box 8"),
          ". See below for options available. If you change graph appearance in Box 8, remember to click ", tags$strong("grafify my data"), "again."
        ),
        tags$li(
          "The graph is available to ", tags$strong("download as a PDF file"),". You will need to change the height and width to fit the graph within the PDF document."
        ),
        tags$li(tags$strong("Tips on PDF sizing for graph downloads:")),
        tags$ul(
          tags$li(
            "Typically, at fontsize of 18 pts (default) with a angled text on X-axis, start with a height of 12 cm and increase width based on number of groups (e.g., 20 cm for ~10 groups plus legend on the right). Even if the graph looks 'squished' on the screen or missing parts, it will look good and contain all components when the dimension of the PDF file are large enough to accommodate it. Therefore, avoid reducing the font or symbol sizes and instead increase the dimensions of the PDF."),
            tags$li("Increase the height if you also used a faceting variable, angled labels on the X-axis or have long list of legends. Add ~8 cm for each additional panel to the H and W."),
            tags$li(tags$strong("You do not need to press 'grafify my data' when you change dimensions, click 'Save as PDF' directly.")
          ),
          tags$li(
            "Changing height or width does not change appearance of the graph online."
          )
          )
      )
    ),
    
    tags$div(tags$h5("Examples of graphs based on choices made in Boxes 1-5:"), 
             mainPanel2.2), #from src01g_Help_n_Images
    
    tags$div(
      tags$h5("Descriptions of graphs types:"),
      #mainPanel2.1,
      tags$ol(
        tags$li(
          tags$strong("Box & whiskers: "),
          tags$em(
            "All data points are shown as scattered circles with boxes depicting the interquartile range (IQR; 25th - 75th percentiles), and whiskers depicting 1.6xIQR, and a line representing the median (50th percentile). The colours of boxes and circles will match, and the colour pallete can be changed in Box 8. If a Shapes variable is slected, the shape of data points will change (shown in black). Up to 25 different shapes are allowed."
          )
        ),
        tags$li(
          tags$strong("Violin plus box & whiskers: "),
          tags$em(
            "As box & whiskers, plus violins which show overall distribution of data. By default, the colours of symbols and vioins will match and boxes will look white, which can be changed with the Box opacity option in Box 8."
          )
        ),
        tags$li(
          tags$strong("Bar graph: "),
          tags$em(
            "Bars show the mean of data and circles represent all data points. The default error bars will denote SD (standard deviation), which can be changed to SEM (standard error of the mean) or CI95 (95% confidence interval calculated from the t-distribution)."
          )
        ),
        tags$li(
          tags$strong("Point & errorbars: "),
          tags$em(
            "A square represents the mean of the data and circles show all data points. The default error bars will denote SD (standard deviation), which can be changed to SEM (standard error of the mean) or CI95 (95% confidence interval calculated from the t-distribution)."
          )
        ),
        tags$li(
          tags$strong("Density or Histogram plot : "),
          tags$em(
            "A smooth plot of density function or histogram of counts or normalised counts (Y-axis variable) grouped by the X-axis (categorical variable only). If Histogram plot is chosen, the binsize can be changed."
          )
        ),
        tags$li(
          tags$strong("Before-after plot: "),
          tags$em(
            "This is a box and whiskers plot, but an additional Shapes variable is needed that indicates matching or pairing within the data. Data points will be joined by grey lines to show change 'before and after treatment'."
          )
        ),
        tags$li(
          tags$strong("Numeric XY 1 and 2: "),
          tags$em(
            "These are used when the X-axis is also numeric (e.g., time, concentrations). A Grouping variable is also required, which can be categorical or numeric."
          )
        )
      )
    ),
    
    tags$div(
      tags$h5("Changing graph appearance: "),
      layout_columns(col_widths = 12, card("", tagList(
        #h4("Types of graphs with grafify"),
        tags$img(
          src = "boxes8.png",
          align = "left",
          width = "60%"
        ),
        tags$h6(
          "Graph customisation can be chosen with options in", tags$strong("Box 8"), "."
        )))),
      tags$ol(
        tags$li("Options for changing graph appearance are available in ", tags$strong("Box 8"), ". Depending on graph type, options for error bars and binsizes appear close to ", tags$strong("Box 6"),"."),
        tags$li(
          tags$em(
            tags$strong("Colours: "),
            "12 colourblind-friendly colour schemes are available for categorical X-axis variables, and 5 for numeric X-axis variables."),
            tags$ul(tags$li("Colours are plotting sequentially from grafify colourblind-friendly palettes and mapped to groups (levels) along the X-axis variable - the colours will map to boxes/bars/vioins/points and data symbols."),
            tags$li("Sometimes, when there are lots of groups along the X-axis, too many colours can be distracting and unnecessary (because group labels are available). In this case, a single colour can be used for all groups."
          ))
        ),
        
        tags$div(mainPanel2.3), #from src01g_Help_n_Images
        
        tags$li(
          tags$em(
            tags$strong("Fonts and labels: "),
            "The default fontsize is 18 points, which can be changed as required. For publications/reports, I suggest keeping it to 18-20 which appears ~8 pts when scaled down to an average sized figure. The angle of labels on the X-axis can be changed to avoid overlap. The default is 45 to avoid overlap of long labels, which can be 0 for short labels."
          )
        ),
        tags$li(
          tags$em(
            tags$strong("Log axes: "),
            "log10 or log2 transformations are possible for the Y-axis. X-axis can also be transformed if a numeric variable is used. Remember that transformation is also used in the ANOVA analyses. If you want the analyses without transformation, repeat after deselecting these choices."
          )
        ),
        tags$li(
          tags$em(
            tags$strong("Appearance of symbols/bars/boxes/violins: "),
            "Sizes of data points can be changed (range of 1-10 allowed). Opacity of all items can be modified as well (range 0-1, where 0 = fully transparent (invisible symbols or white bars/boxes/violins) and 1 = opaque. For 'Bar graphs' and 'Point and errorbar', the type of error bar (SD, SEM or CI95) and width of error bars (0-1) can be adjusted."
          )
        ),
        tags$li(
          tags$em(
            tags$strong("Binsizes: "),
            "For Histogram plots, binsizes can be changed from the default of 30."
          )
        ),
        tags$li(
          tags$em(
            tags$strong("Data scatter: "),
            "By default, the data are scattered to avoid overlap when data points are aligned. This can be changed with a number between 0-1 (0 = aligned data points with no scatter)."
          )
        )
      )
    )
  ))
})


output$Instr_ANOVA <- renderText({ #in use
  HTML(paste0(tags$div(
    tags$h5("Fitting linear models (performing tests) & post-hoc comparisons:"),
    tags$ol(
      tags$li(
        "The X-axis variable and the Grouping variable, if chosen, are used as predictor or independent variables in ANOVAs."),
        tags$ul(
          tags$li("Variables chosen in ", tags$strong("Boxes 1 and 3.1"), " for the X-axis and the optional Grouping variables are also called ", tags$strong("Fixed factors.")),
        tags$li("In the example dataset below, ", tags$strong("Genotype"), "and ", tags$strong("Treatment"), "are ", tags$strong("Fixed factors"), " and could be chosen to be plotted along the X-axis in ", tags$strong("Box 1."))),
      tags$li(
        "The Y-axis variable (which should be a numeric variable) is the dependent or response variable."),
      tags$ul(tags$li("In the example below", tags$strong("Cell_viability_percent"), " should be chosen as the Y-axis variable in ", tags$strong("Box 2"), ".")),
      tags$br(),
      layout_columns(col_widths = 12, card("", tagList(
        #h4("Types of graphs with grafify"),
        tags$img(
          src = "shiny7_long_table.png",
          align = "left",
          width = "50%"
        ),
        tags$ul(
          tags$li("In this example data set, one ", tags$strong("Fixed factor"), " is ", tags$strong("Treatment"), ", which has ", tags$strong("two groups or levels"), "'Untreated' and 'Drug'."),
          tags$li("There is also a second ", tags$strong("Fixed factor"), ", which is", tags$strong("Genotype"), " with ", tags$strong("two levels"), ", i.e., WT & KO."),
          tags$li("These experiments were performed as randomised blocks, wherein 'Untreated' and 'Drug' samples were compared side-by-side for WT and KO cells. This experimental set up is indicated by the variable", tags$strong("Experiment_num"), "which in this case and similar experimental designs is the ", tags$strong("Random factor (Box 9.1)", "for linear mixed effects linear analysis.")))))),
        tags$li(
          "The linear model can be fitted as an ordinary ", tags$strong("Simple"), "or as a mixed-effects model " , tags$strong("Mixed"), "which requires the selection of  a", tags$strong("Random factor")),
        tags$ul(tags$li("To analyse these data as a 'Simple' linear model, choose 'No' in ", tags$strong("Box 9"), ". The data are assumed to be independent and the model will be fitted as an ordinary two-way ANOVA."),
          tags$li("To analyse these data as a 'Mixed' linear model, choose 'Yes' in ", tags$strong("Box 9"), " and choose 'Experiment' as the Random factor in", tags$strong("Box 9.1"), "."),
          tags$li("Remember to click ", tags$strong("Analyse my data"), "after making a selection in ", tags$strong("Box 9"), "to see the results.")),
      layout_columns(col_widths = 12, card("", tagList(
        #h4("Types of graphs with grafify"),
        tags$img(
          src = "boxes9.png",
          align = "left",
          width = "80%"
        ))))
)),
      
      
      tags$div(
        tags$h5("Technical replicates in data:"),
          tags$ol(
            tags$li("Sometimes, to increase the precision of the measurement of 'Cell_viability_percent' within each independent experimental repeat, we may use one or more technical replicates. An example is shown in the image below."),
            tags$br(),
            layout_columns(col_widths = 12, card("", tagList(
              #h4("Types of graphs with grafify"),
              tags$img(
                src = "shiny7_long_table_techs.png",
                align = "left",
                width = "70%"
              )),
              tags$ul(tags$li("Technical replicates are indicated in the variable ", tags$strong("Tech_Rep_num"), ", e.g., Expt1 has data for 'Cell_viability_percent' from TechRep1 and TechRep2."), 
                      tags$li(tags$strong("These kinds of technical replicates are not statistically independent,  and using them in the data table could lead to pseudoreplication.")))
            )),
            tags$li("To avoid pseudoreplication, the `grafify` default is to ", tags$strong("average replicates within levels of the Random factor chosen in Box 9.1 grouped by Fixed factors selected in Boxes 1-3 before fitting a random intercepts mixed effects model.")), 
            tags$li("The averaging of technical replicates ensures that pseudoreplication, which poses an analysis risk is avoided. Within experiment variability, i.e., varibility in technical replicates, should not affect the overall outcome of the test. Overall, therefore, the quality of technical replicates matters more than their quantity."),
            tags$li("If you do have technical replicates in your data table as above, the ", tags$strong("Random factor chosen in Box 9.1"), "should be ", tags$strong("Experiment_num"), ". Choosing 'Technical_rep_num' as Random variable will  give the wrong result."),
            tags$li("Ideally, you should average technical replicates and only use means from independent experiments in the data set uploaded to `grafify`."),
            tags$li("Alternatively, more advanced mixed effects models can be used in R (these are not currently available in `grafify` online)."),
        tags$li(tags$strong("Using linear mixed effects analysis  does not automatically fix issues such as pseudoreplication.")),
        tags$ul(tags$li("It is up to the user to ensure that statistically independent values are entered in the data table"),
        tags$li("Another important aspect of the data table is ensuring the hierarchy is correctly entered, e.g., Genotype and Treatments are tested within each Experimental block in the above example."))
        )),
      
      tags$div(
        tags$h5("Varibles on graphs versus those used for analyses:"),
      tags$ol(
      tags$li(
        "Only the variables selected on the 'Data & Variables' tab are used in ANOVA analyses, i.e, ", tags$strong("only variables in Box 1-3 are used in the linear model analyses."), "Variables chosen for Faceting or Shapes, i.e., Boxes 4-5 are ignored."), 
        tags$li(tags$strong("Important: If levels of the X-axis variable are dropped from the graph, they will also be lost in ANOVAs."), "The data used in the analyses is seen at the bottom of the 'ANOVAs (linear models) and Comparisons' tab."
      ),
      tags$li(
        "Optional settings need to be added/declined on the Graphs tab, and the ", tags$strong("'Variables chosen'"), " button pressed before proceeding to 'ANOVAs (linear models) and Comparisons' tab for analyses. This allows you to 'eye-ball' your data before the analyses. "
      ),
      tags$li(
        tags$strong(
          "If a log-transformation is selected in Box 8, it will be used for graphs and in the analyses."
        )
      ))),
      
      tags$div(
        tags$h5("Results of linear models:"),
      tags$ol(
        tags$li(
        "If you change variables for graphs or analyses, i.e., if you change variables chosen in Boxes 1-3 and 7, remember to click ", tags$strong("'Variables chosen'"), "afterwards. Graphs and analyses do not automatically update when these options are changed."
      ),
      tags$li(
        tags$strong("A QQ plot (quantile-quantile) plot of model residuals"), " is useful to see whether there is significant deviation from approximately normal distribution. If residuals are highly skewed, the linear model may not be a good fit to the model and therefore unreliable. You could consider transforming the response variable, e.g., log, squares, square-roots."
      ),
      tags$li("For Mixed effects analysis, a graph of the same type chosen in Box 6 will be shown, but this time faceted by the Random factor. This allows you to see the effect of experimental blocks. A second graph will show data averaged over levels of the Random factor. These data appear at the bottom of the page. "),
      tags$li(
        "Options for post-hoc comparisons will appear on the 'ANOVAs (linear models) and Comparisons' tab based on the type of analyses."
      ),
      tags$li(
        "Info buttons on the ANOVA tab provide more information on the ANOVA table, post-hoc comparisons, estimated marginal means (EMMEANS)."
      ),
      tags$li(
        "The 'Linear Model' tab provides the summary of the linear model fitted to data in R."
      )))
      )
  )
  })


### FAQs
output$Instr_FAQs <- renderText({ #in use
  HTML(paste0(tags$div(
    tags$br(),
    tags$h5("Tips to avoid errors:"),
    tags$ol(
      tags$li(
        "Ensure that the data is correctly formatted with no spaces in column names (instead use an underscore '_' to separate words). Some special characters, such as Greek letters, may also cause errors."),
      tags$li(
        "If there is an error, reload the app (reload/refresh the page). Repeatedly chaning variables and performing analyes may also lead to errors. Analyses errors may be due to missing values in data table"),
      tags$li(
        "Analyses does not produce ANOVA tables or graphs: this may be because you did not first plot a graph of the data in the Graphs tab."),
      tags$li("Two-way analysis failed: is your grouping variable (Box 3.1) entered as numbers in the data table (e.g., Time in min or years or other units), even though you meant to use these as categorical groups? Enter them as alphanumeric values (e.g., 10min, 20min; y20204, y2025 and so on) so that the app does not assume it to be numeric.")
    ))
    
  ))
})