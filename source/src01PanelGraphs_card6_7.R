Graphs_card6_7 <- list(fluidRow(
  column(
    3,
    selectizeInput(
      "graphType",
      #GraphType dropdown list
      #width = "150px",
      label = tooltip(
        trigger = list(
          tags$h3("6"),
          tags$strong("Choose a graph type."),
          bs_icon("info-circle")
        ),
        "After clicking 'Variables Chosen', choose a graph type and then click 'grafify my data' to visualise the graph."
      ),
      choices = c(
        "Boxplot",
        "Bar graph",
        "Violin plot",
        "Point & Errorbar",
        "Before-after plot",
        "Density plot",
        "Histogram plot",
        "Numeric XY 1",
        "Numeric XY 2"
      ),
      selected = "Boxplot",
      options = list(dropdownParent = 'body')
    )
  ),
  #conditional panel if XY is numeric & boxplot wanted?
  column(4, card(
    tags$strong("Available options:"), 
    textOutput("ShapeLevs"),       #from src01e_GraphTypeChoices
    textOutput("XforRelevel"),     #from src01e_GraphTypeChoices
    textOutput("GpforRelevel")     #from src01e_GraphTypeChoices
  )),
  column(
    2,
    conditionalPanel(
      "input.graphType == 'Numeric XY 1' || input.graphType == 'Numeric XY 2'",
      #from src01f_Optional_GraphSettings.R
    uiOutput("error_typeXY"),      #for XY summary
    #uiOutput("out_smoothyesno"),  #for Smooth 
    uiOutput("ewidXY"),            #for XY errorvars
    uiOutput("out_e_alpha"),       #for XY errorbars
    uiOutput("out_box_wid"),       #for box width
    uiOutput("out_smoothType"),    #for Smooth type
    uiOutput("out_sm_alpha")       #for Smooth SE alpha
    ),
    
    ######## always on Relevel #################
    conditionalPanel(
    "output.XforRelevel != 'The X-axis variable is numeric.'",
    #from src01e_GraphTypeChoices
    htmlOutput("selVarsReLevel"),
    tags$strong("Order of X-axis groups: "),
    #reorder X-axis groups
    #from app.R
    textOutput("newRelevel")       
    )
  ),
  column(2, 
         conditionalPanel(
           "output.GpforRelevel != 'The Grouping variable is numeric.' && input.addVarsOpt == 'Yes'",
           htmlOutput("selVarsReLevelGp"),
           #reorder X-axis groups
           tags$strong("Order of levels in the Grouping variable: "),
           #from app.R
           textOutput("newRelevelGp")#)
         )
    ),
  column(
    3,
    #uiOutputs from src01f_Optional_GraphSettings.R
    conditionalPanel("input.graphType == 'Density plot'", 
                     uiOutput("dens_counts")), 
    conditionalPanel("input.graphType == 'Histogram plot'", 
                     uiOutput("Binsize"),
                     uiOutput("hist_counts")),
    conditionalPanel(
      "input.graphType == 'Bar graph' ||
                     input.graphType == 'Point & Errorbar'",
      #card(card_header("Error bar type"),
      uiOutput("error_type"),
      #errorbar type
      uiOutput("ewid")
    ),
    conditionalPanel(
      "(input.graphType == 'Numeric XY 1' || input.graphType == 'Numeric XY 2') && (input.error_typeXY == 'SD' || input.error_typeXY == 'SEM' input.error_typeXY == 'CI95')",
      #errorbar type
      #uiOutput("ewid"),
      #uiOutput("e_alpha"),
      uiOutput("line_alpha"),
    )
  ),
))