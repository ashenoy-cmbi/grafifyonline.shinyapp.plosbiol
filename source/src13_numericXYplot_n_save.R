##### new plot_xy_Group function start

plot_xy_Group <- function(data, xcol, ycol, Group, facet, 
                          ErrorType = c("none", "SD", "SEM", "CI95", "Boxplot"), 
                          SmoothType = c("none", "Loess", "Linear"),
                          symsize = 3, s_alpha = 0.8, TextXAngle = 0, 
                          meansize = 5, m_alpha = 1,
                          LogYTrans, LogXTrans, 
                          LogYBreaks = waiver(), LogXBreaks = waiver(), 
                          LogYLabels = waiver(), LogXLabels = waiver(), 
                          LogYLimits = NULL, LogXLimits = NULL, 
                          facet_scales = "fixed", fontsize = 20, 
                          bwid = 0.3, b_alpha = 0.3, l_alpha = 0.8, sm_alpha = 0.3,
                          symthick, bthick, ewid = 0.1, e_alpha = 1,
                          ColPal = NULL, ColSeq = TRUE, ColRev = FALSE, ...) {
  
  # Set defaults
  if (missing(symthick)) symthick <- fontsize / 22
  if (missing(bthick)) bthick <- fontsize / 22
  if (missing(meansize)) meansize <- symsize + 1
  SmoothType <- match.arg(SmoothType)
  ErrorType <- match.arg(ErrorType)
  
  # Determine type of Group
  group_var <- data[[deparse(substitute(Group))]]
  is_numeric_group <- is.numeric(group_var)
  
  # Set default palette
  if (is.null(ColPal)) {
    ColPal <- if (is_numeric_group) "blue_conti" else "okabe_ito"
  }
  
  # Validate palette
  if (is_numeric_group && !(ColPal %in% c("blue_conti", "yellow_conti", "grey_conti", "PrGn_div", "PrGn_div"))) {
    stop("For numeric grouping variables, ColPal must be one of: 'blue_conti', 'yellow_conti', 'grey_conti', 'PrGn_div', 'PrGn_div'.")
  }
  if (!is_numeric_group && !(ColPal %in% c("okabe_ito", "all_grafify", "bright", "contrast", "dark", "fishy", "kelly", "light", "muted", "pale", "r4", "safe", "vibrant"))) {
    stop("For categorical grouping variables, ColPal must be one of the categorical palettes from grafify.")
  }
  
  # identify smoothening method
  #if(!SmoothType %in% c("Linear", "Loess")) {
  #  stop("SmoothType must be specified when Smooth is TRUE.
  #        Options are 'Linear' or 'Loess'.")
  #}
  if(SmoothType == "Linear") {sm_type <- "lm"} else 
    if (SmoothType == "Loess") {sm_type <- "loess"}
  
  # Define error bar function
  error_fun <- switch(ErrorType,
                      "SD" = function(x) {
                        m <- mean(x)
                        s <- sd(x)
                        c(y = m, ymin = m - s, ymax = m + s)
                      },
                      "SEM" = function(x) {
                        m <- mean(x)
                        s <- sd(x) / sqrt(length(x))
                        c(y = m, ymin = m - s, ymax = m + s)
                      },
                      "CI95" = function(x) {
                        m <- mean(x)
                        se <- sd(x) / sqrt(length(x))
                        ci <- qt(0.975, df = length(x) - 1) * se
                        c(y = m, ymin = m - ci, ymax = m + ci)
                      },
                      "none" = NULL)
  
  # Base plot
  P <- ggplot2::ggplot(data, aes(x = {{ xcol }}, y = {{ ycol }}))
  
  # Add smoothing line if requested
  if (SmoothType != "none") {
    P <- P + stat_smooth(aes(group = {{ Group }},
                             colour = {{ Group }},
                             fill = {{ Group }}),
                         method = sm_type, geom = "smooth",
                         linewidth = 0, show.legend = FALSE,
                         alpha = sm_alpha)+ 
      stat_smooth(geom = "line",
                  aes(group = {{ Group }},
                      colour = {{ Group }}),
                  method = sm_type, 
                  alpha = l_alpha, #show.legend = FALSE,
                  linewidth = bthick, 
                  se = FALSE)
  }
  #Add boxplot or points
  if (ErrorType == "Boxplot") {
    P <- P +
      geom_boxplot(aes(group = interaction({{ xcol }}, {{ Group }}),
                       fill = {{ Group }}),
                   linewidth = bthick,
                   outlier.alpha = 0,
                   width = bwid,
                   alpha = b_alpha,
                   position = position_identity(),
                   show.legend = FALSE) +
      stat_summary(geom = "line",
                   fun = median,
                   aes(colour = {{ Group }}),
                   linewidth = bthick,
                   alpha = ifelse(SmoothType != "none", 0, l_alpha))
  }
  
  P <- P +
    geom_point(aes(fill = {{ Group }}),
               shape = 21,
               size = symsize,
               stroke = symthick,
               alpha = s_alpha,
               ...)
  
  if (ErrorType %in% c("SD", "SEM", "CI95")) {
    P <- P +
      stat_summary(fun.data = error_fun,
                   geom = "errorbar",
                   show.legend = FALSE,
                   position = position_identity(),
                   width = ewid, alpha = e_alpha,
                   aes(group = {{ Group }})) +
      stat_summary(fun = mean,
                   geom = "point",
                   shape = 22,
                   size = meansize,
                   stroke = symthick,
                   alpha = m_alpha,
                   position = position_identity(),
                   aes(group = {{ Group }}, fill = {{ Group }})) +
      stat_summary(fun = mean,
                   geom = "line", show.legend = FALSE,
                   aes(group = {{ Group }}, colour = {{ Group }}),
                   linewidth = bthick,
                   alpha = ifelse(SmoothType != "none", 0, l_alpha),
                   position = position_identity())
  }
  # add facets 
  if (!missing(facet)) {
    P <- P + facet_wrap(vars({{ facet }}), scales = facet_scales, ...)
  }
  
  # Log transformations
  if (!missing(LogYTrans)) {
    if (!(LogYTrans %in% c("log2", "log10"))) stop("LogYTrans only allows 'log2' or 'log10'.")
    P <- P + scale_y_continuous(trans = LogYTrans,
                                breaks = LogYBreaks,
                                labels = LogYLabels,
                                limits = LogYLimits,
                                ...)
    if (LogYTrans == "log10") {
      P <- P + annotation_logticks(sides = "l", outside = TRUE,
                                   base = 10, color = "grey20",
                                   long = unit(7 * fontsize / 22, "pt"),
                                   size = unit(fontsize / 22, "pt"),
                                   short = unit(4 * fontsize / 22, "pt"),
                                   mid = unit(4 * fontsize / 22, "pt"),
                                   ...) +
        coord_cartesian(clip = "off", ...)
    }
  }
  
  if (!missing(LogXTrans)) {
    if (!(LogXTrans %in% c("log2", "log10"))) stop("LogXTrans only allows 'log2' or 'log10'.")
    P <- P + scale_x_continuous(trans = LogXTrans,
                                breaks = LogXBreaks,
                                labels = LogXLabels,
                                limits = LogXLimits,
                                ...)
    if (LogXTrans == "log10") {
      P <- P + annotation_logticks(sides = "b", outside = TRUE,
                                   base = 10, color = "grey20",
                                   long = unit(7 * fontsize / 22, "pt"),
                                   size = unit(fontsize / 22, "pt"),
                                   short = unit(4 * fontsize / 22, "pt"),
                                   mid = unit(4 * fontsize / 22, "pt"),
                                   ...) +
        coord_cartesian(clip = "off", ...)
    }
  }
  
  # Apply appropriate color scales
  P <- P +
    scale_fill_grafify(palette = ColPal, reverse = ColRev, ColSeq = ColSeq) +
    scale_colour_grafify(palette = ColPal, reverse = ColRev, ColSeq = ColSeq) +
    labs(fill = enquo(Group), colour = enquo(Group)) +
    theme_grafify(base_size = fontsize) +
    guides(x = guide_axis(angle = TextXAngle))
  
  return(P)
}

##### new plot_xy_Group end


##### copilot do.call code start
plot_XYCat_react <- reactive({
  df <- RelevelFile1.2()
  
  # Build common arguments
  args <- list(
    data = df,
    symsize = input$sym_size,
    TextXAngle = input$text_angle,
    SmoothType = input$smooth_Type,
    ErrorType = input$error_typeXY,
    fontsize = input$font_size,
    s_alpha = input$sym_alpha,
    ColSeq = input$colSeq,
    ColPal = input$colpal,
    ColRev = input$colRev,
    Group = input$varsFour,
    xcol = input$varsOne,
    ycol = input$varsTwo
  )
  
  # Conditionally add bwid and b_alpha
  if (input$error_typeXY == "Boxplot") {
      args$bwid <- input$box_wid
      args$b_alpha <- input$box_alpha
      args$l_alpha <- input$line_alpha
  }
  
  ## Conditionally add error bar related arguments
  if (input$error_typeXY %in% c("SD", "SEM", "CI95")){
    args$m_alpha <- input$mean_alpha
    args$meansize <- input$mean_size
    args$ewid <- input$ewidXY
    args$l_alpha <- input$line_alpha
    args$e_alpha <- input$e_alpha
    }
  
  ## Conditionally add smooth related arguments
  if (input$smooth_Type != "none"){
    args$sm_alpha <- input$sm_alpha
    args$l_alpha <- input$line_alpha
  }
  
  # Add log transformations if specified
  if (input$logTrans %in% c("log10", "log2")) {
    args$LogYTrans <- input$logTrans
  }
  if (input$logTransX %in% c("log10", "log2")) {
    args$LogXTrans <- input$logTransX
  }
  
  ### arguments for new plot_xy_Group
  
  # Generate plot
  p <- do.call(plot_xy_Group, args, quote = FALSE)
  
  # Add title
  title_text <- paste("Plot of", input$varsOne, "vs", input$varsTwo, "grouped by", input$varsFour)
  
  if (input$logTrans %in% c("log10", "log2") && input$logTransX %in% c("log10", "log2")) {
    title_text <- paste(title_text, "(log X & Y-axis)")
  } else if (input$logTrans %in% c("log10", "log2")) {
    title_text <- paste(title_text, "(log Y-axis)")
  } else if (input$logTransX %in% c("log10", "log2")) {
    title_text <- paste(title_text, "(log X-axis)")
  }
  
  p + labs(title = title_text)

})

##### copilot code end


output$XYCatGroup_out <- renderPlot({ plot_XYCat_react() })

output$SaveViolin <- downloadHandler(
  filename = function(file) {
    "XYCatGroup_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plot_XYCat_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)


##### copilot (edited) code start
plot_XYNum_react <- reactive({
  df <- file1()
  observe(input$XYBox)
  
  # Build common arguments
  args <- list(
    data = df,
    symsize = input$sym_size,
    TextXAngle = input$text_angle,
    SmoothType = input$smooth_Type,
    ErrorType = input$error_typeXY,
    fontsize = input$font_size,
    s_alpha = input$sym_alpha,
    ColSeq = input$colSeq,
    ColPal = input$colpal,
    ColRev = input$colRev,
    Group = input$varsFour,
    xcol = input$varsOne,
    ycol = input$varsTwo
  )
  
  # Conditionally add bwid and b_alpha
  if (input$error_typeXY == "Boxplot") {
    args$bwid <- input$box_wid
    args$b_alpha <- input$box_alpha
    args$l_alpha <- input$line_alpha
  }
  
  ## Conditionally add error bar related arguments
  if (input$error_typeXY %in% c("SD", "SEM", "CI95")){
    args$m_alpha <- input$mean_alpha
    args$meansize <- input$mean_size
    args$ewid <- input$ewid
    args$l_alpha <- input$line_alpha
    args$e_alpha <- input$e_alpha
  }
  
  ## Conditionally add smooth related arguments
  if (input$smooth_Type != "none"){
    args$sm_alpha <- input$sm_alpha
    args$l_alpha <- input$line_alpha
  }
  
  # Add log transformations if specified
  if (input$logTrans %in% c("log10", "log2")) {
    args$LogYTrans <- input$logTrans
  }
  if (input$logTransX %in% c("log10", "log2")) {
    args$LogXTrans <- input$logTransX
  }
  
  ### arguments for new plot_xy_Group
  
  # Generate plot
  p <- do.call(plot_xy_Group, args, quote = FALSE)
  
  # Add title
  title_text <- paste("Plot of", input$varsOne, "vs", input$varsTwo, "grouped by", input$varsFour)
  
  if (input$logTrans %in% c("log10", "log2") && input$logTransX %in% c("log10", "log2")) {
    title_text <- paste(title_text, "(log X & Y-axis)")
  } else if (input$logTrans %in% c("log10", "log2")) {
    title_text <- paste(title_text, "(log Y-axis)")
  } else if (input$logTransX %in% c("log10", "log2")) {
    title_text <- paste(title_text, "(log X-axis)")
  }
  
  p + labs(title = title_text)

})


output$XYNumNumGp_out <- renderPlot({ plot_XYNum_react() })

output$SaveViolin <- downloadHandler(
  filename = function(file) {
    "XYNumNumGrp_plot.pdf"
  },
  content = function(file) {
    ggsave(file, plot = plot_XYNum_react(), 
           width = input$g_wid, 
           height = input$g_ht, 
           units = "cm")
  }
)

