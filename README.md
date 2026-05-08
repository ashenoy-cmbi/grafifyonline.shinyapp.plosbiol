## `grafify online` GitHub repository

This repository has the code for the `grafify online` Shiny app. The app Shiny app based on the `grafify` R package, which is can be downloaded from [CRAN](https://cran.r-project.org/package=grafify) and [GitHub](https://github.com/ashenoy-cmbi/grafify), and comes with detailed usage [vignettes](https://grafify.shenoylab.com/). 

### `grafify online`

This is a browser-based app to plot graphs and perform analyses using linear models. The graph can be downloaded as a PDF file. Other results can be saved by saving the web page. 

`grafify online` Shiny app can be found at the following URLs
  - https://grafifyonline.shinyapps.io/grafify/
  - https://grafify.impaas.uk/
  
A server-free version that uses `shinylive` can be found at the following URL:
  - https://grafifyonline1.shenoylab.com
  - https://grafifyonline2.shenoylab.com

### App structure

The following provides a general outline of the way the files in this repository are arranged. The app runs through the `app.R` file in the base directory, and be invoked with `runApp()`. 

#### `app.R`

This file contains the basic `ui` and `server` parts of the app, and much of the code is split across several `source` files to keep it a bit more organised. Disclaimer: despite this, the code is long and can be complex to follow, and hopefully the annotations/comments are useful.

As is required for Shiny apps, the code is placed in `source` directory, and other files (e.g., images) are in `www`. The other folders were used during development.

#### Source files in `ui`

There are 11 files that code the `ui`, with the sublists indicating sections within those source files. Most of these are sourced in `app.R`, or in other src files. 

01.  src01e_menu_links.R
     - link_shenoy
     - link_github
     - link_vignettes
     - link_biostats
     - link_rcoding
     
02.  src01eFeb08_mainbar_parts.R
     03. src01Panel_DataVars.R
       - Panel_DataVars
     04. src01Panel_Graphs.R
       05. src01PanelGraphs_card4_5.R
         - Graphs_card4_5
       06. src01PanelGraphs_card6_7.R
         - Graphs_card6_7
       07. src01PanelGraphs_card8.R
         - Graphs_card8
       08. src01PanelGraphs_cardPlotDownload.R
         - Graphs_PlotDownload
       09. src01Panel_Anova_tabs.R
         - Panel_Anova
       
10.  src01g_Help_n_Images.R
     - mainPanel2.1 #used in src_02_headers_help
     - mainPanel2.2 #used in src_02_headers_help
     - mainPanel2.3 #used in src_02_headers_help
   
11.  src02_headers_help.R
     - output$ for help text on all tabs #no lists or sources 
  
#### Source files in `server`

There are 27 files that code the `server`, with the sublists indicating sections (and reactives) within those source files. There are ~ 16 reactives in `app.R`, and others are spread across `server` sections.

01. src01e_GraphTypeChoices.R # ~10 EventReactives
02. src01f_Optional_GraphSettings.R # ~22 output$
03. src02_headers_help.R # mainPanels2.1-2.3
04. src03b_emmeans.R # ~8 reactives
05. src03d_anova_n_residuals_SimpMixed_B.R # ~3 reactives
     - src15_AvgRF_graphs.R # ~14 reactives
06. src04_boxplot_n_save.R
07. src05_barplot_n_save.R
08. src05b_pointSD_plot_n_save.R
09. src06_matchplot_n_save.R
10. src08_violinplot_n_save.R
11. src09_befafterplot_n_save.R
12. src10a_3dviolinplot_n_save.R
13. src10b_3dboxplot_n_save.R
14. src10c_3dbarplot_n_save.R
15. src10d_3dpointSDplot_n_save.R
16. src11a_4dBoxplot_n_save.R
17. src11b_4dShapesBoxplot_n_save.R
18. src11c_4dBarplot_n_save.R
19. src11d_4dShapesBarplot_n_save.R
20. src11e_4dViolinplot_n_save.R
21. src11f_4dShapesViolinplot_n_save.R
22. src11g_4dPointplot_n_save.R
23. src11h_4dShapesPointpoint_n_save.R
24. src12_tooltips.R # ~6 showModal help texts
25. src13_numericXYplot_n_save.R
26. src14_DensityHistogram_plot_n_save.R 
    - 27. src14b2_plot_density_histo.R # plot_density reactive

