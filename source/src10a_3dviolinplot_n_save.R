plot3dViolin_react <- reactive({
  df <- RelevelFile1.1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  #if(input$DoRelevel == "No") df <- file1()
  if(input$logTrans %in% c("log10", "log2")) plot_3dviolin <- 
      plot_3d_scatterviolin(data = df,
                            symsize = input$sym_size,
                            TextXAngle = input$text_angle,
                            s_alpha = input$sym_alpha,
                            b_alpha = input$box_alpha,
                            v_alpha = input$vio_alpha,
                            jitter = input$sym_jitter,
                            fontsize = input$font_size,
                            ColSeq = input$colSeq,
                            ColRev = input$colRev,
                            ColPal = input$colpal,
                            shapes = !!input$varsThree,
                            xcol = !!input$varsOne, 
                            ycol = !!input$varsTwo,
                            LogYTrans = input$logTrans)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~" (log Y-axis)"))
  if(input$logTrans == "") plot_3dviolin <- 
      plot_3d_scatterviolin(data = df,
                            symsize = input$sym_size,
                            TextXAngle = input$text_angle,
                            fontsize = input$font_size,
                            s_alpha = input$sym_alpha,
                            b_alpha = input$box_alpha,
                            v_alpha = input$vio_alpha,
                            jitter = input$sym_jitter,
                            ColSeq = input$colSeq,
                            ColRev = input$colRev,
                            ColPal = input$colpal,
                            shapes = !!input$varsThree,
                            xcol = !!input$varsOne, 
                            ycol = !!input$varsTwo)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo))
  plot_3dviolin
})

fac_plot3dViolin_react <- reactive({
  p <- plot3dViolin_react() +
    facet_grid(FacVars())
  p
})

output$violin3dPlot_out <- renderPlot({ plot3dViolin_react() })

output$SaveViolin <- downloadHandler(
  filename = function(file) {
    "violin3d_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plot3dViolin_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
