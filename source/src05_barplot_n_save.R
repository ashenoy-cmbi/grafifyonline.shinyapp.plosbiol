plotBar_react <- reactive({
  df <- RelevelFile1.1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  #if(input$DoRelevel == "No") df <- file1()
  if(input$logTrans %in% c("log10", "log2")) plot_bar <- 
      plot_scatterbar_sd(data = df,
                         xcol = !!input$varsOne,
                         ycol = !!input$varsTwo,
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
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~" (log Y-axis)"))
  if(input$logTrans == "") plot_bar <- 
      plot_scatterbar_sd(data = df,
                         xcol = !!input$varsOne,
                         ycol = !!input$varsTwo,
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
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo))
  plot_bar
})

fac_plotBar_react <- reactive({
  p <- plotBar_react() +
    facet_grid(FacVars())
  p
})

output$barPlot_out <- renderPlot({ plotBar_react() })

output$SaveBar <- downloadHandler(
  filename = function(file) {
    "bar_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plotBar_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
