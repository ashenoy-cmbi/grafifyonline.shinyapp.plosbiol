# 02/10/2025 update Compare to reference 2way options

#get variables as a or a*b for lmer and emmeans specs
dep <- reactive({
  #observe({c(input$logTransX, input$addVarsOpt)})
  #initiate NULL vectors
  g4 <- NULL
  dep1 <- NULL
  x = input$varsOne
  #get Grouping variable
  if(input$addVarsOpt == "Yes") {g4 <- input$varsFour}
  #get predictor when X is categorical 1way ANOVA
  #PBrvw if (!is.null(g4) && g4 != "") paste(x, g4, sep = "*") else xE
  if(CatGp() == 0 & Xnum() == FALSE) dep1 <- x
  #get predictor when X is categorical 2way ANOVA
  if(CatGp() == TRUE & Xnum() == FALSE) dep1 <- if (!is.null(g4) && g4 != "") paste(x, g4, sep = "*") else x
  #PBrvw
  #predictor when X is categorical and CatGp is numeric 
  if(CatGp() != TRUE & Xnum() == FALSE) dep1 <- if (!is.null(g4) && g4 != "") paste(x, g4, sep = "*") else x
  #get predictor when X is numeric w/o log
  if(Xnum() == TRUE & Ynum() == TRUE & CatGp() %in% c(TRUE, FALSE) &
     !input$logTransX %in% c("log10", "log2")) {dep1 <- if (!is.null(g4) && g4 != "") paste(x, g4, sep = "*") else x}
  #get predictor when X is numeric w/ log10
  if(Xnum() == TRUE & Ynum() == TRUE & CatGp() %in% c(TRUE, FALSE) &
     input$logTransX == "log10") {dep1 <- paste(paste0("log10(", x, ")"), g4, sep = "*")}
  #get predictor when X is numeric w/o log2
  if(Xnum() == TRUE & Ynum() == TRUE & CatGp() %in% c(TRUE, FALSE) &
     input$logTransX == "log2") {dep1 <- paste(paste0("log2(", x, ")"), g4, sep = "*")}
  dep1
})

#UI output of dep() output is correct (dev only)
output$depReactive <- renderText({ paste(as.formula(formula(decideModel()))) })

#series of reactives to make emmeans formula
#reactive for emmeans specs Pairs
emmPairs <- reactive({
  #observe(c(input$emm_type))
  #effi - start
  if(input$emm_type != "Pairwise") return(NULL) 
  #effi - end
  emmDep <- dep()
  if(input$emm_type == "Pairwise")
  as.formula(paste("pairwise", "~", emmDep)) 
})
#UI output (dev only)
output$emmPairFML <- renderText({ paste(emmFml()) })
#reactive for emmeans specs Levelwise1
emmLev1 <- reactive({
  #observe(c(input$emm_type, input$addVarsOpt))
  #effi - start
  if(input$emm_type == "Levelwise - Grouping variable" & 
     input$addVarsOpt == "Yes")
    emmDep <- paste(input$varsOne, input$varsFour, 
                    sep = "|")
  as.formula(sprintf('%s ~ %s', 
                            "pairwise", emmDep))
})
#reactive for emmeans specs Levelwise2
emmLev2 <- reactive({
  #observe(c(input$emm_type, input$addVarsOpt))
  if(input$emm_type == "Levelwise - X-variable" & 
     input$addVarsOpt == "Yes")
    emmDep <- paste(input$varsFour, input$varsOne, 
                    sep = "|")
  as.formula(sprintf('%s ~ %s', 
                            "pairwise", emmDep))
})

#### start - 2way trt.vs.ctrl contrasts 02/10/2025
emm2wLev1 <- reactive({
  #observe(c(input$emm_type, input$addVarsOpt))
  if(input$emm_type == "To reference X-variable" & 
     input$addVarsOpt == "Yes")
    emmDep <- paste(input$varsOne, input$varsFour, 
                    sep = "|")
  fml <- as.formula(sprintf('%s ~ %s', 
                            "trt.vs.ctrl", emmDep))
})
#reactive for emmeans specs Levelwise2
emm2wLev2 <- reactive({
  #observe(c(input$emm_type, input$addVarsOpt))
  if(input$emm_type == "To reference Grouping variable" & 
     input$addVarsOpt == "Yes")
    emmDep <- paste(input$varsFour, input$varsOne, 
                    sep = "|")
  fml <- as.formula(sprintf('%s ~ %s', 
                            "trt.vs.ctrl", emmDep))
})

#### end - 2way trt.vs.ctrl contrasts 02/10/2025 

#reactive for emmeans specs trt.vs.ctrl
emmRef <- reactive({
  #observe(c(input$emm_type, input$addVarsOpt))
  if(input$emm_type == "Compare to reference" & 
     input$addVarsOpt == "No"){
    emmDep <- paste(input$varsOne)
  fml <- as.formula(sprintf('%s ~ %s', 
                            "trt.vs.ctrl", emmDep))}
})


#effi - start
output$emmRefType <- renderUI({
  
  if (input$emm_type %in% c("Compare to reference",
                            "To reference X-variable",
                            "To reference Grouping variable")) {
    
    req(avgFile1())
    # your clean switch block
    levs <- switch(input$emm_type,
                   "Compare to reference" = input$varsReLevel,
                   "To reference X-variable" = input$varsReLevel,
                   #"To reference Grouping variable" = input$varsReLevelGp
                   "To reference Grouping variable" = {
                     if (CatGp()) {input$varsReLevelGp
                     } else {
                         input$varsFour}
                   }
    )
    # only require AFTER assignment
    req(levs)
    levs <- as.character(levs)
    choices <- setNames(seq_along(levs), levs)
    selectInput(
      inputId = "emm_Reftype",
      label = tags$strong("Choose reference level"),
      choices = choices,
      selected = choices[[1]]
    )
  }
})
#effi - end

#reactive for emmeans fml of all types 
emmFml <- reactive({
  #formula output based on choice of comparison
  #observe(input$emm_type) 
  if(input$emm_type == "Pairwise") return(emmPairs())
  if(input$emm_type == "Levelwise - Grouping variable") return(emmLev1())
  if(input$emm_type == "Levelwise - X-variable") return(emmLev2())
  if(input$emm_type == "Compare to reference") return(emmRef())
  ### for 2way - start
  if(input$emm_type == "To reference X-variable") return(emm2wLev1())
  if(input$emm_type == "To reference Grouping variable") return(emm2wLev2())
  ### for 2way - end
  return(NULL)
})

#reactive for main emmeans 
####effi-start
Comp1 <- reactive({
  #get linear model
  M1<-decideModel()
  nRef <- as.numeric(input$emm_Reftype) #from user input
  if (length(nRef) == 0 || is.na(nRef)) nRef <- 1
  fml <- emmFml() #emmeans formula
  req(!is.null(fml))
  # get number of levels safely
  df <- avgFile1()
  req(df)
  #Ensure enough levels ONLY when needed
  if (input$emm_type %in% c("Compare to reference",
                            "To reference X-variable",
                            "To reference Grouping variable")) {
    # must NOT be numeric
    #req(!Xnum())
    # must have >= 2 levels
    levs <- switch(input$emm_type,
                   #"Compare to reference" = input$varsReLevel,
                   "Compare to reference" = {
                     if (Xnum()) {input$varsOne
                     } else {
                       input$varsReLevel}
                   },
                   #"To reference X-variable" = input$varsReLevel,
                   "To reference X-variable" = {
                     if (Xnum()) {input$varsOne
                     } else {
                       input$varsReLevel}
                   },
                   #"To reference Grouping variable" = input$varsReLevelGp
                   "To reference Grouping variable" = {
                     if (CatGp()) {input$varsReLevelGp
                     } else {
                       input$varsFour}
                   }
    )
    #req(levs)
    #k <- length(levs)
    #req(k > 2)
    #req(nRef >= 1)
    M2 <- emmeans(M1,
                  specs = fml,
                  type = "response",
                  adjust = "fdr",
                  ref = nRef)
  } else {# do not pass nref when not needed e.g., pairwise
  M2<-emmeans(M1, 
              specs = fml,
              type = "response",
              adjust="fdr"
  )}
  return(M2)
})

Comp1_cached <- reactive({
  Comp1()
})

####effi - end


#UI output of emmeans $emmeans part
output$Comp1 <- render_gt({
  #req(file1())
  #df <- RelevelFile1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  ##if(input$DoRelevel == "No") df <- file1()
  #file4 <- df
  t1 <- Comp1_cached()
  t2 <- as.data.frame(t1$emmeans)  #extract $emmeans from emmeans output
  n <- length(colnames(t2))  #get dim of table
  #colnames(t2)[1] <- colnames(file4)[colnames(file4)==input$varsOne]
  #observe(input$addVarsOpt)  #variable width for 1w or 2w ANOVA
  if(input$addVarsOpt == "Yes") from = 3
  if(input$addVarsOpt == "No") from = 2
  gt::gt(data = t2)  %>% 
    # Format the specified columns to scientific notation with 3 significant digits
    #fmt_scientific(
    #  columns = from:n,
    #  decimals = 2
    #) %>%
    cols_align(
      align = "center",
      columns = everything()) %>%
    opt_interactive() %>% 
    tab_options(
      table.width = pct(100),
      ihtml.use_pagination = FALSE) %>% 
    fmt_auto()
})

#UI output of emmans $contrasts
output$Comp2 <- render_gt({
  t3 <- Comp1_cached()
  t4 <- as.data.frame(t3$contrasts)  #extract $contrasts from emmeans output
  n <- length(colnames(t4))  #get dim of table
  #observe(input$addVarsOpt)  #get column values for DT formatting
  if(input$addVarsOpt == "Yes" & 
     input$emm_type != "Pairwise") from = 3
  if(input$addVarsOpt == "No") from = 2
  if(input$addVarsOpt == "Yes" & 
     input$emm_type == "Pairwise") from = 2
  gt::gt(data = t4)  %>% 
    tab_style(
      style = cell_fill(color = "#D0F4F5"),
      locations = cells_body(
        rows = p.value <= 0.05
      )
    ) %>%
    # Format the specified columns to scientific notation with 3 significant digits
    #fmt_scientific(
    #  columns = from:n,
    #  decimals = 2
    #) %>%
    cols_align(
    align = "center",
    columns = everything()) %>%
    opt_interactive() %>% 
    tab_options(
      table.width = pct(100),
      ihtml.use_pagination = FALSE) %>% 
    fmt_auto()
  })

#updating choices of emmeans for users if only 2 levels in X-axis variable
#changed Feb26 after fixing always relevel/NumXY to input$MorS
nlev <- eventReactive(input$MorS, { #changed from reactive 
  ######### pass avgfile which is the correct option 
  req(avgFile1()) #changed Feb26 after fixing always relevel/NumXY
  if(Xnum() == TRUE){
  varLevels <- 2}
  if(Xnum() == FALSE){
    df <- avgFile1()
  #varLevels <- length(levels(as.factor(df[[input$varsOne]])))
  #varLevels <- length(unique(df[[input$varsOne]])) #effi
  varLevels <- length(input$varsReLevel) #effi
  }
  length(varLevels)
})

# effi- start
observe({
  choices <- "Pairwise"
  if (Xnum()) {
    # numeric X forces 2-way logic
    choices <- c("Pairwise",
                 "Levelwise - X-variable",
                 "To reference Grouping variable")
    
  } else if (input$addVarsOpt == "Yes" && !Xnum()) {
    choices <- c("Pairwise",
                 "Levelwise - X-variable",
                 "Levelwise - Grouping variable",
                 "To reference X-variable",
                 "To reference Grouping variable")
    } else if (input$addVarsOpt == "No" && nlev() == 2 && Xnum()) {
    
    choices <- c("Pairwise")
    
  } else if (input$addVarsOpt == "No" && nlev() > 2 && Xnum()) {
    
    choices <- c("Pairwise",
                 "Compare to reference")
  }
  
  updateSelectInput(
    session,
    inputId = "emm_type",
    choices = choices,
    selected = choices[1]
  )
})

# effi- end
