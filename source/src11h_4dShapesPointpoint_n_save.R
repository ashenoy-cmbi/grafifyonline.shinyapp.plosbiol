plot4dShapesPoint_react <- reactive({
  df <- RelevelFile1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  #if(input$DoRelevel == "No") df <- file1()
  if(input$logTrans %in% c("log10", "log2")) plot_4dShapesPoint <- 
      plot_4d_point_sd(data = df,
                       xcol = !!input$varsOne, 
                       ycol = !!input$varsTwo,
                       points = !!input$varsFour,
                       shapes = !!input$varsThree,
                       ErrorType = input$error_type,
                       ewid = input$ewid,
                       symsize = input$sym_size,
                       s_alpha = input$sym_alpha,
                       all_jitter = input$sym_jitter,
                       all_alpha = input$pointAllalpha, 
                       all_size = input$pointAllsize, 
                       #all_shape = input$pointAllshape, 
                       TextXAngle = input$text_angle,
                       fontsize = input$font_size,
                       ColSeq = input$colSeq,
                       ColRev = input$colRev,
                       ColPal = input$colpal,
                       LogYTrans = input$logTrans)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~"grouped by"~!!input$varsFour~" (log Y-axis)"))
  if(input$logTrans == "") plot_4dShapesPoint <- 
      plot_4d_point_sd(data = df,
                       xcol = !!input$varsOne, 
                       ycol = !!input$varsTwo,
                       points = !!input$varsFour,
                       shapes = !!input$varsThree,
                       ErrorType = input$error_type,
                       ewid = input$ewid,
                       symsize = input$sym_size,
                       s_alpha = input$sym_alpha,
                       all_jitter = input$sym_jitter,
                       all_alpha = input$pointAllalpha, 
                       all_size = input$pointAllsize, 
                       all_shape = input$pointAllshape, 
                       TextXAngle = input$text_angle,
                       fontsize = input$font_size,
                       ColSeq = input$colSeq,
                       ColRev = input$colRev,
                       ColPal = input$colpal)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~"grouped by"~!!input$varsFour))
  plot_4dShapesPoint
})

fac_plot4dShapesPoint_react <- reactive({
  p <- plot4dShapesPoint_react() +
    facet_grid(FacVars())
  p
})

output$bar4dShapesPoint_out <- renderPlot({ plot4dShapesPoint_react() })

output$SaveViolin <- downloadHandler(
  filename = function(file) {
    "point4dShapes_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plot4dShapesPoint_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
