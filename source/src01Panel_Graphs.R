source("./source/src01PanelGraphs_card4_5.R", local = TRUE) #graphs panel 1
source("./source/src01PanelGraphs_card6_7.R", local = TRUE) #graphs panel 2
source("./source/src01PanelGraphs_card8.R", local = TRUE) #graphs panel 3
source("./source/src01PanelGraphs_cardPlotDownload.R", local = TRUE) #graphs panel 4

Panel_Graphs <- list(fluidRow(
  column(12, accordion(
    open = TRUE,
    accordion_panel(
      "Readme: Graphs (can be minimised)",
      #Graphs tab title
      htmlOutput("graphsHelpOpen")
    )
  )),
  column(
    12,
    #full card for side column 8
    tags$br(),
    card(
      card_header(
        tags$h5("Add more variables to graph"),
        class = "d-flex justify-content-between",
        tooltip(
          bs_icon("info-circle"),
          "Please select Yes (and then a variable) or No and then press 'Variables chosen' before proceeding."
        )
      ),
      Graphs_card4_5 #src01Panelgraphs_card4_5.R
    ),
    column(12, card(card_header(
      tags$h5("Graph choice & X-axis options")
    ), Graphs_card6_7 #src01Panelgraphs_card6_7.R))
    ),
    column(
      12,
      card(card_header(
          actionBttn(
            inputId = "makegraph",
            label = tags$strong("grafify my data"),
            width = "10px",
            size = "sm",
            color = "royal",
            style = "unite",
            #block = TRUE,
            icon = bs_icon("power")
          ),
          tooltip(
            bs_icon("info-circle"),
            "The height of this panel can be increased and the sidebar is collapsible. The size of graphs online (depends on your screen size and) does not affect the downloaded PDF. Use Height and Weight options below to resize downloads."
          ),
          class = "d-flex justify-content-between"
        ),
        style = "resize:vertical;",
        height = "800px",
        layout_sidebar(
          fillable = TRUE,
          sidebar = sidebar(width = 350,
            HTML(
              paste(
                tags$h3("8"),
                tags$h5(
                  "Graph Appearance",
                  #sidebar title
                  class = "d-flex justify-content-between",
                  tooltip(
                    bs_icon("info-circle"),
                    "Select options here and click 'grafify my data' to update the graph."
                  )
                )
              )
            ), 
            Graphs_card8),
        Graphs_PlotDownload
      )
    )
    )))))
  
