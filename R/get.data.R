# 0. help -----------------------------------------------------------------
#' Query SHiNeMaS and return the datasets
#'
#' @description
#' \code{get.data} queries SHiNeMaS and returns the data-sets.
#'
#' @param db_user user name of SHiNeMaS
#' 
#' @param db_host IP address of the computer where SHiNeMaS is. If local host db_host = "127.0.0.1"
#' 
#' @param db_name name of the data base
#' 
#' @param db_password your password to login. If no password is needed, put ""
#'
#' @param query.type Type of query, which will create a data set. There are eight types:
#' 
#' \enumerate{
#' 
#' \item "network": network relations between seed-lots. All filters are possible.
#' 
#' \item "SL.mix": seed-lots merged from replications and not from 'real' mixtures. All filters are possible except relation.in and variable.in.
#' 
#' \item "cross": seed-lots used to give a cross: father, grandfather, mother, grandmother and cross. All filters are possible except variable.in, relation.in, seed.lots.in, seed.lots.out and reproduction.type.in.
#' 
#' \item raw information on levels and variables contained in SHiNeMaS :
#' \itemize{
#' \item "species"
#' \item "variable"
#' \item "person"
#' \item "year"
#' \item "project"
#' \item "seed.lot"
#' \item "selection.person": persons that performed intra-varietal mass selection
#' \item "reproduction.type"
#' \item "germplasm.type"
#' \item "germplasm"
#' }
#' 
#' \item data with variable on specific seed-lots :
#' \itemize{
#' \item "data-classic": default dataframe.
#' \item "data-S": selection differential for a given year.
#' \item "data-SR": seed-lots pairs of selection differential for year n-1 and response to selection for year n.
#' }
#' 
#' \item "methods": information related to the methods used for each variable in SHiNeMaS with its description and units
#' Filters can be applied on variables. Possible filter is variable.in.
#' 
#' \item "person.info": information regarding persons stored in SHiNeMaS. 
#' Possible filters are person.in and person.out.
#' 
#' \item "grandfather": information on son, father and grandfather. 
#' All filters are possible except relation.in and variable.in.
#' 
#' }
#' 
#' @param filter.on This argument is needed if you want to use filters. It chooses on which seed-lots the filters are applied: "son", "father" or "father-son". Filter.on is not used for data.type = "seed-lots", query.type = "methods" and query.type = "person.info"
#' 
#' @param germplasm.in Filter: vector with germplasms to keep. By default, all the germplasms are in.
#' @param germplasm.out Filter: vector with germplasms to discard. By default, no germplasm is out.
#' 
#' @param germplasm.type.in Filter: vector with germplasms to keep. By default, all the germplasm types are in.
#' @param germplasm.type.out Filter: vector with germplasms to discard. By default, no germplasm type is out.
#' 
#' @param year.in Filter: vector with years to keep. By default, all the years are in.
#' @param year.out Filter: vector with years to discard. By default, no year is out.
#' 
#' @param project.in Filter: vector of projects to keep. By default, all the projects are in.
#' @param project.out Filter: vector of projects to discard. By default, no project is out.
#' 
#' @param person.in Filter: vector of persons to keep. By default, all the persons are in.
#' @param person.out Filter: vector of persons to discard.  By default, no person is out.
#' 
#' @param seed.lot.in Filter: vector of seed-lots to keep. By default, all the seed-lots are in.
#' @param seed.lot.out Filter: vector of seed-lots to discard. By default, no seed-lot is out.
#' 
#' @param relation.in Filter on a relation to keep: "reproduction", "mixture", "selection" or "diffusion". By default, all relations are in.
#' 
#' @param reproduction.type.in Filter on reproduction types
#' 
#' @param variable.in Filter: vector with variables to keep. If NULL, all variables in SHiNeMaS are displayed.
#' 
#' @param data.type For queries in "data-". Type of data: "relation" for data linked to relation between seed lots and "seed-lots" for data linked to seed lots
#' 
#' @param network.info For query.type = "network". If TRUE, aggregates information on relations and seed-lots on the network and return it in the results.
#' 
#' @param Mdist For query.type = "network". If TRUE, computes the Mdist matrix and return it in the results. See details.
#' 
#' @param fill.diffusion.gap For query.type = "network", create a network with no gaps between seed-lots (as long as there is information!)
#' 
#' @details
#' \itemize{
#' 
#' \item Queries "cross"
#' 
#' The data frame returned has a column "expe" which corresponds to an id of the set of seed-lots used in the cross
#' 
#' 
#' \item Queries "S"
#' 
#' The data frame returned has a column "expe" which corresponds to an id of one selection differential 
#' 
#' \item Queries "SR"
#' 
#' The data frame returned has a column "expe" which corresponds to an id of one selection differential and the corresponding response to selection
#' 
#' The query "data-SR" takes into account when selection has been done to get a seed lot, that this seed lot has been merged and then has been sown. It is the case when selection has been carried out in a replication that has been merged afterwards. Even if this case should not arrise, it might happen.
#' 
#' 
#' \item Query "network"
#' 
#' The Mdist square matrix can be compared to a differentiation distance. It can be put in relation with genetic Fst for example.
#' 
#' \item Correlated data or not
#' 
#' Note that for data linked to seed-lots, all the data are correlated as there is one measure for a given seed-lot. 
#' Therefore the element of the list for non correlated data is always NULL.
#' 
#' For data linked to relations, as it can be linked to individual within a seed-lot, data may be correlated (data taken on the same individual) or not.
#' }
#' 
#' 
#' @return The function returns a list with 
#' 
#' \itemize{
#' \item data according to the query type.
#' \enumerate{
#' 
#' \item For network it returns a list with
#' \itemize{
#' \item the network object
#' \item the network.info matrix with information on relations in the network
#' \item the Mdist square matrix with the number of reproductions that separate two seed-lots since their last common diffusion.
#' }
#' 
#' \item For SL.mix, it returns a data frame with seed-lots son (i.e. coming from the mixture), seed-lots father, germplasm, person, year and project
#' 
#' \item For raw information on levels and variables present in SHiNeMaS it returns a vector
#' 
#' \item For data with variables on specific seed-lots it returns a list with
#' \itemize{
#' 		\item a data frame with the data set 
#' 		\item a list with data set with individuals that are correlated for a set of variables
#' 		\item the description of methods used for each variable with its description and units
#' 		}
#' }
#' 
#' \item information to connect to SHiNeMaS
#' }
#' 
#' @examples
#' # See the vignette
#' 
#' @author Pierre Riviere for R code and Yannick de Oliveira for SQL code 
#' 
#' @seealso \code{\link{encrypt.data}}, \code{\link{translate.data}},, \code{\link{format.data}}, \code{\link{get.ggplot}}, \code{\link{get.table}}
#' 
#' 
get.data <- function(
db_user = "pierre",
db_host = "127.0.0.1",
db_name = "shinemas_tuto",
db_password = "pierre",
query.type = "person",
filter.on = NULL,
germplasm.in = NULL,
germplasm.out = NULL,
germplasm.type.in = NULL,
germplasm.type.out = NULL,
year.in = NULL,
year.out = NULL,
project.in = NULL,
project.out = NULL,
person.in = NULL,
person.out = NULL,
seed.lot.in = NULL,
seed.lot.out = NULL,
relation.in = NULL,
reproduction.type.in = NULL,
variable.in = NULL,
data.type = NULL,
network.info = TRUE,
Mdist = FALSE,
fill.diffusion.gap = FALSE
)

# lets go !!! ----
{
# 1. Check parameters ----------

# 1.1. Possibles values of arguments ----------
if(!is.element(query.type, c("network", "data-classic", "data-S", "data-SR", "SL.mix", "cross", "variable", "person", "year", "project", "seed.lots", "selection.person", "reproduction.type", "germplasm.type", "germplasm", "methods", "person.info", "grandfather")))  { 	stop("query.type must be \"network\", \"data-classic\", \"data-S\", \"data-SR\", \"SL.mix\", \"cross\", \"variable\", \"person\", \"year\", \"project\", \"seed.lots\", \"selection.person\", \"reproduction.type\", \"germplasm.type\", \"germplasm\", \"methods\", \"person.info\" or \"grandfather\".") }

test = c(germplasm.in, germplasm.out, germplasm.type.in, germplasm.type.out, year.in, year.out, project.in, project.out, person.in, person.out, seed.lot.in, seed.lot.out, relation.in, reproduction.type.in, variable.in)
if(is.element(query.type, c( "variable", "person", "year", "project", "seed.lots", "selection.person", "reproduction.type", "germplasm.type", "germplasm")) & !is.null(test)) { stop("You can not use a filter on raw information on levels and variables.") }

if(!is.null(relation.in)){
	if( !is.element(relation.in, c("reproduction", "mixture", "selection", "diffusion")) )  { stop("relation.in must be \"reproduction\", \"mixture\", \"selection\" or \"diffusion\".") }
}

# 1.2. Possible filters regarding query.types or data.type ----------
if( query.type == "SL.mix" & (!is.null(relation.in) | !is.null(variable.in)) ) { warning("With query.type == \"SL.mix\", filter relation.in is not used.") }

if( query.type == "cross" & (!is.null(relation.in) | !is.null(variable.in)) ) { warning("With query.type == \"cross\", filter relation.in and variable.in are not used.") }

if( query.type == "methods" & (
	!is.null(germplasm.in) | 
	!is.null(germplasm.out) | 
	!is.null(germplasm.type.in) | 
	!is.null(germplasm.type.out) | 
	!is.null(year.in) | 
	!is.null(year.out) | 
	!is.null(project.in) | 
	!is.null(project.out) | 
	!is.null(person.in) | 
	!is.null(person.out) | 
	!is.null(seed.lot.in) | 
	!is.null(seed.lot.out) | 
	!is.null(relation.in) | 
	!is.null(reproduction.type.in)
) ) { warning("With query.type == \"methods\", filters germplasm.in, germplasm.out, germplasm.type.in, germplasm.type.out, year.in, year.out, project.in, project.out, person.in, person.out, seed.lot.in, seed.lot.out, relation.in and reproduction.type.in are not used.") }


if( query.type == "person.info" & (
	!is.null(germplasm.in) | 
	!is.null(germplasm.out) | 
	!is.null(germplasm.type.in) | 
	!is.null(germplasm.type.out) | 
	!is.null(year.in) | 
	!is.null(year.out) | 
	!is.null(project.in) | 
	!is.null(project.out) | 
	!is.null(seed.lot.in) | 
	!is.null(seed.lot.out) | 
	!is.null(relation.in) | 
	!is.null(reproduction.type.in) |
	!is.null(variable.in)
) ) { warning("With query.type == \"person.info\", filters germplasm.in, germplasm.out, germplasm.type.in, germplasm.type.out, year.in, year.out, project.in, project.out, seed.lot.in, seed.lot.out, relation.in, reproduction.type.in and variable.in are not used.") }

if( query.type == "grandfather" & (!is.null(relation.in) | !is.null(variable.in)) ) { warning("With query.type == \"grandfather\", filter relation.in and variable.in is not used.") }


if( !is.null(data.type) ) {
	if( data.type == "seed-lots" & !is.null(relation.in)) { warning("With data.type == \"seed-lots\", filter relation.in is not used.") }
}


# 1.3. Possible values of data.type ----------
if( is.null(data.type) & length(grep("data-", query.type)) > 0 ) { stop("With query.type in \"data-\", data.type must not be NULL. data.type can be \"relation\" or \"seed-lots\".")
	}


if(!is.null(data.type)){

if(!is.element(data.type, c("relation", "seed-lots"))) { 	stop("data.type must be \"relation\" or \"seed-lots\"") }	

# 1.4. Possible values of filter.on regarding query.types ----------

if( data.type == "seed-lots" ) { filter.on = "son" ; message("With data.type == \"seed-lots\", \"filter.on\" is not used.") } # To be ok with filters
}

if( query.type == "person.info" | query.type == "methods" ) { filter.on = "son" ; message("With query.type == \"", query.type, "\", \"filter.on\" is not used.") } # To be ok with filters

if(!is.null(filter.on)){
if(!is.element(filter.on, c("son", "father", "father-son")))  { stop("filter.on must be \"son\", \"father\" or \"father-son\".") }
}

# 1.5. Do not forget to set filter.on if there are filters ----------

test = c(germplasm.in,
				 germplasm.out,
				 germplasm.type.in,
				 germplasm.type.out,
				 year.in,
				 year.out,
				 project.in,
				 project.out,
				 person.in,
				 person.out,
				 seed.lot.in,
				 seed.lot.out,
				 relation.in,
				 reproduction.type.in,
				 variable.in)

if( !is.null(test[1]) & is.null(filter.on)) { stop("You must set filter.on: \"son\", \"father\" or \"father-son\".") }


# 2. Connection to SHiNeMaS ----------
info_db = list("db_user" = db_user, "db_host" = db_host, "db_name" = db_name, "db_password" = db_password)
# function to get data from a query
get.d = function(requete, info_db) {
	
	# call driver which handle the connexion
	drv = dbDriver("PostgreSQL") 
	
	# get the connexion
	con = dbConnect(drv, user = info_db$db_user, host = info_db$db_host, dbname = info_db$db_name, password = info_db$db_password) 	
	
	# clean the query when there are filters
	requete = sub("WHERE AND", "WHERE", requete)
	rs = dbSendQuery(con, requete)
	d = fetch(rs,n=-1) # n=-1 : get everything
	d = as.data.frame(d)
	
	dbDisconnect(con)
	return(d)
	}


# 3. Queries ----------

query.species = function(info_db){
	d = get.d("SELECT DISTINCT species FROM entities_species", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}


query.variable = function(info_db){
	d = get.d("SELECT DISTINCT name FROM eppdata_variable", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}

query.person = function(info_db){
	d = get.d("SELECT short_name FROM actors_person", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}

query.year = function(info_db){
	d = get.d("SELECT DISTINCT(date) FROM entities_seed_lot ORDER BY date", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}


query.project = function(info_db){
	d = get.d("SELECT project_name FROM actors_project", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)	
}


query.seed.lots = function(info_db){
	d = get.d("SELECT name FROM entities_seed_lot", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)		
}

query.selection.person = function(info_db){
	d = get.d("SELECT DISTINCT(short_name) FROM network_selection sel LEFT OUTER JOIN actors_person p ON sel.person_id = p.id", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}

query.reproduction.type = function(info_db){
	d = get.d("SELECT reproduction_methode_name FROM network_reproduction_method", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}

query.germplasm = function(info_db){
	d = get.d("SELECT gp.germplasm_name FROM entities_germplasm gp", info_db)	
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}


query.germplasm.type = function(info_db){
	d = get.d("SELECT germplasm_type FROM entities_germplasm_type", info_db)	
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}


query.network = function( P = NULL, G = NULL, GT = NULL, Y = NULL, R = NULL, SL = NULL, Proj = NULL, info_db) {
	f = c( P, G, GT, Y, R, SL, Proj)
	if( !is.null (f[1]) ) { 
		f = f[!is.null(f)]
		f = paste(f, collapse = " AND ")
		filters = paste(" WHERE ", f, sep = "") 
	} else { filters = NULL }
	
if( !is.null(R[1]) ) { if(length(grep("nr.reproduction_id", R[1])) == 1) { filters = paste(filters, " AND nr.selection_id IS NULL ", sep = "") } }

query = 
paste("
SELECT 

sp1.species AS son_species, sl1.name AS son, gp1.germplasm_name AS son_germplasm, p1.short_name AS son_person, sl1.date AS son_year, gpt1.germplasm_type AS son_germplasm_type, 
l1.altitude AS son_alt, l1.longitude AS son_long, l1.latitude AS son_lat, ",
# waiting for generation and sl comments to be implemented in SHiNeMaS
#sl1.generation AS son_total_generation_nb, sl1.lgeneration AS son_local_generation_nb, sl1.confidence AS son_generation_confidence, sl1.comments AS son_comments, 
"", "
string_agg(DISTINCT pro1.project_name,',') AS son_project,
			
sp2.species AS father_species, sl2.name AS father, gp2.germplasm_name AS father_germplasm, p2.short_name AS father_person, sl2.date AS father_year, gpt2.germplasm_type AS father_germplasm_type,
l2.altitude AS father_alt, l2.longitude AS father_long, l2.latitude AS father_lat,  ",
# waiting for generation and sl comments to be implemented in SHiNeMaS
#sl2.generation AS father_total_generation_nb, sl2.lgeneration AS father_local_generation_nb, sl2.confidence AS father_generation_confidence, sl2.comments AS father_comments,
"", "
string_agg(DISTINCT pro2.project_name,',') AS father_project,
			
nr.reproduction_id AS reproduction_id, nrm.reproduction_methode_name AS reproduction_method_name, nr.is_male, nr.block,
nr.selection_id AS selection_id, psel.short_name AS selection_person, 
nr.mixture_id AS mixture_id, nr.diffusion_id AS diffusion_id,
rep.date AS relation_year
			
FROM network_relation nr
LEFT OUTER JOIN network_selection sel ON nr.selection_id = sel.id 
LEFT OUTER JOIN actors_person psel ON sel.person_id = psel.id 
LEFT OUTER JOIN network_reproduction rep ON nr.reproduction_id = rep.id 
LEFT OUTER JOIN network_reproduction_method nrm ON rep.reproduction_method_id = nrm.id
LEFT OUTER JOIN entities_seed_lot sl1 ON nr.seed_lot_son_id = sl1.id 
LEFT OUTER JOIN entities_seed_lot sl2 ON nr.seed_lot_father_id = sl2.id
LEFT OUTER JOIN entities_germplasm gp1 ON sl1.germplasm_id = gp1.id
LEFT OUTER JOIN entities_germplasm gp2 ON sl2.germplasm_id = gp2.id
LEFT OUTER JOIN entities_species sp1 ON gp1.species_id = sp1.id
LEFT OUTER JOIN entities_species sp2 ON gp2.species_id = sp2.id
LEFT OUTER JOIN entities_germplasm_type gpt1 ON gp1.germplasm_type_id = gpt1.id
LEFT OUTER JOIN entities_germplasm_type gpt2 ON gp2.germplasm_type_id = gpt2.id
LEFT OUTER JOIN actors_person p1 ON sl1.person_id = p1.id
LEFT OUTER JOIN actors_person p2 ON sl2.person_id = p2.id
LEFT OUTER JOIN actors_location l1 ON p1.location_id = l1.id
LEFT OUTER JOIN actors_location l2 ON p2.location_id = l2.id
			
LEFT OUTER JOIN network_relation_project rp1 ON rp1.relation_id = nr.id
LEFT OUTER JOIN actors_project pro1 ON pro1.id = rp1.project_id
LEFT OUTER JOIN network_relation_project rp2 ON rp2.relation_id = nr.id
LEFT OUTER JOIN actors_project pro2 ON pro2.id = rp2.project_id",
	
filters,

"
GROUP BY sp1.species, sl1.name, gp1.germplasm_name, p1.short_name, sl1.date, gpt1.germplasm_type, l1.altitude, l1.longitude, l1.latitude, sp2.species, sl2.name, gp2.germplasm_name, p2.short_name, sl2.date, gpt2.germplasm_type, l2.altitude, l2.longitude, l2.latitude, nr.reproduction_id, nrm.reproduction_methode_name, nr.is_male, nr.block, nr.selection_id, psel.short_name, nr.mixture_id, nr.diffusion_id, rep.date
",
sep = "")

d = get.d(query, info_db)

if(nrow(d) > 0) {
	son_species = as.factor(d$son_species)
	son_project = as.factor(d$son_project)
	son = as.factor(d$son)
	son_germplasm = as.factor(d$son_germplasm)
	son_person = as.factor(d$son_person)
	son_year = as.factor(d$son_year)
	son_germplasm_type = as.factor(d$son_germplasm_type)
	son_alt = as.numeric(as.character(d$son_alt))
	son_long = as.numeric(as.character(d$son_long))
	son_lat = as.numeric(as.character(d$son_lat))
	son_total_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$son_total_generation_nb))
	son_local_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$son_local_generation_nb))
	son_generation_confidence = sample( c(0,1), nrow(d), replace = TRUE) # as.character(d$son_generation_confidence)
	son_comments = rep("blablabla", nrow(d)) # as.character(d$son_comments)
	
	father_species = as.factor(d$father_species)
	father_project = as.factor(d$father_project)
	father = as.factor(d$father)
	father_germplasm = as.factor(d$father_germplasm)
	father_person = as.factor(d$father_person)
	father_year = as.factor(d$father_year)
	father_germplasm_type = as.factor(d$father_germplasm_type)
	father_alt = as.numeric(as.character(d$father_alt))
	father_long = as.numeric(as.character(d$father_long))
	father_lat = as.numeric(as.character(d$father_lat))
	father_total_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$father_total_generation_nb))
	father_local_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$father_local_generation_nb))
	father_generation_confidence = sample( c(0,1), nrow(d), replace = TRUE) # as.character(d$father_generation_confidence)
	father_comments = rep("blablabla", nrow(d)) # as.character(d$father_comments)
	
	reproduction_id = as.character(d$reproduction_id)
	reproduction_method_name = as.factor(d$reproduction_method_name)
	is_male = as.factor(d$is_male)
	block = as.factor(d$block)
	
	selection_id = as.character(d$selection_id)
	selection_person = as.factor(d$selection_person)
	mixture_id = as.character(d$mixture_id)
	diffusion_id = as.character(d$diffusion_id)
	relation_year = as.factor(d$relation_year)
	
	
	d = data.frame(
		son_species,
		son_project,
		son,
		son_germplasm,
		son_person,
		son_year,
		son_germplasm_type,
		son_alt,
		son_long,
		son_lat,
		son_total_generation_nb,
		son_local_generation_nb,
		son_generation_confidence,
		son_comments,
		
		father_species,
		father_project,
		father,
		father_germplasm,
		father_person,
		father_year,
		father_germplasm_type,
		father_alt,
		father_long,
		father_lat,
		father_total_generation_nb,
		father_local_generation_nb,
		father_generation_confidence,
		father_comments,
		
		reproduction_id,
		reproduction_method_name,
		is_male,
		block,
		
		selection_id,
		selection_person,
		mixture_id,
		diffusion_id,
		relation_year
	)
	
	} else { d = NULL }

return(d)
}


query.data.seed_lots = function(G = NULL, GT = NULL, Y = NULL, P = NULL, V = NULL, SL = NULL, Proj = NULL, info_db) {

	f = c(G, GT, Y, P, V, SL, Proj)
	if( !is.null (f[1]) ) { 
		f = f[!is.null(f)]
		f = paste(f, collapse = " AND ")
		filters = paste(" WHERE ", f, sep = "") 
	} else { filters = NULL }
	
query = 
paste("
SELECT sl1.name AS sl, sl1.date AS year, gp1.germplasm_name AS germplasm, gpt1.germplasm_type AS germplasm_type, sp1.species, p1.short_name AS person, v1.name AS variable_name,rd.raw_data, rd.date AS raw_data_date, met.method_name, l1.latitude AS lat, l1.longitude AS long, l1.altitude AS alt, string_agg(DISTINCT pro1.project_name,',')|| ', ' || string_agg(DISTINCT pro2.project_name,',') AS project
 ",
# waiting for generation and sl comments to be implemented in SHiNeMaS
#, sl1.generation AS total_generation_nb, sl1.lgeneration AS local_generation_nb, sl1.confidence AS generation_confidence, sl1.comments AS sl_comments 
"","

FROM entities_seed_lot sl1 
LEFT OUTER JOIN eppdata_raw_data_seed_lot dr ON sl1.id = dr.seed_lot_id 
LEFT OUTER JOIN eppdata_raw_data rd ON dr.raw_data_id = rd.id 
LEFT OUTER JOIN eppdata_method met ON rd.method_id=met.id
LEFT OUTER JOIN eppdata_variable v1 ON rd.variable_id = v1.id
LEFT OUTER JOIN entities_germplasm gp1 ON sl1.germplasm_id = gp1.id
LEFT OUTER JOIN entities_germplasm_type gpt1 ON gp1.germplasm_type_id = gpt1.id
LEFT OUTER JOIN entities_species sp1 ON sp1.id = gp1.species_id
LEFT OUTER JOIN actors_person p1 ON sl1.person_id=p1.id
LEFT OUTER JOIN actors_location l1 ON l1.id = p1.location_id
			
LEFT OUTER JOIN network_relation r1 ON r1.seed_lot_father_id=sl1.id
LEFT OUTER JOIN network_relation_project rp1 ON rp1.relation_id = r1.id
LEFT OUTER JOIN actors_project pro1 ON pro1.id = rp1.project_id
LEFT OUTER JOIN network_relation r2 ON r2.seed_lot_son_id=sl1.id
LEFT OUTER JOIN network_relation_project rp2 ON rp2.relation_id = r2.id
LEFT OUTER JOIN actors_project pro2 ON pro2.id = rp2.project_id

",

filters,

"
GROUP BY sl1.name, sl1.date, gp1.germplasm_name, gpt1.germplasm_type, sp1.species, p1.short_name, v1.name, rd.raw_data, rd.date, met.method_name, l1.latitude, l1.longitude, l1.altitude
",
sep = "")

d = get.d(query, info_db)

if(nrow(d) > 0) {
		species = as.factor(d$species)
		project = as.factor(d$project)
		sl = as.factor(d$sl)
		germplasm = as.factor(d$germplasm)
		germplasm_type = as.factor(d$germplasm_type)
		person = as.factor(d$person)
		year = as.factor(d$year)
		variable_name = as.character(d$variable_name)
		raw_data = as.character(d$raw_data)
		raw_data_date = as.character(d$raw_data_date)
		method_name = as.factor(d$method_name)
		lat = as.numeric(as.character(d$lat))
		long = as.numeric(as.character(d$long))
		alt = as.numeric(as.character(d$alt))
		total_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$total_generation_nb))
		local_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$local_generation_nb))
		generation_confidence = sample( c(1:0), nrow(d), replace = TRUE) # as.character(d$generation_confidence)
		sl_comments = rep("blablabla", nrow(d)) # as.character(d$sl_comments)

	d = data.frame(
		species,
		project,
		sl,
		germplasm,
		germplasm_type,
		person,
		year,
		variable_name,
		raw_data,
		raw_data_date,
		method_name,
		lat,
		long, 
		alt,
		total_generation_nb,
		local_generation_nb,
		generation_confidence,
		sl_comments
	)
	
		} else { d = NULL }

return(d)
}


query.data.relation = function(G = NULL, GT = NULL, Y = NULL, P = NULL, R = NULL, V = NULL, SL = NULL, Proj = NULL, info_db) {
	f = c(G, GT, Y, P, R, V, SL, Proj)
	if( !is.null (f[1]) ) { 
		f = f[!is.null(f)]
		f = paste(f, collapse = " AND ")
		filters = paste(" WHERE ", f, sep = "") 
	} else { filters = NULL }

	if( !is.null(R[1]) ) { if(length(grep("nr.reproduction_id", R[1]))) { filters = paste(filters, " AND nr.selection_id IS NULL ", sep = "")} }

query = paste("	
SELECT 
sl1.name AS son, rd1.individual AS son_ind, sl1.date AS son_year, gp1.germplasm_name AS son_germplasm, sp1.species AS son_species, gpt1.germplasm_type AS son_germplasm_type, p1.short_name AS son_person, l1.altitude AS son_alt, l1.longitude AS son_long, l1.latitude AS son_lat, ",
# waiting for generation and sl comments to be implemented in SHiNeMaS
# sl1.generation AS son_total__generation_nb, sl1.lgeneration AS son_local_generation_nb, sl1.generation_confidence AS son_confidence, sl1.generation_comments AS son_comments,
"","
string_agg(DISTINCT pro1.project_name,',') AS son_project,

sl2.name AS father, sl2.date AS father_year, gp2.germplasm_name AS father_germplasm, sp2.species AS father_species, gpt2.germplasm_type AS father_germplasm_type, p2.short_name AS father_person, l2.altitude AS father_alt, l2.longitude AS father_long, l2.latitude AS father_lat, ",
# waiting for generation and sl comments to be implemented in SHiNeMaS
# sl2.generation AS father_total_generation_nb, sl2.lgeneration AS father_local_generation_nb, sl2.confidence AS father_generation_confidence, sl2.comments AS father_comments,
"","
string_agg(DISTINCT pro2.project_name,',') AS father_project,
							
v1.name AS variable_name, rd1.raw_data, rd1.group AS correlation_group, rd1.date AS raw_data_date, met1.method_name, rep1.date AS relation_year,
nr.reproduction_id AS reproduction_id, nrm1.reproduction_methode_name AS reproduction_method_name, nr.selection_id AS selection_id, psel1.short_name AS selection_person, nr.mixture_id AS mixture_id, nr.diffusion_id AS diffusion_id, 
nr.\"X\", nr.\"Y\", nr.block
							
FROM network_relation nr
LEFT OUTER JOIN network_selection sel1 ON nr.selection_id = sel1.id
LEFT OUTER JOIN actors_person psel1 ON sel1.person_id = psel1.id 
LEFT OUTER JOIN network_reproduction rep1 ON nr.reproduction_id = rep1.id	
LEFT OUTER JOIN network_reproduction_method nrm1 ON rep1.reproduction_method_id = nrm1.id
							
LEFT OUTER JOIN entities_seed_lot sl1 ON nr.seed_lot_son_id = sl1.id
LEFT OUTER JOIN entities_germplasm gp1 ON sl1.germplasm_id = gp1.id
LEFT OUTER JOIN entities_species sp1 ON sp1.id = gp1.species_id
LEFT OUTER JOIN entities_germplasm_type gpt1 ON gp1.germplasm_type_id = gpt1.id
LEFT OUTER JOIN actors_person p1 ON sl1.person_id = p1.id
LEFT OUTER JOIN actors_location l1 ON p1.location_id = l1.id
							
LEFT OUTER JOIN entities_seed_lot sl2 ON nr.seed_lot_father_id=sl2.id
LEFT OUTER JOIN entities_germplasm gp2 ON sl2.germplasm_id = gp2.id
LEFT OUTER JOIN entities_species sp2 ON sp2.id = gp2.species_id
LEFT OUTER JOIN entities_germplasm_type gpt2 ON gp2.germplasm_type_id = gpt2.id
LEFT OUTER JOIN actors_person p2 ON sl2.person_id = p2.id
LEFT OUTER JOIN actors_location l2 ON p2.location_id = l2.id
							
LEFT OUTER JOIN network_relation relfat ON nr.seed_lot_father_id = relfat.seed_lot_son_id
LEFT OUTER JOIN entities_seed_lot slf ON relfat.seed_lot_father_id = slf.id
LEFT OUTER JOIN entities_germplasm gpf ON slf.germplasm_id = gpf.id
LEFT OUTER JOIN actors_person pf ON slf.person_id = pf.id
							
LEFT OUTER JOIN eppdata_raw_data_relation dr1 ON nr.id = dr1.relation_id
LEFT OUTER JOIN eppdata_raw_data rd1 ON dr1.raw_data_id = rd1.id
LEFT OUTER JOIN eppdata_variable v1 ON rd1.variable_id = v1.id
LEFT OUTER JOIN eppdata_method met1 ON rd1.method_id = met1.id
							
LEFT OUTER JOIN network_relation_project rp1 ON rp1.relation_id = nr.id
LEFT OUTER JOIN actors_project pro1 ON pro1.id = rp1.project_id
LEFT OUTER JOIN network_relation_project rp2 ON rp2.relation_id = nr.id
LEFT OUTER JOIN actors_project pro2 ON pro2.id = rp2.project_id",

filters,

"
GROUP BY sl1.name, rd1.individual, sl1.date, gp1.germplasm_name, sp1.species, gpt1.germplasm_type, p1.short_name, l1.altitude, l1.longitude, l1.latitude, sl2.name, sl2.date, gp2.germplasm_name, sp2.species, gpt2.germplasm_type, p2.short_name, l2.altitude, l2.longitude, l2.latitude, v1.name, rd1.raw_data, rd1.group, rd1.date, met1.method_name, rep1.date, nr.reproduction_id, nrm1.reproduction_methode_name, nr.selection_id, psel1.short_name, nr.mixture_id, nr.diffusion_id, nr.\"X\", nr.\"Y\", nr.block
", sep = "")

d = get.d(query, info_db)


if( nrow(d) > 0 ) {

	son_species = as.factor(d$son_species)
	son_project = as.factor(d$son_project)
	son = as.factor(d$son)
	son_ind = as.factor(d$son_ind)
	son_year = as.factor(d$son_year)
	son_germplasm = as.factor(d$son_germplasm)
	son_germplasm_type = as.factor(d$son_germplasm_type)
	son_person = as.factor(d$son_person)
	son_alt = as.numeric(d$son_alt)
	son_long = as.numeric(d$son_long)
	son_lat = as.numeric(d$son_lat)
	son_total_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(son_total_generation_nb))
	son_local_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(son_local_generation_nb))
	son_generation_confidence = sample( c(1:0), nrow(d), replace = TRUE) # as.character(son_generation_confidence)
	son_comments = rep("blablabla", nrow(d)) # as.character(d$son_comments)
	
	father_species = as.factor(d$father_species)
	father_project = as.factor(d$father_project)
	father = as.factor(d$father)
	father_year = as.factor(d$father_year)
	father_germplasm = as.factor(d$father_germplasm)
	father_germplasm_type = as.factor(d$father_germplasm_type)
	father_person = as.factor(d$father_person)
	father_alt = as.numeric(d$father_alt)
	father_long = as.numeric(d$father_long)
	father_lat = as.numeric(d$father_lat)
	father_total_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$father_total_generation_nb))
	father_local_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$father_local_generation_nb))
	father_generation_confidence = sample( c(1:0), nrow(d), replace = TRUE) # as.character(d$father_generation_confidence)
	father_comments = rep("blablabla", nrow(d)) # as.character(d$father_comments)
	
	variable_name = as.character(d$variable_name)
	raw_data = as.character(d$raw_data)
	raw_data_date = as.character(d$raw_data_date)
	correlation_group = as.character(d$correlation_group)
	method_name = as.factor(d$method_name)
	
	reproduction_id = as.character(d$reproduction_id)
	reproduction_method_name = as.factor(d$reproduction_method_name)
	selection_id = as.character(d$selection_id)
	selection_person = as.factor(d$selection_person)
	mixture_id = as.character(d$mixture_id)
	diffusion_id = as.character(d$diffusion_id)
	relation_year = as.factor(d$relation_year)
	
	X = as.factor(d$X)
	Y = as.factor(d$Y)
	block = as.factor(d$block)
	

	d = data.frame(
		son_species,
		son_project,
		son,
		son_ind,
		son_year,
		son_germplasm,
		son_germplasm_type,
		son_person,
		son_alt,
		son_long,
		son_lat,
		son_total_generation_nb,
		son_local_generation_nb,
		son_generation_confidence,
		son_comments,
		
		father_species,
		father_project,
		father,
		father_year,
		father_germplasm,
		father_germplasm_type,
		father_person,
		father_alt,
		father_long,
		father_lat,
		father_total_generation_nb,
		father_local_generation_nb,
		father_generation_confidence,
		father_comments,
		
		variable_name,
		raw_data,
		raw_data_date,
		correlation_group,
		method_name,
		
		reproduction_id,
		reproduction_method_name,
		selection_id,
		selection_person,
		mixture_id,
		diffusion_id,
		relation_year,
		
		X,
		Y,
		block
	)

d = d[order(d$son, d$son_ind), ] 

} else { d = NULL }

return(d)
}


query.cross = function(G = NULL, GT = NULL, Y = NULL, P = NULL, Proj = NULL, info_db) {

	f = c(G, GT, Y, P, Proj)
	if( !is.null (f[1]) ) { 
		f = f[!is.null(f)]
		f = paste(f, collapse = " AND ")
		filters = paste(" AND ", f, sep = "") 
	} else { filters = NULL }
	
	
query = paste(
"
SELECT
sl10.name AS father, gp10.germplasm_name AS father_germplasm, gpt10.germplasm_type AS father_germplasm_type, p10.short_name AS father_person, sl10.date AS father_year, pro10.project_name AS father_project, l10.altitude AS father_alt, l10.longitude AS father_long, l10.latitude AS father_lat,

sl3.name AS grandfather, gp3.germplasm_name AS grandfather_germplasm, gpt3.germplasm_type AS grandfather_germplasm_type, p3.short_name AS grandfather_person, sl3.date AS grandfather_year, pro3.project_name AS grandfather_project, l3.altitude AS grandfather_alt, l3.longitude AS grandfather_long, l3.latitude AS grandfather_lat,

sl2.name AS mother, gp2.germplasm_name AS mother_germplasm, gpt2.germplasm_type AS mother_germplasm_type, p2.short_name AS mother_person, sl2.date AS mother_year, pro2.project_name AS mother_project, l2.altitude AS mother_alt, l2.longitude AS mother_long, l2.latitude AS mother_lat,

sl4.name AS grandmother, gp4.germplasm_name AS grandmother_germplasm, gpt4.germplasm_type AS grandmother_germplasm_type, p4.short_name AS grandmother_person, sl4.date AS grandmother_year, pro4.project_name AS grandmother_project, l4.altitude AS grandmother_alt, l4.longitude AS grandmother_long, l4.latitude AS grandmother_lat,

sl1.name AS cross, gp1.germplasm_name AS cross_germplasm, gpt1.germplasm_type AS cross_germplasm_type, p1.short_name AS cross_person, sl1.date AS cross_year, pro1.project_name AS cross_project, l1.altitude AS cross_alt, l1.longitude AS cross_long, l1.latitude AS cross_lat

FROM network_relation r1 JOIN network_relation r2 ON r1.seed_lot_son_id = r2.seed_lot_son_id

LEFT OUTER JOIN network_relation r3 ON r1.seed_lot_father_id = r3.seed_lot_son_id
LEFT OUTER JOIN network_relation r4 ON r2.seed_lot_father_id = r4.seed_lot_son_id

LEFT OUTER JOIN entities_seed_lot sl10 ON r1.seed_lot_father_id = sl10.id
LEFT OUTER JOIN entities_germplasm gp10 ON sl10.germplasm_id = gp10.id

LEFT OUTER JOIN entities_seed_lot sl2 ON r2.seed_lot_father_id = sl2.id
LEFT OUTER JOIN entities_germplasm gp2 ON sl2.germplasm_id = gp2.id

LEFT OUTER JOIN entities_seed_lot sl3 ON r3.seed_lot_father_id = sl3.id
LEFT OUTER JOIN entities_germplasm gp3 ON sl3.germplasm_id = gp3.id

LEFT OUTER JOIN entities_seed_lot sl4 ON r4.seed_lot_father_id = sl4.id
LEFT OUTER JOIN entities_germplasm gp4 ON sl4.germplasm_id = gp4.id

LEFT OUTER JOIN entities_seed_lot sl1 ON r1.seed_lot_son_id = sl1.id
LEFT OUTER JOIN entities_germplasm gp1 ON sl1.germplasm_id = gp1.id

LEFT OUTER JOIN entities_germplasm_type gpt10 ON gp10.germplasm_type_id=gpt10.id
LEFT OUTER JOIN entities_germplasm_type gpt2 ON gp2.germplasm_type_id=gpt2.id
LEFT OUTER JOIN entities_germplasm_type gpt1 ON gp1.germplasm_type_id=gpt1.id
LEFT OUTER JOIN entities_germplasm_type gpt3 ON gp3.germplasm_type_id=gpt3.id
LEFT OUTER JOIN entities_germplasm_type gpt4 ON gp4.germplasm_type_id=gpt4.id

LEFT OUTER JOIN actors_person p10 ON sl10.person_id = p10.id
LEFT OUTER JOIN actors_person p2 ON sl2.person_id = p2.id
LEFT OUTER JOIN actors_person p1 ON sl1.person_id = p1.id
LEFT OUTER JOIN actors_person p3 ON sl3.person_id = p3.id
LEFT OUTER JOIN actors_person p4 ON sl4.person_id = p4.id

LEFT OUTER JOIN actors_location l10 ON p10.location_id = l10.id
LEFT OUTER JOIN actors_location l2 ON p2.location_id = l2.id
LEFT OUTER JOIN actors_location l1 ON p1.location_id = l1.id
LEFT OUTER JOIN actors_location l3 ON p3.location_id = l3.id
LEFT OUTER JOIN actors_location l4 ON p4.location_id = l4.id

LEFT OUTER JOIN network_relation_project nrp ON nrp.relation_id = r2.id
LEFT OUTER JOIN actors_project pro1 ON nrp.project_id = pro1.id
LEFT OUTER JOIN actors_project pro2 ON nrp.project_id = pro2.id
LEFT OUTER JOIN actors_project pro3 ON nrp.project_id = pro3.id
LEFT OUTER JOIN actors_project pro4 ON nrp.project_id = pro4.id
LEFT OUTER JOIN actors_project pro10 ON nrp.project_id = pro10.id

WHERE r1.seed_lot_father_id <> r2.seed_lot_father_id AND r1.reproduction_id IS NOT NULL AND r1.is_male = 'M'",

filters, 

sep = "")

d = get.d(query, info_db)

if( nrow(d) > 0 ) {
	dok = as.data.frame(matrix(NA, ncol = 12, nrow = 1))
	colnames(dok) = c("expe", "sl", "type", "germplasm", "germplasm_type", "year", "year_cross", "person", "project", "lat", "long", "alt")
	
	for(i in 1:nrow(d)){
		expe = rep(i, times = 5)
		sl = c(d[i, "cross"], d[i, "father"], d[i, "grandfather"], d[i, "mother"], d[i, "grandmother"])
		type = c("cross", "father", "grandfather", "mother", "grandmother")
		germplasm = c(d[i, "cross_germplasm"], d[i, "father_germplasm"], d[i, "grandfather_germplasm"], d[i, "mother_germplasm"], d[i, "grandmother_germplasm"])
		germplasm_type = c(d[i, "cross_germplasm_type"], d[i, "father_germplasm_type"], d[i, "grandfather_germplasm_type"], d[i, "mother_germplasm_type"], d[i, "grandmother_germplasm_type"])
		year = c(d[i, "cross_year"], d[i, "father_year"], d[i, "grandfather_year"], d[i, "mother_year"], d[i, "grandmother_year"])
		year_cross = rep(d[i, "cross_year"], times = 5)
		person = c(d[i, "cross_person"], d[i, "father_person"], d[i, "grandfather_person"], d[i, "mother_person"], d[i, "grandmother_person"])
		project = c(d[i, "cross_project"], d[i, "father_project"], d[i, "grandfather_project"], d[i, "mother_project"], d[i, "grandmother_project"])
		lat = c(d[i, "cross_lat"], d[i, "father_lat"], d[i, "grandfather_lat"], d[i, "mother_lat"], d[i, "grandmother_lat"])
		long = c(d[i, "cross_long"], d[i, "father_long"], d[i, "grandfather_long"], d[i, "mother_long"], d[i, "grandmother_long"])
		alt = c(c(d[i, "cross_alt"], d[i, "father_alt"], d[i, "grandfather_alt"], d[i, "mother_alt"], d[i, "grandmother_alt"]))
		
		d_tmp = cbind.data.frame(expe, sl, type, germplasm, germplasm_type, year, year_cross, person, project, lat, long, alt)
		dok = rbind.data.frame(dok, d_tmp)
	}
	
	d = dok[-1,]
	
	if( nrow(d) > 0 ) {
		d$expe = as.factor(d$expe)
		d$sl = as.factor(d$sl)
		d$germplasm = as.factor(d$germplasm)
		d$germplasm_type = as.factor(d$germplasm_type)
		d$year = as.factor(d$year)
		d$year_cross = as.factor(d$year_cross)
		d$person = as.factor(d$person)
		d$project = as.factor(d$project)
		d$lat = as.numeric(as.character(d$lat))
		d$long = as.numeric(as.character(d$long))
		d$alt = as.numeric(as.character(d$alt))
	} else { d = NULL }
} else { d = NULL }

return(d)
}


query.S = function(info_db) {

query = "
SELECT sl1.name AS vrac_S, sl2.name AS bouquet_S

FROM network_relation nr

LEFT JOIN network_relation nrsel ON (nr.seed_lot_father_id = nrsel.seed_lot_father_id AND nr.reproduction_id = nrsel.reproduction_id)
LEFT JOIN entities_seed_lot sl1 ON nr.seed_lot_son_id = sl1.id
LEFT JOIN entities_seed_lot sl2 ON nrsel.seed_lot_son_id = sl2.id

WHERE nrsel.selection_id IS NOT NULL AND nr.reproduction_id IS NOT NULL AND nr.selection_id IS NULL "

d = get.d(query, info_db)

if(nrow(d) > 0) {		
	d = cbind.data.frame(
		sl = c(d$vrac_s, d$bouquet_s),
		sl_stat = rep( c("vracS", "bouquetS"), each = nrow(d) ),
		expe = rep( seq(1, nrow(d), 1), times = 2 )
	)

	d$sl_statut = paste(sapply(d$sl, function(x){unlist(strsplit(as.character(x),"_"))[3]}), d$sl_stat, sep = ":")
	d = select(d, - sl_stat)
	
	expinfo = unique(
									cbind.data.frame(
																	exp = d$expe,
																	sl = d$sl,
																	g = sapply(d$sl,function(x){unlist(strsplit(as.character(x),"_"))[1]}), 
																	sl_statut = d$sl_statut
																	)
										)
	
	expinfo = expinfo[order(expinfo$exp, expinfo$sl_statut, decreasing = TRUE), ]
	expinfo$ok = sapply( expinfo$exp, function(x){floor(as.numeric(as.character(x)))} )
	liste = unique(expinfo$ok); name.exp.1 = name.exp.2 = NULL
	
	for(i in 1:length(liste)) {
		toto = filter(expinfo, ok %in% liste[i])
		toget = grep("vracS", toto[,"sl_statut"])[1]
		n11 = toto[toget, "g"]
		n21 = toto[toget, "sl"]
		
		toget = grep("bouquetS", toto[,"sl_statut"])[1]
		n12 = toto[toget, "g"]
		n22 = toto[toget,"sl"]
		
		n1 = paste( as.character(n11), as.character(n12), sep = " | " )
		n1 = rep( n1, nrow(toto) ); names(n1) = toto[, "exp"]
		
		n2 = paste( as.character(n21), as.character(n22), sep = " | " )
		n2 = rep( n2, nrow(toto) ); names(n2) = toto[, "exp"]

		name.exp.1 = c(name.exp.1, n1)
		name.exp.2 = c(name.exp.2, n2)
		}
	
	d$expe_name = name.exp.1[as.character(d$expe)]	
	d$expe_name_2 = name.exp.2[as.character(d$expe)]	
	
	d$sl = as.factor(d$sl)
	d$sl_statut = as.factor(d$sl_statut)
	d$expe = as.factor(d$expe)
	d$expe_name = as.factor(d$expe_name)
	d$expe_name_2 = as.factor(d$expe_name_2)
	
} else { d = NULL }

return(d)
}


query.SR = function(info_db) {

query = "
SELECT sl1.name AS vrac_S, sl2.name AS bouquet_S, sl3.name AS vrac_R, sl4.name AS bouquet_R, nr1.block AS bloc_vrac, nr1.\"X\" AS X_vrac, nr1.\"Y\" AS Y_vrac, nr2.block AS bloc_bouquet, nr2.\"X\" AS X_bouquet, nr2.\"Y\" AS Y_bouquet
FROM network_relation nr
JOIN network_relation nrsel ON nr.seed_lot_father_id = nrsel.seed_lot_father_id
JOIN network_relation nr1 ON nr1.seed_lot_father_id = nr.seed_lot_son_id
JOIN network_relation nr2 ON nr2.seed_lot_father_id = nrsel.seed_lot_son_id
LEFT OUTER JOIN entities_seed_lot sl1 ON nr.seed_lot_son_id = sl1.id
LEFT OUTER JOIN entities_seed_lot sl2 ON nrsel.seed_lot_son_id = sl2.id
LEFT OUTER JOIN entities_seed_lot sl3 ON nr1.seed_lot_son_id = sl3.id
LEFT OUTER JOIN entities_seed_lot sl4 ON nr2.seed_lot_son_id = sl4.id

WHERE 

nrsel.selection_id IS NOT NULL AND 
nr.reproduction_id IS NOT NULL AND 
nr.selection_id IS NULL AND 
nr1.reproduction_id IS NOT NULL AND 
nr2.reproduction_id IS NOT NULL AND 
nr1.selection_id IS NULL AND 
nr2.selection_id IS NULL AND
nr1.is_male = 'X' AND
nr2.is_male='X'
"

d1 = get.d(query, info_db)

# special query when selection have been done in a seed-lot that have been merged after
query = "
SELECT sl1.name AS vrac_S, sl2.name AS bouquet_S, sl3.name AS vrac_R, sl4.name AS bouquet_R, nr1.block AS bloc_vrac, nr1.\"X\" AS X_vrac, nr1.\"Y\" AS Y_vrac, nr2.block AS bloc_bouquet, nr2.\"X\" AS X_bouquet, nr2.\"Y\" AS Y_bouquet

FROM network_relation nr
JOIN network_relation nrsel ON nr.seed_lot_father_id = nrsel.seed_lot_father_id
JOIN network_relation nr1mix ON nr1mix.seed_lot_father_id = nr.seed_lot_son_id
JOIN network_relation nr1 ON nr1.seed_lot_father_id = nr1mix.seed_lot_son_id
JOIN network_relation nr2 ON nr2.seed_lot_father_id = nrsel.seed_lot_son_id
LEFT OUTER JOIN entities_seed_lot sl1 ON nr.seed_lot_son_id = sl1.id
LEFT OUTER JOIN entities_seed_lot sl2 ON nrsel.seed_lot_son_id = sl2.id
LEFT OUTER JOIN entities_seed_lot sl3 ON nr1.seed_lot_son_id = sl3.id
LEFT OUTER JOIN entities_seed_lot sl4 ON nr2.seed_lot_son_id = sl4.id

WHERE

nrsel.selection_id IS NOT NULL AND
nr.reproduction_id IS NOT NULL AND
nr.selection_id IS NULL AND
nr1.reproduction_id IS NOT NULL AND
nr2.reproduction_id IS NOT NULL AND
nr1.selection_id IS NULL AND
nr2.selection_id IS NULL AND
nr1mix.mixture_id IS NOT NULL AND

nr.block = nrsel.block AND
(nr.\"X\" = nrsel.\"X\" OR (nr.\"X\" IS NULL AND nr.\"X\" IS NULL)) AND
(nr.\"Y\" = nrsel.\"Y\" OR (nr.\"Y\" IS NULL AND nr.\"Y\" IS NULL))"

d2 = get.d(query, info_db)


if(FALSE){
# On nettoie les données
# Choper dans la réponse le vrac le plus proche du bouquet
	print("transformet en as num as factor les X et Y, comme ça on retrouve et on est pas contraint par la nature de X et Y")
# GÉRER LES 4A, 4B, ETC Cf redmine 583 ---------------------------
NUM = paste(rep(c(1:26),each=length(letters)),rep(c("",letters),rep=26),sep="")
liste_bouquet_r = unique(d2$bouquet_r)
LINE = NULL
for(bouquet in liste_bouquet_r) {
	db = subset(d2,bouquet_r==bouquet)

	if(nrow(db)>1) {
		# 1ere vérif : le bloc
		a.bloc_vrac = db[1,"bloc_vrac"]
		a.bloc_bouquet = db[1,"bloc_bouquet"]
		
		testa = a.bloc_vrac == a.bloc_bouquet
		
		b.bloc_vrac = db[2,"bloc_vrac"]
		b.bloc_bouquet = db[2,"bloc_bouquet"]
		
		testb = b.bloc_vrac == b.bloc_bouquet
		
		if(testa) {line = rownames(db)[1]}
		if(testb) {line = rownames(db)[2]}
		
		if(testa & testb) {
			a.Xvrac = db[1,"x_vrac"]
			a.Yvrac = db[1,"y_vrac"]
			a.Xbouquet = db[1,"x_bouquet"]
			a.Ybouquet = db[1,"y_bouquet"]
			
			a.distX = abs( which(LETTERS==a.Xvrac) - which(LETTERS==a.Xbouquet) )
			a.distY = abs( which(NUM==a.Yvrac) - which(NUM==a.Ybouquet) )
			
			a.dist = a.distX + a.distY
			
			b.Xvrac = db[2,"x_vrac"]
			b.Yvrac = db[2,"y_vrac"]
			b.Xbouquet = db[2,"x_bouquet"]
			b.Ybouquet = db[2,"y_bouquet"]
			
			b.distX = abs( which(LETTERS==b.Xvrac) - which(LETTERS==b.Xbouquet) )
			b.distY = abs( which(NUM==b.Yvrac) - which(NUM==b.Ybouquet) )
			
			b.dist = b.distX + b.distY
	
			if(a.dist<b.dist) {line=rownames(db)[1]} else {line=rownames(db)[2]}
			}
		
		} else {line = rownames(db) }

	LINE = c(LINE,line)
	}


d2 = d2[LINE,]
}


print("vérifier ce que donne d2, est ce que ça a un sens?")

d = rbind(d1,d2)[,1:4]

if(nrow(d) > 0)  { 
	d = cbind.data.frame(
											"sl" = c(d$vrac_s, d$bouquet_s, d$vrac_r, d$bouquet_r), 											
											"sl_stat"= rep( c("vracS", "bouquetS", "vracR", "bouquetR"), each = nrow(d) ),
											"expe"= rep( seq(1, nrow(d), 1), times = 4 )
											) 
	d$sl_statut = paste(sapply(d$sl, function(x){unlist(strsplit(as.character(x),"_"))[3]}), d$sl_stat, sep = ":")
	d = select(d, - sl_stat)
	
	expinfo = unique(
									cbind.data.frame(
																		exp = d$expe, 
																		g = sapply(d$sl, function(x){unlist(strsplit(as.character(x),"_"))[1]}), 
																		sl_statut = d$sl_statut,
																		sl = d$sl
																	)
									)

	expinfo = expinfo[order(expinfo$exp, expinfo$sl_statut, decreasing = TRUE), ]
	expinfo$ok = sapply( expinfo$exp, function(x){floor(as.numeric(as.character(x)))} )
	liste = unique(expinfo$ok); name.exp = NULL
	
	name.exp.1 = name.exp.2 = NULL
	
	for(i in 1:length(liste)) {
		toto = droplevels(subset(expinfo, ok %in% liste[i]))
		toget = grep("vracR", toto[,"sl_statut"])[1]
		n11 = toto[toget,"g"]
		n21 = toto[toget, "sl"]
		
		toget = grep("bouquetR",toto[,"sl_statut"])[1]
		n12 = toto[toget,"g"]
		n22 = toto[toget, "sl"]
		
		n1 = paste( as.character(n11), as.character(n12), sep = " | " )
		n1 = rep( n1, nrow(toto) ); names(n1) = toto[, "exp"]
		
		n2 = paste( as.character(n21), as.character(n22), sep = " | " )
		n2 = rep( n2, nrow(toto) ); names(n2) = toto[, "exp"]
		
		name.exp.1 = c(name.exp.1, n1)
		name.exp.2 = c(name.exp.2, n2)
		}
	
	d$expe_name = name.exp.1[as.character(d$expe)]	
	d$expe_name_2 = name.exp.2[as.character(d$expe)]	
	
	d$sl = as.factor(d$sl)
	d$sl_statut = as.factor(d$sl_statut)
	d$expe = as.factor(d$expe)
	d$expe_name = as.factor(d$expe_name)
	d$expe_name_2 = as.factor(d$expe_name_2)
	
} else { d = NULL }

return(d)
}


query.SL.mix = function(G = NULL, GT = NULL, Y = NULL, P = NULL, SL = NULL, Proj = NULL, info_db) {
	f = c(G, GT, Y, P, SL, Proj)
	if( !is.null (f[1]) ) { 
		f = f[!is.null(f)]
		f = paste(f, collapse = " AND ")
		filters = paste(" AND ", f, sep = "") 
	} else { filters = NULL }
	
	
	query = paste(
		"SELECT DISTINCT sl1.name AS son, gp1.germplasm_name AS son_germplasm, gpt1.germplasm_type AS son_germplasm_type, p1.short_name AS son_person , sl1.date AS son_year,
string_agg(DISTINCT pro1.project_name,',') AS son_project,

sl2.name AS father, gp2.germplasm_name AS father_germplasm, gpt2.germplasm_type AS father_germplasm_type, p2.short_name AS father_person, sl2.date AS father_year, string_agg(DISTINCT pro2.project_name,',') AS father_project

FROM network_relation nr2 JOIN entities_seed_lot sl2 ON nr2.seed_lot_father_id=sl2.id

LEFT OUTER JOIN network_relation nr1 ON nr2.seed_lot_son_id=nr1.seed_lot_father_id
LEFT OUTER JOIN entities_seed_lot sl1 ON nr1.seed_lot_son_id = sl1.id

LEFT OUTER JOIN entities_germplasm gp1 ON sl1.germplasm_id = gp1.id
LEFT OUTER JOIN entities_germplasm gp2 ON sl2.germplasm_id = gp2.id
LEFT OUTER JOIN entities_germplasm_type gpt1 ON gp1.germplasm_type_id = gpt1.id
LEFT OUTER JOIN entities_germplasm_type gpt2 ON gp2.germplasm_type_id = gpt2.id
LEFT OUTER JOIN actors_person p1 ON sl1.person_id = p1.id
LEFT OUTER JOIN actors_person p2 ON sl2.person_id = p2.id

LEFT OUTER JOIN network_relation_project nrp1 ON nrp1.relation_id = nr1.id
LEFT OUTER JOIN actors_project pro1 ON nrp1.project_id = pro1.id

LEFT OUTER JOIN network_relation_project nrp2 ON nrp2.relation_id = nr2.id
LEFT OUTER JOIN actors_project pro2 ON nrp2.project_id = pro2.id

WHERE
nr1.mixture_id IS NOT NULL AND
sl1.germplasm_id = sl2.germplasm_id",

filters,

"
GROUP BY sl1.name, gp1.germplasm_name, gpt1.germplasm_type, p1.short_name, sl1.date, sl2.name, gp2.germplasm_name, gpt2.germplasm_type, p2.short_name, sl2.date
",

sep = "")

d = get.d(query, info_db)

if( nrow(d) > 0 ) {

d = data.frame(
	son_project = as.factor(d$son_project),
	son = as.factor(d$son),
	son_person = as.factor(d$son_person),
	son_germplasm = as.factor(d$son_germplasm),
	son_year = as.factor(d$son_year),
	son_germplasm_type = as.factor(d$son_germplasm_type),
	
	father_project = as.factor(d$father_project),
	father = as.factor(d$father),
	father_germplasm = as.factor(d$father_germplasm),
	father_person = as.factor(d$father_person),
	father_year = as.factor(d$father_year),
	father_germplasm_type = as.factor(d$father_germplasm_type)
)

}

return(d)
}


query.grand.father = function(G = NULL, GT = NULL, Y = NULL, P = NULL, SL = NULL, Proj = NULL, info_db) {

	f = c(G, GT, Y, P, SL, Proj)
	if( !is.null (f[1]) ) { 
		f = f[!is.null(f)]
		f = paste(f, collapse = " AND ")
		filters = paste(" WHERE ", f, sep = "") 
	} else { filters = NULL }
	
query = paste(
"
SELECT
sp1.species AS son_species, sl1.name AS son, gp1.germplasm_name AS son_germplasm, p1.short_name AS son_person, sl1.date AS son_year, gpt1.germplasm_type AS son_germplasm_type,
l1.altitude AS son_alt, l1.longitude AS son_long, l1.latitude AS son_lat,",
# waiting for generation and sl comments to be implemented in SHiNeMaS
#sl1.generation AS son_total_generation_nb, sl1.lgeneration AS son_local_generation_nb, sl1.confidence AS son_generation_confidence,
#sl1.comments AS son_comments, 
"","string_agg(DISTINCT pro1.project_name,',') AS son_project,

sp2.species AS father_species, sl2.name AS father, gp2.germplasm_name AS father_germplasm, p2.short_name AS father_person, sl2.date AS father_year, gpt2.germplasm_type AS father_germplasm_type,
l2.altitude AS father_alt, l2.longitude AS father_long, l2.latitude AS father_lat,",
# waiting for generation and sl comments to be implemented in SHiNeMaS
# sl2.generation AS father_total_generation_nb, sl2.lgeneration AS father_local_generation_nb, sl2.confidence AS father_generation_confidence,
#sl2.comments AS father_comments, 
"", "string_agg(DISTINCT pro2.project_name,',') AS father_project,

rep1.date AS relation_year,

spf.species AS grandfather_species, slf.name AS grandfather, gpf.germplasm_name AS grandfather_germplasm, pf.short_name AS grandfather_person, slf.date AS grandfather_year, gptf.germplasm_type AS grandfather_germplasm_type,
lf.altitude AS grandfather_alt, lf.longitude AS grandfather_long, lf.latitude AS grandfather_lat,",
# waiting for generation and sl comments to be implemented in SHiNeMaS
# slf.generation AS grandfather_total_generation_nb, slf.lgeneration AS grandfather_local_generation_nb, slf.confidence AS grandfather_generation_confidence,
# slf.comments AS grandfather_comments, 
"", "string_agg(DISTINCT pro2.project_name,',')  AS grandfather_project,

repf.date AS relation_father_grandfather_year

FROM network_relation nr
LEFT OUTER JOIN network_selection sel1 ON nr.selection_id = sel1.id
LEFT OUTER JOIN actors_person psel1 ON sel1.person_id = psel1.id
LEFT OUTER JOIN network_reproduction rep1 ON nr.reproduction_id = rep1.id
LEFT OUTER JOIN network_reproduction_method nrm1 ON rep1.reproduction_method_id = nrm1.id

LEFT OUTER JOIN entities_seed_lot sl1 ON nr.seed_lot_son_id=sl1.id
LEFT OUTER JOIN entities_germplasm gp1 ON sl1.germplasm_id = gp1.id
LEFT OUTER JOIN entities_germplasm_type gpt1 ON gp1.germplasm_type_id = gpt1.id
LEFT OUTER JOIN actors_person p1 ON sl1.person_id=p1.id
LEFT OUTER JOIN actors_location l1 ON p1.location_id = l1.id
LEFT OUTER JOIN entities_species sp1 ON gp1.species_id = sp1.id

LEFT OUTER JOIN entities_seed_lot sl2 ON nr.seed_lot_father_id=sl2.id
LEFT OUTER JOIN entities_germplasm gp2 ON sl2.germplasm_id = gp2.id
LEFT OUTER JOIN entities_germplasm_type gpt2 ON gp2.germplasm_type_id = gpt2.id
LEFT OUTER JOIN actors_person p2 ON sl2.person_id=p2.id
LEFT OUTER JOIN actors_location l2 ON p2.location_id = l2.id
LEFT OUTER JOIN entities_species sp2 ON gp2.species_id = sp2.id

LEFT OUTER JOIN network_relation relfat ON nr.seed_lot_father_id = relfat.seed_lot_son_id
LEFT OUTER JOIN entities_seed_lot slf ON relfat.seed_lot_father_id = slf.id
LEFT OUTER JOIN entities_germplasm gpf ON slf.germplasm_id = gpf.id
LEFT OUTER JOIN actors_person pf ON slf.person_id = pf.id
LEFT OUTER JOIN entities_species spf ON gpf.species_id=spf.id
LEFT OUTER JOIN entities_germplasm_type gptf ON gpf.germplasm_type_id=gptf.id
LEFT OUTER JOIN actors_location lf ON pf.location_id=lf.id
LEFT OUTER JOIN network_reproduction repf ON relfat.reproduction_id=repf.id

LEFT OUTER JOIN network_relation_project rp1 ON rp1.relation_id = nr.id
LEFT OUTER JOIN actors_project pro1 ON pro1.id = rp1.project_id
LEFT OUTER JOIN network_relation_project rp2 ON rp2.relation_id = nr.id
LEFT OUTER JOIN actors_project pro2 ON pro2.id = rp2.project_id",

filters,

"
GROUP BY sp1.species, sl1.name, gp1.germplasm_name, p1.short_name, sl1.date, gpt1.germplasm_type, l1.altitude, l1.longitude, l1.latitude, sp2.species, sl2.name, gp2.germplasm_name, p2.short_name, sl2.date, gpt2.germplasm_type, l2.altitude, l2.longitude, l2.latitude, rep1.date, spf.species, slf.name, gpf.germplasm_name, pf.short_name, slf.date, gptf.germplasm_type, lf.altitude, lf.longitude, lf.latitude, repf.date
",

sep = "")

d = get.d(query, info_db)

if( nrow(d) > 0 ) {
	
	son_species = as.factor(d$son_species)
	son_project = as.factor(d$son_project)
	son = as.factor(d$son)
	son_germplasm = as.factor(d$son_germplasm)
	son_person = as.factor(d$son_person)
	son_year = as.factor(d$son_year)
	son_germplasm_type = as.factor(d$son_germplasm_type)
	son_alt = as.numeric(as.character(d$son_alt))
	son_long = as.numeric(as.character(d$son_long))
	son_lat = as.numeric(as.character(d$son_lat))
	son_total_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$son_total_generation_nb))
	son_local_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$son_local_generation_nb))
	son_generation_confidence = sample( c(1:0), nrow(d), replace = TRUE) # as.character(d$son_generation_confidence)
	son_comments = rep("blablabla", nrow(d)) # as.character(d$son_comments)
	
	father_species = as.factor(d$father_species)
	father_project = as.factor(d$father_project)
	father = as.factor(d$father)
	father_germplasm = as.factor(d$father_germplasm)
	father_person = as.factor(d$father_person)
	father_year = as.factor(d$father_year)
	father_germplasm_type = as.factor(d$father_germplasm_type)
	father_alt = as.numeric(as.character(d$father_alt))
	father_long = as.numeric(as.character(d$father_long))
	father_lat = as.numeric(as.character(d$father_lat))
	father_total_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$father_total_generation_nb))
	father_local_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$father_local_generation_nb))
	father_generation_confidence = sample( c(1:8), nrow(d), replace = TRUE) # as.character(d$father_generation_confidence)
	father_comments = rep("blablabla", nrow(d)) # as.character(d$father_comments)
		
	relation_year = as.factor(d$relation_year)
	
	grandfather_species = as.factor(d$grandfather_species)
	grandfather_project = as.factor(d$grandfather_project)
	grandfather = as.factor(d$grandfather)
	grandfather_germplasm = as.factor(d$grandfather_germplasm)
	grandfather_person = as.factor(d$grandfather_person)
	grandfather_year = as.factor(d$grandfather_year)
	grandfather_germplasm_type = as.factor(d$grandfather_germplasm_type)
	grandfather_alt = as.numeric(as.character(d$grandfather_alt))
	grandfather_long = as.numeric(as.character(d$grandfather_long))
	grandfather_lat = as.numeric(as.character(d$grandfather_lat))
	grandfather_total_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$grandfather_total_generation_nb))
	grandfather_local_generation_nb = sample( c(1:8), nrow(d), replace = TRUE) # as.numeric(as.character(d$grandfather_local_generation_nb))
	grandfather_generation_confidence = sample( c(1:8), nrow(d), replace = TRUE) # as.character(d$grandfather_generation_confidence)
	grandfather_comments = rep("blablabla", nrow(d)) # as.character(d$grandfather_comments)
		
	relation_father_grandfather_year = as.factor(d$relation_father_grandfather_year)
	
	
	d = data.frame(
		son_species,
		son_project,
		son,
		son_germplasm,
		son_person,
		son_year,
		son_germplasm_type,
		son_alt,
		son_long,
		son_lat,
		son_total_generation_nb,
		son_local_generation_nb,
		son_generation_confidence,
		son_comments,
		
		father_species,
		father_project,
		father,
		father_germplasm,
		father_person,
		father_year,
		father_germplasm_type,
		father_alt,
		father_long,
		father_lat,
		father_total_generation_nb,
		father_local_generation_nb,
		father_generation_confidence,
		father_comments,
		
		relation_year,
		
		grandfather_species,
		grandfather_project,
		grandfather,
		grandfather_germplasm,
		grandfather_person,
		grandfather_year,
		grandfather_germplasm_type,
		grandfather_alt,
		grandfather_long,
		grandfather_lat,
		grandfather_total_generation_nb,
		grandfather_local_generation_nb,
		grandfather_generation_confidence,
		grandfather_comments,
		
		relation_father_grandfather_year
	)

}

}


query.methods = function(V = NULL, info_db){

if( !is.null (V) ) { filters = paste(" WHERE", V, sep = "") } else { filters = NULL }

query = paste(
"SELECT DISTINCT m.method_name AS method_name, v1.name AS variable_name, m.method_description ,m.unit 
FROM eppdata_raw_data d 
INNER JOIN eppdata_method m ON d.method_id=m.id 
INNER JOIN eppdata_variable v1 ON d.variable_id=v1.id",

filters,

sep = "")

d = get.d(query, info_db)

return(d)
}


query.person.info = function(P = NULL, info_db){

if( !is.null (P) ) { filters = paste(" WHERE ", P, sep = "") } else { filters = NULL }
	
query = paste("
SELECT p1.first_name, p1.last_name, p1.short_name, p1.email, p1.phone1, p1.fax, l1.address, l1.post_code, l1.country, l1.altitude AS alt, l1.latitude AS lat, l1.longitude AS long

FROM actors_person p1

LEFT OUTER JOIN actors_location l1 ON p1.location_id = l1.id",
							
filters, 

sep = "")

d = get.d(query, info_db)

if( nrow(d) > 0 ) {
	first_name = as.factor(d$first_name)
	last_name = as.factor(d$last_name)
	short_name = as.factor(d$short_name)
	email = as.character(d$email)
	phone1 = as.character(d$phone1)
	fax = as.character(d$fax)
	address = as.character(d$address)
	post_code = as.character(d$post_code)
	country = as.character(d$country)
	alt = as.numeric(d$alt)
	lat = as.numeric(d$lat)
	long = as.numeric(d$long)
	
	d = data.frame(
		first_name,
		last_name,
		short_name,
		email,
		phone1,
		fax,
		address,
		post_code,
		country,
		alt,
		lat,
		long
	)

}

return(d)

}


# 4. Filters --------------------------------------------------------------


# 4.1. Check if filters exist ---------------------------------------------

update.error.messages = function(x, possible.x) {
	if(!is.null(x))
	{
		t = which(!is.element(x, possible.x))
		if( length(t) > 0 ) { stop(paste(x, collapse = ", "), " do not exist in SHiNeMaS") }
	}	
}

if( !is.null(variable.in) ){
	vec.variable.names = query.variable(info_db)
	update.error.messages(variable.in, vec.variable.names)		
}

if( !is.null(person.in) | !is.null(person.in) ){ 
	vec.person.names = query.person(info_db) 
	update.error.messages(person.in, vec.person.names)
	update.error.messages(person.out, vec.person.names) 
}

if( !is.null(year.in) | !is.null(year.in) ){
	vec.years = query.year(info_db)
	update.error.messages(year.in, vec.years)
	update.error.messages(year.out, vec.years)	
}

if( !is.null(project.in) | !is.null(project.in) ){
	vec.project.names = query.project(info_db)
	update.error.messages(project.in, vec.project.names)
	update.error.messages(project.out, vec.project.names)
}

if( !is.null(seed.lot.in) |  !is.null(seed.lot.out)){
	vec.seed_lots = query.seed.lots(info_db)
	update.error.messages(seed.lot.in, vec.seed_lots)
	update.error.messages(seed.lot.out, vec.seed_lots)
}

if( !is.null(reproduction.type.in) ){
	vec.reproduction.type = query.reproduction.type(info_db)
	update.error.messages(reproduction.type.in, vec.reproduction.type)
}

if( !is.null(germplasm.in) | !is.null(germplasm.out) ){
	vec.germplasm.names = query.germplasm(info_db)
	update.error.messages(germplasm.in, vec.germplasm.names)
	update.error.messages(germplasm.out, vec.germplasm.names)	
}

if( !is.null(germplasm.type.in) | !is.null(germplasm.type.out)){
	vec.germplasm.type = query.germplasm.type(info_db)	
	update.error.messages(germplasm.type.in, vec.germplasm.type)
	update.error.messages(germplasm.type.out, vec.germplasm.type)
}


# 4.2. get filters --------------------------------------------------------

get.filters = function(filter.in, filter.out, filter.on, sql.son.tag, sql.father.tag) {
	yo = function(P1, P2, filter.on) # P because it has been created based on person example
	{
		P1 = paste(P1, collapse = " OR ")
		P2 = paste(P2, collapse = " OR ")
		if( filter.on == "son" ) { P = paste(" (", P1, ")", sep = "") }
		if( filter.on == "father" ) { P = paste(" (", P2, ")", sep = "") }
		if( filter.on == "father-son" ) {	P = paste(" ((", P1,") OR (", P2, "))", sep = "") }	
		return(P)
	}

if( !is.null(filter.in) ) {
	P1.in = paste(sql.son.tag, "='", filter.in, "'", sep = "")
	P2.in = paste(sql.father.tag, "='", filter.in, "'", sep = "")
	P.in = yo(P1.in, P2.in, filter.on)	
} else {P.in = NULL}

if( !is.null(filter.out) ) {
	P1.out = paste(sql.son.tag, "<>'", filter.out, "'", sep = "")
	P2.out = paste(sql.father.tag, "<>'", filter.out, "'", sep = "")
	P.out = yo(P1.out, P2.out, filter.on)	
} else {P.out = NULL}

P = paste(P.in, P.out, collapse = "") 
if(P == ""){ P = NULL }
return(P)
}

clean.ap = function(a) { # be careful with the ' in names with SQL queries
	a[grep("'", a)] = sub("'", "''", a[grep("'",a)])		
	return(a)
}

# 4.2.1. person -----------------------------------------------------------
if( !is.null(person.in) ) { person.in = clean.ap(person.in) }
if( !is.null(person.out) ) { person.out = clean.ap(person.out) }

filter_P = get.filters(filter.in = person.in, filter.out = person.out, filter.on, sql.son.tag = "p1.short_name", sql.father.tag = "p2.short_name")

# 4.2.2. germplasm --------------------------------------------------------
if( !is.null(germplasm.in) ) { germplasm.in = clean.ap(germplasm.in) }
if( !is.null(germplasm.out) ) { germplasm.out = clean.ap(germplasm.out) }

filter_G = get.filters(filter.in = germplasm.in, filter.out = germplasm.out, filter.on, sql.son.tag = "gp1.germplasm_name", sql.father.tag = "gp2.germplasm_name")


# 4.2.3. germplasm type -------------------------------------------------------------
if( !is.null(germplasm.type.in) ) { germplasm.type.in = clean.ap(germplasm.type.in) }
if( !is.null(germplasm.type.out) ) { project.out = clean.ap(germplasm.type.out) }

filter_GT = get.filters(filter.in = germplasm.type.in, filter.out = germplasm.type.out, filter.on, sql.son.tag = "gpt1.germplasm_type", sql.father.tag = "gpt2.germplasm_type")


# 4.2.4. year -------------------------------------------------------------
filter_Y = get.filters(filter.in = year.in, filter.out = year.out, filter.on, sql.son.tag = "sl1.date", sql.father.tag = "sl2.date")


# 4.2.5. seed lots --------------------------------------------------------
if( !is.null(seed.lot.in) ) { seed.lot.in = clean.ap(seed.lot.in) }
if( !is.null(seed.lot.out) ) { seed.lot.out = clean.ap(seed.lot.out) }

filter_SL = get.filters(filter.in = seed.lot.in, filter.out = seed.lot.out, filter.on, sql.son.tag = "sl1.name", sql.father.tag = "sl2.name")


# 4.2.6. project ----------------------------------------------------------
if( !is.null(project.in) ) { project.in = clean.ap(project.in) }
if( !is.null(project.out) ) { project.out = clean.ap(project.out) }

filter_Proj = get.filters(filter.in = project.in, filter.out = project.out, filter.on, sql.son.tag = "pro1.project_name", sql.father.tag = "pro2.project_name")


# 4.2.7. relation ---------------------------------------------------------
R.sql = function(relation) {
	if( !is.null(relation) ) {
		R = paste("nr.", relation, "_id IS NOT NULL", sep = "")
		R = paste(R, collapse = " OR ")
		R = paste(" (", R, ")", sep = "")
	} else {R = NULL}
	return(R)
}
filter_R = R.sql(relation.in)

# 4.2.8. variable ---------------------------------------------------------
V.sql = function(variable) {
	if( !is.null(variable) ) {
		V = paste("v1.name='", variable, "'", sep = "")
		V = paste(V, collapse = " OR ")
		V = paste(" (", V, ")", sep = "")
	} else {V = NULL}
	return(V)
}
filter_V = V.sql(variable.in)


# 5. Get data from queries ------------------------------------------------

	# 5.1. network ----------	
 	if(query.type == "network") {	
 		message("1. Query SHiNeMaS ...")
 		reseau = query.network(filter_P, filter_G, filter_GT, filter_Y, filter_R, filter_SL, filter_Proj, info_db = info_db)
 		
 		if( is.null(reseau) ) 
 		{ 
 			n = Minfo = M_dist = NULL
 			message("There is no network for these filters in SHiNeMaS.")
 		} else {
 			message("2. Create network matrix ..."); {
 				
 				# fill diffusion gap
 				fill.diff.gap = function(reseau){
 					message("2.1. Fill diffusion gaps ...")
 					RESEAU = query.network(P = NULL, G = NULL, Y = NULL, R = NULL, SL = NULL, Proj = NULL, info_db = info_db)
 					
 					# get seed-lots sent (=father) but never received (=son) that are not in reseau
 					f = unique(as.character(reseau$father)) # vector of seed-lots father
 					s = unique(as.character(reseau$son)) # vector of seed-lots son
 					sl = f[!is.element(f, s)] # seed-lots that are father and not son, the relation is not in reseau
 					
 					# Generate the network from sl
 					R_to_add = NULL
 					
 					for(s in sl) {
 						toget = s
 						for(letsgo in 1:1000000)
 						{
 							R = RESEAU[which(is.element(RESEAU$son, toget)),]
 							if(nrow(R) == 0) { break() }
 							R_to_add = rbind(R_to_add, R)
 							toget = as.character(R[1,"father"])
 						}
 					}
 					
 					# on concatène
 					reseau = unique(rbind(reseau, R_to_add))
 					return(reseau)
 				}
 				
 				if(fill.diffusion.gap | Mdist) { # To get Mdist, you need to fill the gap
 					reseau = fill.diff.gap(reseau)	
 				}
 				
 				point = unique(c(as.character(reseau[,"father"]),as.character(reseau[,"son"])))
 				
 				M = matrix(0, ncol = length(point), nrow = length(point))
 				colnames(M) = rownames(M) = point
 				
 				for (i in 1:nrow(reseau)) {
 					Father = as.character(reseau[i, "father"])
 					Son = as.character(reseau[i, "son"])
 					M[Father, Son] = 1 + M[Father, Son] # From column to the row
 				}
 				
 				n <- network(M, directed = TRUE)
 			}
 			
 			
 			message("3. Link information to vertex and edges ..."); {
 				
 				# 2.1. information on seed-lots
 				f = as.character(reseau[,"father"])
 				s = as.character(reseau[,"son"])	
 				Y = P = G = TG = SEX = NULL
 				
 				for (p in point) {
 					# year
 					a = unique(reseau[which(f == p), "father_year"])
 					b = unique(reseau[which(s == p), "son_year"])
 					
 					if(length(a) == 0 & length(b) == 1) { pp = b }
 					if(length(a) == 0 & length(b) == 0) { pp = NULL }
 					if(length(a) == 1 & length(b) == 0) { pp = a }
 					if(length(a) == 1 & length(b) == 1) { pp = unique(a, b) }
 					
 					Y = c(Y, as.character(pp))
 					
 					# person
 					a = unique(reseau[which(f == p),"father_person"])
 					b = unique(reseau[which(s == p),"son_person"])
 					
 					if(length(a) == 0 & length(b) == 1) { pp = b }
 					if(length(a) == 0 & length(b) == 0) { pp = NULL }
 					if(length(a) == 1 & length(b) == 0) { pp = a }
 					if(length(a) == 1 & length(b) == 1) { pp = unique(a,b) }
 					
 					P = c(P, as.character(pp))	
 					
 					# germplasm
 					a = unique(reseau[which(f == p), "father_germplasm"])
 					b = unique(reseau[which(s == p), "son_germplasm"])
 					
 					if(length(a) == 0 & length(b) == 1) { g = b }
 					if(length(a) == 0 & length(b) == 0) { g = NULL }
 					if(length(a) == 1 & length(b) == 0) { g = a }
 					if(length(a) == 1 & length(b) == 1) { g = unique(a,b) }
 					
 					G = c(G, as.character(g))
 					
 					# germplasm type
 					a = unique(reseau[which(f == p), "father_germplasm_type"])
 					b = unique(reseau[which(s == p), "son_germplasm_type"])
 					
 					if(length(a) == 0 & length(b) == 1) { tg = b }
 					if(length(a) == 0 & length(b) == 0) { tg = NULL }
 					if(length(a) == 1 & length(b) == 0) { tg = a }
 					if(length(a) == 1 & length(b) == 1) { tg = unique(a,b) }
 					
 					TG = c(TG, as.character(tg))
 					
 					# sex associated to seed-lots if it is a cross
 					sex = reseau[which(f==p),]
 					sex = sex[which(sex$reproduction_type == "cross"), "is_male"]
 					if(length(sex) > 0) { sex = sex } else { sex = "" }
 					SEX = c(SEX, as.character(sex))	
 				}
 				
 				set.vertex.attribute(n, "year", value = as.vector(Y))
 				set.vertex.attribute(n, "person", value = as.vector(P))
 				set.vertex.attribute(n, "germplasm", value = as.vector(G))
 				set.vertex.attribute(n, "germplasm.type", value = as.vector(TG))
 				set.vertex.attribute(n, "sex", value = as.vector(SEX))
 				
 				# 2.2. information on relations and generations
 				R = M_generation = matrix("", ncol = length(point), nrow = length(point))
 				colnames(R) = rownames(R) = colnames(M_generation) = rownames(M_generation) = point
 				
 				# number of generations
 				DD = filter(reseau, !is.na(reproduction_id))
 				D_generation = unique(DD[,c("father", "son", "son_total_generation_nb")])
 				D_generation$toto = paste(D_generation$father, D_generation$son, sep = ":")
 				
 				stock_type_relation = NULL
 				
 				for (i in 1:nrow(reseau)) {
 					Father = as.character(reseau[i, "father"])
 					Son = as.character(reseau[i, "son"])
 					
 					r = as.character(reseau[i, "reproduction_id"])
 					s = as.character(reseau[i, "selection_id"])
 					m = as.character(reseau[i, "mixture_id"])
 					d = as.character(reseau[i, "diffusion_id"])
 					
 					generation = ""		
 					if(!is.na(r)) {
 						type = "reproduction"
 						f = D_generation[which(D_generation$toto == paste(Father, Son, sep = ":")), "generation"]
 						generation = paste("F", f, sep = "") 
 					}
 					if(!is.na(s)) {type = "selection"} # selection erase reproduction
 					if(!is.na(m)) {type = "mixture"}
 					if(!is.na(d)) {type = "diffusion"}
 					
 					R[Father, Son] = type
 					M_generation[Father, Son] = generation
 				}
 				
 				set.edge.value(n, "relation", value = R)
 				set.edge.value(n, "generation", value = M_generation)
 			}
 			
 			if(network.info){
 				message("4. Get network information on seed-lots ..."); {
 					
 					# update point with the updated reseau without mixture for replication event
 					point = unique(c(as.character(reseau[,"father"]), as.character(reseau[,"son"])))
 					
 					# These datas are also useful for part 5. with Mdist
 					repro = filter(reseau, !is.na(reproduction_id))
 					reseau_repro = filter(repro, is.na(selection_id))
 					reseau_sel = filter(reseau, !is.na(selection_id))			
 					reseau_diff = filter(reseau, !is.na(diffusion_id))
 					
 					# get Minfo
 					Minfo = matrix(NA, ncol = 16, nrow = nrow(reseau))
 					colnames(Minfo) = c("father", "son", "diffusion_father_info", "diffusion_son_info", "id.diff_son", "id.diff_father", "reproduction_father_info", "reproduction_son_info", "selection_info", "mixture_info", "father_alt", "father_long", "father_lat", "son_alt", "son_long", "son_lat")
 					
 					for(i in 1:nrow(reseau)) {
 						
 						Minfo[i, "father"] = f = as.character(reseau[i, "father"])
 						Minfo[i, "son"] = s = as.character(reseau[i, "son"])
 						
 						# coordinates and id.diff information
 						Minfo[i, "father_alt"] = reseau[i, "father_alt"]
 						Minfo[i, "father_long"] = reseau[i, "father_long"]
 						Minfo[i, "father_lat"] = reseau[i, "father_lat"]
 						Minfo[i, "son_alt"] = reseau[i, "son_alt"]
 						Minfo[i, "son_long"] = reseau[i, "son_long"]
 						Minfo[i, "son_lat"] = reseau[i, "son_lat"]
 						Minfo[i, "id.diff_son"] = Minfo[i, "id.diff_father"] = reseau[i, "diffusion_id"]
 						
 						# relation information
 						if( !is.na(reseau[i, "diffusion_id"]) ) { relation = "diffusion" }
 						if( !is.na(reseau[i, "mixture_id"]) ) { relation = "mixture"}
 						if( !is.na(reseau[i, "reproduction_id"]) ) { relation = "reproduction"}
 						if( !is.na(reseau[i, "selection_id"]) ) { relation = "selection"} # erase relation = "reproduction"
 						
 						if( relation == "diffusion") {				
 							# info on father
 							sent = 1 # because is father
 							if( is.element(f, reseau_diff[, "son"]) ) { receive = 1 } else { receive = 0 }				
 							if(sent == 1 & receive == 1) { info.f = gettext("give-receive") }	else { info.f = gettext("give")}
 							Minfo[i, "diffusion_father_info"] = info.f
 							
 							# info on son
 							receive = 1 # because is son
 							if( is.element(s, reseau_diff[, "father"]) ) { sent = 1 } else { sent = 0 }
 							if(sent == 1 & receive == 1) { info.s = gettext("give-receive") }	else { info.s = gettext("receive") }
 							Minfo[i, "diffusion_son_info"] = info.s
 						}	
 						
 						if( relation == "reproduction" ) {		
 							# info on father
 							if( is.element(f, reseau_repro[, "father"]) ) { sown = 1 } else { sown = 0 }
 							if( is.element(f, reseau_repro[, "son"]) ) { harvested = 1 } else { harvested = 0 }
 							if(harvested == 1 & sown == 0) { info.f = gettext("harvest") }
 							if(harvested == 0 & sown == 1) { info.f = gettext("sow") }
 							if(harvested == 1 & sown == 1) { info.f = gettext("harvest-sow") } 					
 							Minfo[i, "reproduction_father_info"] = info.f
 							
 							# info on son
 							if( is.element(s, reseau_repro[, "son"]) ) { harvested = 1 } else { harvested = 0 }
 							if( is.element(s, reseau_repro[, "father"]) ) { sown = 1 } else { sown = 0 }
 							if(harvested == 1 & sown == 0) { info.s = gettext("harvest") }
 							if(harvested == 0 & sown == 1) { info.s = gettext("sow") }
 							if(harvested == 1 & sown == 1) { info.s = gettext("harvest-sow") }
 							Minfo[i, "reproduction_son_info"] = info.s
 						}
 						
 						if( relation == "selection" ) { Minfo[i, "selection_info"] = "selection" }
 						
 						if( relation == "mixture") { 
 							Minfo[i, "mixture_info"] = "mixture" 
 							if(Minfo[i, "father_germplasm"] == Minfo[i, "son_germplasm"]) { Minfo[i, "mixture_info"] = "mixture_rep" } 
 						}
 					}
 					
 					# Get duplicated information, there must be one information per seed-lot
 					Minfo = unique(Minfo)
 					
 					# reshape Minfo
 					{ 
 					Minfo = as.data.frame(Minfo)
 					
 					Mcross = query.cross(filter_G, filter_GT, filter_Y, filter_P, filter_Proj, info_db = info_db)
 					if( is.null(Mcross) ) { 
 						Mcross = as.data.frame(matrix(NA, ncol = 12, nrow = 1))
 						colnames(Mcross) = c("expe", "sl", "type", "germplasm", "germplasm_type", "year", "year_cross", "person", "project", "lat", "long", "alt")
 					}
 					
 					Minfo = cbind.data.frame(
 						sl = c(as.character(Minfo$son), as.character(Minfo$father), as.character(Mcross$sl)),
 						alt = c(as.numeric(as.character(Minfo$son_alt)), as.numeric(as.character(Minfo$father_alt)), as.numeric(as.character(Mcross$alt))),
 						long = c(as.numeric(as.character(Minfo$son_long)), as.numeric(as.character(Minfo$father_long)), as.numeric(as.character(Mcross$long))),
 						lat = c(as.numeric(as.character(Minfo$son_lat)), as.numeric(as.character(Minfo$father_lat)), as.numeric(as.character(Mcross$lat))),
 						diffusion = c(as.character(Minfo$diffusion_son_info), as.character(Minfo$diffusion_father_info), rep(NA, nrow(Mcross))),
 						id.diff = c(as.character(Minfo$id.diff_son), as.character(Minfo$id.diff_father), rep(NA, nrow(Mcross))),
 						reproduction = c(as.character(Minfo$reproduction_son_info), as.character(Minfo$reproduction_father_info), rep(NA, nrow(Mcross))),
 						mixture = c(as.character(Minfo$mixture_info), rep(NA, nrow(Minfo)), rep(NA, nrow(Mcross))), # only associated to son
 						selection = c(as.character(Minfo$selection_info), rep(NA, nrow(Minfo)), rep(NA, nrow(Mcross))), # only associated to son
 						cross.info = c(rep(NA, nrow(Minfo)), rep(NA, nrow(Minfo)), as.character(Mcross$type))
 					)
 					
 					# add extra information on levels in separate columns
 					gs = sapply(as.character(Minfo$sl), function(x){unlist(strsplit(x,"_"))[1]})
 					Minfo$germplasm = sapply(as.character(gs), function(x){unlist(strsplit(x,"#"))[1]}); Minfo$germplasm = as.factor(Minfo$germplasm)
 					Minfo$person = sapply(as.character(Minfo$sl), function(x){unlist(strsplit(x,"_"))[2]}); Minfo$person = as.factor(Minfo$person)
 					Minfo$year = sapply(as.character(Minfo$sl), function(x){unlist(strsplit(x,"_"))[3]}); Minfo$year = as.factor(Minfo$year)
 					}
 					
 				}
 			} else { Minfo = NULL }
 			
 			
 			if(Mdist) {
 				message("5. Get Mdist square matrix ...")
 				# Mdist square matrix with the number of reproductions that separate two seed-lots since their last common diffusion.
 				
 				# 4.1. For each seed-lot of the network, get their last diffusion_id and the number of reproductions since the last diffusion ----------
 				fun = function(sl) {
 					test = TRUE
 					nb_repro = 0
 					id_diffusion_sl = NULL
 					
 					while(test) {
 						d_sl_repro = reseau_repro[which(reseau_repro$son == sl),]
 						d_sl_sel = reseau_sel[which(reseau_sel$son == sl),]
 						d_sl_diff = reseau_diff[which(reseau_diff$son == sl),]
 						d_sl_mix = reseau_diff[which(reseau_diff$son == sl),]
 						test = FALSE # default if the sl does not match a son i.e. it is only father => the relations stop
 						
 						if(nrow(d_sl_mix) > 0){ test = FALSE }
 						
 						# if the seed-lot (sl) come from a reproduction or a selection: get the diffusion or go back in the history of the reproduction
 						if(nrow(d_sl_repro) > 0 | nrow(d_sl_sel) > 0) {
 							# increase the number of reproductions by 1 and get the sl father to go back in the history of network
 							nb_repro = nb_repro + 1
 							if(nrow(d_sl_repro) > 0) { sl = as.character(d_sl_repro[1, "father"]) }
 							if(nrow(d_sl_sel) > 0) { sl = as.character(d_sl_sel[1, "father"]) }		
 						}
 						
 						# if the seed-lot (sl) come from a diffusion: get the sl father, that has been sent, and get the diffusion id
 						if(nrow(d_sl_diff) > 0) {
 							sl = as.character(d_sl_diff[1, "father"])		
 							id_diffusion_sl = as.character(sl)
 							test = FALSE
 						}
 						
 					}
 					
 					names(nb_repro) = id_diffusion_sl
 					L = c(list("id_diffusion" = id_diffusion_sl), list("nb_repro" = nb_repro))
 					return(L)
 				}
 				
 				OUT = lapply(point, function(x){fun(x)})
 				names(OUT) = point
 				
 				# 4.2. For each pair of seed-lots, find the last diffusion in common and calculate the distance ----------
 				M_dist = matrix(NA, ncol = length(point), nrow = length(point))
 				diag(M_dist) = 1
 				colnames(M_dist) = rownames(M_dist) = point
 				
 				liste_combi = combn(rownames(M_dist), 2)
 				
 				for(i in 1:ncol(liste_combi)) {
 					# sl1
 					sl1 = liste_combi[1,i]
 					farm1 = unlist(strsplit(sl1, "_"))[2]
 					out = OUT[[sl1]]
 					id_diffusion_sl1 = out$id_diffusion
 					nb_repro_sl1 = out$nb_repro
 					
 					# sl2
 					sl2 = liste_combi[2,i]
 					farm2 = unlist(strsplit(sl2, "_"))[2]
 					out = OUT[[sl2]]
 					id_diffusion_sl2 = out$id_diffusion
 					nb_repro_sl2 = out$nb_repro
 					
 					# Do seed-lots have their last diffusion event in common?
 					t1 = t2 = FALSE
 					if(!is.null(id_diffusion_sl1) & !is.null(id_diffusion_sl2) & !is.null(farm1) & !is.null(farm2)) { t1 = id_diffusion_sl1 == id_diffusion_sl2 ; t2 = farm1 != farm2} # They must be on different farms otherwise it is a non sens !
 					if(t1 & t2) { nb_repro = nb_repro_sl1 + nb_repro_sl2 } else { nb_repro = 0 } 
 					
 					M_dist[sl1, sl2] = nb_repro
 				}
 			} else { M_dist = NULL }
 			} 

 	d = list("network" = n, "network.info" = Minfo, "Mdist" = M_dist)
 	attributes(d)$shinemas2R.object = "network"
 	}
 	
 
 	# 5.2. SL.mix ----------
 	if(query.type == "SL.mix") { 
 		message("1. Query SHiNeMaS ...")
 		d = query.SL.mix(filter_G, filter_GT, filter_Y, filter_P, filter_SL, filter_Proj, info_db = info_db) 
 		attributes(d)$shinemas2R.object = "SL.mix"
 		}
 	
	# 5.3. cross ----------
	if(query.type == "cross") {
		message("1. Query SHiNeMaS ...")
		d = query.cross(filter_G, filter_GT, filter_Y, filter_P, filter_Proj, info_db = info_db)
		attributes(d)$shinemas2R.object = "cross"
	}

 	# 5.4. raw information on levels and variables present in SHiNeMaS ----------
	if( query.type == "species"){ d = query.species(info_db = info_db); attributes(d)$shinemas2R.object = "species"
} 	

	if( query.type == "variable"){ d = query.variable(info_db = info_db); attributes(d)$shinemas2R.object = "variable"
 }
 	if( query.type == "person"){ d = query.person(info_db = info_db); attributes(d)$shinemas2R.object = "person"
 }
 	if( query.type == "year"){ d = query.year(info_db = info_db); attributes(d)$shinemas2R.object = "year"
 }
 	if( query.type == "project"){ d = query.project(info_db = info_db); attributes(d)$shinemas2R.object = "project"
 }
 	if( query.type == "seed.lots"){ d = query.seed.lots(info_db = info_db); attributes(d)$shinemas2R.object = "seed.lots"
 }
 	if( query.type == "selection.person"){ d = query.selection.person(info_db = info_db); attributes(d)$shinemas2R.object = "selection.person"
 }
 	if( query.type == "reproduction.type"){ d = query.reproduction.type(info_db = info_db); attributes(d)$shinemas2R.object = "reproduction.type"
 }
 	if( query.type == "germplasm"){ d = query.germplasm(info_db = info_db); attributes(d)$shinemas2R.object = "germplasm"
 }
 	if( query.type == "germplasm.type"){ d = query.germplasm.type(info_db = info_db); attributes(d)$shinemas2R.object = "germplasm.type"
 }
 	

	# 5.5. data with variable on specific relation or seed-lots ----------	
	if(query.type == "data-classic") {
		if(data.type == "seed-lots") { message("1. Query SHiNeMaS ..."); d = query.data.seed_lots(filter_G, filter_GT, filter_Y, filter_P, filter_V, filter_SL, filter_Proj, info_db = info_db) }
		if(data.type == "relation") { message("1. Query SHiNeMaS ..."); d = query.data.relation(filter_G, filter_GT, filter_Y, filter_P, filter_R, filter_V, filter_SL, filter_Proj, info_db = info_db) }	
	}

	if(query.type == "data-S" | query.type == "data-SR") { 
		if(query.type == "data-S") { message("1. Query SHiNeMaS ..."); tab = query.S(info_db = info_db) }
		if(query.type=="data-SR") { message("1. Query SHiNeMaS ..."); tab = query.SR(info_db = info_db) }
		
		if(!is.null(tab)) {
			vec.seed_lots = tab[,"sl"]
			if(data.type == "seed-lots") { dv = query.data.seed_lots(filter_G, filter_GT, Y = filter_Y, filter_P, filter_R, filter_V, SL = get.filters(filter.in = vec.seed_lots, filter.out = NULL, filter.on = "son", sql.son.tag = "sl1.name", sql.father.tag = "sl2.name"), filter_Proj, info_db = info_db) } 
			if(data.type == "relation") { dv = query.data.relation(filter_G, filter_GT, Y = filter_Y, filter_P, filter_R, filter_V, SL = get.filters(filter.in = vec.seed_lots, filter.out = NULL, filter.on = "son", sql.son.tag = "sl1.name", sql.father.tag = "sl2.name"), filter_Proj, info_db = info_db) }
			
			tab = plyr::rename(tab, replace = c("sl" = "son"))
			if( !is.null(dv) ) { d = join(tab, dv, by = "son" ) } else { d = NULL }
			} else { d = NULL }
		}		

	# Set up datasets
	if( query.type == "data-classic" | query.type == "data-S" | query.type == "data-SR" ) {
		if( !is.null(unique(d$variable_name)[1]) ) { variable = unique(d$variable_name) }
		if( is.null(d) ) { variable = NULL }
		
			if( !is.null(d) & !is.null(variable)) {
			vec_variable = na.omit(unique(as.character(d$variable_name)))		
			
			if(length(vec_variable) != 0) { # If there are no variables, nothing is done
				message("2. Set up data set ...")	
											
				# All the data set for both data.type
				out_d = list(d)
				
				# Get subset of correlated variable for data.type = relation
				if(data.type == "relation") { 
					corr_gp = unique(as.character(d$correlation_group))
					corr_gp = corr_gp[!is.na(corr_gp)]
					corr_gp = corr_gp[which(corr_gp != "")]
					
					if( length(corr_gp) == 0 ) { out_corr = NULL } else {
						out_corr = list()
						for(corr in corr_gp){ out_corr = c(out_corr, list(NULL)) }
						names(out_corr) = corr_gp
						for(cg in corr_gp){	out_corr[[cg]] = d[grep(cg, d$correlation_group),] }
						} 
				}
				
				if(data.type == "seed-lots") { out_corr = NULL }
				
				# Arrange datasets
				arrange.data = function(data, data.type){
					if(!is.null(data)){
						# an ID is needed to get unicity
						# sl_name for data.type = "seed-lots"
						# son & son_ind & father for data.type = "relation"
						# expe for query.type = "S" or "SR"
						
						if(data.type == "relation") {
							data$ID = paste(as.character(data$sl_name), as.character(data$son), as.character(data$son_ind), as.character(data$expe), as.character(data$father), sep = "~") 
						}
						
						if(data.type == "seed-lots") { data$ID = as.character(data$sl) }
						
						data$var_meth = paste(data$variable_name, data$method_name, sep = "---")
						var_meth = unique(data$var_meth)
						
						if( is.element("NA---NA", var_meth) ) {
							data = data[-which(data$var_meth == "NA---NA"),]
							var_meth = var_meth[-which(var_meth == "NA---NA")]
						}
						
						D = select(data, -method_name, -variable_name, -raw_data, -var_meth, -raw_data_date)
						D = droplevels(D[!duplicated(D$ID),]) # In case there is redondant information. This is not possible with SHiNeMaS v1, but it occured in the dev version
		
						# In the following: *2 to take into account a column with the date				
						D = cbind.data.frame(D, matrix(NA, ncol = length(var_meth)*2, nrow = nrow(D))) 
						colnames(D)[(ncol(D) - length(var_meth)*2 + 1) : ncol(D)] = sort(c(var_meth, paste(var_meth, "date", sep = "$")))
						
						pb <- txtProgressBar(min = 0, max = length(var_meth), style = 3)
						for(j in 1:length(var_meth)) {
							v = var_meth[j]
							row = which(data$var_meth == v)
							data_tmp = droplevels(data[row,])
							id = data_tmp$ID
							{
							# In case there is redondant information. This is not possible with SHiNeMaS v1, but it occured in the dev version
							raw_data = as.character(data_tmp$raw_data[which(!duplicated(id))])
							raw_data_date = as.character(data_tmp$raw_data_date[which(!duplicated(id))])
							id = as.character(id[which(!duplicated(id))])
							}
							
							D[which(D$ID %in% id), v] = raw_data
							D[which(D$ID %in% id), paste(v, "$date", sep= "")] = raw_data_date
							setTxtProgressBar(pb, j)
						}
						if(data.type == "relation") { D = select(D, -ID, -correlation_group) }
						if(data.type == "seed-lots") { D = select(D, -ID) }
						cat("\n")
					} else { D = NULL }
					return(D)
				}
				
				d1 = lapply(out_d, arrange.data, data.type); if(length(d1) == 0) { d1 = NULL }
				d2 = lapply(out_corr, arrange.data, data.type); if(length(d2) == 0) { d2 = NULL }
				
				out.d = list("data" = d1[[1]], "data.with.correlated.variables" = d2)
				
				# description of methods
				filter_V = V.sql(vec_variable)
				m = query.methods(filter_V, info_db = info_db)
				m$"variable---methods" = paste(m$variable_name, m$method_name, sep = "---")
				m = list("methods" = m)
				
				d = c(out.d, m)
				
				if(query.type == "data-classic" & data.type == "seed-lots") { attributes(d)$shinemas2R.object = "data-classic-seed-lots" }
				if(query.type == "data-classic" & data.type == "relation") { attributes(d)$shinemas2R.object = "data-classic-relation" }
				if(query.type == "data-S"& data.type == "seed-lots") { attributes(d)$shinemas2R.object = "data-S-seed-lots" }
				if(query.type == "data-S"& data.type == "relation") { attributes(d)$shinemas2R.object = "data-S-relation" }
				if(query.type == "data-SR"& data.type == "seed-lots") { attributes(d)$shinemas2R.object = "data-SR-seed-lots" }
				if(query.type == "data-SR"& data.type == "relation") { attributes(d)$shinemas2R.object = "data-SR-relation" }
		}	
		}
	}



# 5.6. data on methods ----------	
if(query.type == "methods") {
	message("1. Query SHiNeMaS ...")
	d = query.methods(filter_V, info_db = info_db)
	attributes(d)$shinemas2R.object = "methods"
	}

# 5.7. query.person.info ----------
if(query.type == "person.info") {
	message("1. Query SHiNeMaS ...")
	d = query.person.info(filter_P, info_db = info_db)
	attributes(d)$shinemas2R.object = "person.info"
}

# 5.8. query.grand.father ----------
if(query.type == "grandfather") {
	message("1. Query SHiNeMaS ...")
	d = query.grand.father(filter_G, filter_GT, filter_Y, filter_P, filter_SL, filter_Proj, info_db = info_db)
	attributes(d)$shinemas2R.object = "grandfather"
}

# 6. Return results ----------
d = list("data" = d, "info_db" = info_db)
return(d)
}

