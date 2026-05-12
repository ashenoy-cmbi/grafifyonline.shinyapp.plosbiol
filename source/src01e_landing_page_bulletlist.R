landing_info <- list(tagList(tags$div(
  tags$h5("grafify (version 0.1)"), 
  tags$ul(tags$li(
    tags$h6(
      "grafify online plot graphs and easily performs ANOVAs and post-hoc comparisons just like the ",
      tags$a(href = "https://grafify-vignettes.netlify.app/", "R package.")
    )
  ), tags$li(
    tags$h6(
      "The main advantages of grafify are the use of ggplot2 and various colourblind-friendly palettes, and easy access to linear models and linear mixed effects analyses for ANOVAs. These are more powerful and appropriate when experiments are designed as randomised blocks or have repeated measures."
    ), 
  ), 
  ### PBrvw for Shiny live only - start
  #tags$li(tags$h6(tags$strong("Please use Firefox browser on this website as other browsers currently fail to download PDF graphs."))),
  #tags$li(tags$h6(tags$strong("Privacy note:"), "This version of the app is based on", tags$a(href = "https://posit-dev.github.io/r-shinylive/", " Shinylive"), " and runs entirely in your browser. Uploaded data are processed locally and not transmitted to our servers.")), 
  #### for Shiny live only - end
  
  tags$li(
    tags$h6(
      "grafify online is also available on ", tags$a(href = "https://grafifyonline.shinyapps.io/grafify/", "Shinyapps.io"), " and as a local ", tags$a(href = "https://posit-dev.github.io/r-shinylive/", " Shinylive app"), " at ", tags$a(href = "https://grafifyonline1.shenoylab.com/", "mirror 1"), " and ", tags$a(href = "https://grafifyonline2.shenoylab.com/", "mirror 2."), " Windows users can install an ", tags$a(href = "https://sourceforge.net/projects/grafify/", "offline copy"), " as a stand-alone app within the user's browser.")),
  
  ### impaas acknw - start
  tags$li(tags$h6(
    "grafify online on ", tags$a(href = "https://grafify.impaas.uk/", "Impaas (Imperial Platform as a Service)"), " courtesy of", tags$a(href = "https://edtech.pages.doc.ic.ac.uk/", " Robert Chatley and Jason Bailey, Department of Computing, Imperial College London.")
  )),
  ### impaas acknw - end
  
  tags$li(
    tags$h6(
      "Access resources on ", tags$a(href = "https://biostats.shenoylab.com/", "statistics for biologists"), " and getting started with ", tags$a(href = "https://rcoding.shenoylab.com/", "R programming."))),
  
  ### shiny app --- start PBrvw
  tags$li(tags$h6(tags$strong("Privacy note:"), "This version is a", tags$a(href = "https://www.shinyapps.io/", " Shiny app"), ". Data are uploaded temporarily to servers (Posit Cloud via HTTPS), but they are not retained beyond the active user session. Consider installing grafify online locally from our ", tags$a(href = "https://github.com/ashenoy-cmbi/grafifyonline.shinyapp.plosbiol", "GitHub repo"), " or the Windows app for analysing sensitive data.")), 
  ### shiny app --- end
  
  
  ### analytic dec - start 
  tags$li(tags$h6(tags$strong("User metrics:"), "With your consent, we use anonymised analytics (Google Analytics) to understand general usage patterns and allocate computing resources. No uploaded datasets or analysis results are collected.")),
  ### analytics dec - end
  tags$li(p(paste("Last updated on:", last_updated))),)
)))
