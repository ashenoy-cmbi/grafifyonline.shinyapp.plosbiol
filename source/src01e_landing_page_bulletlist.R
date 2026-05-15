landing_info <- list(
  tagList(tags$div(
    
    tags$h5("grafify (version 0.1)"),
    
    tags$ul(
      
      tags$li(tags$h6(
        "grafify plots graphs and performs ANOVAs with post-hoc comparisons, similar to the ",
        tags$a(href = "https://grafify-vignettes.netlify.app/", "R package.")
      )),
      
      tags$li(tags$h6(
        "Uses ggplot2 with colourblind-friendly palettes and supports linear and mixed-effects models."
      )),
      
      tags$li(tags$h6(
        "Available online at ",
        tags$a(href = "https://grafifyonline.shinyapps.io/grafify/", "Shinyapps.io"), ". Also available as a ", tags$a(href = "https://posit-dev.github.io/r-shinylive/", "Shinylive app"), "at ",
        tags$a(href = "https://grafifyonline1.shenoylab.com/", "mirror 1"), " and ",
        tags$a(href = "https://grafifyonline2.shenoylab.com/", "mirror 2"), ", and as a ",
        tags$a(href = "https://sourceforge.net/projects/grafify/", "Windows app.")
      )),
      
      tags$li(tags$h6(
        "Also hosted on ",
        tags$a(href = "https://grafify.impaas.uk/", "Impaas"),
        " with support from Imperial College London ", tags$a(href = "https://edtech.pages.doc.ic.ac.uk/", "Department of Computing.")
      )),
      
      tags$li(tags$h6(
        "Resources: ",
        tags$a(href = "https://biostats.shenoylab.com/", "Statistics for biologists"),
        " and ",
        tags$a(href = "https://rcoding.shenoylab.com/", "R programming.")
      )),
      
      # ---- Shinylive version ----
      #tags$li(tags$h6(tags$strong("Browser:"), "Use Firefox for reliable PDF downloads. Other browsers fail to download PDFs of graphs.")), tags$li(tags$h6(tags$strong("Privacy:"), "Runs entirely in your browser (Shinylive). Data are not uploaded or stored.")),
      
      # ---- Shinyapps (server-hosted) version ----
      tags$li(tags$h6(tags$strong("Privacy: "),"Uploaded user data are processed only during the session and data, graphs or analyses are not retained. ", "For sensitive data, you can install a local version from our ", tags$a(href = "https://github.com/ashenoy-cmbi/grafifyonline.shinyapp.plosbiol", "GitHub"), ".")),
      
      # ---- Analytics ----
      tags$li(tags$h6(
        tags$strong("Usage metrics: "),
        "With your permission, anonymous analytics (Google Analytics) may be collected to understand usage and allocate computing resources."
      )),
      
      # ---- Window Analytics ----
      #tags$li(tags$h6(tags$strong("Privacy: "), "User data remain local and no usage metrics are collected.")),
      
      tags$li(tags$h6("Developed and maintained by",
              tags$a(href = "https://shenoylab.com/", "Avinash R Shenoy. "), paste("Last updated on:", last_updated)))
    )
  ))
)

