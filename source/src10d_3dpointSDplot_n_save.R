plot3dPoint_react <- reactive({
  df <- RelevelFile1.1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  #if(input$DoRelevel == "No") df <- file1()
  if(input$logTrans %in% c("log10", "log2")) plot_3dpoint <- 
      plot_3d_point_sd(data = df,
                       symsize = input$sym_size,
                       TextXAngle = input$text_angle,
                       s_alpha = input$sym_alpha,
                       ErrorType = input$error_type,
                       all_jitter = input$sym_jitter,
                       all_alpha = input$pointAllalpha, 
                       all_size = input$pointAllsize, 
                       all_shape = input$pointAllshape, 
                       ewid = input$ewid, 
                       ColSeq = input$colSeq,
                       ColRev = input$colRev,
                       fontsize = input$font_size,
                       ColPal = input$colpal,
                       shapes = !!input$varsThree,
                       xcol = !!input$varsOne, 
                       ycol = !!input$varsTwo,
                       LogYTrans = input$logTrans)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~" (log Y-axis)"))
  if(input$logTrans == "") plot_3dpoint <- 
      plot_3d_point_sd(data = df,
                       symsize = input$sym_size,
                       TextXAngle = input$text_angle,
                       fontsize = input$font_size,
                       s_alpha = input$sym_alpha,
                       ErrorType = input$error_type,
                       all_jitter = input$sym_jitter,
                       all_alpha = input$pointAllalpha, 
                       all_size = input$pointAllsize, 
                       all_shape = input$pointAllshape, 
                       ewid = input$ewid, 
                       ColSeq = input$colSeq,
                       ColRev = input$colRev,
                       ColPal = input$colpal,
                       shapes = !!input$varsThree,
                       xcol = !!input$varsOne, 
                       ycol = !!input$varsTwo)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo))
  plot_3dpoint
})

fac_plot3dPoint_react <- reactive({
  p <- plot3dPoint_react() +
    facet_grid(FacVars())
  p
})

output$point3dPlot_out <- renderPlot({ plot3dPoint_react() })

output$SaveViolin <- downloadHandler(
  filename = function(file) {
    "point3d_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plot3dPoint_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
