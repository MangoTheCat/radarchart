# radarchart

[![Build Status](https://travis-ci.org/MangoTheCat/radarchart.svg?branch=master)](https://travis-ci.org/MangoTheCat/radarchart)

An R implementation of the radar chart from the chart.js javascript library.

To install direct from GitHub you'll need devtools installed. Assuming you have this run:
```r
devtools::install_github("MangoTheCat/radarchart")
```

Or if you want to hack about with the code then clone the repository, change directory into it and run
```r
devtools::install()
```

Once installed you can make a radar chart

```r
library(radarchart)

labs <- c("Communicator", "Data Wangler", "Programmer",
          "Technologist",  "Modeller", "Visualizer")

scores <- list(
  "Rich Pugh" = c(9, 7, 4, 5, 3, 7),
  "Andy Nicholls" = c(7, 6, 6, 2, 6, 9),
  "Aimee Gott" = c(6, 5, 8, 4, 7, 6)
)

chartJSRadar(scores=scores, labs=labs, maxScale=10)


```
