Panel_DataVars <- list(fluidRow(column(
  12, accordion(
    open = TRUE,
    #starting help on data
    accordion_panel(
      "Readme: Getting started (can be minimised)",
      htmlOutput("dataHelpOpen") #from src02_headers_help.R
    )
  )
)),
tags$br(),
card(card_header(tags$h5("Data & variables")), value = 1, #tab panel for data & variables value 1
     fluidRow(
       column(3, fluidRow(
         column(12, htmlOutput("varsel1")), #app.R
         #X-var varsOne
         column(12, htmlOutput("varsel2")), #app.R
         #Y-var varsTwo
         column(
           12,
           #conditional panel to show after start button
           conditionalPanel(
             condition = "output.started == 'Now pick variables.'",
             htmlOutput("addVarsOut"),         
             selectizeInput(
               "addVarsOpt",
               #Add grouping var Yes/No button
               label =
                 list(
                   tooltip(
                     trigger = list(
                       tags$h3("3"),
                       tags$strong("Add a Grouping variable (Yes/No)?"),
                       bs_icon("info-circle")
                     ),
                     "An optional (categorical) grouping variable for 2way ANOVA designs. A Grouping variable (either categorical or numeric) is required when both X and Y variables are numeric."
                   )
                 ),
               choices = c("Choose Yes/No" =
                             "", "Yes", "No"),
               selected = "No",
               options = list(dropdownParent = 'body')
             )
           )
         ),
         column(12, uiOutput("addMoreVars"))
       )),
       #Grouping var varsFour
       column(8, htmlOutput("tab_header"), #Table title
              gt_output("mytable2"))
     )))