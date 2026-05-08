Graphs_PlotDownload <- list(#layout_sidebar(fillable = TRUE, 
plotOutput("plotChosenGraph", #graph output
           #width = "60vw",
           height = "60vh"),
#textOutput("FacVars"),
#plotOutput("plotgraph2"),
#tags$br(),
#sidebar = sidebar()),
fluidRow(
  column(3, #PDF height
         numericInput(
           "g_ht",
           label = tooltip(trigger = list(
             tags$strong("Graph Height (cm)"), bs_icon("info-circle")
           ), "Adjust height of PDF file."),
           value = 12
         )),
  column(3, numericInput(
    "g_wid",
    #PDF width
    label = tooltip(trigger = list(
      tags$strong("Graph Width (cm)"), bs_icon("info-circle")
    ), "Adjust width of PDF file."),
    value = 15
  )),
  #tags$br(),
  #column so that next button is not on the same line and less wide
  column(10),
  column(
    3,
    downloadBttn(
      "SaveGraph",
      size = "sm",
      #download button
      label = "Save as PDF",
      color = "royal",
      style = "unite",
      block = TRUE,
      icon = bs_icon("download")
    )
  ),
  column(
    6,
    actionButton(
      "PDFSizeHelper",
      #Posthoc comparisons help button
      label = "More Info on sizing PDFs for download",
      icon = icon("info-circle"),
      class = "btn-info",
      style = "unite"
    ),
  )
))