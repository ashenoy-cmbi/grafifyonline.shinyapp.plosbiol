#effi - start
observeEvent(input$varHelpBtn, {
  showModal(modalDialog(
    
    title = "Variables for graphs and analyses",
    
    tags$div(tags$ul(
      
      tags$li(
        "Upload data in long format (CSV or Excel), then click ",
        tags$strong("'Start'"), "."
      ),
      
      tags$li(
        "Select X- and Y-axis variables. ",
        "A grouping variable is optional for categorical X, but ",
        tags$strong("required if X is numeric"), "."
      ),
      
      tags$li(
        "Selected variables and any log-transformation will be used in both Graphs and ANOVA analyses."
      ),
      
      tags$li(
        "Go to the Graphs tab, choose options, then click ",
        tags$strong("'Variables chosen'"),
        " and ",
        tags$strong("'grafify my data'"),
        " to create the plot.",
        tags$br(),
        tags$strong("Note: "),
        "This step is required even if you only want to analyse data."
      ),
      
      tags$li(
        "Optional settings can change the appearance of graphs. ",
        "Graphs can be downloaded as high-resolution PDFs."
      ),
      
      tags$li(
        "On the ANOVA tab, choose Simple or Mixed effects, then click ",
        tags$strong("'Analyse my data'"), "."
      ),
      
      tags$li(
        tags$strong("Important: "),
        "Results do not update automatically. ",
        "After any change, click the relevant buttons to update Graphs and ANOVA results."
      )
      
    )),
    
    easyClose = TRUE,
    footer = NULL
    
  ))
})

observeEvent(input$ContrHelper, {
  showModal(modalDialog(
    
    title = "Types of post-hoc comparisons",
    
    tags$div(tags$ul(
      
      tags$li(
        tags$strong("Pairwise: "),
        tags$em(
          "Compares all groups with each other (all vs all). ",
          "Useful for small numbers of groups, but can become difficult to interpret when many groups are present."
        )
      ),
      
      tags$li(
        tags$strong("Compare to reference: "),
        tags$em(
          "Compares one reference (control) group with all others. ",
          "Select the reference group from the dropdown below (based on group order shown in the graph or Boxes 7.1–7.2)."
        )
      ),
      
      tags$li(
        tags$strong("Levelwise - Grouping variable: "),
        tags$em(
          "Compares levels of the X-variable (Box 1) ",
          "within each level of the Grouping factor (Box 3.1)."
        )
      ),
      
      tags$li(
        tags$strong("Levelwise - X-variable: "),
        tags$em(
          "Compares levels of the Grouping factor (Box 3.1) ",
          "within each level of the X-axis variable (Box 1)."
        )
      ),
      
      tags$li(
        tags$strong("Compare to reference (2-way) – 1: "),
        tags$em(
          "Compares a reference group within the first factor (Box 1), ",
          "at each level of the second factor (Box 3.1). ",
          "Choose the reference from the dropdown."
        )
      ),
      
      tags$li(
        tags$strong("Compare to reference (2-way) – 2: "),
        tags$em(
          "Compares a reference group within the second factor (Box 3.1), ",
          "at each level of the first factor (Box 1). ",
          "Choose the reference from the dropdown."
        )
      )
      
    )),
    
    easyClose = TRUE,
    footer = NULL
    
  ))
})

observeEvent(input$PDFSizeHelper, {
  showModal(modalDialog(
    
    title = "Dimensions of PDFs for download",
    
    tags$div(tags$ul(
      
      tags$li(
        tags$strong("Important: "),
        "The graph you see on screen is NOT the same size as the downloaded PDF."
      ),
      
      tags$li(
        "Graphs may look 'squished' or incomplete on screen (e.g., missing parts of the legend). ",
        "This is due to screen size limitations."
      ),
      
      tags$li(
        tags$strong("The downloaded PDF will look correct "),
        "as long as the width and height are large enough."
      ),
      
      tags$li(
        tags$strong("Recommended starting size: "),
        "~12 cm (height) × 15 cm (width) for ~3 groups at font size 18–20 with short X-axis labels and legends."
      ),
      
      tags$li(
        "If the graph looks crowded or labels overlap, increase the width and/or height and click ",
        tags$strong("'Save as PDF'"), ".",
        tags$br(),
        tags$strong("Note: "),
        "You do NOT need to click 'grafify my data' when changing PDF size."
      ),
      
      tags$li(
        "If using faceting, increase both height and width by ~8 cm for each additional panel."
      ),
      
      tags$li(
        tags$strong("Important: "),
        "Font size and symbol size do NOT scale with PDF dimensions."
      ),
      
      tags$li(
        "If text or points appear small in the PDF, increase them using ",
        tags$strong("Box 8"),
        " before downloading."
      )
      
    )),
    
    easyClose = TRUE,
    footer = NULL
    
  ))
})
#effi - end

observeEvent(input$AnTbleHelpBtn, {
  showModal(modalDialog(
    title = "ANOVA table",
    tags$div(tags$ul(
      tags$li("The sum of squares (sq), degrees of freedom (Df) and F value are shown."),
      tags$li("Pr(>F) is the P value for getting an F value at least as large as the one calculated from data."),
      tags$li("Use the ANOVA table to decide whether post-hoc comparisons will be meaningful.")
    )),
    easyClose = TRUE,
    footer = NULL
  ))
})

observeEvent(input$EmmeansHelpBtn, {
  showModal(modalDialog(
    title = "EMM Table",
    tags$div(tags$ul(
      tags$li("This provides estimated marginal mean (emmean) calculated form the fitted linear model for each level within factors."),
      tags$li("Standard error (SE) and CI95 (95% confidence intervals) are calculated from the fitted linear model."),
      tags$li("df indicates degrees of freedom."),
      tags$li(tags$em("Note: the emmeans are calculated from the fitted model and will be different from means calculated from original data.")),
      
    )),
    easyClose = TRUE,
    footer = NULL
  ))
})

observeEvent(input$ConstrasHelpBtn, {
  showModal(modalDialog(
    title = "EMM",
    tags$div(tags$ul(
      tags$li("This table provides comparisons (contrasts) between various groups and the associated P value.")
    )),
    easyClose = TRUE,
    footer = NULL
  ))
})
