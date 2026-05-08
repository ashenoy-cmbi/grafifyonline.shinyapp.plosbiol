#sourced in src14_DensityHistogram_plot_n_save

plot_density_log <- function(data, ycol, group, facet, PlotType = c("Density", "Counts", "Normalised counts"), c_alpha = 0.2, TextXAngle = 0, facet_scales = "fixed", fontsize = 20, linethick, LogYTrans, LogYBreaks = waiver(), LogYLabels = waiver(), LogYLimits = NULL, ColPal = c("okabe_ito", "all_grafify", "bright",  "contrast",  "dark",  "fishy",  "kelly",  "light",  "muted",  "pale",  "r4",  "safe",  "vibrant"), ColSeq = TRUE, ColRev = FALSE, SingleColour = NULL, ...){
  if(missing(linethick)) {linethick = fontsize/22}
  ColPal <- match.arg(ColPal)
  PlotType <- match.arg(PlotType)
  if (!(PlotType %in% c("Density", "Counts", "Normalised counts"))) {
    stop("`PlotType` can only be NULL, count or max_counts")
  }
  if(missing(group) & is.null(SingleColour)) {message("You did not provide a grouping variable, so grafify used the default colour. You can change this with the `SingleColour` argument.") }
  if(!is.null(SingleColour)){
    ifelse(grepl("#", SingleColour), 
           a <- SingleColour,
           ifelse(isTRUE(get_graf_colours(SingleColour) != 0), 
                  a <- unname(get_graf_colours(SingleColour)), 
                  a <- SingleColour))
  } else a <- "#E69F00"
  if(missing(group)) {
    suppressWarnings(P <- ggplot2::ggplot(data, 
                                          aes(x = {{ ycol }},
                                              fill = "one",
                                              colour = "one")) +
                       guides(fill = "none", colour = "none")) 
  } else {
    suppressWarnings(P <- ggplot2::ggplot(data, 
                                          aes(x = {{ ycol }},
                                              fill = factor({{ group }}),
                                              colour = factor({{ group }}))))
  }
  if(PlotType == "Density") {
    suppressWarnings(P <- P +
                       geom_density(linewidth = linethick,
                                    alpha = c_alpha)+
                       labs(y = "Density"))}
  if(PlotType == "Counts") {
    suppressWarnings(P <- P +
                       geom_density(linewidth = linethick,
                                    aes(y = after_stat(count)),
                                    alpha = c_alpha)+
                       labs(y = "Counts"))
  }
  if(PlotType == "Normalised counts") {
    suppressWarnings(P <- P +
                       geom_density(linewidth = linethick,
                                    aes(y = after_stat(count/max(count))),
                                    alpha = c_alpha)+
                       labs(y = "Normalised counts"))
  }
  if (!missing(LogYTrans)) {
    if (!(LogYTrans %in% c("log2", "log10"))) {
      stop("LogYTrans only allows 'log2' or 'log10' transformation.")
    }
    if (LogYTrans == "log10") {
      P <- P + 
        scale_x_continuous(trans = "log10", 
                           breaks = LogYBreaks, 
                           labels = LogYLabels, 
                           limits = LogYLimits, 
                           ...)+
        annotation_logticks(sides = "b", 
                            outside = TRUE,
                            base = 10, color = "grey20",
                            long = unit(7*fontsize/22, "pt"), size = unit(fontsize/22, "pt"),# 
                            short = unit(4*fontsize/22, "pt"), mid = unit(4*fontsize/22, "pt"),#
                            ...)+ 
        coord_cartesian(clip = "off", ...)
    }
    if (LogYTrans == "log2") {
      P <- P + 
        scale_x_continuous(trans = "log2", 
                           breaks = LogYBreaks, 
                           labels = LogYLabels, 
                           limits = LogYLimits, 
                           ...)}
  }
  if(!missing(facet)) {
    P <- P + facet_wrap(vars({{ facet }}), 
                        scales = facet_scales, 
                        ...)
  }
  if (!is.null(SingleColour)) {
    if (missing(group)) {
      P <- P +
        scale_fill_manual(values = rep(a, times = 1)) +
        scale_colour_manual(values = rep(a, times = 1))
    } else {
      group <- deparse(substitute(group))
      x <- length(levels(factor(data[[group]])))
      P <- P +
        scale_fill_manual(values = rep(a, times = x)) +
        scale_colour_manual(values = rep(a, times = x))+
        labs(fill = enquo(group),
             colour = enquo(group))
    }
  } else {
    P <- P  +
      scale_fill_grafify(palette = ColPal, 
                         reverse = ColRev, 
                         ColSeq = ColSeq)+
      scale_colour_grafify(palette = ColPal, 
                           reverse = ColRev, 
                           ColSeq = ColSeq) +
      labs(fill = enquo(group),
           colour = enquo(group))
  }
  P <- P +
    theme_grafify(base_size = fontsize) +
    guides(x = guide_axis(angle = TextXAngle),
           colour = "none")
  P
}


plot_histogram_log <- function(data, ycol, group, facet, PlotType = c("Counts", "Normalised counts"), BinSize = 30, c_alpha = 0.8, TextXAngle = 0, facet_scales = "fixed", fontsize = 20, linethick, alpha, LogYTrans, LogYBreaks = waiver(), LogYLabels = waiver(), LogYLimits = NULL, ColPal = c("okabe_ito", "all_grafify", "bright",  "contrast",  "dark",  "fishy",  "kelly",  "light",  "muted",  "pale",  "r4",  "safe",  "vibrant"), ColSeq = TRUE, ColRev = FALSE, SingleColour = NULL, ...){
  if(missing(linethick)) {linethick = fontsize/22}
  if (!missing("alpha")) {
    warning("Use `c_alpha` argument instead, as `alpha` is deprecated.")
    c_alpha <- substitute(alpha)}
  ColPal <- match.arg(ColPal)
  PlotType <- match.arg(PlotType)
  if (!(PlotType %in% c("Counts", "Normalised counts"))) {
    stop("`PlotType` can only be 'Counts' or 'Normalised Counts'.")
  }
  if(missing(group) & missing(SingleColour)) {message("You did not provide a grouping variable, so grafify used the default colour. You can change this with the `SingleColour` argument.") }
  if(!is.null(SingleColour)){
    ifelse(grepl("#", SingleColour), 
           a <- SingleColour,
           ifelse(isTRUE(get_graf_colours(SingleColour) != 0), 
                  a <- unname(get_graf_colours(SingleColour)), 
                  a <- SingleColour))
  } else a <- "#E69F00"
  if(missing(group)) {
    suppressWarnings(P <- ggplot2::ggplot(data, 
                                          aes({{ ycol }},
                                              fill = "one",
                                              colour = "one")) + 
                       scale_fill_manual(values = a)+
                       scale_colour_manual(values = a)+
                       guides(fill = "none", colour = "none")) 
  } else {
    suppressWarnings(P <- ggplot2::ggplot(data, 
                                          aes({{ ycol }},
                                              fill = factor({{ group }}),
                                              colour = factor({{ group }}))))
  }
  if(PlotType == "Counts") {
    P <- P +                     
      geom_histogram(linewidth = linethick,
                     alpha = c_alpha,
                     bins = BinSize,
                     #colour = "black"
      )+
      labs(y = "Counts")}
  if(PlotType == "Normalised counts") {
    P <- P +                     
      geom_histogram(linewidth = linethick,
                     alpha = c_alpha,
                     bins = BinSize,
                     #colour = "black",
                     aes(y = after_stat(count/max(count))))+
      labs(y = "Normalised counts")}
  if (!missing(LogYTrans)) {
    if (!(LogYTrans %in% c("log2", "log10"))) {
      stop("LogYTrans only allows 'log2' or 'log10' transformation.")
    }
    if (LogYTrans == "log10") {
      P <- P + 
        scale_x_continuous(trans = "log10", 
                           breaks = LogYBreaks, 
                           labels = LogYLabels, 
                           limits = LogYLimits, 
                           ...)+
        annotation_logticks(sides = "b", 
                            outside = TRUE,
                            base = 10, color = "grey20",
                            long = unit(7*fontsize/22, "pt"), size = unit(fontsize/22, "pt"),# 
                            short = unit(4*fontsize/22, "pt"), mid = unit(4*fontsize/22, "pt"),#
                            ...)+ 
        coord_cartesian(clip = "off", ...)
    }
    if (LogYTrans == "log2") {
      P <- P + 
        scale_x_continuous(trans = "log2", 
                           breaks = LogYBreaks, 
                           labels = LogYLabels, 
                           limits = LogYLimits, 
                           ...)}
  }
  if(!missing(facet)) {
    P <- P + facet_wrap(vars({{ facet }}), 
                        scales = facet_scales, 
                        ...)
  }
  if (!is.null(SingleColour)) {
    if (missing(group)) {
      P <- P +
        scale_fill_manual(values = rep(a, times = 1)) +
        scale_colour_manual(values = rep(a, times = 1))
    } else {
      group <- deparse(substitute(group))
      x <- length(levels(factor(data[[group]])))
      P <- P +
        scale_fill_manual(values = rep(a, times = x)) +
        scale_colour_manual(values = rep(a, times = x)) +
        labs(fill = enquo(group),
             colour = enquo(group))
    }
  } else {
    P <- P  +
      scale_fill_grafify(palette = ColPal, 
                         reverse = ColRev, 
                         ColSeq = ColSeq)+
      scale_colour_grafify(palette = ColPal, 
                           reverse = ColRev, 
                           ColSeq = ColSeq) +
      labs(fill = enquo(group),
           colour = enquo(group))
  }
  P <- P  +
    theme_grafify(base_size = fontsize)+
    guides(x = guide_axis(angle = TextXAngle),
           colour = "none")
  P
}
