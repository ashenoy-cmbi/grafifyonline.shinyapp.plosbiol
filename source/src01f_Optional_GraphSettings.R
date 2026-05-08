#optional choices for graphs

#facet scales option
#output in src01PanelGraphs_card4_5
output$facet_scaleOut <- renderUI({
  if (input$facetingOpt == "Yes")
    selectizeInput(
      "facet_scales",
      label = tooltip(
        trigger = list(
          tags$h3("4.2"),
          tags$strong("Axes options for facet panels"),
          bs_icon("info-circle")
        ),
        "Should X and/or Y axes have the same scales on facet panel graphs? Pick which axes can vary freely."
      ),
      choices = c("Fixed XY" = "fixed",
                  "Free Y" = "free_y",
                  "Free X" = "free_x"), 
      selected = "Fixed XY",
      options = list(dropdownParent = 'body'),
      multiple = FALSE
    )
})


## Output for density counts
#output in src01PanelGraphs_card6_7
output$dens_counts <- renderUI({
  if (input$graphType %in% c("Density plot"))
    selectizeInput(
      "dens_count_type",
      label = tooltip(
        trigger = list(tags$strong("Plot type"), 
                       bs_icon("info-circle")),
        "Pick whether to plot smooth density, counts or normalised counts."
      ),
      choices = c("Density", "Counts", "Normalised counts"),
      options = list(dropdownParent = 'body'),
      selected =  "Counts", 
      multiple = FALSE
    )
})

## Output for histogram counts
#output in src01PanelGraphs_card6_7
output$hist_counts <- renderUI({
  if (input$graphType %in% c("Histogram plot"))
    selectizeInput(
      "hist_count_type",
      label = tooltip(
        trigger = list(tags$strong("Plot type"), 
                       bs_icon("info-circle")),
        "Pick whether to plot counts or normalised counts."
      ),
      choices = c("Counts", "Normalised counts"),
      options = list(dropdownParent = 'body'),
      selected =  "Counts", 
      multiple = FALSE
    )
})

#UI output for plot_point_sd & bars errorbar width
#output in src01PanelGraphs_card6_7
output$ewid <- renderUI({
  if (input$graphType %in% c("Point & Errorbar", "Bar graph"))
    numericInput(
      "ewid",
      label = tooltip(
        trigger = list(
          tags$strong("Change the width of errorbars"),
          bs_icon("info-circle")
        ),
        "Change the width of the horizontal lines at ends of errorbars."
      ),
      value = 0.1, step = 0.1,
      min = 0,
      max = 1
    )
})
#UI output for errorbar type SD/SEM/CI95
#changed to dropdown list for consistency on Jan 19
#output in src01PanelGraphs_card6_7
output$error_type <- renderUI({
  if (input$graphType %in% c("Bar graph", "Point & Errorbar"))
    selectizeInput(
      "error_type",
      label = tooltip(
        trigger = list(tags$strong("Error Bars"), bs_icon("info-circle")),
        "Pick type of errorbars on Bar or Point & Errorbar graphs."
      ),
      choices = c("CI95", "SD", "SEM"),
      options = list(dropdownParent = 'body'),
      selected =  "SD", 
    )
})

#UI output for boxwidth for XYNum1 and XYNum2 
#13 Jun 2025

# UI output for new plot_xy_Group 
# 15 Jun 2025
#output$out_smoothyesno <- renderUI({
#  if (input$graphType %in% c("Numeric XY 1", "Numeric XY 2"))
#    selectizeInput(
#      "smooth_yesno",
#      label = tooltip(
#        trigger = list(tags$strong("Smooth Line"), bs_icon("info-circle")),
#        "Add a smooth line and then select the type (loess or linear)."
#      ),
#      choices = c("Yes", "No"),
#      options = list(dropdownParent = 'body'),
#      selected =  "No", 
#      multiple = FALSE
#    )
#})

#output in src01PanelGraphs_card6_7
output$out_smoothType <- renderUI({
  #observe(input$smooth_yesno, input$graphType)
  if (input$graphType %in% c("Numeric XY 1", "Numeric XY 2"))
    selectizeInput(
      "smooth_Type",
      label = tooltip(
        trigger = list(tags$strong("Smooth Line Type"), bs_icon("info-circle")),
        "Choose whether to fit a loess or linear smooth line."
      ),
      choices = c("none", "Loess", "Linear"),
      options = list(dropdownParent = 'body'),
      selected =  "none", 
      multiple = FALSE
    )
})
#output in src01PanelGraphs_card6_7
output$error_typeXY <- renderUI({
  if (input$graphType %in% c("Numeric XY 1", "Numeric XY 2"))
  selectizeInput(
    "error_typeXY",
    label = tooltip(
      trigger = list(tags$h3("7.1"),
                     tags$strong("Central value & Dispersion"), bs_icon("info-circle")),
      "Pick mean and SD/SEM/CI95 error bars, or a box and whiskers plot."
    ),
    choices = c("none", "SD", "SEM", "CI95", "Boxplot"),
    options = list(dropdownParent = 'body'),
    selected =  "none", 
  )
})
#output in src01PanelGraphs_card6_7
output$out_box_wid <- renderUI({
  #req() fixes Warning: Error in if: argument is of length zero
  #30/09/2025
  req(input$error_typeXY)
  if (input$error_typeXY == "Boxplot" 
      )
    numericInput(
      "box_wid",
      label = tooltip(
        trigger = list(tags$strong("Box width"), bs_icon("info-circle")),
        "Provide width of boxes in same units as the X-axis variable, otherwise a suitable default is calculated."
      ),
      value = NULL, min = 0, step = 0.1, 
    )
})

#updating default options after user selection of graphs
observe({
  if (input$graphType %in% c("Numeric XY 1", "Numeric XY 2"))
    updateNumericInput(
      #session = "graphType",
      inputId = "box_alpha",
      #label = tags$strong("Choose graph type"),
      value = 0.5
    )
})

#output in src01PanelGraphs_card6_7
output$out_sm_alpha <- renderUI({
  #observeEvent(input$smooth_yesno)
  #req() fixes Warning: Error in if: argument is of length zero
  #30/09/2025
  req(input$smooth_Type)
  if (input$smooth_Type %in% c("none", "Loess", "Linear") 
      )
    numericInput(
      "sm_alpha",
      label = tooltip(
        trigger = list(tags$strong("Opacity of smooth fit"), bs_icon("info-circle")),
        "Reduce the value below 1 to control the transparency of the line."
      ),
      value = 0.3, min = 0, max = 1, step = 0.1
    )
})
#output in src01PanelGraphs_card6_7
output$out_e_alpha <- renderUI({
  #observeEvent(input$smooth_yesno)
  #req() fixes Warning: Error in if: argument is of length zero
  #30/09/2025
  req(input$error_typeXY)
  if (input$error_typeXY %in% c("SD", "SEM", "CI95") 
      )
    numericInput(
      "e_alpha",
      label = tooltip(
        trigger = list(tags$strong("Opacity of errorbars"), bs_icon("info-circle")),
        "Reduce the value below 1 to control the transparency of errorbars."
      ),
      value = 1, min = 0, max = 1, step = 0.1
    )
})
#output in src01PanelGraphs_card6_7
output$ewidXY <- renderUI({
  #req() fixes Warning: Error in if: argument is of length zero
  #30/09/2025
  req(input$error_typeXY)
  if (input$error_typeXY %in% c("SD", "SEM", "CI95")
      )
    numericInput(
      "ewidXY",
      label = tooltip(
        trigger = list(
          tags$strong("Change the width of errorbars"),
          bs_icon("info-circle")
        ),
        "Change the width of the horizontal lines at ends of errorbars."
      ),
      value = 0.1, step = 0.1,
      min = 0,
      max = 1
    )
})

#output in src01PanelGraphs_card8
output$out_mean_alpha <- renderUI({
  #observe(input$smooth_yesno, input$graphType)
  #req() fixes Warning: Error in if: argument is of length zero
  #30/09/2025
  req(input$error_typeXY)
  if (input$error_typeXY %in% c("SD", "SEM", "CI95")
  )
    numericInput(
      "mean_alpha",
      label = tooltip(
        trigger = list(tags$strong("Opacity of Mean"), bs_icon("info-circle")),
        "Reduce the value below 1 to control the transparency of the Mean."
      ),
      value = 1, min = 0, max = 1, step = 0.1
    )
})
#output in src01PanelGraphs_card8
output$out_mean_size <- renderUI({
  #observeEvent(input$smooth_yesno)
  #req() fixes Warning: Error in if: argument is of length zero
  #30/09/2025
  req(input$error_typeXY)
  if (input$error_typeXY %in% c("SD", "SEM", "CI95")
  )
    numericInput(
      "mean_size",
      label = tooltip(
        trigger = list(tags$strong("Mean size"), bs_icon("info-circle")),
        "Choose symbol size for the Mean."
      ),
      value = 5, min = 0, max = 15, step = 1
    )
})
#output in src01PanelGraphs_card8
output$out_line_alpha <- renderUI({
  #observeEvent(input$smooth_yesno)
  #req() fixes Warning: Error in if: argument is of length zero
  #30/09/2025
  req(input$smooth_Type)
  if (input$smooth_Type %in% c("none", "Loess", "Linear")
  )
    numericInput(
      "line_alpha",
      label = tooltip(
        trigger = list(tags$strong("Opacity of Line"), bs_icon("info-circle")),
        "Reduce the value below 1 to control the transparency of the line."
      ),
      value = 1, min = 0, max = 1, step = 0.1
    )
})

#UI output for histogram bindwidth
#output in src01PanelGraphs_card8
output$Binsize <- renderUI({
  if (input$graphType %in% c("Histogram plot"))
    numericInput(
      "Binsize",
      label = tooltip(
        trigger = list(
          tags$strong("Change the binsize for histograms"),
          bs_icon("info-circle")
        ),
        "The default is 30, increase or decreaes this for binning values into groups for histograms."
      ),
      value = 30, step = 1,
      min = 5,
      max = 100
    )
})

#UI output for plot_point_sd transparency
#output in src01PanelGraphs_card8
output$pointAllalpha <- renderUI({
  if (input$graphType == "Point & Errorbar")
    numericInput(
      "pointAllalpha",
      label = tooltip(
        trigger = list(
          tags$strong("Opacity of all symbols except the mean (0-1)"),
          bs_icon("info-circle")
        ),
        "Reduce to below 1 to make boxes or bars transparent. When set to 0, symbols will disappear."
      ),
      value = 0.4, step = 0.1,
      min = 0,
      max = 1
    )
})

#UI output for plot_point_sd sizes
#output in src01PanelGraphs_card8
output$pointAllsize <- renderUI({
  if (input$graphType == "Point & Errorbar")
    numericInput(
      "pointAllsize",
      label = tooltip(
        trigger = list(
          tags$strong("Adjust size of all symbols except the mean"),
          bs_icon("info-circle")
        ),
        "Increase or decrease size of data points."
      ),
      value = 2.5, step = 0.5,
      min = 0,
      max = 10
    )
})
#UI output for plot_point_sd shapes
#output in src01PanelGraphs_card8
output$pointAllshape <- renderUI({
  if (input$graphType == "Point & Errorbar" & 
      input$ShapesOpt == "No")
    numericInput(
      "pointAllshape",
      label = tooltip(
        trigger = list(
          tags$strong("Change shape of all symbols except the mean (1-25)"),
          bs_icon("info-circle")
        ),
        "Change the shape of data points."
      ),
      value = 1, step = 1,
      min = 1,
      max = 25
    )
})

#UI output for ColSeq options TRUE/FALSE
#output in src01PanelGraphs_card8
output$colSeqOut <- renderUI({
  selectizeInput(
    "colSeq",
    label = tooltip(
      trigger = list(tags$strong("Colour sequence"), bs_icon("info-circle")),
      "Colours for categorical variables are picked sequentially from the chosen colour palette (Default). If set to FALSE, the most distant colours are chosen."
    ),
    choices = c(TRUE, FALSE),
    selected = TRUE,
    options = list(dropdownParent = 'body'),
    multiple = FALSE
  )
})

#UI output for ColRev options TRUE/FALSE
#output in src01PanelGraphs_card8
output$colRevOut <- renderUI({
  selectizeInput(
    "colRev",
    label = tooltip(
      trigger = list(
        tags$strong("Reverse swatch order?"),
        bs_icon("info-circle")
      ),
      "Whether or not to pick colours from palette swatches in default or reverse order. Set to TRUE for the order to be reversed."
    ),
    choices = c(TRUE, FALSE),
    selected = FALSE,
    options = list(dropdownParent = 'body'),
    multiple = FALSE
  )
})

#UI output for Violin transparency
#output in src01PanelGraphs_card8
output$vio_alpha <- renderUI({
  if (input$graphType == "Violin plot")
    #violin alpha
    numericInput(
      "vio_alpha",
      label = tooltip(
        trigger = list(tags$strong("Violin opacity (0-1)"), bs_icon("info-circle")),
        "Reduce to below 1 to make violins transparent. When set to 0, violins will appear white in colour."
      ),
      value = 1,
      max = 1, min = 0, step = 0.1
    )
})

## Output for box alpha, conditional
#output in src01PanelGraphs_card8
output$out_box_alpha <- renderUI({
  if (input$graphType %in% c("Boxplot",
                             "Bar graph", 
                             "Violin plot",
                             "Before after plot",
                             "Numeric XY 1",      #added for box_wid on xy num graphs
                             "Numeric XY 2"))     #added for box_wid on xy num graphs
    numericInput(
      "box_alpha",
      #box transparency option
      label = tooltip(
        trigger = list(tags$strong("Box or Bar opacity (0-1)"), bs_icon("info-circle")),
        "Reduce to below 1 to make boxes or bars transparent. When set to 0, boxes and bars will appear white in colour."
      ),
      value = 1,
      min = 0,
      max = 1,
      step = 0.1
    )
})
