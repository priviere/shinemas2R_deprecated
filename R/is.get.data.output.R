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
#' 	Formats of the different shinemas2R.object:
#' 	\itemize{
#' 	 \item "network" It must be a list of four elements: "network", "network.query", "network.info" and "Mdist" (see \code{get.data} for more details) with the followinf format:
#' 	 \itemize{
#' 	 	\item "network" must be a network object. It can be NULL. Vertex attributes can be put on "year", "person", "germplasm", germplasm.type" and "sex". Edge attributes can be put on "relation" and "generation"
#' 	 	
#' 	 	\item "network.query" must be a dataframe. It can be NULL. It has the following columns: 
#' son_species, son_project, son, son_germplasm, son_person, son_year, son_germplasm_type which are factors,
#' son_alt, son_long, son_lat, son_total_generation_nb, son_local_generation_nb which are numerics,
#' son_generation_confidence, son_comments which are characters,father_species, father_project, son, father_germplasm, father_person, father_year, father_germplasm_type which are factors,
#' father_alt, father_long, father_lat, father_total_generation_nb, father_local_generation_nb which are numerics,
#' father_generation_confidence, father_comments which are characters,
#' reproduction_id which is character,
#' reproduction_method_name, is_male, block which are factors,
#' selection_id which is character,
#' selection_person which is factor,
#' mixture_id, diffusion_id  which are character,
#' relation_year_start, relation_year_end which are factors.
#'
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
#' @examples 
#' # See the vignette and appendix D
#' 
#' @author Pierre Riviere
#' 
#' @seealso \code{\link{encrypt.data}}, \code{\link{translate.data}},, \code{\link{format.data}}, \code{\link{get.ggplot}}, \code{\link{get.table}}
#' 
is.get.data.output = function(
	data, 
	shinemas2R.object = "network"
)	
	# lets go !!! ----------
{
	# 1. Error messages ----------
	vec_shinemas2R.object = c("network", "data-classic-seed-lots", "data-classic-relation", "data-S-seed-lots", "data-S-relation", "data-SR-seed-lots", "data-SR-relation")
	if(!is.element(shinemas2R.object, vec_shinemas2R.object)) { stop("shinemas2R.object must be: ", paste(vec_shinemas2R.object, collapse = ", ")) }

	# 2. shinemas2R.object == "network" ----------
	if( shinemas2R.object == "network") { 
		
		mess = "With shinemas2R.object == \"network\", data must be a list with the following three elements: \"network\", \"network.info\", \"Mdist\"." 
		if( !is.list(data) ) { stop(mess) }
		if( is.null(names(data)[1]) ) { stop(mess) }
		if( is.null(names(data)[2]) ) { stop(mess) }
		if( is.null(names(data)[3]) ) { stop(mess) }
		if( is.null(names(data)[4]) ) { stop(mess) }
		if( names(data)[1] != "network" ) { stop(mess) }
		if( names(data)[2] != "network.query" ) { stop(mess) }
		if( names(data)[3] != "network.info" ) { stop(mess) }
		if( names(data)[4] != "Mdist" ) { stop(mess) }
		
		# 2.1. "network" ----------
		if( !is.null(data[[1]]) ) {
			if( !is.network(data[[1]]) ) { stop("The first element of data must be NULL or a network object.") }
			update.vertex.attributes = function(n = data, v.att = "year"){
				test = get.vertex.attribute(n, v.att)
				if( length(which(is.na(test))) == length(test) ) { 
					set.vertex.attribute(n, v.att, value = NA)	
					message("vertex attributes \"", v.att,"\" has been set to NA.")
				}			
			}
			update.vertex.attributes(n = data[[1]], v.att = "year")
			update.vertex.attributes(n = data[[1]], v.att = "person")
			update.vertex.attributes(n = data[[1]], v.att = "germplasm")
			update.vertex.attributes(n = data[[1]], v.att = "germplasm.type")
			update.vertex.attributes(n = data[[1]], v.att = "sex")
			
			update.edge.attributes = function(n = n, e.att = "relation"){
				test = get.edge.attribute(n, e.att)
				if( is.null(test) ) { 
					set.edge.attribute(n, e.att, value = NA)	
					message("edge attributes \",", e.att,",\" has been set to NA.")
				}
			}
			
			update.edge.attributes(n = data[[1]], e.att = "relation")
			update.edge.attributes(n = data[[1]], e.att = "generation")
		}

		# 2.2. "network.query" ----------
		ni = data[[2]]
		if( !is.null(ni) ) {
			if( !is.data.frame(ni) ) { stop("The second element of data (i.e. network.query) must be NULL or a data frame.") }
			
			col_to_have = c(
				"son_species",
				"son_project",
				"son",
				"son_germplasm",
				"son_person",
				"son_year",
				"son_germplasm_type",
				"son_alt",
				"son_long",
				"son_lat",
				"son_total_generation_nb",
				"son_local_generation_nb",
				"son_generation_confidence",
				"son_comments",
				
				"father_species",
				"father_project",
				"father",
				"father_germplasm",
				"father_person",
				"father_year",
				"father_germplasm_type",
				"father_alt",
				"father_long",
				"father_lat",
				"father_total_generation_nb",
				"father_local_generation_nb",
				"father_generation_confidence",
				"father_comments",
				
				"reproduction_id",
				"reproduction_method_name",
				"is_male",
				"block",
				
				"selection_id",
				"selection_person",
				"mixture_id",
				"diffusion_id",
				"relation_year_start",
				"relation_year_end")
			test = setdiff(colnames(ni), col_to_have)
			
			if( length(test) > 0 ) { stop("The second element of data (i.e. network.query) must have the following columns: ", paste(col_to_have, collapse = ", ")) }

			if( !is.factor(ni$son_species) ) { stop("The data fame must have a column \"son_species\" as factor") } 
			if( !is.factor(ni$son_project) ) { stop("The data fame must have a column \"son_project\" as factor") } 
			if( !is.factor(ni$son) ) { stop("The data fame must have a column \"son\" as factor") } 
			if( !is.factor(ni$son_germplasm) ) { stop("The data fame must have a column \"son_germplasm\" as factor") } 
			if( !is.factor(ni$son_person) ) { stop("The data fame must have a column \"son_person\" as factor") } 
			if( !is.factor(ni$son_year) ) { stop("The data fame must have a column \"son_year\" as factor") } 
			if( !is.factor(ni$son_germplasm_type) ) { stop("The data fame must have a column \"son_germplasm_type\" as factor") } 
			if( !is.numeric(ni$son_alt) ) { stop("The data fame must have a column \"son_alt\" as numeric") } 
			if( !is.numeric(ni$son_long) ) { stop("The data fame must have a column \"son_long\" as numeric") } 
			if( !is.numeric(ni$son_lat) ) { stop("The data fame must have a column \"son_lat\" as numeric") } 
			if( !is.numeric(ni$son_total_generation_nb) ) { stop("The data fame must have a column \"son_total_generation_nb\" as numeric") } 
			if( !is.numeric(ni$son_local_generation_nb) ) { stop("The data fame must have a column \"son_local_generation_nb\" as numeric") } 
			if( !is.character(ni$son_generation_confidence) ) { stop("The data fame must have a column \"son_generation_confidence\" as character") } 
			if( !is.character(ni$son_comments) ) { stop("The data fame must have a column \"son_comments\" as character") } 
			
			
			if( !is.factor(ni$father_species) ) { stop("The data fame must have a column \"father_species\" as factor") } 
			if( !is.factor(ni$father_project) ) { stop("The data fame must have a column \"father_project\" as factor") } 
			if( !is.factor(ni$father) ) { stop("The data fame must have a column \"father\" as factor") } 
			if( !is.factor(ni$father_germplasm) ) { stop("The data fame must have a column \"father_germplasm\" as factor") } 
			if( !is.factor(ni$father_person) ) { stop("The data fame must have a column \"father_person\" as factor") } 
			if( !is.factor(ni$father_year) ) { stop("The data fame must have a column \"father_year\" as factor") } 
			if( !is.factor(ni$father_germplasm_type) ) { stop("The data fame must have a column \"father_germplasm_type\" as factor") } 
			if( !is.numeric(ni$father_alt) ) { stop("The data fame must have a column \"father_alt\" as numeric") } 
			if( !is.numeric(ni$father_long) ) { stop("The data fame must have a column \"father_long\" as numeric") } 
			if( !is.numeric(ni$father_lat) ) { stop("The data fame must have a column \"father_lat\" as numeric") } 
			if( !is.numeric(ni$father_total_generation_nb) ) { stop("The data fame must have a column \"father_total_generation_nb\" as numeric") } 
			if( !is.numeric(ni$father_local_generation_nb) ) { stop("The data fame must have a column \"father_local_generation_nb\" as numeric") } 
			if( !is.character(ni$father_generation_confidence) ) { stop("The data fame must have a column \"father_generation_confidence\" as character") } 
			if( !is.character(ni$father_comments) ) { stop("The data fame must have a column \"father_comments\" as character") } 
			
			if( !is.character(ni$reproduction_id) ) { stop("The data fame must have a column \"reproduction_id\" as character") } 
			if( !is.factor(ni$reproduction_method_name) ) { stop("The data fame must have a column \"reproduction_method_name\" as factor") } 
			if( !is.factor(ni$is_male) ) { stop("The data fame must have a column \"is_male\" as factor") } 
			if( !is.factor(ni$block) ) { stop("The data fame must have a column \"block\" as factor") } 
			
			if( !is.character(ni$selection_id) ) { stop("The data fame must have a column \"selection_id\" as character") } 
			if( !is.factor(ni$selection_person) ) { stop("The data fame must have a column \"selection_person\" as factor") } 
			if( !is.character(ni$mixture_id) ) { stop("The data fame must have a column \"mixture_id\" as character") } 
			if( !is.character(ni$diffusion_id) ) { stop("The data fame must have a column \"diffusion_id\" as character") } 
			if( !is.factor(ni$relation_year_start) ) { stop("The data fame must have a column \"relation_year_start\" as factor") } 
			if( !is.factor(ni$relation_year_end) ) { stop("The data fame must have a column \"relation_year_end\" as factor") } 
		}
		
		# 2.3. "network.info" ----------
		ni = data[[3]]
		
		if( !is.null(ni) ) {
			if( !is.data.frame(ni) ) { stop("The third element of data must be NULL or a data frame.") }
			
			col_to_have = c("sl", "alt", "long", "lat", "diffusion", "id.diff", "reproduction", "mixture", "selection", "cross.info", "germplasm", "person", "year")
			test = setdiff(colnames(ni), c(col_to_have))
			if( length(test) > 0 ) { stop("The second element of data (i.e. network.info) must have the following columns: ", paste(col_to_have, collapse = ", ")) }

			if( !is.factor(ni$sl) ) { stop("The data fame must have a column \"sl\" as factor") } 
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
			
		test = setdiff(as.character(ni$diffusion), c(gettext("give"), gettext("receive"), gettext("give-receive"), NA))
		if( length(test) > 0 ) { stop("For column diffusion, the possible values are: \"", gettext("give"), "\" ,\"", gettext("receive"), "\" ,\"", gettext("give-receive"), "\", or NA.") }

		test = setdiff(as.character(ni$reproduction), c(gettext("sow"), gettext("harvest"), gettext("harvest-sow"), NA))
		if( length(test) > 0 ) { stop("For column reproduction, the possible values are: \"", gettext("sow"), "\" ,\"", gettext("harvest"), "\" ,\"", gettext("harvest-sow"), "\", or NA.") }

		test = setdiff(as.character(ni$selection), c("selection", NA))
		if( length(test) > 0 ) { stop("For column selection, the possible values are: \"selection\", or \"\".") }

		test = setdiff(as.character(ni$mixture), c("mixture", NA))
		if( length(test) > 0 ) { stop("For column mixture, the possible values are: \"mixture\", or \"\".") }
		
		}
		
		# 2.4. "Mdist" ----------
		Md = data[[4]]
		
		if( !is.null(Md) ) {
			mess = "Mdist must be a square matric with the same names in columns and in rows."
			if( ncol(Md) != nrow(Md) ) { stop(mess) }
			test = unique(colnames(Md) == rownames(Md))
			test = length(test) == 1 & test[1]
			if( !test ) { stop(mess) }
			}
		
		attributes(data)$shinemas2R.object = "network"
		data = list("data" = data, "info_db" = NULL)
	}

	# 3. shinemas2R.object in "data-..." ----------

	check.format.all = function(shinemas2R.object){
		mess = paste("With shinemas2R.object == \"", shinemas2R.object, "\", data must be a list with the following three elements: \"data\", \"data.with.correlated.variables\", \"methods\".", sep = "")
			if( !is.list(data) ) { stop(mess) }
			if( is.null(names(data)[1]) ) { stop(mess) }
			if( is.null(names(data)[2]) ) { stop(mess) }
			if( is.null(names(data)[3]) ) { stop(mess) }
			if( names(data)[1] != "data" ) { stop(mess) }
			if( names(data)[2] != "data.with.correlated.variables" ) { stop(mess) }
			if( names(data)[3] != "methods" ) { stop(mess) }
	}
	
	check.format.method = function(d){
		if( !is.null(d) ) {
			if( !is.data.frame(d) ) { stop("The third element of data must be NULL or a data frame.") }
			
			col_to_have = c("method_name", "variable_name", "method_description", "unit", "variable---methods")
			test = setdiff(colnames(d), c(col_to_have))
			if( length(test) > 0 ) { stop("The first element of data (i.e. data) must have the following columns: ", paste(col_to_have, collapse = ", ")) }
			
			if( !is.character(d$method_name) ) { stop("The data fame must have a column \"method_name\" as character") } 
			if( !is.character(d$variable_name) ) { stop("The data fame must have a column \"variable_name\" as character") } 
			if( !is.character(d$method_description) ) { stop("The data fame must have a column \"method_description\" as character") } 
			if( !is.character(d$unit) ) { stop("The data fame must have a column \"unit\" as character") } 
			if( !is.character(d$"variable---methods") ) { stop("The data fame must have a column \"variable---methods\" as character") } 
		}
	}
	
	
	# 3.1. shinemas2R.object == "data-classic-seed-lots" ----------
	if( shinemas2R.object == "data-classic-seed-lots") {
		check.format.all(shinemas2R.object)

		check.d = function(d){
			if( !is.null(d) ) {
				if( !is.data.frame(d) ) { stop("The first element of data must be NULL or a data frame.") }
				
				col_to_have = c("species", "project", "sl", "germplasm", "germplasm_type", "person",  "year", "lat", "long", "alt", "total_generation_nb", "local_generation_nb", "generation_confidence", "sl_comments")
				test = setdiff(col_to_have, colnames(d))
				if( length(test) > 0 ) { stop("The first element of data (i.e. data) must have the following columns: ", paste(col_to_have, collapse = ", ")) }
				
				if( !is.factor(d$species) ) { stop("The data fame must have a column \"species\" as factor") } 
				if( !is.factor(d$project) ) { stop("The data fame must have a column \"project\" as factor") } 
				if( !is.factor(d$sl) ) { stop("The data fame must have a column \"sl\" as factor") } 
				if( !is.factor(d$germplasm) ) { stop("The data fame must have a column \"germplasm\" as factor") } 
				if( !is.factor(d$germplasm_type) ) { stop("The data fame must have a column \"germplasm_type\" as factor") } 
				if( !is.factor(d$person) ) { stop("The data fame must have a column \"person\" as factor") } 
				if( !is.factor(d$year) ) { stop("The data fame must have a column \"year\" as factor") } 
				if( !is.numeric(d$lat) ) { stop("The data fame must have a column \"lat\" as numeric") } 
				if( !is.numeric(d$long) ) { stop("The data fame must have a column \"long\" as numeric") } 
				if( !is.numeric(d$alt) ) { stop("The data fame must have a column \"alt\" as numeric") } 
				if( !is.numeric(d$total_generation_nb) ) { stop("The data fame must have a column \"total_generation_nb\" as numeric") } 
				if( !is.numeric(d$local_generation_nb) ) { stop("The data fame must have a column \"local_generation_nb\" as numeric") } 
				if( !is.numeric(d$generation_confidence) ) { stop("The data fame must have a column \"generation_confidence\" as numeric") } 
				if( !is.factor(d$sl_comments) ) { stop("The data fame must have a column \"sl_comments\" as factor") } 
			}
		}
		
		check.d(data[[1]])
		
		lapply(data[[2]], check.d)
		
		d = data[[3]]
		check.format.method(d)
		
		attributes(data)$shinemas2R.object = "data-classic-seed.lots"
		data = list("data" = data, "info_db" = NULL)
		
	}

	# 3.2. shinemas2R.object == "data-classic-relation" ----------
	if( shinemas2R.object == "data-classic-relation") {

	check.format.all(shinemas2R.object)
	
	check.d = function(d){
			if( !is.null(d) ) {
				if( !is.data.frame(d) ) { stop("The first element of data must be NULL or a data frame.") }
				
				col_to_have = c("son_species", "son_project", "son", "son_ind", "son_year", "son_germplasm", "son_germplasm_type", "son_person", "son_alt", "son_long", "son_lat", "son_total_generation_nb", "son_local_generation_nb", "son_generation_confidence", "son_comments", "father_species", "father_project", "father", "father_year", "father_germplasm", "father_germplasm_type", "father_person", "father_alt", "father_long", "father_lat", "father_total_generation_nb", "father_local_generation_nb", "father_generation_confidence", "father_comments", "reproduction_id", "reproduction_method_name", "selection_id", "selection_person", "mixture_id", "diffusion_id", "relation_year", "X", "Y", "block")
				test = setdiff(col_to_have, colnames(d))
				if( length(test) > 0 ) { stop("The first element of data (i.e. data) must have the following columns: ", paste(col_to_have, collapse = ", ")) }
				
				if( !is.factor(d$son_species) ) { stop("The data fame must have a column \"son_species\" as factor") } 
				if( !is.factor(d$son_project) ) { stop("The data fame must have a column \"son_project\" as factor") } 
				if( !is.factor(d$son) ) { stop("The data fame must have a column \"son\" as factor") } 
				if( !is.factor(d$son_ind) ) { stop("The data fame must have a column \"son_ind\" as factor") } 
				if( !is.factor(d$son_year) ) { stop("The data fame must have a column \"son_year\" as factor") } 
				if( !is.factor(d$son_germplasm) ) { stop("The data fame must have a column \"son_germplasm\" as factor") } 
				if( !is.factor(d$son_germplasm_type) ) { stop("The data fame must have a column \"son_germplasm_type\" as factor") } 
				if( !is.factor(d$son_person) ) { stop("The data fame must have a column \"son_person\" as factor") } 
				if( !is.numeric(d$son_alt) ) { stop("The data fame must have a column \"son_alt\" as numeric") } 
				if( !is.numeric(d$son_long) ) { stop("The data fame must have a column \"son_long\" as numeric") } 
				if( !is.numeric(d$son_lat) ) { stop("The data fame must have a column \"son_lat\" as numeric") } 
				if( !is.numeric(d$son_total_generation_nb) ) { stop("The data fame must have a column \"son_total_generation_nb\" as numeric") } 
				if( !is.numeric(d$son_local_generation_nb) ) { stop("The data fame must have a column \"son_local_generation_nb\" as numeric") } 
				if( !is.numeric(d$son_generation_confidence) ) { stop("The data fame must have a column \"son_generation_confidence\" as numeric") } 
				if( !is.factor(d$son_comments) ) { stop("The data fame must have a column \"son_comments\" as factor") } 
				if( !is.factor(d$father_species) ) { stop("The data fame must have a column \"father_species\" as factor") } 
				if( !is.factor(d$father) ) { stop("The data fame must have a column \"father\" as factor") } 
				if( !is.factor(d$father_project) ) { stop("The data fame must have a column \"father_project\" as factor") } 
				if( !is.factor(d$father_year) ) { stop("The data fame must have a column \"father_year\" as factor") } 
				if( !is.factor(d$father_germplasm) ) { stop("The data fame must have a column \"father_germplasm\" as factor") } 
				if( !is.factor(d$father_germplasm_type) ) { stop("The data fame must have a column \"father_germplasm_type\" as factor") } 
				if( !is.factor(d$father_person) ) { stop("The data fame must have a column \"father_person\" as factor") } 
				if( !is.numeric(d$father_alt) ) { stop("The data fame must have a column \"father_alt\" as numeric") } 
				if( !is.numeric(d$father_long) ) { stop("The data fame must have a column \"father_long\" as numeric") } 
				if( !is.numeric(d$father_lat) ) { stop("The data fame must have a column \"father_lat\" as numeric") } 
				if( !is.numeric(d$father_total_generation_nb) ) { stop("The data fame must have a column \"father_total_generation_nb\" as numeric") } 
				if( !is.numeric(d$father_local_generation_nb) ) { stop("The data fame must have a column \"father_local_generation_nb\" as numeric") } 
				if( !is.numeric(d$father_generation_confidence) ) { stop("The data fame must have a column \"father_generation_confidence\" as numeric") } 
				if( !is.factor(d$father_comments) ) { stop("The data fame must have a column \"father_comments\" as factor") } 
				if( !is.factor(d$reproduction_id) ) { stop("The data fame must have a column \"reproduction_id\" as factor") } 
				if( !is.factor(d$reproduction_method_name) ) { stop("The data fame must have a column \"reproduction_method_name\" as factor") } 
				if( !is.factor(d$selection_id) ) { stop("The data fame must have a column \"selection_id\" as factor") } 
				if( !is.factor(d$selection_person) ) { stop("The data fame must have a column \"selection_person\" as factor") } 
				if( !is.factor(d$mixture_id) ) { stop("The data fame must have a column \"mixture_id\" as factor") } 
				if( !is.factor(d$diffusion_id) ) { stop("The data fame must have a column \"diffusion_id\" as factor") } 
				if( !is.factor(d$relation_year) ) { stop("The data fame must have a column \"relation_year\" as factor") } 
				if( !is.factor(d$X) ) { stop("The data fame must have a column \"X\" as factor") } 
				if( !is.factor(d$Y) ) { stop("The data fame must have a column \"Y\" as factor") } 
				if( !is.factor(d$block) ) { stop("The data fame must have a column \"block\" as factor") } 
			}
		}

	check.d(data[[1]])
		
	lapply(data[[2]], check.d)
		
	d = data[[3]]
	check.format.method(d)
		
	attributes(data)$shinemas2R.object = "data-classic-relation"
	data = list("data" = data, "info_db" = NULL)
	}
	
	
	# 3.3. shinemas2R.object == "data-S-seed-lots" and "data-SR-seed-lots" ----------
	if( shinemas2R.object == "data-S-seed-lots" | shinemas2R.object == "data-SR-seed-lots" ) {
		check.format.all(shinemas2R.object)
		
		check.d = function(d){
			if( !is.null(d) ) {
				if( !is.data.frame(d) ) { stop("The first element of data must be NULL or a data frame.") }
				
				col_to_have = c("expe", "sl_statut", "expe_name", "expe_name_2", "species", "project", "sl", "germplasm", "germplasm_type", "person",  "year", "lat", "long", "alt", "total_generation_nb", "local_generation_nb", "generation_confidence", "sl_comments")
				test = setdiff(col_to_have, colnames(d))
				if( length(test) > 0 ) { stop("The first element of data (i.e. data) must have the following columns: ", paste(col_to_have, collapse = ", ")) }
				
				if( !is.factor(d$expe) ) { stop("The data fame must have a column \"expe\" as factor") } 
				if( !is.factor(d$sl_statut) ) { stop("The data fame must have a column \"sl_statut\" as factor") }
				if( !is.factor(d$expe_name) ) { stop("The data fame must have a column \"expe_name\" as factor") }
				if( !is.factor(d$expe_name_2) ) { stop("The data fame must have a column \"expe_name_2\" as factor") } 
				if( !is.factor(d$species) ) { stop("The data fame must have a column \"species\" as factor") } 
				if( !is.factor(d$project) ) { stop("The data fame must have a column \"project\" as factor") } 
				if( !is.factor(d$sl) ) { stop("The data fame must have a column \"sl\" as factor") } 
				if( !is.factor(d$germplasm) ) { stop("The data fame must have a column \"germplasm\" as factor") } 
				if( !is.factor(d$germplasm_type) ) { stop("The data fame must have a column \"germplasm_type\" as factor") } 
				if( !is.factor(d$person) ) { stop("The data fame must have a column \"person\" as factor") } 
				if( !is.factor(d$year) ) { stop("The data fame must have a column \"year\" as factor") } 
				if( !is.numeric(d$lat) ) { stop("The data fame must have a column \"lat\" as numeric") } 
				if( !is.numeric(d$long) ) { stop("The data fame must have a column \"long\" as numeric") } 
				if( !is.numeric(d$alt) ) { stop("The data fame must have a column \"alt\" as numeric") } 
				if( !is.numeric(d$total_generation_nb) ) { stop("The data fame must have a column \"total_generation_nb\" as numeric") } 
				if( !is.numeric(d$local_generation_nb) ) { stop("The data fame must have a column \"local_generation_nb\" as numeric") } 
				if( !is.numeric(d$generation_confidence) ) { stop("The data fame must have a column \"generation_confidence\" as numeric") } 
				if( !is.factor(d$sl_comments) ) { stop("The data fame must have a column \"sl_comments\" as factor") } 
			}
		}
		
		check.d(data[[1]])
		
		lapply(data[[2]], check.d)
		
		d = data[[3]]
		check.format.method(d)
		
		attributes(data)$shinemas2R.object = "data-classic-seed.lots"
		data = list("data" = data, "info_db" = NULL)
	}
	
	
	# 3.4. shinemas2R.object == "data-S-relation" and "data-SR-relation" ----------
	if( shinemas2R.object == "data-S-relation" | shinemas2R.object == "data-SR-relation" ) { 
		check.format.all(shinemas2R.object)
		
		check.d = function(d){
			if( !is.null(d) ) {
				if( !is.data.frame(d) ) { stop("The first element of data must be NULL or a data frame.") }
				
				col_to_have = c("expe", "sl_statut", "expe_name", "expe_name_2", "son_species", "son_project", "son", "son_ind", "son_year", "son_germplasm", "son_germplasm_type", "son_person", "son_alt", "son_long", "son_lat", "son_total_generation_nb", "son_local_generation_nb", "son_generation_confidence", "son_comments", "father_species", "father_project", "father", "father_year", "father_germplasm", "father_germplasm_type", "father_person", "father_alt", "father_long", "father_lat", "father_total_generation_nb", "father_local_generation_nb", "father_generation_confidence", "father_comments", "reproduction_id", "reproduction_method_name", "selection_id", "selection_person", "mixture_id", "diffusion_id", "relation_year", "X", "Y", "block")
				test = setdiff(col_to_have, colnames(d))
				if( length(test) > 0 ) { stop("The first element of data (i.e. data) must have the following columns: ", paste(col_to_have, collapse = ", ")) }
				
				if( !is.factor(d$expe) ) { stop("The data fame must have a column \"expe\" as factor") } 
				if( !is.factor(d$sl_statut) ) { stop("The data fame must have a column \"sl_statut\" as factor") }
				if( !is.factor(d$expe_name) ) { stop("The data fame must have a column \"expe_name\" as factor") }
				if( !is.factor(d$expe_name_2) ) { stop("The data fame must have a column \"expe_name_2\" as factor") } 
				if( !is.factor(d$son_species) ) { stop("The data fame must have a column \"son_species\" as factor") } 
				if( !is.factor(d$son_project) ) { stop("The data fame must have a column \"son_project\" as factor") } 
				if( !is.factor(d$son) ) { stop("The data fame must have a column \"son\" as factor") } 
				if( !is.factor(d$son_ind) ) { stop("The data fame must have a column \"son_ind\" as factor") } 
				if( !is.factor(d$son_year) ) { stop("The data fame must have a column \"son_year\" as factor") } 
				if( !is.factor(d$son_germplasm) ) { stop("The data fame must have a column \"son_germplasm\" as factor") } 
				if( !is.factor(d$son_germplasm_type) ) { stop("The data fame must have a column \"son_germplasm_type\" as factor") } 
				if( !is.factor(d$son_person) ) { stop("The data fame must have a column \"son_person\" as factor") } 
				if( !is.numeric(d$son_alt) ) { stop("The data fame must have a column \"son_alt\" as numeric") } 
				if( !is.numeric(d$son_long) ) { stop("The data fame must have a column \"son_long\" as numeric") } 
				if( !is.numeric(d$son_lat) ) { stop("The data fame must have a column \"son_lat\" as numeric") } 
				if( !is.numeric(d$son_total_generation_nb) ) { stop("The data fame must have a column \"son_total_generation_nb\" as numeric") } 
				if( !is.numeric(d$son_local_generation_nb) ) { stop("The data fame must have a column \"son_local_generation_nb\" as numeric") } 
				if( !is.numeric(d$son_generation_confidence) ) { stop("The data fame must have a column \"son_generation_confidence\" as numeric") } 
				if( !is.factor(d$son_comments) ) { stop("The data fame must have a column \"son_comments\" as factor") } 
				if( !is.factor(d$father_species) ) { stop("The data fame must have a column \"father_species\" as factor") } 
				if( !is.factor(d$father) ) { stop("The data fame must have a column \"father\" as factor") } 
				if( !is.factor(d$father_year) ) { stop("The data fame must have a column \"father_year\" as factor") } 
				if( !is.factor(d$father_germplasm) ) { stop("The data fame must have a column \"father_germplasm\" as factor") } 
				if( !is.factor(d$father_germplasm_type) ) { stop("The data fame must have a column \"father_germplasm_type\" as factor") } 
				if( !is.factor(d$father_person) ) { stop("The data fame must have a column \"father_person\" as factor") } 
				if( !is.numeric(d$father_alt) ) { stop("The data fame must have a column \"father_alt\" as numeric") } 
				if( !is.numeric(d$father_long) ) { stop("The data fame must have a column \"father_long\" as numeric") } 
				if( !is.numeric(d$father_lat) ) { stop("The data fame must have a column \"father_lat\" as numeric") } 
				if( !is.numeric(d$father_total_generation_nb) ) { stop("The data fame must have a column \"father_total_generation_nb\" as numeric") } 
				if( !is.numeric(d$father_local_generation_nb) ) { stop("The data fame must have a column \"father_local_generation_nb\" as numeric") } 
				if( !is.numeric(d$father_generation_confidence) ) { stop("The data fame must have a column \"father_generation_confidence\" as numeric") } 
				if( !is.factor(d$father_comments) ) { stop("The data fame must have a column \"father_comments\" as factor") } 
				if( !is.factor(d$reproduction_id) ) { stop("The data fame must have a column \"reproduction_id\" as factor") } 
				if( !is.factor(d$reproduction_method_name) ) { stop("The data fame must have a column \"reproduction_method_name\" as factor") } 
				if( !is.factor(d$selection_id) ) { stop("The data fame must have a column \"selection_id\" as factor") } 
				if( !is.factor(d$selection_person) ) { stop("The data fame must have a column \"selection_person\" as factor") } 
				if( !is.factor(d$mixture_id) ) { stop("The data fame must have a column \"mixture_id\" as factor") } 
				if( !is.factor(d$diffusion_id) ) { stop("The data fame must have a column \"diffusion_id\" as factor") } 
				if( !is.factor(d$relation_year) ) { stop("The data fame must have a column \"relation_year\" as factor") } 
				if( !is.factor(d$X) ) { stop("The data fame must have a column \"X\" as factor") } 
				if( !is.factor(d$Y) ) { stop("The data fame must have a column \"Y\" as factor") } 
				if( !is.factor(d$block) ) { stop("The data fame must have a column \"block\" as factor") } 
			}
		}
		
		check.d(data[[1]])
		
		lapply(data[[2]], check.d)
		
		d = data[[3]]
		check.format.method(d)
		
		attributes(data)$shinemas2R.object = "data-S-relation"
		data = list("data" = data, "info_db" = NULL)
		
	}
	

	message("The data has been sucessfully updated with shinemas2R.object = \"", shinemas2R.object, "\".")
	return(data)
	}


