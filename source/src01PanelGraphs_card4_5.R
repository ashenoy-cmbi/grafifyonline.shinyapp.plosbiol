Graphs_card4_5 <- list(fluidRow(
  column(
    2,
    selectizeInput(
      "facetingOpt",
      #Add faceting variable yes/no
      #width = "250px",
      label = tooltip(
        trigger = list(
          tags$h3("4"),
          tags$strong("Add a faceting variable to graph (Yes/No)?"),
          bs_icon("info-circle")
        ),
        "A categorical variable to facet plots by, or choose No before proceeding."
      ),
      choices = c("Choose Yes/No" = "", c("Yes", "No")),
      selected = "No",
      options = list(dropdownParent = 'body')
    )
  ),
  column(3, uiOutput("addFacets")),
  #Add faceting variable varsFive
  #textOutput("FacVars")),
  column(2, uiOutput("facet_scaleOut")),
  column(
    2,
    selectizeInput(
      "ShapesOpt",
      #Add shapes yes/no
      #width = "250px",
      label = tooltip(
        trigger = list(
          tags$h3("5"),
          tags$strong("Add a variable for matching/shapes?"),
          bs_icon("info-circle")
        ),
        "A categorical variable to map to shape of symbols or a matching variable for Before-after plots, or choose No before proceeding."
      ),
      choices = c("Choose Yes/No" = "", c("Yes", "No")),
      selected = "No",
      options = list(dropdownParent = 'body')
    )
  ),
  column(3, uiOutput("addShapes") #Shapes variable varsThree
         ),
  column(4,
           actionBttn(
             "varsDone",
             #Done with variables
             label = tooltip(
               trigger = list(tags$strong("Variables Chosen"), bs_icon("check2-circle")),
               "The options available will depend on the type and number of variables you chose before clicking Done. You can choose different variables again and click 'Variables chosen' to update graph options."
             ),
             size = "sm",
             color = "royal",
             style = "unite"
           )
         )
  ))