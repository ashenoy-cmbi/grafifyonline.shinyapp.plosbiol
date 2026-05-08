plot4dBar_react <- reactive({
  df <- RelevelFile1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  #if(input$DoRelevel == "No") df <- file1()
  if(input$logTrans %in% c("log10", "log2")) plot_4dBar <- 
      plot_4d_scatterbar(data = df,
                         xcol = !!input$varsOne, 
                         ycol = !!input$varsTwo,
                         bars = !!input$varsFour,
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
  if(input$logTrans == "") plot_4dBar <- 
      plot_4d_scatterbar(data = df,
                         xcol = !!input$varsOne, 
                         ycol = !!input$varsTwo,
                         bars = !!input$varsFour,
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
  plot_4dBar
})

fac_plot4dBar_react <- reactive({
  p <- plot4dBar_react() +
    facet_grid(FacVars())
  p
})

output$bar4dPlot_out <- renderPlot({ plot4dBar_react() })

output$SaveViolin <- downloadHandler(
  filename = function(file) {
    "bar4d_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plot4dBar_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
