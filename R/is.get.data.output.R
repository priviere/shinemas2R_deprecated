# 0. help -----------------------------------------------------------------
#' Check if data set can be used as entry for \code{get.ggplot} and \code{get.table}
#'
#' @description
#' \code{is.get.data.output} check if data set can be used as entry for \code{get.ggplot} and \code{get.table}.
#' This is useful when the user do not have SHiNeMaS but wish to use the other functions of the package.
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
#' 	@details 
#' 	Format of the different shinemas2R.object
#' 	\itemize{
#' 	 \item "network" It must be a list of three elements: "network", "network.info" and "Mdist" (see \code{get.data} for more details) with the followinf format:
#' 	 \itemize{
#' 	 	\item "network" must be a network object. It can be NULL. Vertex attributes can be put on "year", "person", "germplasm", germplasm.type" and "sex". Edge attributes can be put on "relation" and "generation"
#' 	 	\item "network.info" must be a dataframe. It can be NULL. It has the following columns: sl, which is a character; alt, long and lat which are numeric; diffusion, id.diff, reproduction, mixture, cross.info, germplasm, person and year, which are factor.
#' 	 	Possible values for diffusion are for EN: "give", "receive", "give-receive" or NA.
#' 	 	Possible values for reproduction are for EN: "sow", "harvest", "harvest-sow" or NA.
#' 	 	Possible values for selection are for EN: selection or NA.
#' 	 	Possible values for mixture are for EN: mixture or NA.
#' 	 	
#' 	 	\item "Mdist" must be a square matrix with the same columns and rows names.
#' 	 	}
#' 	 	
#' 	 \item "data-classic-seed-lots"
#' 	 
#' 	 \item "data-classic-relation"
#' 	 
#' 	 \item "data-S-seed-lots"
#' 	 
#' 	 \item "data-S-relation"
#' 	 
#' 	 \item "data-SR-seed-lots"
#' 	 
#' 	 \item "data-SR-relation"
#' 	 
#' 	}
#' 	
#' @return The function returns a data set with the corresponding shinemas2R.object attributes or an error.
#' 
#' @author Pierre Riviere
#' 
#' @seealso \code{\link{encrypt.data}}, \code{\link{translate.data}},, \code{\link{format.data}}, \code{\link{get.ggplot}}, \code{\link{get.table}}
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

	# 2. shinemas2R.object == "network"
	if( shinemas2R.object == "network") { 
		
		mess = "With shinemas2R.object == \"network\", data must be a list with the following three elements: \"network\", \"network.info\", \"Mdist\"." 
		if( !is.list(data) ) { stop(mess) }
		if( is.null(names(data)[1]) ) { stop(mess) }
		if( is.null(names(data)[2]) ) { stop(mess) }
		if( is.null(names(data)[3]) ) { stop(mess) }
		if( names(data)[1] != "network" ) { stop(mess) }
		if( names(data)[2] != "network.info" ) { stop(mess) }
		if( names(data)[3] != "Mdist" ) { stop(mess) }
		
		# 2.1. "network"
		if( !is.null(data[[1]]) ) {
			if( !is.network(data[[1]]) ) { stop("The first element of data must be NULL or a network object.") }
			update.vertex.attributes = function(n = data, v.att = "year"){
				test = get.vertex.attribute(n, v.att)
				if( length(which(is.na(test))) == length(test) ) { 
					set.vertex.attribute(n, v.att, value = NULL)	
					message("vertex attributes \",", v.att,",\" has been set to NULL.")
				}			
			}
			update.vertex.attributes(n = data[[1]], v.att = "year")
			update.vertex.attributes(n = data[[1]], v.att = "person")
			update.vertex.attributes(n = data[[1]], v.att = "germplasm")
			update.vertex.attributes(n = data[[1]], v.att = "germplasm.type")
			update.vertex.attributes(n = data[[1]], v.att = "sex")
			
			update.edge.attributes = function(n = data, e.att = "relation"){
				test = get.edge.attribute(n, e.att)
				if( length(which(is.na(test))) == length(test) ) { 
					set.edge.value(n, e.att, value = NULL)	
					message("edge attributes \",", e.att,",\" has been set to NULL.")
				}			
			}
			update.edge.attributes(n = data[[1]], e.att = "relation")
			update.edge.attributes(n = data[[1]], e.att = "generation")
		}
		
		
		# 2.2. "network.info"
		ni = data[[2]]
		
		if( !is.null(ni) ) {
			if( !is.data.frame(ni) ) { stop("The first second of data must be NULL or a data frame.") }

			if( !is.character(ni$sl) ) { stop("The data fame must have a column \"sl\" as character") } 
		if( !is.numeric(ni$alt) ) { stop("The data fame must have a column \"alt\" as numeric") }
		if( !is.numeric(ni$long) ) { stop("The data fame must have a column \"long\" as numeric") }
		if( !is.numeric(ni$lat) ) { stop("The data fame must have a column \"lat\" as numeric") }
		if( !is.factor(ni$diffusion) ) { stop("The data fame must have a column \"diffusion\" as factor") }
		if( !is.factor(ni$id.diff) ) { stop("The data fame must have a column \"id.diff\" as factor") }
		if( !is.factor(ni$reproduction) ) { stop("The data fame must have a column \"reproduction\" as factor") }
		if( !is.factor(ni$mixture) ) { stop("The data fame must have a column \"mixture\" as factor") }
		if( !is.factor(ni$selection) ) { stop("The data fame must have a column \"selection\" as factor") }
		if( !is.factor(ni$cross.info) ) { stop("The data fame must have a column \"cross.info\" as factor") }
		if( !is.factor(ni$germplasm) ) { stop("The data fame must have a column \"germplasm\" as factor") }
		if( !is.factor(ni$person) ) { stop("The data fame must have a column \"person\" as factor") }
		if( !is.factor(ni$year) ) { stop("The data fame must have a column \"year\" as factor") }
			
		test = setdiff(ni$diffusion, c(gettext("give"), gettext("receive"), gettext("give-receive"), NA))
		if( length(test) > 0 ) { stop("For column diffusion, the possible values are: \"", gettext("give"), "\" ,\"", gettext("receive"), "\" ,\"", gettext("give-receive"), "\", or NA.") }

		test = setdiff(ni$reproduction, c(gettext("sow"), gettext("harvest"), gettext("harvest-sow"), NA))
		if( length(test) > 0 ) { stop("For column reproduction, the possible values are: \"", gettext("sow"), "\" ,\"", gettext("harvest"), "\" ,\"", gettext("harvest-sow"), "\", or NA.") }

		test = setdiff(ni$selection, c("selection", NA))
		if( length(test) > 0 ) { stop("For column selection, the possible values are: \"selection\", or \"\".") }

		test = setdiff(ni$mixture, c("mixture", NA))
		if( length(test) > 0 ) { stop("For column mixture, the possible values are: \"mixture\", or \"\".") }
		
		}
		

		# 2.3. "Mdist"
		Md = data[[3]]
		
		if( !is.null(Md) ) {
			mess = "Mdist msut be a square matric with the same names in columns and in rows."
			if( ncol(Md) != nrow(Md) ) { stop(mess) }
			test = unique(colnames(Md) == rownames(Md))
			test = length(test) == 1 & test[1]
			if( !test ) { stop(mess) }
			}
		
		attributes(data)$shinemas2R.object = "network"
		data = list("data" = data, "info_db" = NULL)
		}

	if( shinemas2R.object == "data-classic-seed-lots") { }

	if( shinemas2R.object == "data-classic-relation") { }

	if( shinemas2R.object == "data-S-seed-lots") { }

	if( shinemas2R.object == "data-S-relation") { }

	if( shinemas2R.object == "data-SR-seed-lots") { }
	
	if( shinemas2R.object == "data-SR-relation") { }
		
	return(data)
	}


