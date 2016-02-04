# 0. help -----------------------------------------------------------------
#' Check if data set can be used as entry for \code{get.ggplot} and \code{get.table}
#'
#' @description
#' \code{is.get.data.output} check if data set can be used as entry for \code{get.ggplot} and \code{get.table}.
#' This is useful when the user do not have SHiNeMaS but wish to use the other functions of the packages: \code{get.ggplot}, \code{get.table} and \code{get.pdf}.
#'
#' @param data the date set to check
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
	vec_shinemas2R.object = c("network", "data-classic-seed-lots", "data-classic-relation", "data-S-seed-lots", "data-S-relation", "data-SR-seed-lots", "data-SR-relation")
	if(!is.element(shinemas2R.object, vec_shinemas2R.object)) { stop("shinemas2R.object must be: ", paste(vec_shinemas2R.object, collapse = ", ")) }

	
	}


