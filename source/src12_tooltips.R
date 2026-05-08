#help and tooltips
observeEvent(input$varHelpBtn, {
  showModal(modalDialog(
    title = "Variables for graphs and analyses",
    tags$div(tags$ul(
      tags$li("Data should be in a 'long' table saved in csv or Excel format. Upload a file and click 'Start'."),
      tags$li("Pick X- and Y-axis variable. A Grouping variable is optional (e.g., 2way-ANOVAs), but it is required if the X-axis variable is also numeric."),
      tags$li("All variables selected on this page, and log-transformation from the Graphs tab, will be used on Graphs and in the ANOVA analysis."),
      tags$li("Go to Graphs tab to set other essential options, press 'Variables chosen' and then press 'grafify my data' for the plot. This is required even if you only want to analyse data, because eye-balling data is important before the analysis."),
      tags$li("There are several optional settings that change the appearance of Graphs. You can download graphs as a high-resolution PDF file."),
      tags$li("On the ANOVA tab, pick the type of analysis (Simple/Mixed effects) and then click 'Analyse my data'"),
      tags$li("Results will not update automatically if you change variables or other options. Please remember to press appropriate action buttons to get updated Graphs and ANOVA results.")
      )),
    easyClose = TRUE,
    footer = NULL
  ))
})

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

observeEvent(input$ContrHelper, {
  showModal(modalDialog(
    title = "Types of post-hoc comparisons",
    tags$div(tags$ul(
      tags$li(tags$strong("Pairwise:"), tags$em(" All versus all comparison. This is rarely the preferred choice when there are lots of levels within factors.")),
      tags$li(tags$strong("Compare to reference: "), tags$em("Compare a reference or control group with all others. Choose the number of the reference group in the dropdown list below (this is the order of groups in the graph or Boxes 7.1 and 7.2).")),
      tags$li(tags$strong("Levelwise 1: "), tags$em("Compare all groups of the first factor (chosen in Box 1) with each other at each level of the second factor (Box 3.1).")),
      tags$li(tags$strong("Levelwise 2: "), tags$em("Compare all groups of the second factor (chosen in Box 3.1) with each other at each level of the first factor (Box 1).")),
      tags$li(tags$strong("Compare to reference 2way - 1: "), tags$em("Compare a reference or control group within the first factor (chosen in Box 1)  at each level of the second factor (Box 3.1). Choose the number of the reference group in the dropdown list below (this is the order of groups in the graph or Boxes 7.1 and 7.2).")),
      tags$li(tags$strong("Compare to reference 2way - 2: "), tags$em("Compare a reference or control group within the second factor (chosen in Box 3.1)  at each level of the first factor (Box 1). Choose the number of the reference group in the dropdown list below (this is the order of groups in the graph or Boxes 7.1 and 7.2)."))
    )),
    easyClose = TRUE,
    footer = NULL
  ))
})


observeEvent(input$PDFSizeHelper, {
  showModal(modalDialog(
    title = "Dimensions of PDFs for download",
    tags$div(tags$ul(
      tags$li("The size of the graph as it appears online is determined by the screen size you are using and is not the same as the downloaded PDF."), 
      tags$li("Even if the graph appears 'squished' or part of the legend are missing online, it will look good (and contain all parts of the legend), provided the dimensions of the PDF for download are large enough."),
      tags$li("For an 'average' sized graph with ~3 groups along the X-axis at font size 18-20, a starting PDF size of 12cm H x 15 cm W is recommended. Increase or decrease these dimensions (you do not need to click 'grafify my data') and click 'Save as PDF' until you are satisfied with the downloaded graph."),
      tags$li("If you use faceting, add ~ 8cm H and W for each additional panel."),
      tags$li("Note that sizes of symbols or fonts do not scale with the PDF size. If these sizes appear small on the downloaded PDF, increase them using options in ", tags$strong("Box 8"), ".")
    )),
    easyClose = TRUE,
    footer = NULL
  ))
})