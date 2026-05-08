plotBox_react <- reactive({
  df <- RelevelFile1.1() #df <- RelevelFile1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  ##if(input$DoRelevel == "No") df <- file1()
  if(input$logTrans %in% c("log10", "log2")) plot_box <- 
      plot_scatterbox(data = df,
                      symsize = input$sym_size,
                      TextXAngle = input$text_angle,
                      s_alpha = input$sym_alpha,
                      b_alpha = input$box_alpha,
                      jitter = input$sym_jitter,
                      fontsize = input$font_size,
                      ColSeq = input$colSeq,
                      ColRev = input$colRev,
                      ColPal = input$colpal,
                      xcol = !!input$varsOne, 
                      ycol = !!input$varsTwo,
                      LogYTrans = input$logTrans)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~" (log Y-axis)"))
  if(input$logTrans == "") plot_box <- 
      plot_scatterbox(data = df,
                      symsize = input$sym_size,
                      TextXAngle = input$text_angle,
                      fontsize = input$font_size,
                      s_alpha = input$sym_alpha,
                      b_alpha = input$box_alpha,
                      jitter = input$sym_jitter,
                      ColSeq = input$colSeq,
                      ColRev = input$colRev,
                      ColPal = input$colpal,
                      xcol = !!input$varsOne, 
                      ycol = !!input$varsTwo)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo))
  plot_box
})

fac_plotBox_react <- reactive({
  p <- plotBox_react() +
    facet_grid(FacVars(),
               scales = input$facet_scales)
  p
})

output$boxPlot_out <- renderPlot({ plotBox_react() })

output$SaveBox <- downloadHandler(
  filename = function(file) {
    "box_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plotBox_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
