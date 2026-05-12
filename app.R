#parts of the UI spread across 8 src01Panel___.R files
# The app is spread over 39 source (src_SOME_NAME.R) files
# Many src files are sourced in this file
# Several others are 'nested', as those src files source other src files
# 
#
library(grafify)      #for graphs and analyses
library(bslib)        #for themes
library(bsicons)      #for icons
library(shinyBS)      #for BS tooltip
library(shiny)        #for app
library(shinyWidgets) #for updated shiny
library(colourpicker) #for single colour graphs
library(readxl)       #for file upload
library(readr)        #for file upload
library(ggplot2)      #for facet_grid and others
library(lmerTest)     #for lmerMod
library(emmeans)      #for posthoc comparisons
library(rlang)        #for !! calls
library(gt)           #for colour tables
library(shinyjqui)    #for drag and drop
library(dplyr)        #for mutate

#next few lines required for shinylive only
#library(showtext)
#font_add("Arial", "www/fonts/arial.ttf")
#font_add("Courier", "www/fonts/cour.ttf")
#showtext_auto()

#biology data as default - PBrvw
default_data <- readr::read_csv("./source/cell_death.csv")

#source files for UI parts
source("./source/src01e_menu_links.R", local = TRUE) #menus on navbar
source("./source/src01eFeb08_mainbar_parts.R", local = TRUE) #main page tabsets
source("./source/src01g_Help_n_Images.R", local = TRUE) #For landing page

#for relative subfolder, such as www
app_path <- normalizePath("app.R")

#time stamp
last_updated <- format(file.info(app_path)$mtime, "%d %B %Y, %H:%M") #copilot code 

#has to be after last_updated as it is called in this file
source("./source/src01e_landing_page_bulletlist.R", local = TRUE) #For landing page bullet list PBrvw

# Define UI for application that draws a histogram
ui <- bslib::page_navbar(
  #ga G-059EWJ6910 for shiny.io
  #ga G-TMCF321TZZ for netlify.app
  #for anonymous counting of usage
  tags$head(includeHTML("source/head_copilot.html")),
  tags$body(includeHTML("source/body_copilot.html")), 
  #fluid = TRUE,
  theme = bs_theme(preset = "cosmo",
                   "navbar-bg" = "#aa4499",
                   "progress-bar-bg" = "#445eab",
                   #background colour
                   #bootswatch = "bootstrap",
                   version = "5", 
                   #theme
                   bg = "#ffffff",
                   fg = "#121111",
                   #primary = "#4444ab",                                   #shinylive
                   #secondary = "#55224D",                                 #shinylive
                   #info = "#44abab",                                      #shinylive
                   #success = "#296E13",                                   #shinylive
                   #`enable-shadows` = TRUE,                               #shinylive
                   #`enable-rounded` = TRUE,                               #shinylive
                   #base_font = font_face("sans-serif", src = "/fonts"),   #shinylive
                   #code_font = font_face("monospace", src = "/fonts"),    #shinylive
                   #heading_font = font_face("sans-serif", src = "/fonts") #shinylive
  ),
  #main title
  title = "grafify online",
  
  #sidebar for main page
  
  bslib::nav_panel(
    width = 12,
    title = "Graphs and Analysis",
    
    #main panel sourced from src01 *mainbar* file
    mainPanel(width = 12, fluidRow(
      column(2, tagList(
        tags$div(tags$img(src = "grafify.png", 
                          width = "70%"), 
                 style = "text-align: center;")
      )), 
      column(5,
             landing_info), #from src01e_landing_page_bulletlist.R PBrvw 
      column(3, card(
        card_header(
          div(class = "d-flex flex-column", #PBrvw more info
              tags$h5("Start here"),
              tags$h6("Click 'Start' to try example data or first upload your data.", 
                      class = "text-muted mt-1")),
          #start button
          class = "d-flex justify-content-between",
          tooltip(
            bs_icon("info-circle"),
            "Columns from data table will appear in dropdown menus for choosing variables for the graph."
          )
        ),
        #textOutput("started"),
        fileInput(
          "file1",
          #file upload
          placeholder = "Path to file",
          "Upload a CSV or Excel File (max 20 columns & 20 k rows).",
          accept = c(".csv", ".xlsx", ".xls")
        ),
        uiOutput("sheetSelector"), #from app.R
        actionBttn(
          inputId = "startBtn",
          #start button
          size = "md",
          block = TRUE,
          label = tooltip(
            trigger = list(tags$strong("Start"), bs_icon("info-circle")),
            "Upload a file and click Start, or click Start to use example dataset."
          ),
          color = "royal",
          style = "unite",
          #icon = bs_icon("power")
        ),
        bsTooltip("startBtn", 
                  title = "Test Title", 
                  trigger = "hover")
      )
      )
    ), 
    ),
    mainPanel(mainPanel1, #from src01e_mainbar_navbarFluidRows & src01e_menu_links.R
              width = 12)
  ),
  
  #main menu bar names and links
  nav_panel(title = "Instructions", 
            mainPanel(width = 9,
                      HTML(paste0(tags$div(tags$h6(
                        "Note: Quick help also available by hovering over ", 
                        bs_icon("info-circle"),"icons.")))),
                      tabsetPanel(
                        #from src02_headers_help.R & src_01g_Help_n_Images.R
                        tabPanel(tags$h5("Instructions: Data & Variables"), 
                                 tags$br(),
                                 htmlOutput("Instr_Data")),
                        tabPanel(tags$h5("Graphs"),
                                 tags$br(),
                                 htmlOutput("Instr_Graphs")),
                        tabPanel(tags$h5("ANOVAs & Comparisons"),
                                 tags$br(),
                                 htmlOutput("Instr_ANOVA")),
                        tabPanel(tags$h5("FAQs"),
                                 tags$br(),
                                 htmlOutput("Instr_FAQs"))
                      ),
            )
  ),
  
  #links on menu bar sourced from src01e_menu_links
  nav_menu(
    title = "Links",
    align = "left",
    #shenoy lab
    nav_item(link_shenoy),   
    #GitHub
    nav_item(link_github),
    #grafify vignettes
    nav_item(link_vignettes),
    #microbio stats
    nav_item(link_biostats),
    #r coding workshop
    nav_item(link_rcoding)
  ),
  
  #favicon for browswers in www folder
  tags$head(tags$link(rel = "shortcut icon", href = "grafify.ico")),
  
  #for copying code
  tags$script(HTML("
  Shiny.addCustomMessageHandler('copy-to-clipboard', function(msg) {
    navigator.clipboard.writeText(msg);
  });
"))
  
)

# server logic
server <- function(input, output, session) {
  #bslib::bs_themer() #during development
  
  #Main uploaded file
  file1 <- reactive({
    inFile <- input$file1
    #get file extension
    file_ext <- tools::file_ext(input$file1$name)
    
    #options if file is csv, excel or null
    if (is.null(inFile)) {
      #use 2way ANOVA file
      file1 <- default_data #PBrvw biology data
    } else if (file_ext == "csv") {
      file1 <- read_csv(inFile$datapath)
    } else if (file_ext %in% c("xlsx", "xls")) {
      file1 <-
        read_excel(input$file1$datapath, sheet = input$sheet)
    } else {
      stop("Unsupported file type")
    }
    
    #### PBrvw
    #limit file size
    validate(
      need(nrow(file1) <= 20000,
           "Dataset too large (>20,000 rows). Please downsample your data."),
      need(ncol(file1) <= 20,
           "Too many columns (>20). Please keep only relevant variables.")
    )
    
    # replace space etc with _
    original_names <- names(file1)
    names(file1) <- gsub("\\.+", "_",
                         make.names(names(file1), unique = TRUE))
    
    if (!identical(original_names, names(file1))) {
      showNotification(
        "Column names adjusted for compatibility with R (spaces/special characters replaced).",
        type = "message",
        duration = 10
      )
    }
    file1
  })
  
  ###
  #sheet selector UI for Excel file
  output$sheetSelector <- renderUI({
    req(input$file1)
    file_ext <- tools::file_ext(input$file1$name)
    if (file_ext %in% c("xlsx", "xls")) {
      sheets <- excel_sheets(input$file1$datapath)
      selectInput("sheet", "Select Sheet", choices = sheets)
    }
  })
  
  #X-axis varsOne reactive Box 1
  v1Input <- eventReactive(input$startBtn, {
    req(file1())
    # Variable selection:
    varSelectInput(
      inputId = "varsOne",
      label = tooltip(
        trigger = list(
          tags$h3("1"),
          tags$strong("X-axis variable (categorical or numeric)"),
          bs_icon("info-circle")
        ),
        "Pick a variable to plot along the X-axis. This is typically a categorical variable for box/bar/point/violin plots. If your X-axis variable is numeric, please also select a Grouping variable."
      ),
      selected = NULL,
      data = file1(),
      selectize = TRUE,
      multiple = FALSE
    )
  })
  #varsOne UI output X-axis Box 1
  output$varsel1 <- renderUI({
    v1Input()
  })
  
  #Y-axis varsTwo reactive Box 2
  v2Input <- eventReactive(input$startBtn, {
    req(file1())
    # Variable selection:
    varSelectInput(
      inputId = "varsTwo",
      label = tooltip(
        trigger = list(
          tags$h3("2"),
          tags$strong("Y-axis variable (should be a numeric variable)"),
          bs_icon("info-circle")
        ),
        "Pick a numeric variable to plot along the Y axis."
      ),
      data = file1(),
      selectize = TRUE,
      selected = NULL,
      multiple = FALSE
    )
  })
  #varsTwo UI output Y-axis Box 2
  output$varsel2 <- renderUI({
    v2Input()
  })
  
  #Shapes Box5 varsThree reactive
  v3Input <- eventReactive(input$startBtn, {
    req(file1())
    # Variable selection:
    varSelectizeInput(
      inputId = "varsThree",
      label = tooltip(
        trigger = list(
          tags$h3("5.1"),
          tags$strong("Choose a shapes/matching variable from your data."),
          bs_icon("info-circle")
        ),
        "Choose a column from your data."
      ),
      data = file1(),
      selected = NULL,
      options = list(dropdownParent = 'body'),
      multiple = FALSE
    )
  })
  #Shapes varsThree UI output Box 5
  output$varsel3 <- renderUI({
    v3Input()
  })
  
  #Grouping variable varsFour reactive Box 3.1
  v4Input <- eventReactive(input$startBtn, {
    req(file1())
    # Variable selection:
    varSelectInput(
      inputId = "varsFour",
      label = tooltip(
        trigger = list(
          tags$h3("3.1"),
          tags$strong("Select a Grouping variable (e.g., 2-way ANOVA designs)"),
          bs_icon("info-circle")
        ),
        "Choose a column from your data."
      ),
      selected = NULL,
      data = file1(),
      selectize = TRUE,
      multiple = FALSE
    )
  })
  #Grouping varsFour UI output Box 3.1
  output$varsel4 <- renderUI({
    v4Input()
  })
  #Faceting variable varsFive reactive Box 4.1
  v5Input <- eventReactive(input$startBtn, {
    req(file1())
    # Variable selection:
    varSelectizeInput(
      inputId = "varsFive",
      label = tooltip(
        trigger = list(
          tags$h3("4.1"),
          tags$strong("Choose faceting variables for graphs from your data."),
          bs_icon("info-circle")
        ),
        "Choose one or more columns from your data. If you choose more than one variable, faceting will use them in the chosen order to generate panels by rows and then by columns."
      ),
      data = file1(),
      multiple = TRUE,
      options = list(dropdownParent = 'body'),
      selected = ""
    )
  })
  #faceting varsFive UI output Box 4.1
  output$varsel5 <- renderUI({
    v5Input()
  })
  
  #Random variable varsSix reactive Box 9.1
  v6Input <- eventReactive(input$startBtn, {
    req(file1())
    # Variable selection:
    varSelectizeInput(
      inputId = "varsSix",
      label = tooltip(
        trigger = list(
          tags$h3("9.1"),
          tags$strong("Random factor for Mixed ANOVA."),
          bs_icon("info-circle")
        ),
        "Choose a column from your data. Note: a random intercepts model will be fitted."
      ),
      data = file1(),
      multiple = FALSE,
      options = list(dropdownParent = 'body'),
      selected = ""
    )
  })
  #Random varsSix UI output Box 9.1
  output$varsel6 <- renderUI({
    req(input$MorS)
    if (input$MorS == "Mixed")
      v6Input()
  })
  
  #UI output to select a Vars3 if Shapes is yes
  output$addShapes <- renderUI({
    if (input$ShapesOpt == "Yes")
      uiOutput("varsel3")
  })
  #UI output to select vars5 if Faceting is yes
  output$addFacets <- renderUI({
    if (input$facetingOpt == "Yes")
      uiOutput("varsel5")
  })
  #UI output for selecting vars4 for Grouping variable
  output$addMoreVars <- renderUI({
    if (input$addVarsOpt == "Yes")
      uiOutput("varsel4")
  })
  
  #reactive to get a conditional panel match for start button click
  # condition panel used in src01Panel_DataVars.R
  startedq <- eventReactive(input$startBtn, {
    txt <- paste("Now pick variables.")
  })
  #UI output for start reactive for conditional above
  output$started <- renderText({
    startedq()
  })
  #Option to have output even when not on page
  outputOptions(output, "started", suspendWhenHidden = FALSE)
  
  #source file with updated choices of graphs based on variable types
  source("./source/src01e_GraphTypeChoices.R",
         local = TRUE,
         echo = TRUE)
  
  #update default colour palettes if numeric XY2 graph
  observe({
    if (input$graphType == "Numeric XY 2")
      updateSelectInput(
        #session = "graphType",
        inputId = "colpal",
        #label = tags$strong("Choose graph type"),
        choices = c(
          "blue_conti",
          "yellow_conti",
          "grey_conti",
          "PrGn_div",
          "OrBl_div"
        )
      )
  })
  
  #update back to default colour palettes if user goes back after numeric XY2
  observe({
    if (input$graphType != "Numeric XY 2")
      updateSelectInput(
        #session = "graphType",
        inputId = "colpal",
        #label = tags$strong("Choose graph type"),
        choices = c(
          "okabe_ito",
          "bright",
          "contrast",
          "dark",
          "fishy",
          "kelly",
          "light",
          "muted",
          "pale",
          "r4",
          "safe",
          "vibrant"
        )
      )
  })
  
  #  #UI output for for X-axis log transformations
  #  output$logTransX <- renderUI({
  #    if (Xnum() == TRUE)
  #      #graph_log X
  #      pickerInput(
  #        "logTransX",
  #        label = tooltip(
  #          trigger = list(tags$strong("Log(X) axis"), bs_icon("info-circle")),
  #          "Pick a log-X axis if X-axis variable is also numeric. Log-transformed data will be used in analyses."
  #        ),
  #        choices = c("", "log10", "log2"),
  #        selected = "",
  #        multiple = FALSE
  #      )
  #  })
  #  #use UI output even when hidden
  #  outputOptions(output, "logTransX", suspendWhenHidden = FALSE)
  
  #UI output for violin transparency
  observe({
    if (input$graphType == "Violin plot")
      updateNumericInput(
        inputId = "box_alpha",
        min = 0, step = 0.1,
        max = 1,
        value = 0
      )
  })
  #UI output of transparency if not violins
  observe({
    if (!input$graphType %in% c("Violin plot",
                                "Numeric XY 1",
                                "Numeric XY 2") )
      updateNumericInput(
        inputId = "box_alpha",
        min = 0, step = 0.1,
        max = 1,
        value = 1
      )
  })
  #update UI output symsize for plot_point_sd plots
  observe({
    if (input$graphType == "Point & Errorbar")
      updateNumericInput(
        inputId = "sym_size",
        min = 0, step = 1,
        max = 10,
        value = 5
      )
  })
  #update UI output if not plot_point_sd plots
  observe({
    if (input$graphType != "Point & Errorbar")
      updateNumericInput(
        inputId = "sym_size",
        min = 0, step = 1,
        max = 10,
        value = 3
      )
  })
  #update UI output for transparency for plot_point_sd
  observe({
    if (input$graphType == "Point & Errorbar")
      updateNumericInput(
        inputId = "sym_alpha",
        min = 0, step = 0.1,
        max = 1,
        value = 1
      )
  })
  #update UI output for transparency if not plot_point_sd
  observe({
    if (input$graphType != "Point & Errorbar")
      updateNumericInput(
        inputId = "sym_alpha",
        min = 0, step = 0.1,
        max = 1,
        value = 0.8
      )
  })
  #update UI output jitter for plot_point_sd
  observe({
    if (input$graphType == "Point & Errorbar")
      updateNumericInput(
        inputId = "sym_jitter",
        min = 0, step = 0.1,
        max = 1,
        value = .05
      )
  })
  #update UI output jitter if not plot_point_sd
  observe({
    if (input$graphType != "Point & Errorbar")
      updateNumericInput(
        inputId = "sym_jitter",
        min = 0, step = 0.1,
        max = 1,
        value = 0.1
      )
  })
  #UI output update for textAngle if XY numeric
  observe({
    if (Xnum() == TRUE)
      updateNumericInput(inputId = "text_angle", value = 0)
  })
  #UI output update for textAngle if not XY numeric
  observe({
    if (Xnum() == FALSE)
      updateNumericInput(inputId = "text_angle", value = 45)
  })
  
  #Next set of reactives are for updating input data table
  #based on user-defined levels in vars1 and vars2
  #This varies based on 1way or 2way designs, or XY1 
  
  #Reactive for reordering X groups 
  #This reactive forces vars1 to factors and provides levels
  RelevelNames <- reactive({
    #force to factors and levels originally from data
    #get levels within categorical X-axis
    req(file1())
    f <- file1()
    ############ always on relevel
    f[[input$varsOne]] <- factor(f[[input$varsOne]], levels = input$varsReLevel)
    flev <- levels(f[[input$varsOne]])
    flev
  })
  #UI output text for user about reordering
  #output in src01PanelGraphs_card6_7
  output$newRelevel <- renderText({
    txt <- paste(paste(RelevelNames(), collapse = ", "))
    txt
  })
  ############## always on Grouping relevel
  #output in src01PanelGraphs_card6_7
  output$newRelevelGp <- renderText({
    txt <- paste(paste(RelevelNamesGp(), collapse = ", "))
    txt
  })
  
  #Reactive for reordering Grouping vars4
  #This reactive forces vars4 to factors and provides levels
  RelevelNamesGp <- reactive({
    #force to factors and levels originally from data
    #get levels within categorical X-axis
    req(file1())
    f <- file1()
    ############ always on relevel #PBrvw for Xcat & CatNum
    if(CatGp()){
      f[[input$varsFour]] <- factor(f[[input$varsFour]], levels = input$varsReLevelGp)
      flev <- levels(f[[input$varsFour]])
    } else {
      flev <- input$varsReLevelGp
    }
    flev
  })
  
  #Update/relevel X axis vars1 groups and get new table
  #This is when X and vars4 are categorical
  RelevelFile1 <- reactive({
    #force to factors and levels originally from data
    #then from user input of groups as new levels
    #varsReLevel has names of groups from user
    #drop levels not used
    req(file1())
    ######### relevel with dplyr
    req(input$varsReLevel, input$varsReLevelGp)
    observe(input$addVarsOpt)
    #### copilot PBrvw to allow X-categorical & Grouping Numeric to also plot 2way ANOVA
    # ---- CASE 1: both numeric → do nothing
    
    if(is.numeric(file1()[[input$varsOne]]) &
       is.numeric(file1()[[input$varsFour]]) ) {
      return(file1())
    }
    
    #---- CASE 2: X categorical, grouping numeric → filter grouping only
    
    if (!is.numeric(file1()[[input$varsOne]]) &
        is.numeric(file1()[[input$varsFour]])) {
      gp_vals <- suppressWarnings(as.numeric(input$varsReLevelGp))
      return(
        file1() %>%
          filter(
            get(input$varsOne) %in% input$varsReLevel,
            get(input$varsFour) %in% gp_vals
          ) %>%
          mutate(
            across(all_of(input$varsOne),
                   ~factor(.x, levels = input$varsReLevel))
          )
      )
    }
    
    # ---- CASE 3: both categorical → filter + relevel
    if (!is.numeric(file1()[[input$varsOne]]) &
        !is.numeric(file1()[[input$varsFour]])) {
      file1() %>% 
        filter(get(input$varsOne) %in% input$varsReLevel,
               get(input$varsFour) %in% input$varsReLevelGp) %>% 
        mutate(across(all_of(input$varsOne), ~factor(.x, levels = input$varsReLevel)),
               across(all_of(input$varsFour), ~factor(.x, levels = input$varsReLevelGp)))}
  })
  
  #Update/relevel X axis vars1 groups and get new table
  #This is for XY1 graphs (categorical vars4)
  RelevelFile1.2 <- reactive({
    #force to factors and levels originally from data
    #then from user input of groups as newlevels
    #varsReLevel has names of groups from user
    #drop levels not used
    req(file1())
    ######### relevel with dplyr
    req(input$varsReLevelGp)
    observe(input$addVarsOpt)
    file1() %>% 
      filter(get(input$varsFour) %in% input$varsReLevelGp) %>% 
      mutate(across(all_of(input$varsFour), ~factor(.x, levels = input$varsReLevelGp)))
  })
  
  ######### reactive when there is no Grouping variable 
  #drop levels for X axis and get new table
  #This is for 1way designs
  RelevelFile1.1 <- reactive({
    #force to factors and levels originally from data
    #then from user input of groups as newlevels
    #varsReLevel has names of groups from user
    #drop levels not used
    req(file1())
    ######### relevel with dplyr
    req(input$varsReLevel)
    if(is.numeric(file1()[[input$varsOne]]) ) {
      return(file1())
    }
    file1() %>% 
      filter(get(input$varsOne) %in% input$varsReLevel) %>% 
      mutate(across(all_of(input$varsOne), ~factor(.x, levels = input$varsReLevel)))
  })
  
  ########
  #reactive to make user table for main landing page
  tabInput <- eventReactive(input$startBtn, {
    file2 <- file1()
    yname <- colnames(file2)[colnames(file2) == input$varsTwo]
    n <- length(colnames(file2))
    gt(file2) %>% 
      fmt_auto() %>%
      cols_align(
        align = "center",
        columns = everything()) %>%
      opt_interactive()
  })
  #UI output of user table
  output$mytable2 <- render_gt({
    h3("Your data table")
    br()
    tabInput()
  })
  
  #source options for point_sd, errorbars, single colour
  source("./source/src01f_Optional_GraphSettings.R", local = TRUE)
  #source help for tab panels & instructions menu option
  source("./source/src02_headers_help.R", local = TRUE, echo = TRUE)
  #source of emmeans calls
  source("./source/src03b_emmeans.R", local = TRUE, echo = TRUE)
  #source of ANOVA and Residuals plots calls
  source("./source/src03d_anova_n_residuals_SimpMixed_B.R",
         local = TRUE,
         echo = TRUE)
  #source graph types without/with shapes & faceting
  source("./source/src04_boxplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src05_barplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src05b_pointSD_plot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src06_matchplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src08_violinplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src09_befafterplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src10a_3dviolinplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src10b_3dboxplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src10c_3dbarplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src10d_3dpointSDplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src11a_4dBoxplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src11b_4dShapesBoxplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src11c_4dBarplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src11d_4dShapesBarplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src11e_4dViolinplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src11f_4dShapesViolinplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src11g_4dPointplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  source("./source/src11h_4dShapesPointpoint_n_save.R",
         local = TRUE,
         echo = TRUE)
  #plot func is in src14b_plot_density_histo
  source("./source/src14_DensityHistogram_plot_n_save.R",
         local = TRUE,
         echo = TRUE)
  
  #source with tooltips for i icons
  source("./source/src12_tooltips.R", 
         local = TRUE,
         echo = TRUE)
  source("./source/src13_numericXYplot_n_save.R",
         local = TRUE,
         echo = TRUE)
  
  #main reactive with conditions for which graph to plot
  whichplotChosenGraph <- eventReactive(input$makegraph, {
    #boxplot w & w/o facets
    if (input$graphType == "Boxplot" &
        input$addVarsOpt == "No" &
        input$ShapesOpt == "No")
      p <- plotBox_react()
    #bar graph w & w/o facets
    if (input$graphType == "Bar graph" &
        input$addVarsOpt == "No" &
        input$ShapesOpt == "No")
      p <- plotBar_react()
    #violin graph w & w/o facets
    if (input$graphType == "Violin plot"  &
        input$addVarsOpt == "No" &
        input$ShapesOpt == "No")
      p <- plotViolin_react()
    #pointSD
    if (input$graphType == "Point & Errorbar" &
        input$addVarsOpt == "No" &
        input$ShapesOpt == "No")
      p <- plotPointSD_react()
    
    #befafter graph w & w/o facets
    if (input$graphType == "Before-after plot"  &
        input$addVarsOpt == "No" &
        input$ShapesOpt == "Yes")
      p <- plotBefAfter_react()
    
    #3dBox graphs w & w/o facets
    if (input$graphType == "Boxplot" &
        input$addVarsOpt == "No" &
        input$ShapesOpt == "Yes")
      p <- plot3dBox_react()
    #3dViolin graphs w & w/o facets
    if (input$graphType == "Violin plot" &
        input$addVarsOpt == "No" &
        input$ShapesOpt == "Yes")
      p <- plot3dViolin_react()
    #3dBar graphs w & w/o facets
    if (input$graphType == "Bar graph" &
        input$addVarsOpt == "No" &
        input$ShapesOpt == "Yes")
      p <- plot3dBar_react()
    #3dpoint graphs w & w/o facets
    if (input$graphType == "Point & Errorbar" &
        input$addVarsOpt == "No" &
        input$ShapesOpt == "Yes")
      p <- plot3dPoint_react()
    
    #4dbox w/ w/o shapes (w/o facets)
    if (input$graphType == "Boxplot" &
        input$addVarsOpt == "Yes" &
        input$ShapesOpt == "Yes")
      p <- plot4dShapesBox_react()
    if (input$graphType == "Boxplot" &
        input$addVarsOpt == "Yes" &
        input$ShapesOpt == "No")
      p <- plot4dBox_react()
    #4dbar w/ w/o shapes (wo/ facets)
    if (input$graphType == "Bar graph" &
        input$addVarsOpt == "Yes" &
        input$ShapesOpt == "Yes")
      p <- plot4dShapesBar_react()
    if (input$graphType == "Bar graph" &
        input$addVarsOpt == "Yes" &
        input$ShapesOpt == "No")
      p <- plot4dBar_react()
    #4dviolin w/ w/o shapes (w/o facets)
    if (input$graphType == "Violin plot" &
        input$addVarsOpt == "Yes" &
        input$ShapesOpt == "Yes")
      p <- plot4dShapesViolin_react()
    if (input$graphType == "Violin plot" &
        input$addVarsOpt == "Yes" &
        input$ShapesOpt == "No")
      p <- plot4dViolin_react()
    #4dbar w/ w/o shapes (wo/ facets)
    if (input$graphType == "Point & Errorbar" &
        input$addVarsOpt == "Yes" &
        input$ShapesOpt == "Yes" )
      p <- plot4dShapesPoint_react()
    if (input$graphType == "Point & Errorbar" &
        input$addVarsOpt == "Yes" &
        input$ShapesOpt == "No" )
      p <- plot4dPoint_react()
    
    #XY numeric catGroup
    if (input$graphType == "Numeric XY 1" &
        input$addVarsOpt == "Yes")
      p <- plot_XYCat_react()
    if (input$graphType == "Numeric XY 2" &
        input$addVarsOpt == "Yes")
      p <- plot_XYNum_react()
    
    #Density & Histogram
    if (input$graphType == "Density plot")
      p <- plotDensity_react()
    if (input$graphType == "Histogram plot" )
      p <- plotHistogram_react()
    
    #output reactive graph p
    p
  })
  
  #output$plotChosenGraph <- renderPlot({ whichplotChosenGraph() })
  
  #add single colour on chosen graph if user selects one
  #  PlotSingCol <- eventReactive(input$makegraph, {
  #    ifelse(input$facetingOpt == "Yes",
  #           p <- whichplotChosenGraph() +
  #             facet_grid(FacVars(),
  #                        scales = input$facet_scales),
  #           p <- whichplotChosenGraph())
  #    if(input$addVarsOpt == "Yes" & 
  #       Xnum() == FALSE & 
  #       CatGp() == TRUE){singColnum <- CatGplevels()}
  #    if(input$addVarsOpt == "No" & 
  #       Xnum() == FALSE) {singColnum <- Xlevels()}
  #    
  #    #input$colPick from src01PanelGraphs_card8.R
  #    #also in src03d_anova_n_residuals_SimpleMixed...
  #    #also in src15_AvgRF_graphs
  #    ifelse (input$colPick == "No" , 
  #            p <- p,
  #            p <- p +
  #              #input$colPick2 from src01PanelGraphs_card8.R
  #              #also used in src03d_anova_n_residuals_SimpleMixed...
  #              scale_fill_manual(values = rep(input$colPick2, 
  #                                             times = singColnum)))
  #    p
  #  })
  
  ###############
  ### 08052026 PBrvw
  # no ifelse()
  # better handling of rep()
  source("./source/src01i_graf_call_helper.R",
         local = TRUE,
         echo = TRUE)
  
  PlotSingCol <- eventReactive(input$makegraph, {
    
    p <- whichplotChosenGraph()
    
    if (input$facetingOpt == "Yes") {
      p <- p + facet_grid(FacVars(), 
                          scales = input$facet_scales)
      ### PBrvw collect faceting code
      facet_code <- paste0(
        " + facet_grid(",
        deparse(FacVars()),
        ", scales = '", input$facet_scales, "')"
      )
      # attach faceting code to plot object
      attr(p, "facet_code") <- facet_code
      
    }
    
    singColnum <- NULL
    
    if (input$addVarsOpt == "Yes" &&
        !Xnum() &&
        CatGp()) {
      singColnum <- CatGplevels()
    }
    
    if (input$addVarsOpt == "No" &&
        !Xnum()) {
      singColnum <- Xlevels()
    }
    
    if (input$colPick != "No" && !is.null(singColnum)) {
      cols <- rep(as.character(input$colPick2), length.out = singColnum)
      p <- p + scale_fill_manual(values = cols)
    }
    
    p
  })
  
  
  grafify_code_ev <- eventReactive(input$makegraph, {
    
    code <- get_grafify_call(input)
    
    # ---- format to one argument per line ----
    #code <- gsub("\\(", "(\n  ", code)
    #code <- gsub(", ", ",\n  ", code)
    #code <- gsub("\\)$", "\n)", code)
    facet_code <- attr(PlotSingCol(), "facet_code")
    paste0(code, facet_code)
    
  })
  # for copying grafify:: code
  observeEvent(input$copy_code, {
    code <- grafify_code_ev()
    session$sendCustomMessage("copy-to-clipboard", code)
  })
  
  output$grafify_code <- renderText({
    req(grafify_code_ev())
    grafify_code_ev()
  })
  
  ############  
  #main UI output of graph
  output$plotChosenGraph <- renderPlot({
    PlotSingCol()
  })
  
  #UT output for download button
  output$SaveGraph <- downloadHandler(
    filename = function(file) {
      "grafify_plot.pdf"
    },
    content = function(file) {
      ggsave(
        file,
        width = input$g_wid,
        height = input$g_ht,
        units = "cm"
      )
    }
  )
  
  #for Inno
  session$onSessionEnded(function() {
    stopApp()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
