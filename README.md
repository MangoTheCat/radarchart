# radarchart

```r
library(radarchart)

labs <- c("Communicator", "Data Wangler", "Programmer", "Technologist",  "Modeller", "Visualizer")

scores <- list(
  "Rich Pugh" = c(9, 7, 4, 5, 3, 7),
  "Andy Nicholls" = c(7, 6, 6, 2, 6, 9),
  "Aimee Gott" = c(6, 5, 8, 4, 7, 6)
)

chartJSRadar(scores=scores, labs=labs)


```