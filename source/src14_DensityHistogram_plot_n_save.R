source("./source/src14b2_plot_density_histo.R", local = TRUE)

### args code start
plotDensity_react <- reactive({
  df <- RelevelFile1.1()
  
  args <- list(data = df,
               TextXAngle = input$text_angle,
               c_alpha = input$sym_alpha,
               fontsize = input$font_size,
               PlotType = input$dens_count_type,
               ColSeq = input$colSeq,
               ColRev = input$colRev,
               ColPal = input$colpal,
               group = input$varsOne, 
               ycol = input$varsTwo)
  
  # Add log transformations if specified
  if (input$logTrans %in% c("log10", "log2")) {
    args$LogYTrans <- input$logTrans
  }
  
  # Generate plot
  p <- do.call(plot_density_log, args, quote = FALSE)
  
  # Add title
  title_text <- paste("Plot of ", input$varsOne, " vs ", input$varsTwo, " (", input$dens_count_type, ")", 
                      sep = "")
  
  if (input$logTrans %in% c("log10", "log2")) {
    title_text <- paste(title_text, "(log X-axis)")
  } 
  
  p + labs(title = title_text)
  
})

### args code end


fac_plotDensity_react <- reactive({
  p <- plotDensity_react() +
    facet_grid(FacVars())
  p
})

output$densityPlot_out <- renderPlot({ plotDensity_react() })

output$SaveViolin <- downloadHandler(
  filename = function(file) {
    "density_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plotDensity_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)

###Histogram

### args code histo start
plotHistogram_react <- reactive({
  df <- RelevelFile1.1()
  
  args <- list(data = df,
               TextXAngle = input$text_angle,
               BinSize = input$Binsize,
               PlotType = input$hist_count_type,
               c_alpha = input$sym_alpha,
               fontsize = input$font_size,
               ColSeq = input$colSeq,
               ColRev = input$colRev,
               ColPal = input$colpal,
               group = input$varsOne, 
               ycol = input$varsTwo)
  
  # Add log transformations if specified
  if (input$logTrans %in% c("log10", "log2")) {
    args$LogYTrans <- input$logTrans
  }
  
  # Generate plot
  p <- do.call(plot_histogram_log, args, quote = FALSE)
  
  # Add title
  title_text <- paste("Plot of ", input$varsOne, " vs ", input$varsTwo, " (", input$dens_count_type, ")", 
                      sep = "")
  
  if (input$logTrans %in% c("log10", "log2")) {
    title_text <- paste(title_text, "(log X-axis)")
  } 
  
  p + labs(title = title_text)
  
})

### args code histo end

fac_plotHistogram_react <- reactive({
  p <- plotHistogram_react() +
    facet_grid(FacVars())
  p
})

output$histogramPlot_out <- renderPlot({ plotHistogram_react() })

output$SaveViolin <- downloadHandler(
  filename = function(file) {
    "histogram_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plotHistogram_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)
