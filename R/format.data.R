# 0. help -----------------------------------------------------------------
#' Format data from \code{get.data} to be used by several R packages
#'
#' @param data output from the \code{get.data} function
#' 
#' @param data.on "son" or "father" depending on which seed-lots you want the information.
#' 
#' @param fuse_g_and_s Fuse germplasm and selection name information in a column named germplasm
#' 
#' @param correlated_group Name of the group of correlation in data. NULL by default.
#' 
#' @param format the format you want. It is under the form "name_of_the_package" or "name_of_the_package::name_of_the_function" if there are several formats within a package. Possible values are "PPBstats".
#' 
#' @return The data set with the right format for the R package
#' 
#' @example 
#' # See the vignette
#' 
#' @seealso \code{\link{get.data}}, \code{\link{is.get.data.output}}
#' 
format.data = function(
data,
data.on = "son",
fuse_g_and_s = FALSE,
correlated_group = NULL,
format = "PPBstats"
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
	

if( is.null(correlated_group) ) {
	data = data$data	
	} else { 
		data_tmp = data$data.with.correlated.variables
		if(is.element(correlated_group, names(d))) {
			data = data_tmp[[correlated_group]]
		} else { stop(correlated_group, "is not a group of the data set. Possibles groups are: ", paste(names(data_tmp), collapse = ", "), ".") }
	}
	
	
if( format == "PPBstats" ) {

	if( data.on == "son" ){ 
		if( fuse_g_and_s ) { data$format_germplasm = sapply(data$son, function(x){unlist(strsplit(x,"_"))[1]}) } else { data$format_germplasm = data$son_germplasm }
		data$format_year = data$son_year
		data$format_location = data$son_person
		}
	
	if( data.on == "father" ){ 
		if( fuse_g_and_s ) { data$format_germplasm = sapply(data$father, function(x){unlist(strsplit(x,"_"))[1]}) } else { data$format_germplasm = data$father_germplasm }
		data$format_year = data$father_year
		data$format_location = data$father_person
	}
	

	vec_variables = colnames(data)[c(29: (ncol(data)-3))] # - 3 because of  format_germplasm format_year format_location
	# Importance d'avoir le meme nombre de colonnes dans toutes les sorties de data ou alors avec un attributes ?!!!
	print("Importance d'avoir le meme nombre de colonnes dans toutes les sorties de data ou alors avec un attributes ?!!!")
	
	out = data[,c("format_year", "format_location", "format_germplasm", "block", "X", "Y", vec_variables)]
	colnames(out) = c("year", "location", "germplasm", "block", "X", "Y", vec_variables)
	
	}

return(out)
}

