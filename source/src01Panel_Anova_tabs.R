# 02/10/2025 has tabsetPanels for ANOVA page
# this plots residuals on main tab and mixed model ones on second tab

Panel_Anova <- list(
  fluidRow(column(
    12, accordion(
      open = TRUE,
      accordion_panel(
        "Readme: ANOVAs and Comparisons (can be minimised)",
        htmlOutput("ANOVAsHelpOpen"),
        tags$br()
      )
    ),  tags$br(), 
  ),column(12, card(tags$br(), 
    fluidRow(
      column(
        4,
        htmlOutput("outnewMorS"),       #from src03d_anova_n_residuals_SimpMixed
      ),
      column(4, htmlOutput("varsel6")), #app.R    
      column(4, 
             htmlOutput("outnewAvgRF"), #from src03d_anova_n_residuals_SimpMixed
             ),
      #Random factor choice varsSix
      #empty columns for formatting
      #column(12),
      #column(6),
      column(6,                         #from src03d_anova_n_residuals_SimpMixed
             htmlOutput("newAvgRF_msg"),
      ),
      column(12),
      column(12),
      tags$br(),
      column(
        3,
        #card(card_header(tags$h6("Click to analyse data")),
        actionBttn(
          inputId = "analyseData",
          #ANOVA action button
          label = tags$strong("Analyse my data"),
          size = "sm",
          color = "royal",
          style = "unite",
          icon = bs_icon("power")
        )
      )
    )
  ))),
  tabsetPanel(
    tags$br(),
    tabPanel(
      tags$h5("Plots of residuals"),
      width = 12,
      value = 2,
      #tags$br(),
      mainPanel(width = 12,
  fluidRow(
    column(10, card(
      card_header(
        "Residuals plots",
        #Residuals plots card
        tooltip(
          bs_icon("info-circle"),
          "These are plots of residuals of your linear model. If residuals are very skewed away from the line in QQ plot or far from 0 in the Density plot, it is likely that there is a major deviation from normal distribution. Therefore, the linear model may be a poor fit for your data. Proceed with caution and consider using data-transformations (e.g., log-data)."
        )
      ),
      #htmlOutput("qq_head"),
      fluidRow(
        column(5, plotOutput(
          "ModPlot", #QQ plot from src03d_anova_n_residuals_SimpMixed
          width = "25vw", height = "25vw"
        )),
        column(5, plotOutput(
          "ModPlotDist", #Density plot from src03d_anova_n_residuals_SimpMixed
          width = "25vw", height = "25vw"
        ))
      )) #new end to QQ & Density plots
    ))
      )), 
  tabPanel(
    tags$h5("Additional plots of Mixed models"),
    width = 12,
    value = 2,
    #tags$br(),
    mainPanel(width = 12,
  fluidRow(
    column(10, card(height = "40vw",
      card_header(
        "Additional plots 1 (Press 'Analyse my data' if graphs do not appear). Graphs will be faceted by levels of Random factor.",
        tooltip(
          bs_icon("info-circle"),
          "Plots will appear for Mixed models only, faceted by levels within the Random factor."
        )),
      plotOutput("RandFplot", 
                 height = "40vw"))),  #from src03d_anova_n_residuals_SimpMixed
    column(10, card(
      card_header(
      "Additional plots 2 (Press 'Analyse my data' if graphs do not appear). Random factor will be mapped to symbol shapes or size.",
      tooltip(
        bs_icon("info-circle"),
        "Plots will appear for Mixed models with levels within the Random factor mapped to shapes of data symbols, or their size (for Numeric XY graphs)."
      )),
      #uiOutput("RFLev_txt"),
      plotOutput("avgRandFplot", 
                 height = "40vw"))  #from src03d_anova_n_residuals_SimpMixed
      ))
    ))
  ),
  fluidRow(
    column(
      10,
      #card(card_header("",
      actionButton(
        "AnTbleHelpBtn",
        #ANOVA table help button
        label = "More Info on ANOVA Table",
        icon = icon("info-circle"),
        class = "btn-info",
        style = "unite"
      ),
      tags$br(),
      htmlOutput("anova_head"),     #from src02_headers_help.R
      #ANOVA table header
      gt_output("AnovaTab1"),       #from src03d_anova_n_residuals_SimpMixed
      #ANOVA table
      tags$br(),
      tags$br(),
      tags$br()
    ),
    column(
      10,
      #card(card_header("",
      actionButton(
        "EmmeansHelpBtn",
        #EMMEANS table help button
        label = "More Info on EMMEANS table",
        icon = icon("info-circle"),
        class = "btn-info",
        style = "unite"
      ),
      tags$br(),
      htmlOutput("emmeans_head"), #from src02_headers_help.R
      #EMMEANS table header
      gt_output("Comp1"),         #from src03b_emmeans
      #EMMEANS table
      tags$br(),
      tags$br(),
      tags$br()
    ),
    column(
      6,
      #card(
      actionButton(
        "ContrHelper",
        #Posthoc comparisons help button
        label = "More Info on Comparisons",
        icon = icon("info-circle"),
        class = "btn-info",
        style = "unite"
      ),
      selectizeInput(
        "emm_type",
        #choose contrast type
        label = list(tags$h3("10"), "Type of comparisons"),
        choices = c("Pairwise", 
                    "Compare to reference", 
                    "Levelwise 1", 
                    "Levelwise 2"),
        selected = c("Pairwise"),
        options = list(dropdownParent = 'body'),
        multiple = FALSE
      ),
      uiOutput("emmRefType"),     #from src03b_emmeans
      #Post-hoc comparison output
      tags$br()
    ),
    column(
      10,
      #card(card_header("",
      actionButton(
        "ConstrasHelpBtn",
        #Contrasts help button
        label = "More Info on Post-hoc comparisons",
        icon = icon("info-circle"),
        class = "btn-info",
        style = "unite"
      ),
      tags$br(),
      htmlOutput("contrasts_head"),      #from src02_headers_help.R
      #Posthoc comparisons help button
      tags$br(),
      gt_output("Comp2"),                #from src03b_emmeans
      #Posthoc comparisons
      tags$br()
    ),
    column(
      10,
      tags$br(),
      card(
        card_header(
          tags$h5(
            "Linear Model",
            #sidebar title
            class = "d-flex justify-content-between",
            tooltip(
              bs_icon("info-circle"),
              "Raw output from R of the linear model fitted to data."
            )
          )
        ),
        #Linear model panel
        tags$h6(
          "This is the summary of the fitted model. It shows model parameters, such as residual SE, coefficients etc. For simple or ordinar linear models, grafify uses the lm() function from base R. For mixed effects models, grafify uses the lmer() function from the lme4 and lmerTest packages. "
        ),
        #from src03d_anova_n_residuals_SimpMixed
        verbatimTextOutput("ModSummary"),  #Linear model from R
        tags$br()
      )                 
    ),
    column(
      10,
      tags$br(),
      card(
        card_header(
          tags$h5(
            "Data used for analyses",
            #sidebar title
            class = "d-flex justify-content-between",
            tooltip(
              bs_icon("info-circle"),
              "Table showing data used for Simple or Mixed effects analyses."
            )
          )
        ),
        #Linear model panel
        HTML("The table below includes the variables used in the analysis, which were chosen in Boxes 1-3. For Mixed effects analyses, means of replicate values of the response variable, if any, (chosen in Box 2) within levels of the random variable (chosen in Box 9), along with the Median, SD and Counts are shown."),
        #from src03d_anova_n_residuals_SimpMixed
        gt_output("avgFile_out"),       #Table used for analyses
      )                 
    )
  )
)
