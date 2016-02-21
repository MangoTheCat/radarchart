# radarchart

[![Build Status](https://travis-ci.org/MangoTheCat/radarchart.svg?branch=master)](https://travis-ci.org/MangoTheCat/radarchart) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/MangoTheCat/radarchart?branch=master&svg=true)](https://ci.appveyor.com/project/MangoTheCat/radarchart)

An R implementation of the radar chart from the chart.js javascript library.

To install direct from GitHub you'll need devtools installed. Assuming you have this run:
```r
devtools::install_github("MangoTheCat/radarchart")
```

Or if you want to hack about with the code then clone the repository, change directory into it and run
```r
devtools::install()
```

Note: `htmlwidgets` packages don't work well with `devtools::load_all()`. Once installed you can make a radar chart


```r
library(radarchart)

labs <- c("Communicator", "Data Wangler", "Programmer",
          "Technologist",  "Modeller", "Visualizer")

scores <- list(
  "Rich" = c(9, 7, 4, 5, 3, 7),
  "Andy" = c(7, 6, 6, 2, 6, 9),
  "Aimee" = c(6, 5, 8, 4, 7, 6)
)

chartJSRadar(scores = scores, labs = labs, maxScale = 10)
```

Alternatively, you may supply a data frame and `chartJSRadar` will pickup the labels from the first column of the data.

```r
scores <- data.frame("Label"=c("Communicator", "Data Wangler", "Programmer",
                     "Technologist",  "Modeller", "Visualizer"),
                     "Rich" = c(9, 7, 4, 5, 3, 7),
                     "Andy" = c(7, 6, 6, 2, 6, 9),
                     "Aimee" = c(6, 5, 8, 4, 7, 6))

chartJSRadar(scores, maxScale = 10)
```

