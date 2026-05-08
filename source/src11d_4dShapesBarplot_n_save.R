plot4dShapesBar_react <- reactive({
  df <- RelevelFile1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  #if(input$DoRelevel == "No") df <- file1()
  if(input$logTrans %in% c("log10", "log2")) plot_4dShapesBar <- 
      plot_4d_scatterbar(data = df,
                         xcol = !!input$varsOne, 
                         ycol = !!input$varsTwo,
                         bars = !!input$varsFour,
                         shapes = !!input$varsThree,
                         ErrorType = input$error_type,
                         ewid = input$ewid,
                         symsize = input$sym_size,
                         s_alpha = input$sym_alpha,
                         b_alpha = input$box_alpha,
                         jitter = input$sym_jitter,
                         TextXAngle = input$text_angle,
                         fontsize = input$font_size,
                         ColSeq = input$colSeq,
                         ColRev = input$colRev,
                         ColPal = input$colpal,
                         LogYTrans = input$logTrans)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~"grouped by"~!!input$varsFour~" (log Y-axis)"))
  if(input$logTrans == "") plot_4dShapesBar <- 
      plot_4d_scatterbar(data = df,
                         xcol = !!input$varsOne, 
                         ycol = !!input$varsTwo,
                         bars = !!input$varsFour,
                         shapes = !!input$varsThree,
                         ErrorType = input$error_type,
                         ewid = input$ewid,
                         symsize = input$sym_size,
                         s_alpha = input$sym_alpha,
                         b_alpha = input$box_alpha,
                         jitter = input$sym_jitter,
                         TextXAngle = input$text_angle,
                         fontsize = input$font_size,
                         ColSeq = input$colSeq,
                         ColRev = input$colRev,
                         ColPal = input$colpal)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~"grouped by"~!!input$varsFour))
  plot_4dShapesBar
})

fac_plot4dShapesBar_react <- reactive({
  p <- plot4dShapesBar_react() +
    facet_grid(FacVars())
  p
})

output$bar4dShapesPlot_out <- renderPlot({ plot4dShapesBar_react() })

output$SaveViolin <- downloadHandler(
  filename = function(file) {
    "bar4dShapes_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plot4dShapesBar_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
