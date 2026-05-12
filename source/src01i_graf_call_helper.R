#### PBrvw helper for grafify-like code
# copilot scaffold

get_grafify_call <- function(input) {
  
  # ---- base args ----
  data_arg <- "data = data"
  x_arg <- paste0("xcol = ", input$varsOne)
  y_arg <- paste0("ycol = ", input$varsTwo)
  
  # optional inputs
  shape_var <- if (input$ShapesOpt == "Yes" && !is.null(input$varsThree)) paste0(input$varsThree) else NULL
  group_var <- if (input$addVarsOpt == "Yes" && !is.null(input$varsFour)) paste0(input$varsFour) else NULL
  
  #colour palette
  colpal_part <- if (input$colPick == "Yes") {
    paste0(", SingleColour = \"", input$colPick2, "\"")
  } else {
    paste0(", ColPal = \"", input$colpal, "\"")
  }
  axis_y_part <- if(input$logTrans %in% c("log10", "log2")){
    paste0(", LogYTrans = \"", input$logTrans, "\"")
  } else NULL
  axis_x_part <- if(input$logTransX %in% c("log10", "log2")){
    paste0(", LogXTrans = \"", input$logTransX, "\"")
  } else NULL
  
  #text angle
  text_angle <- paste0(", TextXAngle = ", input$text_angle)
  
  #combined colour, axis, text angle
  col_axis_Txt <- paste0(colpal_part, axis_y_part, axis_x_part, text_angle)
  
  #error and other options
  error_type <- if (!is.null(input$error_type)) paste0("\"", input$error_type, "\"") else "\"SD\""
  plot_den_type <- if (!is.null(input$dens_count_type)) paste0("\"", input$dens_count_type, "\"") else "\"Counts\""
  plot_his_type <- if (!is.null(input$hist_count_type)) paste0("\"", input$hist_count_type, "\"") else "\"Counts\""
  
  #XY error & smooth options
  smooth_xy_type <- if (!is.null(input$smooth_Type) && input$smooth_Type %in% c("none", "Loess", "Linear")) {
    paste0(", SmoothType = \"", input$smooth_Type, "\"")
  } else NULL
  error_xy_type <- if (!is.null(input$error_typeXY) && input$error_typeXY %in% c("none", "SD", "SEM", "CI95", "Boxplot")) {
    paste0(", ErrorType = \"", input$error_typeXY, "\"")
  } else NULL
  #combined XY
  xy_parts <- paste0(smooth_xy_type, error_xy_type)
  
  # ---- 1. SIMPLE (no addVars, no shapes) ----
  if (input$addVarsOpt == "No" && input$ShapesOpt == "No") {
    
    if (input$graphType == "Bar graph") {
      return(paste0(
        "grafify::plot_scatterbar_sd(",
        data_arg, ", ", x_arg, ", ", y_arg,
        ", ErrorType = ", error_type, col_axis_Txt, ")"
      ))
    }
    
    if (input$graphType == "Point & Errorbar") {
      return(paste0(
        "grafify::plot_point_sd(",
        data_arg, ", ", x_arg, ", ", y_arg,
        ", ErrorType = ", error_type,  col_axis_Txt, ")"
      ))
    }
    
    if (input$graphType == "Boxplot") {
      return(paste0(
        "grafify::plot_scatterbox(",
        data_arg, ", ", x_arg, ", ", y_arg,  col_axis_Txt, ")"
      ))
    }
    
    if (input$graphType == "Violin plot") {
      return(paste0(
        "grafify::plot_scatterviolin(",
        data_arg, ", ", x_arg, ", ", y_arg,  col_axis_Txt, ")"
      ))
    }
  }
  
  # ---- 2. 3D (Shapes only, mandatory shapes) ----
  if (input$addVarsOpt == "No" && input$ShapesOpt == "Yes") {
    
    if (is.null(shape_var)) {
      return("# ERROR: shapes required for 3D plots")
    }
    
    if (input$graphType == "Bar graph") {
      return(paste0(
        "grafify::plot_scatterbar_sd(",
        data_arg, ", ", x_arg, ", ", y_arg,
        ", ErrorType = ", error_type,
        ", shapes = ", shape_var,  col_axis_Txt, ")"
      ))
    }
    
    if (input$graphType == "Point & Errorbar") {
      return(paste0(
        "grafify::plot_3d_point_sd(",
        data_arg, ", ", x_arg, ", ", y_arg,
        ", ErrorType = ", error_type,
        ", shapes = ", shape_var,  col_axis_Txt, ")"
      ))
    }
    
    if (input$graphType == "Boxplot") {
      return(paste0(
        "grafify::plot_3d_scatterbox(",
        data_arg, ", ", x_arg, ", ", y_arg,
        ", shapes = ", shape_var,  col_axis_Txt, ")"
      ))
    }
    
    if (input$graphType == "Violin plot") {
      return(paste0(
        "grafify::plot_3d_scatterviolin(",
        data_arg, ", ", x_arg, ", ", y_arg,
        ", shapes = ", shape_var,  col_axis_Txt, ")"
      ))
    }
  }
  
  # ---- 3. 4D (addVars = Yes, shapes optional) ----
  if (input$addVarsOpt == "Yes") {
    
    if (is.null(group_var)) {
      return("# ERROR: grouping variable required for 4D plots")
    }
    
    shape_part <- if (!is.null(shape_var)) {paste0(", shapes = ", shape_var)} else {""}
    
    if (input$graphType == "Bar graph") {
      return(paste0(
        "grafify::plot_4d_scatterbar(",
        data_arg, ", ", x_arg, ", ", y_arg,
        ", bars = ", group_var,
        shape_part,
        ", ErrorType = ", error_type,  col_axis_Txt, ")"
      ))
    }
    
    if (input$graphType == "Point & Errorbar") {
      return(paste0(
        "grafify::plot_4d_point_sd(",
        data_arg, ", ", x_arg, ", ", y_arg,
        ", points = ", group_var,
        shape_part,
        ", ErrorType = ", error_type,  col_axis_Txt, ")"
      ))
    }
    
    if (input$graphType == "Boxplot") {
      return(paste0(
        "grafify::plot_4d_scatterbox(",
        data_arg, ", ", x_arg, ", ", y_arg,
        ", boxes = ", group_var,
        shape_part,  col_axis_Txt, ")"
      ))
    }
    
    if (input$graphType == "Violin plot") {
      return(paste0(
        "grafify::plot_4d_scatterviolin(",
        data_arg, ", ", x_arg, ", ", y_arg,
        ", boxes = ", group_var,
        shape_part,  col_axis_Txt, ")"
      ))
    }
  }
  
  # ---- 4. XY plots ----
  if (input$graphType == "Numeric XY 1") {
    return(paste0(
      "grafify::plot_xy_Group(",
      data_arg, ", ", x_arg, ", ", y_arg,
      ", Group = ", group_var,  xy_parts, col_axis_Txt, ")"
    ))
  }
  
  if (input$graphType == "Numeric XY 2") {
    return(paste0(
      "grafify::plot_xy_Group(",
      data_arg, ", ", x_arg, ", ", y_arg,
      ", Group = ", group_var, xy_parts, col_axis_Txt, ")"
    ))
  }
  
  # ---- 5. distributions ----
  if (input$graphType == "Density plot") {
    return(paste0(
      "grafify::plot_density(",
      data_arg,
      ", ycol = ", input$varsTwo, 
      ", group = ", group_var,
      ", PlotType = ", plot_den_type,  col_axis_Txt, ")"
    ))
  }
  
  if (input$graphType == "Histogram plot") {
    return(paste0(
      "grafify::plot_histogram(",
      data_arg,
      ", ycol = ", input$varsTwo, 
      ", group = ", group_var,
      ", PlotType = ", plot_his_type,  col_axis_Txt, ")"
    ))
  }
  
  # ---- fallback ----
  return("# grafify equivalent not identified")
}