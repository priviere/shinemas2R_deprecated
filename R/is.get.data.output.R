# 0. help -----------------------------------------------------------------
#' Get a pdf by concatene outputs from \code{get.ggplot} and \code{get.table}
#'
#' @description
#' \code{is.get.data.output} check if data set can be used as entry for \code{get.ggplot} and \code{get.table}
#'
#' @param data dthe date set to check
#'
#' @param shinemas2R.object The type of shinemas2R.object to check. Possible values are:
#' \itemize{
#' 	\item "network"
#' 	\item "data-classic-seed-lots"
#' 	\item "data-classic-relation"
#' 	\item "data-S-seed-lots"
#' 	\item "data-S-relation"
#' 	\item "data-SR-seed-lots"
#' 	\item "data-SR-relation"
#' 	}
#' 	
#' @return The function returns a data set with the corresponding shinemas2R.object attributes or an error.
#' 
#' @author Pierre Riviere
#' 
#' @seealso \code{\link{get.ggplot}}, \code{\link{get.table}}
#' 
is.get.data.output = function(
	data, 
	shinemas2R.object
)	
	# lets go !!! ----------
{
	# 1. Error messages ----------
	shinemas2R.object = "network"
	shinemas2R.object = "data-classic-seed-lots"
	shinemas2R.object = "data-classic-relation"
	shinemas2R.object = "data-S-seed-lots"
	shinemas2R.object = "data-S-relation"
	shinemas2R.object = "data-SR-seed-lots"
	shinemas2R.object = "data-SR-relation"
	
	}


