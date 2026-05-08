plotBefAfter_react <- reactive({
  df <- RelevelFile1.1() #if(input$DoRelevel == "Yes") df <- RelevelFile1()
  #if(input$DoRelevel == "No") df <- file1()
    if(input$logTrans %in% c("log10", "log2")) plot_befafter <- 
        plot_befafter_box(data = df,
                          symsize = input$sym_size,
                          TextXAngle = input$text_angle,
                          fontsize = input$font_size,
                          s_alpha = input$sym_alpha,
                          b_alpha = input$box_alpha,
                          jitter = input$sym_jitter,
                          ColSeq = input$colSeq,
                          ColRev = input$colRev,
                          ColPal = input$colpal,
                          match = !!input$varsThree,
                          xcol = !!input$varsOne,
                          ycol = !!input$varsTwo,
                          LogYTrans = input$logTrans)+
        labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo~" (log Y-axis)"))
    if(input$logTrans == "") plot_befafter <- 
        plot_befafter_box(data = df,
                          symsize = input$sym_size,
                          TextXAngle = input$text_angle,
                          fontsize = input$font_size,
                          s_alpha = input$sym_alpha,
                          b_alpha = input$box_alpha,
                          jitter = input$sym_jitter,
                          ColSeq = input$colSeq,
                          ColRev = input$colRev,
                          ColPal = input$colpal,
                          match = !!input$varsThree,
                          xcol = !!input$varsOne,
                          ycol = !!input$varsTwo)+
        labs(title = expr("Plot of"~!!input$varsOne~"vs"~!!input$varsTwo))
    plot_befafter
})


fac_plotBefAfter_react <- reactive({
  p <- plotBefAfter_react() +
    facet_grid(FacVars())
  p
})

output$befafterPlot_out <- renderPlot({ plotBefAfter_react() })

output$SaveBefAfter <- downloadHandler(
  filename = function(file) {
    "befAfter_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plotBefAfter_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
