plot3dBar_react <- reactive({
  df <- RelevelFile1.1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  #if(input$DoRelevel == "No") df <- file1()
  if(input$logTrans %in% c("log10", "log2")) plot_3dbar <- 
      plot_3d_scatterbar(data = df,
                         xcol = !!input$varsOne, 
                         ycol = !!input$varsTwo,
                         shapes = !!input$varsThree,
                         ErrorType = input$error_type,
                         ewid = input$ewid,
                         symsize = input$sym_size,
                         s_alpha = input$sym_alpha,
                         b_alpha = input$box_alpha,
                         jitter = input$sym_jitter,
                         fontsize = input$font_size,
                         TextXAngle = input$text_angle,
                         ColPal = input$colpal,
                         ColSeq = input$colSeq,
                         ColRev = input$colRev,
                         LogYTrans = input$logTrans)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~" (log Y-axis)"))
  if(input$logTrans == "") plot_3dbar <- 
      plot_3d_scatterbar(data = df,
                         xcol = !!input$varsOne, 
                         ycol = !!input$varsTwo,
                         shapes = !!input$varsThree,
                         ErrorType = input$error_type,
                         ewid = input$ewid,
                         symsize = input$sym_size,
                         s_alpha = input$sym_alpha,
                         b_alpha = input$box_alpha,
                         jitter = input$sym_jitter,
                         fontsize = input$font_size,
                         TextXAngle = input$text_angle,
                         ColPal = input$colpal,
                         ColSeq = input$colSeq,
                         ColRev = input$colRev)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo))
  plot_3dbar
})

fac_plot3dBar_react <- reactive({
  p <- plot3dBar_react() +
    facet_grid(FacVars())
  p
})

output$bar3dPlot_out <- renderPlot({ plot3dBar_react() })

output$SaveViolin <- downloadHandler(
  filename = function(file) {
    "bar3d_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plot3dBar_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
