# 0. help -----------------------------------------------------------------
#' Translate variables and methods present in data coming from \code{get.data}
#' 
#' @param data output from the \code{get.data} function
#' 
#' @param list_translation A list with as many elements as variables to translate. It is under the form list(c("tkw", "pmg"), c("protein", "proteine")).
#' 
#' @return The data with translated data
#' 
#' @seealso \code{\link{get.data}}, \code{\link{is.get.data.output}}
#' 
translate.data = function(
data,
list_translation
)
	# lets go !!! ----------
{
	shinemas2R.object = attributes(data$data)$shinemas2R.object
	
	mess = "data must come from shinemas2R::get.data or shinemas2R:is.get.data.output"
	if( is.null(shinemas2R.object) ) { stop(mess) }
	if( !is.element(shinemas2R.object, 
									c("data-classic-relation", 
										"data-S-relation", 
										"data-SR-relation", 
										"data-classic-seed-lots",
										"data-S-seed-lots", 
										"data-SR-seed-lots",
										"data-mixture")) 
	) { stop(mess) }  
	
	
	translate = function(d, n1 ,n2){
		if( !is.null(d)){
			# variables
			toget = grep(paste(n1, "---", sep = ""), colnames(d))
			if( length(toget) > 0 ){ colnames(d)[toget] = sub(paste(n1, "---", sep = ""), paste(n2, "---", sep = ""), colnames(d)[toget]) }
			# methods
			toget = grep(paste("---", n1, sep = ""), colnames(d))
			if( length(toget) > 0 ){ colnames(d)[toget] = sub(paste("---", n1, sep = ""), paste("---", n2, sep = ""), colnames(d)[toget]) }
		}
		return(d)
	}
	
	for(n in list_translation){
		n1 = n[1]; n2 = n[2]
		
		# data
		data$data$data = translate(data$data$data, n1, n2)
		data$data$data.with.correlated.variables = lapply(data$data$data.with.correlated.variables, translate, n1, n2)
		
		# methods
		toget = grep(paste(n1, "---", sep = ""), data$data$methods$"variable---methods")
		if( length(toget) > 0 ){ data$data$methods$"variable---methods"[toget] = sub(paste(n1, "---", sep = ""), paste(n2, "---", sep = ""), data$data$methods$"variable---methods"[toget]) }
		toget = grep(paste("---", n1, sep = ""), data$data$methods$"variable---methods")
		if( length(toget) > 0 ){ data$data$methods$"variable---methods"[toget] = sub(paste("---", n1, sep = ""), paste("---", n2, sep = ""), data$data$methods$"variable---methods"[toget]) }

		data$data$methods$variable_name=unlist(gsub("^([^---]*)---.*$", "\\1",as.character(data$data$methods$"variable---methods")))
		data$data$methods$method_name=unlist(gsub("^.*---([^---]*).*$", "\\1",as.character(data$data$methods$"variable---methods")))
		}

	return(data)
}

