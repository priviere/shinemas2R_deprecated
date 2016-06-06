# 0. help -----------------------------------------------------------------
#' Encrypt data from \code{get.data} or \code{is.get.fata.output}
#'
#' @description
#' \code{encrypt.data} encrypts data from \code{get.data} or \code{is.get.fata.output}
#'
#' @param data output from \code{get.data}
#' 
#' @details
#' The following information is encrypted: 
#' person,
#' year (from 2000),
#' project,
#' selection_person,
#' reproduction_type,
#' germplasm_type,
#' germplasm and 
#' seed-lots
#' 
#' All query.type can be encrypt unless "species", "variable", "reproduction.type" and "methods"
#' 
#' The key is written in .RData format. To use it you should type load("key.RData").
#' 
#' @return The function returns the data frame encrypted and writes in the work directory a file.RData with the key
#' 
#' @examples 
#' # See the vignette
#' 
#' @author Pierre Rivière 
#' 
#' @seealso \code{\link{get.data}}, \code{\link{is.get.data.output}}
#' 
#' 
encrypt.data <- function(
data
)
# lets go !!! ----
{
# 1. Check parameters ----------
	shinemas2R.object = attributes(data$data)$shinemas2R.object
	
	mess = "data must come from shinemas2R::get.data or shinemas2R:is.get.data.output and be"
	if( is.null(shinemas2R.object) ) { stop(mess) }
	if( is.element(shinemas2R.object, c("species", "variable", "reproduction.type", "methods") ) ) { stop(mess) }  
	
# 2. Encrypt data ----------

	message("Prepare key for encryption ...")

	info_db = data$info_db
	
	v = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "person")$data
	vec = paste("person-", c(1:length(v)), sep = ""); names(vec) = v
	vec_person = vec

	v = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "year")$data
	vec = c(2000:(2000+length(v))); names(vec) = v
	vec_year = vec

	v = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "project")$data
	vec = paste("project-", c(1:length(v)), sep = ""); names(vec) = v
	vec_project = vec
	
	v = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "selection.person")$data
	vec = paste("sel.person-", c(1:length(v)), sep = ""); names(vec) = v
	vec_selection_person = vec
	
	v = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "reproduction.type")$data
	vec = paste("repro.type-", c(1:length(v)), sep = ""); names(vec) = v
	vec_repro_type = vec
	
	v = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "germplasm.type")$data
	vec = paste("germplasm.type-", c(1:length(v)), sep = ""); names(vec) = v
	vec_germplasm_type = vec
	
	v = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "germplasm")$data
	vec = paste("germplasm-", c(1:length(v)), sep = ""); names(vec) = v
	vec_germplasm = vec
	
	encrypt_sl = function(sl, vec_germplasm, vec_person, vec_year){
		a = unlist(strsplit(as.character(sl), "_"))
		gs = as.character(a[1])
		gs = unlist(strsplit(as.character(gs), "#"))
		g = vec_germplasm[as.character(gs[1])]
		if( is.na(gs[2]) ) { s = NULL } else { s = paste("#", gs[2], sep = "") }
		p = vec_person[as.character(a[2])]
		y = vec_year[as.character(a[3])]
		d = a[4]
		sl = paste(g, s, "_", p, "_", y, "_", d, sep = "")
		return(sl)
	}
	
	message("Encrypt data ...")

	if( shinemas2R.object == "network"){

		d = data$data$network
		y = get.vertex.attribute(d, "year")
		set.vertex.attribute(d, "year", value = vec_year[as.character(y)])
		p = get.vertex.attribute(d, "person")
		set.vertex.attribute(d, "person", value = vec_person[as.character(p)])
		g = get.vertex.attribute(d, "germplasm")
		set.vertex.attribute(d, "germplasm", value = vec_germplasm[as.character(g)])
		gt = get.vertex.attribute(d, "germplasm_type")
		set.vertex.attribute(d, "germplasm_type", value = vec_germplasm_type[as.character(gt)])
		sl = network.vertex.names(d)
		network.vertex.names(d) = sapply(sl, encrypt_sl, vec_germplasm, vec_person, vec_year)
		data$data$network = d
		
		d = data$data$network.info
		d$germplasm = factor(vec_germplasm[as.character(d$germplasm)])
		d$person = factor(vec_person[as.character(d$person)])
		d$year = factor(vec_year[as.character(d$year)])
		d$sl = sapply(d$sl, encrypt_sl, vec_germplasm, vec_person, vec_year)
		data$data$network.info = d
		
		d = data$data$Mdist
		if( !is.null(d)){
			colnames(d) = sapply(colnames(d), encrypt_sl, vec_germplasm, vec_person, vec_year)
			rownames(d) = sapply(rownames(d), encrypt_sl, vec_germplasm, vec_person, vec_year)
			data$data$Mdist = d
		}
		
		}
	
	
	if( shinemas2R.object == "SL.mix"){
		data$data$son = sapply(data$data$son, encrypt_sl, vec_germplasm, vec_person, vec_year)
		data$data$son_germplasm = factor(vec_germplasm[as.character(data$data$son_germplasm)])
		data$data$son_germplasm_type = factor(vec_germplasm_type[as.character(data$data$son_germplasm_type)])
		data$data$son_year = factor(vec_year[as.character(data$data$son_year)])
		data$data$son_person = factor(vec_person[as.character(data$data$son_person)])
		data$data$son_project = factor(vec_project[as.character(data$data$son_project)])
		
		data$data$father = sapply(data$data$father, encrypt_sl, vec_germplasm, vec_person, vec_year)
		data$data$father_germplasm = factor(vec_germplasm[as.character(data$data$father_germplasm)])
		data$data$father_germplasm_type = factor(vec_germplasm_type[as.character(data$data$father_germplasm_type)])
		data$data$father_year = factor(vec_year[as.character(data$data$father_year)])
		data$data$father_person = factor(vec_person[as.character(data$data$father_person)])
		data$data$father_project = factor(vec_project[as.character(data$data$father_project)])
		}
	
		
	if( shinemas2R.object == "cross"){
		data$data$sl = sapply(data$data$sl, encrypt_sl, vec_germplasm, vec_person, vec_year)
		data$data$germplasm = factor(vec_germplasm[as.character(data$data$germplasm)])
		data$data$germplasm_type = factor(vec_germplasm_type[as.character(data$data$germplasm_type)])
		data$data$year = factor(vec_year[as.character(data$data$year)])
		data$data$year_cross = factor(vec_year[as.character(data$data$year_cross)])
		data$data$person = factor(vec_person[as.character(data$data$person)])
		data$data$project = factor(vec_project[as.character(data$data$project)])
		}

		
	if( shinemas2R.object == "person"){ }
	
	
	if( shinemas2R.object == "year"){ }
	
	
	if( shinemas2R.object == "project"){ }
	
	
	if( shinemas2R.object == "seed.lot"){ }
	
	
	if( shinemas2R.object == "selection.person"){ }
	
	
	if( shinemas2R.object == "germplasm"){ }
	
	
	if( shinemas2R.object == "data-classic-seed-lots" | 
			shinemas2R.object == "data-S-seed-lots" |
			shinemas2R.object == "data-SR-seed-lots"
			){
		
		toto = function(d, vec_germplasm, vec_person, vec_year){
			d$sl = sapply(d$sl, encrypt_sl, vec_germplasm, vec_person, vec_year)
			d$germplasm = factor(vec_germplasm[as.character(d$germplasm)])
			d$germplasm_type = factor(vec_germplasm_type[as.character(d$germplasm_type)])
			d$year = factor(vec_year[as.character(d$year)])
			d$person = factor(vec_person[as.character(d$person)])
			d$project = factor(vec_project[as.character(d$project)])
			return(d)
		}
		data$data$data = toto(data$data$data, vec_germplasm, vec_person, vec_year)
		for(i in 1:length(data$data$data.with.correlated.variables)) {
			data$data$data.with.correlated.variables[[i]] = toto(data$data$data.with.correlated.variables[[i]], vec_germplasm, vec_person, vec_year)
		}
	}
	
	
	if( shinemas2R.object == "data-classic-relation" |
			shinemas2R.object == "data-SR-relation" |
			shinemas2R.object == "data-S-relation"
			){
		
		toto = function(d, vec_germplasm, vec_person, vec_year){
			d$son = sapply(d$son, encrypt_sl, vec_germplasm, vec_person, vec_year)
			d$son_germplasm = factor(vec_germplasm[as.character(d$son_germplasm)])
			d$son_germplasm_type = factor(vec_germplasm_type[as.character(d$son_germplasm_type)])
			d$son_year = factor(vec_year[as.character(d$son_year)])
			d$son_person = factor(vec_person[as.character(d$son_person)])
			d$son_project = factor(vec_project[as.character(d$son_project)])
			
			d$father = sapply(d$father, encrypt_sl, vec_germplasm, vec_person, vec_year)
			d$father_germplasm = factor(vec_germplasm[as.character(d$father_germplasm)])
			d$father_germplasm_type = factor(vec_germplasm_type[as.character(d$father_germplasm_type)])
			d$father_year = factor(vec_year[as.character(d$father_year)])
			d$father_person = factor(vec_person[as.character(d$father_person)])
			d$father_project = factor(vec_project[as.character(d$father_project)])
			
			d$selection_person = factor(vec_selection_person[as.character(d$selection_person)])
			return(d)
		}
		data$data$data = toto(data$data$data, vec_germplasm, vec_person, vec_year)
		for(i in 1:length(data$data$data.with.correlated.variables)) {
			data$data$data.with.correlated.variables[[i]] = toto(data$data$data.with.correlated.variables[[i]], vec_germplasm, vec_person, vec_year)
		}
	}
	
	
	if( shinemas2R.object == "person.info"){ }
	
	
	if( shinemas2R.object == "grandfather"){ }
	
	
	key = list(
		"vec_person" = vec_person,
		"vec_year" = vec_year,
		"vec_project" = vec_project,
		"vec_selection_person" = vec_selection_person,
		"vec_repro_type" = vec_repro_type,
		"vec_germplasm_type" = vec_germplasm_type,
		"vec_germplasm" = vec_germplasm)
	
	file = paste("key_", shinemas2R.object, "_", date(), ".RData", sep = "")
	save(key, file = file)
	message("The key has been written in ", getwd(), "/", file, sep = "")

# 3. Return results ----------

return(data)
}
