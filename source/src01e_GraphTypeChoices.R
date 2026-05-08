#reactive for creating faceting variable as formula
#this is used in facet_grid() in PlotSingCol in app.R
FacVars <- eventReactive(input$varsDone, {
  #start when varsDone is clicked
  observe(input$facetingOpt)
  #null starting vector
  lfvars <- NULL
  #did user select 1 or more faceting var?
  if (input$facetingOpt == "Yes") {
    lfvars <- length(input$varsFive)
  }
  #faceting not selected
  if (input$facetingOpt == "No") {
    fvar <- NULL
  }
  #faceting selected and only 1
  if (input$facetingOpt == "Yes" &
      lfvars == 1) {
    fvar <- as.formula(paste("~", input$varsFive))
  }
  #faceting selected but more than 1
  #paste as formula for facet_grid(~var ~ var)
  if (input$facetingOpt == "Yes" &
      lfvars > 1) {
    fvar <- as.formula(paste("~", input$varsFive, collapse = " ", sep = ""))
  }
  fvar
})
#trial output during development, not used in production
output$FacVars <- renderText({
  paste(FacVars())
})

#Identify type of variables
#is X-axis numeric: will be TRUE if numeric
Xnum <- eventReactive(input$varsDone, {
  req(file1()) #get input file
  f <- file1()
  Xnum <- f[[input$varsOne]] #get name of variable
  is.numeric(Xnum)           #output
})

#How many groups in X-axis variable
#used for emmeans pairwise and reordering X-axis groups
output$XforRelevel <- renderText({
  #get X-axis type from Xnum() reactive
  if (Xnum() == TRUE) {
    tx <- "numeric"
    #if numeric txt output for logical
    txt <- paste("The X-axis variable is ", tx, ".", sep = "")
  }
  #if not txt output for logical
  if (Xnum() == FALSE) {
    tx <- "categorical"
    txt <- paste("The X-axis variable is ", tx, ". You can reorder groups.", sep =
                   "")
  }
  txt
})

######## always on Grouping relevel
#output on src01PanelGraphs_card6_7
output$GpforRelevel <- renderText({       
  #get X-axis type from Xnum() reactive
  observe(input$addVarsOpt)
  if(input$addVarsOpt == "No"){
    txt <- paste("No Grouping variable is selected.", sep = "")
  }
  if (input$addVarsOpt == "Yes" & 
      CatGp() == FALSE) {
    tx <- "numeric"
    #if numeric txt output for logical
    txt <- paste("The Grouping variable is ", tx, ".", sep = "")
  }
  #if not txt output for logical
  if (input$addVarsOpt == "Yes" & 
      CatGp() == TRUE) {
    tx <- "categorical"
    txt <- paste("The Grouping variable is ", tx, ". You can reorder groups.", sep =
                   "")
  }
  txt
})

#levels in Grouping factor, if it is categorical
#used for single colour graphs in src03d_GraphTypeChoices.R
CatGplevels <- eventReactive(input$varsDone, {
  req(file1())
  f <- file1()
  #get number of levels in categorical variable
  if (Xnum() == FALSE &
      CatGp() == TRUE)
    CatGplev <- length(levels(factor(f[[input$varsFour]])))
  CatGplev
})

#how many levels in categorical X-axis
#used by emmeans pairwise, reodering X-axis groups 
#& SingleColour in src03d_GraphTypeChoices.R
#& src03d_anova_n_residuals_SimpMixed
Xlevels <- eventReactive(input$varsDone, {
  req(file1())
  f <- file1()
  if (Xnum() == FALSE)
    Xlev <- length(levels(factor(f[[input$varsOne]])))
  Xlev
})
#names of levels in categorical X-axis
XlevelNames <- eventReactive(input$varsDone, {
  req(file1())
  f <- file1()
  if (Xnum() == FALSE)
    Xlev <- paste(levels(factor(f[[input$varsOne]])), sep = ", ")
  if (Xnum() == TRUE)
    Xlev <- 0
  Xlev
})
#output X axis level names for output in main panel
output$XlevelNames <- renderText({
  if (is.numeric(XlevelNames()))
    txt <- paste("You have chosen a numeric X-axis variable")
  if (!is.numeric(XlevelNames()))
    txt <- paste(
      "Your categorical X-axis variable has the following levels in default (alphabetical) order: ",
      paste(XlevelNames(), collapse = ", ")
    )
  txt
})
#do you want to reorder X variable?
#reorder X variables from vars1
selVarsReLevel <- eventReactive(input$varsDone, {
  #get names of groups if categorical X-axis
  req(file1())
  if (Xnum() == FALSE)
    varList <- unique(file1()[[input$varsOne]])  #should be this format
  #else set to NULL
  if (Xnum() == TRUE)
    varList <- NULL
  #optional UI for groups
  selectizeInput(
    inputId = "varsReLevel",
    label = tooltip(
      trigger = list(
        tags$h3("7.1"),
        tags$strong("Reorder X-axis groups"),
        bs_icon("info-circle")
      ),
      "Choose levels within the categorical X-axis variable in the order you would like them to appear on the graph. Press 'grafify my data' for an updated graph."
    ),
    choices = varList,
    selected = varList,
    multiple = TRUE,
    options = list(dropdownParent = 'body',  
                   plugins = list('remove_button', 'drag_drop')) #shinyjqui
  )
})
########## always on grouping relevel
#reorder Gp variables from vars4
selVarsReLevelGp <- eventReactive(input$varsDone, {
  #get names of groups if categorical Grouping variable
  #observe(input$addVarsOpt)
  req(file1())
  observe(input$addVarsOpt)
  if (input$addVarsOpt == "Yes" & 
      CatGp() == TRUE)
    varList <- unique(file1()[[input$varsFour]])  #should be this format
  if (input$addVarsOpt == "Yes" & 
      CatGp() != TRUE)
    varList <- NULL
  if (input$addVarsOpt == "No")
    varList <- NULL
  #optional UI for groups
  selectizeInput(
    inputId = "varsReLevelGp",
    label = tooltip(
      trigger = list(
        tags$h3("7.2"),
        tags$strong("Reorder levels of Grouping variable"),
        bs_icon("info-circle")
      ),
      "Choose levels within the categorical Grouping variable in the order you would like them to appear on the graph. Press 'grafify my data' for an updated graph."
    ),
    choices = varList,
    selected = varList,
    multiple = TRUE,
    options = list(dropdownParent = 'body',  
                   plugins = list('remove_button', 'drag_drop')) #shinyjqui
  )
})

#UI output for reordering X-axis
output$selVarsReLevel <- renderUI({
  selVarsReLevel()
})

output$selVarsReLevelGp <- renderUI({
  selVarsReLevelGp()
})

#is Y-axis variable numeric?
#used in src03_emmeans
Ynum <- eventReactive(input$varsDone, {
  req(file1())
  f <- file1()
  Ynum <- f[[input$varsTwo]]
  is.numeric(Ynum)
})

#Is Grouping variable categorical?
#used in src03_emmeans.. , src03d_anova_n_residuals_SimpMixed.. , src15_AvgRF_graphs
CatGp <- eventReactive(input$varsDone, {
  req(file1())
  f <- file1()
  observe({
    input$addVarsOpt
  })
  if (input$addVarsOpt == "No")
    ctgp <- 0
  if (input$addVarsOpt == "Yes")
    ctgp <- is.character(f[[input$varsFour]])
  ctgp
})

#get levels within shapes
#used for warning if >25 levels
#output in src01ePanelGraphs_card6_7
ShapeLevs <- eventReactive(input$varsDone, {
  req(file1())
  f <- file1()
  observe({
    input$ShapesOpt
  })
  if (input$ShapesOpt == "No")
    shplv <- 0
  if (input$ShapesOpt == "Yes")
    shplv <- length(levels(factor(f[[input$varsThree]])))
  shplv
})
#UI output for type of Grouping variables (dev)
output$OutCatGp <- renderText({
  CatGp()
})
#UI output for type of X-axis variables (dev)
output$OutXnum <- renderText({
  Xnum()
})
#UI output for type of Y-axis variables (dev)
output$OutYnum <- renderText({
  Ynum()
})
#UI output for type of Shapes variables (production)
#output in src01ePanelGraphs_card6_7
output$ShapeLevs <- renderText({
  observe(input$varsDone)
  if (ShapeLevs() >= 25)
    txt <- paste(
      "Your Shapes variable has ",
      ShapeLevs(),
      " levels. Only up to 25 levels for the shapes variable are allowed for Box/Bar/Violin plot. Any number are allowed for Before-after plots."
    )
  if (ShapeLevs() %in% 1:25)
    txt <- paste(
      "Your Shapes variable has ",
      ShapeLevs(),
      " levels. You can use Box/Bar/Point/Violin and Before-after plots."
    )
  if (ShapeLevs() < 1 &
      Xnum() == FALSE)
    txt <- paste("Your have not chosen a Shapes variable. You can use Box/Bar/Point/Violin plots.")
  if (ShapeLevs() > 0 &
      Xnum() == TRUE)
    txt <- paste("Your X-axis variable is numeric. You can only map colour to symbols in Numeric XY plots.")
  if (input$ShapesOpt == "No" &
      Xnum() == TRUE)
    txt <- paste("Your X-axis variable is numeric. You can only map colour to symbols in Numeric XY plots.")
  txt
})

#Series of choices for 1way or 2way or shapes graphs
#1WAY without shapes
observeEvent(c(input$varsDone), {
  #graphs for Categorical X-axis & 1way ANOVA
  if (input$ShapesOpt == "No" &
      CatGp() == 0 &
      Xnum() == FALSE)
    updateSelectInput(
      #session = "graphType",
      inputId = "graphType",
      #label = tags$strong("Choose graph type"),
      choices = c(
        "Boxplot",
        "Bar graph",
        "Violin plot",
        "Point & Errorbar",
        "Density plot",
        "Histogram plot"
      )
    )
})
#1WAY with shapes
observeEvent(c(input$varsDone), {
  #graphs for Categorical X-axis & 1way ANOVA with randomised blocks/shapes
  if (CatGp() == 0 &
      input$ShapesOpt == "Yes" &
      Xnum() == FALSE)
    updateSelectInput(
      #session = "graphType",
      inputId = "graphType",
      #label = tags$strong("Choose graph type"),
      choices = c(
        "Boxplot",
        "Bar graph",
        "Violin plot",
        "Point & Errorbar",
        "Before-after plot"
      )
    )
})
#2WAY without or with shapes
observeEvent(c(input$varsDone), {
  #graphs for Categorical X-axis & 2way ANOVA
  if (CatGp() %in% c("TRUE", "FALSE") &
      input$ShapesOpt %in% c("No", "Yes") &
      Xnum() == FALSE)
    updateSelectInput(
      #session = "graphType",
      inputId = "graphType",
      #label = tags$strong("Choose graph type"),
      choices = c("Boxplot", "Bar graph", "Violin plot", "Point & Errorbar")
    )
})
observeEvent(c(input$varsDone), {
  #graphs for Numeeric X-axis & categorical Grouping
  if (#input$ShapesOpt == "No" &
    Xnum() == TRUE & Ynum() == TRUE & CatGp() == TRUE)
    updateSelectInput(#session = "graphType",
      inputId = "graphType", #label = tags$strong("Choose graph type"),
      choices = c("Numeric XY 1"))
})
observeEvent(c(input$varsDone), {
  #graphs for Numeeric X-axis & numeric Grouping
  if (#input$ShapesOpt == "No" &
    Xnum() == TRUE & Ynum() == TRUE & CatGp() == FALSE)
    updateSelectInput(#session = "graphType",
      inputId = "graphType", #label = tags$strong("Choose graph type"),
      choices = c("Numeric XY 2"))
})
