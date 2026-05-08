#main panel of outputs and inputs.
source("./source/src01Panel_DataVars.R", local = TRUE) #data panel 1
source("./source/src01Panel_Graphs.R", local = TRUE) #Graph panel 1
source("./source/src01Panel_Anova_tabs.R", local = TRUE) #Anova panel 1

mainPanel1 <- list(#width = 6,
  #tags$br(),
  #tags$br(),
  tabsetPanel(
    id = "1",
    tags$br(),
    tabPanel(
      tags$h5("Data & Variables"),
      #width = 12,
      value = 1,
      mainPanel(width = 12, 
                Panel_DataVars) #src01Panel_DataVars.R
    ),
    tabPanel(
      tags$h5("Graphs"),
      width = 12,
      value = 2,
      #tags$br(),
      mainPanel(width = 12, 
                Panel_Graphs)  #src01Panel_Graphs.R
    ),
    tabPanel(
      tags$h5("ANOVAs (linear models) and Comparisons"),
      width = 12,
      value = 3,
      mainPanel(
        width = 12,
        #main ANOVA panel
        Panel_Anova)          #src01Panel_Anova_tabs.R
    )
  ))
