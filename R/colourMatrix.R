
#' Check and prep the colour matrix
#'
#' @param colMatrix A 3 x n matrix of integers between 0-255
#'
#' @return The checked and prepped matrix of the same size
#'
#' @examples
colourMatrix <- function(colMatrix) {
  
  # Colours. Perhaps replace with proper palette
  if (is.null(colMatrix)) {
    colMatrix <- grDevices::col2rgb(c("red", "green", "blue", "yellow", 
                                      "magenta", "cyan", "orange", "purple", "pink"))
  } else {
    
    stopifnot(is.numeric(colMatrix))
    stopifnot(is.matrix(colMatrix))
    
    if(nrow(colMatrix) != 3 & ncol(colMatrix)==3) {
      warning("3 columns and ", nrow(colMatrix), "rows. Do you need to transform the matrix - t(colMatrix)?")
    }

    if (any(colMatrix<0)) stop("colMatrix can't have negative values")
        
    # Check the range
    if (max(colMatrix) > 255) {
      colMatrix <- colMatrix / max(colMatrix)
      warning("colMatrix has values larger than 255, scaling by largest value")
    }
    
    # Make sure it's integer
    colMatrix <- floor(colMatrix)
  }
  
  colMatrix
}