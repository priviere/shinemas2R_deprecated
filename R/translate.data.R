# 0. help -----------------------------------------------------------------
#' Translate variables present in data coming from \code{get.data}
#' 
#' @param data output from the \code{get.data} function
#' 
#' @param list_translation A list with as many element as variables to translate. It is under the form list(c("tkw", "pmg"), c("protein", "proteine")).
#' 
#' @return The data with translated variables
#' 
#' @seealso \code{\link{get.data}}, \code{\link{is.get.data.output}}
#' 

translate.data = function(
data,
list_translation
)
	# lets go !!! ----------

{
	data = data$data
	shinemas2R.object = attributes(data)$shinemas2R.object
	
	mess = "data must come from shinemas2R::get.data or shinemas2R:is.get.data.output"
	if( is.null(shinemas2R.object) ) { stop(mess) }
	if( !is.element(shinemas2R.object, 
									c("data-classic-relation", 
										"data-S-relation", 
										"data-SR-relation", 
										"data-classic-seed-lots",
										"data-S-seed-lots", 
										"data-SR-seed-lots")) 
	) { stop(mess) }  
	
	
	att_data = attributes(data)$shinemas2R.object
	data_cor = data$datasets.with.correlated.variables 
	data_not_cor = data$datasets.with.non.correlated.variables
	meth = data$methods
	
	for(n in list_translation){
		n1 = n[1]; n2 = n[2]
		toget = which(colnames(data_cor) == n1)
		if( length(toget) > 0 ){ colnames(data_cor)[toget] = n2 }
		toget = which(colnames(data_not_cor) == n1)
		if( length(toget) > 0 ){ colnames(data_not_cor)[toget] = n2 }
	}
	
	out = list(
"datasets.with.correlated.variables" = data_cor, 
"datasets.with.non.correlated.variables" = data_not_cor, 
"methods" = meth
)
	attributes(out)$shinemas2R.object = att_data

	return(out)
}

