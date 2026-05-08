Graphs_card8 <- list(fluidRow(column(
  12,
  accordion(
    open = TRUE,
    #Colour options accordion, open default
    accordion_panel(
      "Colour Options",
      #graph_colours
      selectizeInput(
        "colpal",
        #colour palette choices for categorical X
        label = tooltip(
          trigger = list(tags$strong("Colour Scheme"), bs_icon("info-circle")),
          "Pick one of several colourblind-friendly grafify palettes for categorical or numeric variables."
        ),
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
          "vibrant",
          "blue_conti",
          "yellow_conti",
          "grey_conti",
          "PrGn_div",
          "OrBl_div"
        ),
        selected = "okabe_ito",
        options = list(dropdownParent = 'body'),
        multiple = FALSE
      ),
      #from src01_Optional_GraphSettings
      uiOutput("colSeqOut"),
      #ColSeq option
      uiOutput("colRevOut"),
      #ColRev option
      conditionalPanel(
        #Conditional panel for SingleColour plots
        "input.graphType == 'Boxplot' ||
         input.graphType == 'Bar graph' ||
         input.graphType == 'Point & Errorbar' ||
         input.graphType == 'Violin plot' ||
         input.graphType == 'Before-after plot' ||
         input.graphType == 'Density plot' ||
         input.graphType == 'Histogram plot'",
        selectizeInput(
          inputId = "colPick",
          #Single colour yes/no
          label =  tooltip(
            trigger = list(
              tags$strong("Graph with a single colour (Yes/No)?"),
              bs_icon("info-circle")
            ),
            "If you have lots of groups along the X-axis, you may want to consider a single colour for all groups instead of multiple colours. Choose Yes and a hexcode from the colour picker below for 'single colour' graphs."
          ),
          choices = c("Choose one" = "", c("Yes", "No")),
          selected = "No",
          options = list(dropdownParent = 'body', container = "body"),
          multiple = FALSE
        ),
        colourInput(
          "colPick2",
          #single colour picker
          label = tooltip(
            trigger = list(tags$strong("Single colour picker"), bs_icon("info-circle")),
            "Pick a hexcode for single colour graphs."
          ),
          showColour = "both",
          closeOnClick = TRUE,
          value =  "#E69F00"
        )
      )
    )
  ),
  accordion(
    open = TRUE,
    accordion_panel(
      "Axes options",
      #Log Y axis option
      #graph_log Y
      pickerInput(
        "logTrans",
        label = tooltip(
          trigger = list(tags$strong("Log(Y) axis"), bs_icon("info-circle")),
          "Use a log-scale for the Y-axis. Log-transformed data will be used in analyses."
        ),
        choices = c("", "log10", "log2"),
        selected = "",
        #selectize = TRUE,
        options = list(dropdownParent = 'body'),
        multiple = FALSE
      ),
      #uiOutput("logTransX"),
      pickerInput(
        "logTransX",
        #Log X axis option
        label = tooltip(
          trigger = list(tags$strong("Log(X) axis"), bs_icon("info-circle")),
          "If X-axis variable is also numeric, it can be converted to a log10 or log2 scale. Log-transformed data will be used in analyses."
        ),
        choices = c("", "log10", "log2"),
        selected = "",
        multiple = FALSE
      )
    )
  )
), column(
  12, accordion(
    open = TRUE,
    accordion_panel(
      "Symbols & Labels options",
      #Symbol options
      #card(card_header("Symbols & Labels options"),
      #graph_font
      numericInput(
        "font_size",
        #fontsize option
        label = tooltip(
          trigger = list(tags$strong("Font size"), bs_icon("info-circle")),
          "Change text fontsize on graphs."
        ),
        min = 1,
        step = 1,
        max = 30,
        value =  18
      ),
      #graph_angle
      numericInput(
        "text_angle",
        #textsize option
        label = tooltip(
          trigger = list(tags$strong("Angled X-axis labels"), bs_icon("info-circle")),
          "Change angle of labels to avoid overlapping text."
        ),
        min = 0,
        max = 90,
        value = 45
      ),
      #graph_symsize
      numericInput(
        "sym_size",
        #symbol size option
        label = tooltip(
          trigger = list(tags$strong("Symbol size"), bs_icon("info-circle")),
          "Pick a value between 1-10 for sizes of data symbols on graphs."
        ),
        min = 1,
        max = 10,
        step = 1,
        value = 3
      ),
      #sym_jitter
      conditionalPanel("input.graphType == 'Bar graph' || input.graphType == 'Boxplot' || input.graphType == 'Violin plot' || input.graphType == 'Before-after plot' || input.graphType == 'Point & Errorbar' ", 
      numericInput(
        "sym_jitter",
        #symbol scatter option
        label = tooltip(
          trigger = list(tags$strong("Symbol scatter (0-1)"), bs_icon("info-circle")),
          "Use 0 to align data symbols with no scatter."
        ),
        value = .1,
        step = 0.1,
        min = 0,
        max = 1
      )),
      numericInput(
        "sym_alpha",
        #symbol transparency option
        label = tooltip(
          trigger = list(tags$strong("Symbol/Density/Histogram opacity (0-1)"), bs_icon("info-circle")),
          "Reduce the value below 1 to control transparency of symbols when data points overlap."
        ),
        value = .8,
        step = 0.1,
        min = 0,
        max = 1
      ),
#      numericInput(
#        "box_alpha",
#        #box transparency option
#        label = tooltip(
#          trigger = list(tags$strong("Box or Bar opacity (0-1)"), 
#                         bs_icon("info-circle")),
#          "Reduce to below 1 to make boxes or bars transparent. When set to 0, boxes and bars will appear white in colour."
#        ),
#        value = 1,
#        min = 0,
#        max = 1
#      ),
  #uiOutputs from src01f_Optional_GraphSettings
      uiOutput("out_box_alpha"),
      uiOutput("out_mean_alpha"),
      uiOutput("out_mean_size"),
      uiOutput("out_line_alpha"),
      uiOutput("vio_alpha"),
      uiOutput("pointAllalpha"),
      #all points transparency option
      uiOutput("pointAllsize"),
      uiOutput("pointAllshape"),
    )
  )
)))