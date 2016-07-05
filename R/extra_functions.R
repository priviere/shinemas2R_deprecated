# 0. help -----------------------------------------------------------------
#' Some functions used in several functions of shinemas2R
#' 
#' @name extra_functions
#' 
#' @description
#' This file group several functions used in several functions of shinemas2R:
#' \itemize{
#' 	\item get.ggplot
#' 	\item get.table
#' }
#' 
#' @author Pierre Riviere
#' 

# get.ggplot, get.table
data.to.use = function(data, correlated_group){
	if( is.null(correlated_group) ) {
		data = data$data	
	} else { 
		data_tmp = data$data.with.correlated.variables
		if(is.element(correlated_group, names(d))) {
			data = data_tmp[[correlated_group]]
		} else { stop(correlated_group, "is not a group of the data set. Possibles groups are: ", paste(names(data_tmp), collapse = ", "), ".") }
	}
	return(data)
}

# get.ggplot, get.table
update.data.merge_g_and_s = function(data, merge_g_and_s){
	if( merge_g_and_s ) { 
		data$son_germplasm = sapply(as.character(data$son), function(x){unlist(strsplit(x,"_"))[1]}) 
		data$father_germplasm = sapply(as.character(data$father), function(x){unlist(strsplit(x,"_"))[1]}) 
	}	
	return(data)
}
 
# get.table, format.data
get.vec_variables = function(data, shinemas2R){
	if( shinemas2R.object == "data-classic-relation") { vec_variables = colnames(data)[c(40: ncol(data))] }
	if( shinemas2R.object == "data-S-relation" | shinemas2R.object == "data-SR-relation" ) { vec_variables = colnames(data)[c(44: ncol(data))] }
	if( shinemas2R.object == "data-classic-seed-lots") { vec_variables = colnames(data)[c(15: ncol(data))] }
	if( shinemas2R.object == "data-S-seed-lots" | shinemas2R.object == "data-SR-seed-lots" ) { vec_variables = colnames(data)[c(19: ncol(data))] }
	return(vec_variables)
}
