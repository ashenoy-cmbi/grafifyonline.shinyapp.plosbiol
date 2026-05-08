#separate averaging reactives for Simple and Mixed 
#this fixes issues with correct initialisation of downstream reactives
# For Simple model
avgFileSimple <- eventReactive(input$analyseData, {
  req(input$MorS == "Simple")
  req(input$addVarsOpt)
  
  if (Xnum() == TRUE & CatGp() == FALSE) { df <- file1() }
  if (Xnum() == TRUE & CatGp() == TRUE)  { df <- RelevelFile1.2() }
  if (Xnum() == FALSE & CatGp() == TRUE) { df <- RelevelFile1() }
  if (Xnum() == FALSE & input$addVarsOpt == "No") { df <- RelevelFile1.1() }
  
  df  # no averaging needed
})

# For Mixed model
avgFileMixed <- eventReactive(input$analyseData, {
  req(input$MorS == "Mixed")
  req(input$addVarsOpt)
  req(input$AvgRF)
  
  if (Xnum() == TRUE & CatGp() == FALSE) { df <- file1() }
  if (Xnum() == TRUE & CatGp() == TRUE)  { df <- RelevelFile1.2() }
  if (Xnum() == FALSE & CatGp() == TRUE) { df <- RelevelFile1() }
  if (Xnum() == FALSE & input$addVarsOpt == "No") { df <- RelevelFile1.1() }
  
  ns <- colnames(df)
  x1 <- ns[ns == input$varsOne]
  y  <- ns[ns == input$varsTwo]
  if (input$addVarsOpt == "Yes") { x2 <- ns[ns == input$varsFour] }
  r1 <- ns[ns == input$varsSix]
  
  if (input$AvgRF == "Yes") {
    if (input$addVarsOpt == "Yes") {
      avgdf <- table_summary(df, y, c(x1, x2, r1))
      colnames(avgdf)[4] <- y
    } else {
      avgdf <- table_summary(df, y, c(x1, r1))
      colnames(avgdf)[3] <- y
    }
    ltab <- length(colnames(avgdf))
    n1 <- ltab - 3
    n2 <- ltab - 2
    avgdf <- avgdf[, c(1:n1, n2:ltab)]
  } else {
    avgdf <- df
  }
  
  avgdf
})
#get result only when button clicked
avgFile1 <- eventReactive(input$analyseData, {
  if (input$MorS == "Simple") avgFileSimple()
  else avgFileMixed()
})
#output to UI
output$avgFile_out <- render_gt({
  #observe(input$analyseData)
  req(c(file1(), avgFile1(), input$MorS))
  #ifelse(input$AvgRF == "Yes",
  avgdf1 <- avgFile1() #, avgdf <- file1())
  gt(avgdf1) %>% 
    opt_interactive() %>% 
    tab_options(
      table.width = pct(100),
      ihtml.use_pagination = FALSE) %>% 
    fmt_auto()
  })

#reactive for simple linear model
simMod <- reactive({
  #pass avgtable to reactive
  df <- avgFile1()
  ns <- colnames(df)
  x = ns[ns == input$varsOne]
  y = ns[ns == input$varsTwo]
  #get formula like form of predictors
  pred <- dep()
  #get Y value log10 or log2
  if(input$logTrans == "log10") {y <- paste("log10(", y, ")", sep = "")} 
  if(input$logTrans == "log2") {y <- paste("log2(", y, ")", sep = "")}
  if(input$logTrans == "") {y <- y}
  fml <- as.formula(paste(y, pred, sep = "~"))
  obj1 <- lm(formula = fml, 
             data = df)
  obj1$call$formula <- fml #update formula in lm object
  obj1
})
#text output of simple linear model 
#for RAW R output
output$newmodOut <- renderPrint({ 
  simMod() })

#reactive for mixed model 
mixMod <- reactive({
  df <- avgFile1()#, df <- file1())
  ns <- colnames(df)
  x = ns[ns == input$varsOne]
  y = ns[ns == input$varsTwo]
  RandIn = ns[ns == input$varsSix]
  dep <- dep() #get formula like predictors
  #get random factor as lmer() 
  rand <- paste("+ (1|",
                input$varsSix, 
                ")")
  pred <- paste(dep, rand) #formula with random factor
  #get Y value with log10 and log2
  if(input$logTrans == "log10") {y <- paste("log10(", y, ")", sep = "")} 
  if(input$logTrans == "log2"){ y <- paste("log2(", y, ")", sep = "")}
  if(input$logTrans == "") {y <- y}
  fml <- as.formula(paste(y, pred, sep = "~")) #lmer formula
  obj1 <- lmer(formula = fml, 
               data = df)
  obj1@call$formula <- fml
  obj1 <- lmerTest::as_lmerModLmerTest(obj1) #set as lmerMod for P values
})
#UI Output of mixed model
output$anomodel <- renderPrint({
   mixMod()
})

#reactive that responds to Mixed vs Simple
decideModel <- eventReactive(input$analyseData, {
  req(input$MorS)
  if(input$MorS == "Simple") mod <- simMod()
  if(input$MorS == "Mixed") mod <- mixMod()
  if(input$MorS == "") mod <- NULL
  mod
})

#reactive for summary of lm() or lmer()
ModsummEvent <- reactive({
  mod <- decideModel()
  summary(mod)
})
#UI output for Linear Model panel
output$ModSummary <- renderPrint({ 
  ModsummEvent() })

#UI output of ANOVA table
output$AnovaTab1 <- render_gt({
  req(input$MorS)
  #observe(input$analyseData)
  file7<-decideModel() #get linear model
  if(input$MorS == "Mixed") #if mixed use anova()
    obj2<-anova(file7, 
                type = "II",
                ddf = "Kenward-Roger")
  
  if(input$MorS == "Simple") #if simple use car::Anova()
    obj2 <- car::Anova(file7,
                       type = 2) #F statistic is default for lm()
  obj2_n <- colnames(obj2)
  obj2$"ANOVA" <- rownames(obj2)
  obj2 <- obj2[, c("ANOVA", obj2_n)]
  n <- length(colnames(obj2))
  gt::gt(data = obj2)  %>% 
    tab_style(
      style = cell_fill(color = "#D0F4F5"),
      locations = cells_body(
        rows = `Pr(>F)` <= 0.05
      )
    ) %>%
    cols_align(
      align = "center",
      columns = everything()) %>%
    opt_interactive() %>% 
    tab_options(
      table.width = pct(100),
      ihtml.use_pagination = FALSE) %>% 
    fmt_auto()
})

#UI output of ANOVA residuals
#QQ plot 
output$ModPlot <- renderPlot({
  req(input$MorS)
  file8 <- decideModel()
  obj3 <- plot_qqmodel(Model = file8, 
                       symsize = input$sym_size, 
                       s_alpha = input$sym_alpha,
                       fontsize = (input$font_size-3))+
    #theme_grafify(aspect.ratio = 1)+
    labs(title = "QQ plot of model residuals")
    obj3
})
#Density plot
output$ModPlotDist <- renderPlot({
  req(input$MorS)
  file8 <- decideModel()
  Residuals = residuals(file8)
  n <- length(Residuals)
  df <- data.frame(Residuals,
                   Q = rep("A", times = n))
  obj3 <- plot_density(df,
                       Residuals,
                       Q,
                       fontsize = (input$font_size-3))+
    guides(fill = "none",
           colour = "none")+
    #theme_grafify(aspect.ratio = 1)+
    labs(title = "Density plot of model residuals")
  obj3
})
#faceted plot by random factor
RandFplotreact <- eventReactive(input$analyseData, {
  p <- whichplotChosenGraph() #take base graph without faceting
  #or the single colour graph, if chosen
  if(input$addVarsOpt == "Yes" &  
     Xnum() == FALSE & 
     CatGp() == TRUE){singColnum <- CatGplevels()}
  if(input$addVarsOpt == "No" & 
     Xnum() == FALSE) {singColnum <- Xlevels()}
  ifelse (input$colPick == "No" ,
          p <- p,
          p <- p +
            scale_fill_manual(values = rep(input$colPick2, 
                                           times = singColnum)))
  #add random factor as the facet
  if(input$MorS == "Mixed"){
  p <- p + facet_wrap(vars(!!input$varsSix))+
      #theme_grafify(aspect.ratio = 1)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo),
           subtitle = expr("(Faceted by the Random factor:"~!!input$varsSix~")"))}
  p
})
#UI output of faceted plot
output$RandFplot <- renderPlot({
  req(input$analyseData)
  #observe(input$analyseData)
  if(input$MorS == "Mixed") {p <- RandFplotreact()}
  if(input$MorS == "Simple") {p <- NULL}
  p
})


source("./source/src15_AvgRF_graphs.R", #sources the AvgRF plot functions
       local = TRUE,
       echo = TRUE)

avg_RandFplotreact <- eventReactive(input$analyseData, {
  req(avgFile1())
  avgpf <- AvgRFPlotSingCol()
  avgpf$data <- avgFile1()
  avgpf <- avgpf  + 
    labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo),
         subtitle = expr("(Shapes of data symbols are mapped to levels of the Random factor:"~!!input$varsSix~")"))
  avgpf
})
#UI output of avg plot
output$avgRandFplot <- renderPlot({
  if (input$MorS == "Mixed" && input$AvgRF == "Yes") {
    p <- avg_RandFplotreact()} 
  if (input$MorS == "Mixed" && input$AvgRF == "No") {
    p <- avg_RandFplotreact()} 
  if (input$MorS == "Simple") {
    p <- NULL} 
  p
})


#new MorS for better reactive response for ANOVA tab outputs
#this is because conditionalPanel does not respond correctly
output$outnewMorS <- renderUI({
  selectizeInput(
  "MorS",
  multiple = FALSE,
  #Type of ANOVA simple/mixed
  label = tooltip(
    trigger = list(
      tags$h3("9"),
      tags$strong("Choose Simple or Mixed-effects ANOVA."),
      bs_icon("info-circle")
    ),
    "A simple linear model is an ordinary 1-way or 2-way ANOVA. For a mixed effects linear models, in addition to fixed factors",
    tags$strong("Boxes 1-3"),
    "a random factor is required (e.g., experimental blocks, matching or repeated-measures)."
  ),
  choices =  c("Choose one" = "", c("Simple", "Mixed")),
  options = list(dropdownParent = 'body')
)
  })

#new AvgRF for better reactive response for ANOVA tab outputs
#this is because conditionalPanel does not respond correctly
output$outnewAvgRF <- renderUI({
  req(input$MorS)
  if(input$MorS == "Mixed")
  selectizeInput(
    "AvgRF",
    multiple = FALSE,
    #Average RF or not
    label = tooltip(
      trigger = list(
        tags$h3("9.2"),
        tags$strong("Choose whether to average replicates grouped by fixed and random factors."),
        bs_icon("info-circle")
      ),
      "If a Random factor is selected, you can choose to average replicates within the levels of this variable or not."
    ),
    choices = c("Choose one" =
                  "", c("Yes", "No")),
    selected = "Yes",
    options = list(dropdownParent = 'body')
    )
})

output$newAvgRF_msg <- renderText({
  # If input$MorS is not yet initialized, show default message
  if (is.null(input$MorS) || input$MorS == "") {
    return("Select the type of model to fit.")
  }
  
  # Now input$MorS is defined and non-empty
  if (input$MorS == "Simple") {
    return("A simple linear model will be fit.")
  }
  
  # Check AvgRF only if MorS is Mixed
  if (input$MorS == "Mixed") {
    if (input$AvgRF == "Yes") {
      return("A mixed-effects model will be fit. If there are replicate values within levels of the Random Factor grouped by Fixed Factor(s) chosen in Boxes 2 and/or 3, those will be averaged and their means used to fit a random intercepts model. Choose 'No' in Box 9.2 to plot all values without averaging.")
    } else if (input$AvgRF == "No") {
      return("A mixed-effects model will be fit. All values within all levels of the Random Factor, grouped by Fixed Factor(s) chosen in Boxes 2 and/or 3, will be used to fit a random intercepts model. Choose 'Yes' in Box 9.2 to average them.")
    } else {
      return("Choose whether to average replicates within the Random Factor.")
    }
  }
  
  # Fallback
  return("Select the type of model to fit.")
})
#setting to allow detection of output before sent to UI
outputOptions(output, "newAvgRF_msg", suspendWhenHidden = FALSE)
