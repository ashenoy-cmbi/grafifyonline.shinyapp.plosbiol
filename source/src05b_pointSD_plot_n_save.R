plotPointSD_react <- reactive({
  df <- RelevelFile1.1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  #if(input$DoRelevel == "No") df <- file1()
  if(input$logTrans %in% c("log10", "log2")) plot_point <- 
      plot_point_sd(data = df,
                    symsize = input$sym_size,
                    TextXAngle = input$text_angle,
                    fontsize = input$font_size,
                    s_alpha = input$sym_alpha,
                    all_jitter = input$sym_jitter,
                    all_alpha = input$pointAllalpha, 
                    all_size = input$pointAllsize, 
                    all_shape = input$pointAllshape, 
                    ewid = input$ewid, 
                    ColSeq = input$colSeq,
                    ColRev = input$colRev,
                    ColPal = input$colpal,
                    ErrorType = input$error_type,
                    xcol = !!input$varsOne,
                    ycol = !!input$varsTwo,
                    LogYTrans = input$logTrans)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~" (log Y-axis)"))
  if(input$logTrans == "") plot_point <- 
      plot_point_sd(data = df,
                    symsize = input$sym_size,
                    TextXAngle = input$text_angle,
                    fontsize = input$font_size,
                    s_alpha = input$sym_alpha,
                    all_jitter = input$sym_jitter,
                    all_alpha = input$pointAllalpha, 
                    all_size = input$pointAllsize, 
                    all_shape = input$pointAllshape, 
                    ewid = input$ewid, 
                    ColSeq = input$colSeq,
                    ColRev = input$colRev,
                    ColPal = input$colpal,
                    ErrorType = input$error_type,
                    xcol = !!input$varsOne,
                    ycol = !!input$varsTwo)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo))
  plot_point
})

fac_plotPointSD_react <- reactive({
  p <- plotPointSD_react() +
    facet_grid(FacVars())
  p
})

output$pointSDPlot_out <- renderPlot({ plotPointSD_react() })

output$SaveBar <- downloadHandler(
  filename = function(file) {
    "pointSD_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plotPointSD_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)

