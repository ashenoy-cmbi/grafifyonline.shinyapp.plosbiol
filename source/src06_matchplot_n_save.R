plotMatch_react <- reactive({
  df <- RelevelFile1.1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  #if(input$DoRelevel == "No") df <- file1()
  if(input$logTrans %in% c("log10", "log2"))  plot_match <- 
      plot_befafter_box(data = df, 
                        symsize = input$sym_size,
                        TextXAngle = input$text_angle,
                        fontsize = input$font_size,
                        ColSeq = input$colSeq,
                        ColRev = input$colRev,
                        ColPal = input$colpal, 
                        s_alpha = input$sym_alpha,
                        b_alpha = input$box_alpha,
                        jitter = input$sym_jitter,
                        xcol = !!input$varsOne,  
                        ycol = !!input$varsTwo, 
                        match = !!input$varsThree,
                        LogYTrans = input$logTrans)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~" (log Y-axis)"))
  if(input$logTrans == "")  plot_match <- 
      plot_befafter_box(data = df, 
                        symsize = input$sym_size,
                        TextXAngle = input$text_angle,
                        fontsize = input$font_size,
                        ColSeq = input$colSeq,
                        ColRev = input$colRev,
                        ColPal = input$colpal, 
                        s_alpha = input$sym_alpha,
                        b_alpha = input$box_alpha,
                        jitter = input$sym_jitter,
                        xcol = !!input$varsOne,  
                        ycol = !!input$varsTwo, 
                        match = !!input$varsThree)+
      labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo))
  plot_match
})

fac_plotMatch_react <- reactive({
  p <- plotMatch_react() +
    facet_grid(FacVars())
  p
})

output$matchPlot_out <- renderPlot({ plotMatch_react() })

output$SaveMatch <- downloadHandler(
  filename = function(file) {
    "matched_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plotMatch_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
