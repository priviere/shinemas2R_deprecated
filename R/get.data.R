# 0. help -----------------------------------------------------------------
#' Query SHiNeMaS and return the datasets
#'
#' @description
#' \code{get.data} queries SHiNeMaS and return the data-sets.
#'
#' @param db_user user name of SHiNeMaS
#' 
#' @param db_host IP adress of the computer where SHiNeMaS is!, If local host db_host = "127.0.0.1"
#' 
#' @param db_name name fo the data base
#' 
#' @param db_password your password to login. If no password is needed, put ""
#'
#' @param query.type Type of query, which will create a data set. There are five types: 
#' \enumerate{
#' 
#' \item "network": network relations between seed-lots
#' 
#' \item "SL.mix": seed-lots merged from replications and not from 'real' mixture
#' 
#' \item "cross": seed-lots used to give a cross: father, grandfather, mother, grandmother and cross.
#' 
#' \item raw information on levels and variables present in SHiNeMaS :
#' \itemize{
#' \item "variable"
#' \item "person"
#' \item "year"
#' \item "project"
#' \item "seed.lot"
#' \item "selection.person": persons that did intra-varietal mass selection
#' \item "reproduction.type"
#' \item "germplasm.type"
#' \item "germplasm"
#' }
#' 
#' \item data with variable on specific seed-lots :
#' \itemize{
#' \item "data-classic": default dataframe
#' \item "data-S": selection differential for a given year.
#' \item "data-SR": seed-lots pairs of selection differential for year n-1 and response to selection for year n.
#' }
#' 
#' \item "methods": information related to methods used for each variable in SHiNeMaS with its description and units. Filters can be applied on variables.
#' 
#' }
#' 
#' @param fill.diffusion.gap For query.type = "network", create a network with no gaps between seed-lots (as long as there is information!)
#' 
#' @param network.info For query.type = "network", if TRUE, aggregate information on relation and seed-lots on the network.
#' 
#' @param Mdist For query.type = "network", if TRUE, compute the Mdist matrix. See details.
#' 
#' @param data.type For queries in "data-", type of data: "relation" for data linked to relation between seed lots and "seed-lots" for data linked to seed lots
#' 
#' @param filter.on This argument is needed for filters for queries in "network", data-" and "data.type" = data.relation. It chooses on which seed-lots the filters is applied: "son", "father" or "father-son".
#' 
#' @param germplasm.in Filter: vector with germplasms to keep. By default, all the germplasms are in.
#' @param germplasm.out Filter: vector with germplasms to discard. By default, no germplasms are out.
#' 
#' @param germplasm.type.in Filter: vector with germplasms to keep. By default, all the germplasm types are in.
#' @param germplasm.type.out Filter: vector with germplasms to discard. By default, no germplasm types are out.
#' 
#' @param year.in Filter: vector with years to keep. By default, all the years are in.
#' @param year.out Filter: vector with years to discard. By default, no years are out.
#' 
#' @param project.in Filter: vector of projects to keep. By default, all the projects are in.
#' @param project.out Filter: vector of projects to discard. By default, no projects are out.
#' 
#' @param person.in Filter: vector of persons to keep. By default, all the persons are in.
#' @param person.out Filter: vector of persons to discard.  By default, no persons are out.
#' 
#' @param seed.lot.in Filter: vector of seed-lots to keep. By default, all the seed-lots are in.
#' @param seed.lot.out Filter: vector of seed-lots to discard. By default, on seed-lots are out.
#' 
#' @param relation.in Filter on a relation to keep: "reproduction", "mixture", "selection" or "diffusion". By default, all relations are in.
#' 
#' @param reproduction.type.in Filter on reproduction types
#' 
#' @param variable.in Filter: vector with variables to keep. If NULL, all variables in SHiNeMaS are displayed.
#' 
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
#' The query "data-SR" takes into account when selection have been done in a seed lot, that this seed lot have been merged and then have been sown. It is the case when selection have been carried out in a replication that have been merge after. Even if this case should not arrise, it may happen.
#' 
#' 
#' \item Query "network"
#' 
#' The Mdist square matrix can be compared to a differenciation distance. It can be put in relation with genetic Fst for example.
#' 
#' \item Correlated data or not
#' Note that for data linked to seed-lots, all the data are correlated as there is one measure for a given seed-lot. 
#' Therefore the element of the list for non correlated data is always NULL.
#' For data linked to relations, as it can be linked to individual within a seed-lot, data may be correlated (data taken on ther same individual) or not.
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
#' \item the netwok object
#' \item the network.info matrix with information on relation in the network
#' \item the Mdist square matrix with the number of reproductions that separate two seed-lots since their last common diffusion.
#' }
#' 
#' \item For SL.mix, it returns a data frame with seed-lots son (i.e. coming from the mixture), seed-lots father, germplasm, person, year and project
#' 
#' \item For raw information on levels and variables present in SHiNeMaS it returns a vector
#' 
#' \item For data with variable on specific seed-lots it returns a list with
#' \itemize{
#' 		\item the data set with correlated variables
#' 		\item the data set with non correlated variables
#' 		\item the description of methods used for each variable in with its description and units
#' 		}
#' }
#' 
#' \item information to connect to SHiNeMaS
#' }
#' 
#' 
#' @author Pierre Riviere for R code and Yannick de Oliveira for SQL code 
#' 
#' @seealso \code{\link{encrypt.data}}, \code{\link{translate.data}},, \code{\link{get.ggplot}}, \code{\link{get.table}}
#' 
#' 
get.data <- function(
db_user = "pierre",
db_host = "127.0.0.1",
db_name = "shinemas",
db_password = "pierre",
query.type = "person",
fill.diffusion.gap = FALSE,
network.info = TRUE,
Mdist = FALSE,
data.type = NULL,
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
variable.in = NULL
)

# lets go !!! ----
{
	
	# !!!!!!!! En attendant que les projets soient liés aux relations -------------------	
	if( is.null(project.in) )  { message('ATTENTION !!! en attendant que les projets soient liées aux relations, il faut bien définir un projet sinon ça le fait pas !!!')}
	
	
# 1. Check parameters ----------

if(!is.element(query.type, c("network", "data-classic", "data-S", "data-SR", "SL.mix", "cross", "variable", "person", "year", "project", "seed.lots", "selection.person", "reproduction.type", "germplasm.type", "germplasm", "methods")))  { 	stop("query.type must be \"network\", \"data-classic\", \"data-S\", \"data-SR\", \"SL.mix\", \"cross\", \"variable\", \"person\", \"year\", \"project\", \"seed.lots\", \"selection.person\", \"reproduction.type\", \"germplasm.type\", \"germplasm\" or \"methods\".") }

test = c(germplasm.in, germplasm.out, germplasm.type.in, germplasm.type.out, year.in, year.out, project.in, project.out, person.in, person.out, seed.lot.in, seed.lot.out, relation.in, reproduction.type.in, variable.in)
if(is.element(query.type, c( "variable", "person", "year", "project", "seed.lots", "selection.person", "reproduction.type", "germplasm.type", "germplasm")) & !is.null(test)) { stop("You can not use a filter on raw information on levels and variables.") }


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

if( !is.null(test[1]) & is.null(filter.on) & query.type != "methods") { stop("With a filter, you must set filter.on: \"son\", \"father\" or \"father-son\".") }


if( is.null(data.type) & length(grep("data-", query.type)) > 0 ) { stop("With query.type in \"data-\", data.type must not be NULL. data.type can be \"relation\" or \"seed-lots\".")
	}


if(!is.null(data.type)){

	if(!is.element(data.type, c("relation", "seed-lots"))) { 	stop("data.type must be \"relation\" or \"seed-lots\"") }	

if( data.type == "relation" & is.null(filter.on) ){ stop("filter.on must be set: either \"son\" \"father\" or \"father-son\"") }

if( data.type == "seed-lots" & is.null(filter.on)){ filter.on = "son" } # To be ok with filters
}

if(!is.null(filter.on)){
if(!is.element(filter.on, c("son", "father", "father-son")))  { stop("filter.on must be \"son\", \"father\" or \"father-son\".") }
}

if(!is.null(relation.in)){
if( !is.element(relation.in, c("reproduction", "mixture", "selection", "diffusion")) )  { stop("relation.in must be \"reproduction\", \"mixture\", \"selection\" or \"diffusion\".") }
}


# 2. Connection to SHiNeMaS ----------
info_db = list("db_user" = db_user, "db_host" = db_host, "db_name" = db_name, "db_password" = db_password)
# function to get data from a query
get.d = function(requete, info_db) {
	
	# call driver which handle the connexion
	drv = dbDriver("PostgreSQL") 
	
	# create the connexion
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

query.variable = function(){
	d = get.d("SELECT DISTINCT name FROM eppdata_env_pra_phe_variable", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}

query.person = function(){
	d = get.d("SELECT short_name FROM actors_person", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}

query.year = function(){
	d = get.d("SELECT DISTINCT(date) FROM entities_seed_lot ORDER BY date", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}


query.project = function(){
	d = get.d("SELECT project_name FROM actors_project", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)	
}


query.seed.lots = function(){
	d = get.d("SELECT name FROM entities_seed_lot", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)		
}

query.selection.person = function(){
	d = get.d("SELECT DISTINCT(short_name) FROM network_selection sel LEFT OUTER JOIN actors_person p ON sel.person_id = p.id", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}

query.reproduction.type = function(){
	d = get.d("SELECT reproduction_methode_name FROM network_reproduction_method", info_db)
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}

query.germplasm = function(){
	d = get.d("SELECT gp.germplasm_name FROM entities_germplasm gp", info_db)	
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}


query.germplasm.type = function(){
	d = get.d("SELECT germplasm_type FROM entities_germplasm_type", info_db)	
	out = sort(unlist(d)); names(out) = NULL	
	return(out)
}


query.network = function( P = NULL, G = NULL, GT = NULL, Y = NULL, R = NULL, SL = NULL, Proj = NULL) {
if( !is.null ( c(G, Y, P, R, SL, Proj)[1]) ) { w = " WHERE" } else { w = NULL }
if( !is.null(R[1]) ) { if(length(grep("nr.reproduction_id", R[1])) == 1) { w = " WHERE nr.selection_id IS NULL "} }

query = 
paste("
SELECT 

sl1.name AS son, gp1.germplasm_name AS son_germplasm, gpt1.germplasm_type AS son_germplasm_type, sl1.date AS son_year, p1.short_name AS son_person, l1.altitude AS son_alt, l1.longitude AS son_long, l1.latitude AS son_lat, pro1.project_name AS son_project,

sl2.name AS father, gp2.germplasm_name AS father_germplasm, gpt2.germplasm_type AS father_germplasm_type, sl2.date AS father_year, p2.short_name AS father_person, l2.altitude AS father_alt, l2.longitude AS father_long, l2.latitude AS father_lat, pro2.project_name AS father_project,

nr.is_male, nr.block, nr.reproduction_id AS reproduction_id, nrm.reproduction_methode_name AS reproduction_type, nr.selection_id AS selection_id, psel.short_name AS selection_person, nr.mixture_id AS mixture_id, nr.diffusion_id AS diffusion_id
	
FROM network_relation nr
LEFT OUTER JOIN network_selection sel ON nr.selection_id = sel.id 
LEFT OUTER JOIN actors_person psel ON sel.person_id = psel.id 
LEFT OUTER JOIN network_reproduction rep ON nr.reproduction_id = rep.id 
LEFT OUTER JOIN network_reproduction_method nrm ON rep.reproduction_method_id = nrm.id
LEFT OUTER JOIN entities_seed_lot sl1 ON nr.seed_lot_son_id=sl1.id 
LEFT OUTER JOIN entities_seed_lot sl2 ON nr.seed_lot_father_id=sl2.id
LEFT OUTER JOIN entities_germplasm gp1 ON sl1.germplasm_id=gp1.id
LEFT OUTER JOIN entities_germplasm gp2 ON sl2.germplasm_id=gp2.id
LEFT OUTER JOIN entities_germplasm_type gpt1 ON gp1.germplasm_type_id=gpt1.id
LEFT OUTER JOIN entities_germplasm_type gpt2 ON gp2.germplasm_type_id=gpt2.id
LEFT OUTER JOIN actors_person p1 ON sl1.person_id=p1.id
LEFT OUTER JOIN actors_person p2 ON sl2.person_id=p2.id
LEFT OUTER JOIN actors_location l1 ON p1.location_id = l1.id
LEFT OUTER JOIN actors_location l2 ON p2.location_id = l2.id
LEFT OUTER JOIN entities_seed_lot_project eslp1 ON sl1.id = eslp1.seed_lot_id
LEFT OUTER JOIN entities_seed_lot_project eslp2 ON sl2.id = eslp2.seed_lot_id
LEFT OUTER JOIN actors_project pro1 ON eslp1.project_id = pro1.id
LEFT OUTER JOIN actors_project pro2 ON eslp2.project_id = pro2.id",
	
w,
G,
Y,
P,
R,
SL,
Proj, sep = "")

d = get.d(query, info_db)

if(nrow(d) > 0) {
	d$son = as.factor(d$son)
	d$son_germplasm = as.factor(d$son_germplasm)
	d$son_germplasm_type = as.factor(d$son_germplasm_type)
	d$son_year = as.factor(d$son_year)
	d$son_person = as.factor(d$son_person)
	d$son_alt = as.numeric(as.character(d$son_alt))
	d$son_long = as.numeric(as.character(d$son_long))
	d$son_lat = as.numeric(as.character(d$son_lat))
	d$son_project = as.factor(d$son_project)
	d$father = as.factor(d$father)
	d$father_germplasm = as.factor(d$father_germplasm)
	d$father_germplasm_type = as.factor(d$father_germplasm_type)
	d$father_year = as.factor(d$father_year)
	d$father_person = as.factor(d$father_person)
	d$father_alt = as.numeric(as.character(d$father_alt))
	d$father_long = as.numeric(as.character(d$father_long))
	d$father_lat = as.numeric(as.character(d$father_lat))
	d$father_project = as.factor(d$father_project)
	d$is_male = as.factor(d$is_male)
	d$block = as.factor(d$block)
	d$reproduction_id = as.character(d$reproduction_id)
	d$reproduction_type = as.factor(d$reproduction_type)
	d$selection_id = as.character(d$selection_id)
	d$selection_person = as.factor(d$selection_person)
	d$mixture_id = as.character(d$mixture_id)
	d$diffusion_id = as.character(d$diffusion_id)	
	} else { d = NULL }

return(d)
}


query.data.seed_lots = function(G = NULL, GT = NULL, Y = NULL, P = NULL, V = NULL, SL = NULL, Proj = NULL) {
if( !is.null (c(G, GT, Y, P, V, SL, Proj)[1]) ) { w = " WHERE" } else { w = NULL }

query = 
paste("
SELECT sl1.name AS sl, sl1.date AS year, gp1.germplasm_name AS germplasm, gpt1.germplasm_type AS germplasm_type, p1.short_name AS person,v1.name AS variable_name,rd.raw_data, met.method_name, met.quali_quanti_notes, pro1.project_name AS project

FROM entities_seed_lot sl1 
LEFT OUTER JOIN eppdata_env_pra_phe_raw_data_seed_lot dr ON sl1.id = dr.seed_lot_id 
LEFT OUTER JOIN eppdata_env_pra_phe_raw_data rd ON dr.env_pra_phe_raw_data_id = rd.id 
LEFT OUTER JOIN eppdata_env_pra_phe_method met ON rd.method_id=met.id
LEFT OUTER JOIN eppdata_env_pra_phe_variable v1 ON rd.variable_id = v1.id
LEFT OUTER JOIN entities_seed_lot_project eslp ON sl1.id = eslp.seed_lot_id 
LEFT OUTER JOIN actors_project pro1 ON eslp.project_id = pro1.id
LEFT OUTER JOIN entities_germplasm gp1 ON sl1.germplasm_id = gp1.id
LEFT OUTER JOIN entities_germplasm_type gpt1 ON gp1.germplasm_type_id=gpt1.id
LEFT OUTER JOIN actors_person p1 ON sl1.person_id=p1.id",

w,
G,
Y,
P,
V,
SL,
Proj, sep = "")

d = get.d(query, info_db)
if(nrow(d) > 0) {
	d$sl = as.factor(d$sl)
	d$year = as.factor(d$year)
	d$germplasm = as.factor(d$germplasm)
	d$person = as.factor(d$person)
	d$variable_name = as.character(d$variable_name)
	d$raw_data = as.character(d$raw_data)
	d$method_name = as.factor(d$method_name)
	d$quali_quanti_notes = as.factor(d$quali_quanti_notes)
	d$project = as.factor(d$project)
	} else { d = NULL }

return(d)
}


query.data.relation = function(G = NULL, GT = NULL, Y = NULL, P = NULL, R = NULL, V = NULL, SL = NULL, Proj = NULL) {
if( !is.null (c(G,Y,P,R,V,SL,Proj)[1]) ) { w = " WHERE" } else { w = NULL }
if( !is.null(R[1]) ) { if(length(grep("nr.reproduction_id", R[1]))) { w = " WHERE nr.selection_id IS NULL "} }

query = paste("	
SELECT sl1.name AS son,rd1.individual AS son_ind, sl1.date AS son_year, gp1.germplasm_name AS son_germplasm, gpt1.germplasm_type AS son_germplasm_type, p1.short_name AS son_person, l1.altitude AS son_alt, l1.longitude AS son_long, l1.latitude AS son_lat,
		
sl2.name AS father, sl2.date AS father_year, gp2.germplasm_name AS father_germplasm, gpt2.germplasm_type AS father_germplasm_type, p2.short_name AS father_person, l2.altitude AS father_alt, l2.longitude AS father_long, l2.latitude AS father_lat,

v1.name AS variable_name,rd1.raw_data, met1.method_name, met1.quali_quanti_notes,
nr.reproduction_id AS reproduction_id, nrm1.reproduction_methode_name AS reproduction_type, nr.selection_id AS selection_id, psel1.short_name AS selection_person, nr.mixture_id AS mixture_id, nr.diffusion_id AS diffusion_id, 
nr.\"X\", nr.\"Y\", nr.block, 
pro1.project_name AS project
		
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

LEFT OUTER JOIN entities_seed_lot sl2 ON nr.seed_lot_father_id=sl2.id
LEFT OUTER JOIN entities_germplasm gp2 ON sl2.germplasm_id = gp2.id
LEFT OUTER JOIN entities_germplasm_type gpt2 ON gp2.germplasm_type_id = gpt2.id
LEFT OUTER JOIN actors_person p2 ON sl2.person_id=p2.id
LEFT OUTER JOIN actors_location l2 ON p2.location_id = l2.id
		
LEFT OUTER JOIN network_relation relfat ON nr.seed_lot_father_id = relfat.seed_lot_son_id
LEFT OUTER JOIN entities_seed_lot slf ON relfat.seed_lot_father_id = slf.id
LEFT OUTER JOIN entities_germplasm gpf ON slf.germplasm_id = gpf.id
LEFT OUTER JOIN actors_person pf ON slf.person_id = pf.id

LEFT OUTER JOIN eppdata_env_pra_phe_raw_data_relation dr1 ON nr.id = dr1.relation_id
LEFT OUTER JOIN eppdata_env_pra_phe_raw_data rd1 ON dr1.env_pra_phe_raw_data_id = rd1.id
LEFT OUTER JOIN eppdata_env_pra_phe_variable v1 ON rd1.variable_id = v1.id
LEFT OUTER JOIN eppdata_env_pra_phe_method met1 ON rd1.method_id=met1.id
		
LEFT OUTER JOIN entities_seed_lot_project eslp1 ON sl1.id = eslp1.seed_lot_id
LEFT OUTER JOIN actors_project pro1 ON eslp1.project_id = pro1.id ",
		
w,
G,
Y,
P,
R,
V,
SL,
Proj, sep = "")

d = get.d(query, info_db)

if( nrow(d) > 0 ) {
	d$son = as.factor(d$son)
	d$son_ind = as.factor(d$son_ind)
	d$son_year = as.factor(d$son_year)
	d$son_germplasm = as.factor(d$son_germplasm)
	d$son_germplasm_type = as.factor(d$son_germplasm_type)
	d$son_person = as.factor(d$son_person)
	d$son_alt = as.numeric(d$son_alt)
	d$son_long = as.numeric(d$son_long)
	d$son_lat = as.numeric(d$son_lat)
	d$father = as.factor(d$father)
	d$father_year = as.factor(d$father_year)
	d$father_germplasm = as.factor(d$father_germplasm)
	d$father_germplasm_type = as.factor(d$father_germplasm_type)
	d$father_person = as.factor(d$father_person)
	d$father_alt = as.numeric(d$father_alt)
	d$father_long = as.numeric(d$father_long)
	d$father_lat = as.numeric(d$father_lat)
	d$variable_name = as.character(d$variable_name)
	d$raw_data = as.character(d$raw_data)
	d$method_name = as.factor(d$method_name)
	d$quali_quanti_notes = as.factor(d$quali_quanti_notes)
	d$reproduction_id = as.character(d$reproduction_id)
	d$reproduction_type = as.factor(d$reproduction_type)
	d$selection_id = as.character(d$selection_id)
	d$selection_person = as.factor(d$selection_person)
	d$mixture_id = as.character(d$mixture_id)
	d$diffusion_id = as.character(d$diffusion_id)
	d$X = as.factor(d$X)
	d$Y = as.factor(d$Y)
	d$block = as.factor(d$block)
	d$project  = as.factor(d$project)
	
	d = d[order(d$son, d$son_ind), ] 
	} else { d = NULL }

return(d)
}


query.cross = function(G = NULL, GT = NULL, Y = NULL, P = NULL, Proj = NULL) {

query = paste(
"SELECT 
sl10.name AS father, gp10.germplasm_name AS father_germplasm, gpt10.germplasm_type AS father_germplasm_type, p10.short_name AS father_person, sl10.date AS father_year, pro10.project_name AS father_project, l10.altitude AS father_alt, l10.longitude AS father_long, l10.latitude AS father_lat, 

sl3.name AS grandfather, gp3.germplasm_name AS grandfather_germplasm, gpt3.germplasm_type AS grandfather_germplasm_type, p3.short_name AS grandfather_person,  sl3.date AS grandfather_year, pro3.project_name AS grandfather_project, l3.altitude AS grandfather_alt, l3.longitude AS grandfather_long, l3.latitude AS grandfather_lat, 

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

LEFT OUTER JOIN entities_seed_lot_project eslp ON sl1.id = eslp.seed_lot_id
LEFT OUTER JOIN actors_project pro1 ON eslp.project_id = pro1.id
LEFT OUTER JOIN actors_project pro2 ON eslp.project_id = pro2.id
LEFT OUTER JOIN actors_project pro3 ON eslp.project_id = pro3.id
LEFT OUTER JOIN actors_project pro4 ON eslp.project_id = pro4.id
LEFT OUTER JOIN actors_project pro10 ON eslp.project_id = pro10.id

WHERE r1.seed_lot_father_id <> r2.seed_lot_father_id AND r1.reproduction_id IS NOT NULL AND r1.is_male = 'M'",

G, 
Y, 
P, 
Proj,
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


query.S = function(Y) {

query = paste("
SELECT sl1.name AS vrac_S, sl2.name AS bouquet_S

FROM network_relation nr

LEFT JOIN network_relation nrsel ON (nr.seed_lot_father_id = nrsel.seed_lot_father_id AND nr.reproduction_id = nrsel.reproduction_id)
LEFT JOIN entities_seed_lot sl1 ON nr.seed_lot_son_id = sl1.id
LEFT JOIN entities_seed_lot sl2 ON nrsel.seed_lot_son_id = sl2.id

WHERE nrsel.selection_id IS NOT NULL AND nr.reproduction_id IS NOT NULL AND nr.selection_id IS NULL ",

Y, sep="")

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


query.SR = function(year.in) {

	# special format for year
if( !is.null(year.in) ) {
	Y = paste( "(sl3.date=", year.in, " AND sl4.date=", year.in, ")", sep = "" )
	Y = paste( Y, collapse = " OR ")
	Y = paste( " AND (", Y, ")", sep = "" )
	} else { Y = NULL}

query = paste("
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
nr2.selection_id IS NULL",
Y, sep = "")

d1 = get.d(query, info_db)

# special query when selection have been done in a seed-lot that have been merged after ...
query = paste("
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
(nr.\"Y\" = nrsel.\"Y\" OR (nr.\"Y\" IS NULL AND nr.\"Y\" IS NULL))",
Y, sep = "")

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
		
		# 2eme vérif : si dans le meme bloc : coordonnées la plus proche : lettre la plus proche et chiffre le plus proche = chemin le plus court
		

# !!!!! gérer si X et Y sont des lettres ou des chiffres !!!! tran --------
# transférer tt en lettres. Du coup X et Y ne peuvent etre que de slettres ou des chiffres. *

# cf avec les histoires de X et Y avec SandR : c'est ok dans notre cas mais pas générique ... le virer ?!? faire un truc + souple ?

		
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
#print(head(d1))
#print(head(d2))


d = rbind(d1,d2)[,1:4]

if(nrow(d) > 0)  { 
	d = cbind.data.frame(
											"sl" = c(d$vrac_s, d$bouquet_s, d$vrac_r, d$bouquet_r), 											
											"sl_stat"= rep( c("vracS", "bouquetS", "vracR", "bouquetR"), each = nrow(d) ),
											"expe"= rep( seq(1, nrow(d), 1), times = ncol(d) )
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
		toto = subset(expinfo, ok %in% liste[i])
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
	
	d$expe_name = name.exp.1[as.character(d$exp)]	
	d$expe_name_2 = name.exp.2[as.character(d$expe)]	

	d$sl = as.factor(d$sl)
	d$sl_statut = as.factor(d$sl_statut)
	d$expe = as.factor(d$expe)
	d$expe_name = as.factor(d$expe_name)
	d$expe_name_2 = as.factor(d$expe_name_2)
	
	} else { d = NULL }

return(d)
}


query.SL.mix = function(G = NULL, GT = NULL, Y = NULL, P = NULL, SL = NULL, Proj = NULL) {
query = paste(
"SELECT DISTINCT sl1.name AS son, gp1.germplasm_name AS son_germplasm, gpt1.germplasm_type AS son_germplasm_type, p1.short_name AS son_person , sl1.date AS son_year, pro1.project_name AS son_project,

sl2.name AS father, gp2.germplasm_name AS father_germplasm, gpt2.germplasm_type AS father_germplasm_type, p2.short_name AS father_person, sl2.date AS father_year, pro2.project_name AS father_project

FROM network_relation nr2 JOIN entities_seed_lot sl2 ON nr2.seed_lot_father_id=sl2.id

LEFT OUTER JOIN network_relation nr1 ON nr2.seed_lot_son_id=nr1.seed_lot_father_id		
LEFT OUTER JOIN entities_seed_lot sl1 ON nr1.seed_lot_son_id = sl1.id

LEFT OUTER JOIN entities_germplasm gp1 ON sl1.germplasm_id = gp1.id
LEFT OUTER JOIN entities_germplasm gp2 ON sl2.germplasm_id = gp2.id
LEFT OUTER JOIN entities_germplasm_type gpt1 ON gp1.germplasm_type_id = gpt1.id
LEFT OUTER JOIN entities_germplasm_type gpt2 ON gp2.germplasm_type_id = gpt2.id
LEFT OUTER JOIN actors_person p1 ON sl1.person_id = p1.id
LEFT OUTER JOIN actors_person p2 ON sl2.person_id = p2.id
LEFT OUTER JOIN entities_seed_lot_project eslp1 ON sl1.id = eslp1.seed_lot_id
LEFT OUTER JOIN actors_project pro1 ON eslp1.project_id = pro1.id
LEFT OUTER JOIN entities_seed_lot_project eslp2 ON sl2.id = eslp2.seed_lot_id
LEFT OUTER JOIN actors_project pro2 ON eslp2.project_id = pro2.id
				
WHERE
nr1.mixture_id IS NOT NULL AND
sl1.germplasm_id = sl2.germplasm_id",

G,
Y,
P,
SL,
Proj, sep = "")

d = get.d(query, info_db)

if( nrow(d) > 0 ) {
d$son = as.factor(d$son)
d$son_germplasm = as.factor(d$son_germplasm)
d$son_germplasm_type = as.factor(d$son_germplasm_type)
d$son_person = as.factor(d$son_person)
d$son_year = as.factor(d$son_year)
d$son_project = as.factor(d$son_project)

d$father = as.factor(d$son)
d$father_germplasm = as.factor(d$father_germplasm)
d$father_germplasm_type = as.factor(d$father_germplasm_type)
d$father_person = as.factor(d$father_person)
d$father_year = as.factor(d$father_year)
d$father_project = as.factor(d$father_project)
}

return(d)
}


query.grandparents = function(G = NULL, GT = NULL, Y = NULL, P = NULL, SL = NULL, Proj = NULL) { # A AJOUTER

	}


query.methods = function(V = NULL){

if( !is.null (V) ) { w = " WHERE" } else { w = NULL }

query = paste(
"SELECT DISTINCT m.method_name AS method_name, v1.name AS variable_name, m.method_description ,m.unit 
FROM eppdata_env_pra_phe_raw_data d 
INNER JOIN eppdata_env_pra_phe_method m ON d.method_id=m.id 
INNER JOIN eppdata_env_pra_phe_variable v1 ON d.variable_id=v1.id",

w,
V, sep = "")

d = get.d(query, info_db)

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
	vec.variable.names = query.variable()
	update.error.messages(variable.in, vec.variable.names)		
}

if( !is.null(person.in) | !is.null(person.in) ){ 
	vec.person.names = query.person() 
	update.error.messages(person.in, vec.person.names)
	update.error.messages(person.out, vec.person.names) 
}

if( !is.null(year.in) | !is.null(year.in) ){
	vec.years = query.year()
	update.error.messages(year.in, vec.years)
	update.error.messages(year.out, vec.years)	
}

if( !is.null(project.in) | !is.null(project.in) ){
	vec.project.names = query.project()
	update.error.messages(project.in, vec.project.names)
	update.error.messages(project.out, vec.project.names)
}

if( !is.null(seed.lot.in) |  !is.null(seed.lot.out)){
	vec.seed_lots = query.seed.lots()
	update.error.messages(seed.lot.in, vec.seed_lots)
	update.error.messages(seed.lot.out, vec.seed_lots)
}

if( !is.null(reproduction.type.in) ){
	vec.reproduction.type = query.reproduction.type()
	update.error.messages(reproduction.type.in, vec.reproduction.type)
}

if( !is.null(germplasm.in) | !is.null(germplasm.out) ){
	vec.germplasm.names = query.germplasm()
	update.error.messages(germplasm.in, vec.germplasm.names)
	update.error.messages(germplasm.out, vec.germplasm.names)	
}

if( !is.null(germplasm.type.in) | !is.null(germplasm.type.out)){
	vec.germplasm.type = query.germplasm.type()	
	update.error.messages(germplasm.type.in, vec.germplasm.type)
	update.error.messages(germplasm.type.out, vec.germplasm.type)
}


# 4.2. get filters --------------------------------------------------------

get.filters = function(filter.in, filter.out, filter.on, sql.son.tag, sql.father.tag) {
	yo = function(P1, P2, filter.on) # P because it has been created based on person example
	{
		P1 = paste(P1, collapse = " OR ")
		P2 = paste(P2, collapse = " OR ")
		if( filter.on == "son" ) { P = paste(" AND (", P1, ")", sep = "") }
		if( filter.on == "father" ) { P = paste(" AND (", P2, ")", sep = "") }
		if( filter.on == "father-son" ) {	P = paste(" AND ((", P1,") OR (", P2, "))", sep = "") }	
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

filter_Proj = get.filters(filter.in = project.in, filter.out = project.out, filter.on, sql.son.tag = "pro1.project_name", sql.father.tag = "pro1.project_name")
cat("ATTENTION, à changer en pro2 quand les projets seront reliés aux relations ... \n")


# 4.2.7. relation ---------------------------------------------------------
R.sql = function(relation) {
	if( !is.null(relation) ) {
		R = paste("nr.", relation, "_id IS NOT NULL", sep = "")
		R = paste(R, collapse = " OR ")
		R = paste(" AND (", R, ")", sep = "")
	} else {R = NULL}
	return(R)
}
filter_R = R.sql(relation.in)

# 4.2.8. variable ---------------------------------------------------------
V.sql = function(variable) {
	if( !is.null(variable) ) {
		V = paste("v1.name='", variable, "'", sep = "")
		V = paste(V, collapse = " OR ")
		V = paste(" AND (", V, ")", sep = "")
	} else {V = NULL}
	return(V)
}
filter_V = V.sql(variable.in)


# 5. Get data from queries ------------------------------------------------

	# 5.1. network ----------	
 	if(query.type == "network") {	
 		message("1. Query SHiNeMaS ...")
 		reseau = query.network(filter_P, filter_G, filter_GT, filter_Y, filter_R, filter_SL, filter_Proj)
 		
 		reseau$generation = sample( c(1:8), nrow(reseau), replace = TRUE) # !!!!!! Ajouter nb generation. cf yannick ---------------
 		 		
 		message("2. Create network matrix ..."); {
 
 			# fill diffusion gap
 			fill.diff.gap = function(reseau){
 				message("2.1. Fill diffusion gaps ...")
 				RESEAU = query.network(P = NULL, G = NULL, Y = NULL, R = NULL, SL = NULL, Proj = NULL)
 				RESEAU$generation = sample( c(1:8), nrow(RESEAU), replace = TRUE) # !!!!!! Ajouter nb generation. cf yannick ---------------
 				
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
 				M[Father, Son] = 1 + M[Father, Son] # en colonne vers la ligne
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
 			D_generation = unique(DD[,c("father", "son", "generation")])
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
 				if(!is.na(r)) {type = "reproduction"
 											 f = D_generation[which(D_generation$toto == paste(Father, Son, sep=":")), "generation"]
 											 f = f[1] # !!!!!!!!!!! virer quand les projets seront liés aux relations, normalement, un seul élément !				 
 											 generation = paste("F", f, sep = "") }
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
 				
 				# get rid of replications, i.e. seed-lot father and son have the same germplasm in a mixture
 				toget = which((as.character(reseau$son_germplasm) == as.character(reseau$father_germplasm)) & !is.na(reseau$mixture_id) )
 				if( length(toget) > 0) { reseau = reseau[-toget, ] }
 				
 				# update point with the updated reseau without mixture for replication event
 				point = unique(c(as.character(reseau[,"father"]), as.character(reseau[,"son"])))
 				
 				# These datas are also useful for part 4. with Mdist
 				repro = filter(reseau, !is.na(reproduction_id))
 				reseau_repro = filter(repro, is.na(selection_id))
 				reseau_sel = filter(reseau, !is.na(selection_id))			
 				reseau_diff = filter(reseau, !is.na(diffusion_id))
 				
 				# get Minfo
 				Minfo = matrix(NA, ncol = 16, nrow = nrow(reseau))
 				colnames(Minfo) = c("father", "son", "diffusion_father_info", "diffusion_son_info", "id.diff_son", "id.diff_father", "reproduction_father_info", "reproduction_son_info", "selection_info", "mixture_info", "father_alt", "father_long", "father_lat", "son_alt", "son_long", "son_lat")
 				
 				# Faire avec event-year !!! A Ajouter dans le data reseau ------------
 				# dès que c'est fait, vérifier la cohérence des graph de diffusion et de reproduction (?) ----------
 				
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
 						
 						sent = 1 # because is father
 						if( is.element(f, reseau_diff[, "son"]) ) { receive = 1 } else { receive = 0 }				
 						if(sent == 1 & receive == 1) { info.f = gettext("give-receive") }	else { info.f = gettext("give")}
 						Minfo[i, "diffusion_father_info"] = info.f
 						
 						receive = 1 # because is son
 						if( is.element(s, reseau_diff[, "father"]) ) { sent = 1 } else { sent = 0 }
 						if(sent == 1 & receive == 1) { info.s = gettext("give-receive") }	else { info.s = gettext("receive") }
 						Minfo[i, "diffusion_son_info"] = info.s
 					}	
 					
 					if( relation == "reproduction" ) {		
 						if( is.element(f, reseau_repro[, "father"]) ) { sown = 1 } else { sown = 0 }
 						if( is.element(f, reseau_repro[, "son"]) ) { harvested = 1 } else { harvested = 0 }
 						if(harvested == 1 & sown == 0) { info.f = gettext("harvest") }
 						if(harvested == 0 & sown == 1) { info.f = gettext("sow") }
 						if(harvested == 1 & sown == 1) { info.f = gettext("harvest-sow") } 					
 						Minfo[i, "reproduction_father_info"] = info.f
 						
 						if( is.element(s, reseau_repro[, "son"]) ) { harvested = 1 } else { harvested = 0 }
 						if( is.element(s, reseau_repro[, "father"]) ) { sown = 1 } else { sown = 0 }
 						if(harvested == 1 & sown == 0) { info.s = gettext("harvest") }
 						if(harvested == 0 & sown == 1) { info.s = gettext("sow") }
 						if(harvested == 1 & sown == 1) { info.s = gettext("harvest-sow") }
 						Minfo[i, "reproduction_son_info"] = info.s
 					}
 					
 					if( relation == "selection" ) { Minfo[i, "selection_info"] = "selection" }
 					
 					if( relation == "mixture") { Minfo[i, "mixture_info"] = "mixture" }
 				}
 				
 				# Get duplicated information, there must be one information per seed-lot
 				Minfo = unique(Minfo)
 				
 				# reshape Minfo
 				{ 
 				Minfo = as.data.frame(Minfo)
 				
 				Mcross = query.cross(filter_G, filter_GT, filter_Y, filter_P, filter_Proj)
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
 			
 			# 4.1. For each seed-lot of the network, get their last diffusion_id and the number of reproductions since the last diffusion
 			fun = function(sl) {
 				test = TRUE
 				nb_repro = 0
 				to_check = "yo"
 				id_diffusion_sl = NULL
 				
 				while(test) {
 					d_sl_repro = reseau_repro[which(reseau_repro$son == sl),]
 					d_sl_sel = reseau_sel[which(reseau_sel$son == sl),]
 					d_sl_diff = reseau_diff[which(reseau_diff$son == sl),]
 					d_sl_mix = NULL # Not done, if there are neither selection or reproduction or diffusion, then it is mixture and we stop, the same as in a cross event
 					
 					# if the seed-lot (sl) come from a reproduction or a selection: get the diffusion or go back in the history of the reproduction
 					if(nrow(d_sl_repro) > 0 | nrow(d_sl_sel) > 0) {
 						
 						d_diff = reseau_diff[which(reseau_diff$father == sl),] 
 						
 						if(nrow(d_diff) > 0) { # if the sl come from a diffusion: get the sl father, that has been sent, and get the diffusion id
 							sl = as.character(d_diff[1, "father"]); id_diffusion_sl = as.character(sl); test = FALSE 
 						} else { # else increase the number of reproductions by 1 and get the sl father to go vback in the history of network
 							
 							nb_repro = nb_repro + 1
 							if(nrow(d_sl_repro) > 0) { sl = as.character(d_sl_repro[1, "father"]) }
 							if(nrow(d_sl_sel) > 0) { sl = as.character(d_sl_sel[1, "father"]) }							
 							
 							# Stop if the son do not have father
 							to_check = c(to_check, sl)
 							l = length(to_check)
 							if(to_check[l-1] == to_check[l]) { break() } 
 						}	
 						
 					} else { test = FALSE }
 					
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
 
 			# 4.2. For each pair of seed-lots, find the last diffusion in common and calculate the distance
			M_dist = matrix(NA, ncol = length(point), nrow = length(point))
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
 
			
 			# A CONTINUER, OK A PRIORI => A VERIFIER AVEC LES GRAPHS !!! ---------------------
 		
# 		cat("ajouter reproduction_type \n Puis dans analyse.network.relation")
# 	if(FALSE)
# 	{
# 		if(relation=="reproduction" & repro.type=="cross") # cas particulier
# 		{
# 			liste_year = unique(y)
# 			liste_germplasm = unique(g)
# 			liste_person = unique(p)
# 			
# 			out = get.data(requete.type="cross",year.in=liste_year,germplasm.in=liste_germplasm,person.in=liste_person, return.data = TRUE)[["data"]]
# 			
# 			if(!is.null(out))
# 			{
# 				out = subset(out, cross_germplasm %in% liste_germplasm) # pour ne pas avoir les parents en plus
# 				
# 				liste_ferme = rep(NA,times=nrow(out))
# 				
# 				# liste des fermes qui ont envoyé leur lot de graine à croiser
# 				liste_ferme[which(is.na(out$diffusion_father))] = as.character(out$cross_location[which(is.na(out$diffusion_father))])
# 				
# 				# liste des fermes qui ont fait leur croisement tout seul
# 				liste_ferme[which(!is.na(out$diffusion_father))] = as.character(out$grandfather_person[which(!is.na(out$diffusion_father))])
# 				out$liste_ferme = liste_ferme
# 				
# 				outb = out[,c("father" ,"mother", "cross_name", "liste_ferme", "cross_year", "cross_germplasm" )]
# 				
# 				# On enelve les germplasm qui ont des -1, -2 ou -3, ... car ils seront mélangés ensuite. On ne garde que la racine, qui correspond au nom du germplasm
# 				a = as.character(outb$cross_germplasm)
# 				a = sapply(a,function(x){unlist(strsplit(x,"-"))[1]})
# 				outb$cross_germplasm = a	
# 				
# 				outb = unique(outb) # car après on mélange les différents grains issus des croisements      
# 				outb$germplasm_type = "cross"
# 				colnames(outb) = c("father", "mother", "SL",  "p", "y", "g", "gp")
# 				
# 				name = outb$SL
# 				
# 				a = as.data.frame(table(name, rep("cross", length(name)), outb$g, outb$gp, outb$y, outb$p))
# 				colnames(a) = c("SL", "relation", "g", "gt", "y", "p", "Freq")
# 				a=subset(a,Freq!=0)
# 			} else {a = NULL}
# 		}
# 	}	
# 		
 	d = list("network" = n, "network.info" = Minfo, "Mdist" = M_dist)
 	attributes(d)$shinemas2R.object = "network"
 	}
 	
 
 	# 5.2. SL.mix ----------
 	if(query.type == "SL.mix") { 
 		message("1. Query SHiNeMaS ...")
 		d = query.SL.mix(filter_G, filter_GT, filter_Y, filter_P, filter_SL, filter_Proj) 
 		attributes(d)$shinemas2R.object = "SL.mix"
 		}
 	
	# 5.3. cross ----------
	if(query.type == "cross") {
		message("1. Query SHiNeMaS ...")
		d = query.cross(filter_G, filter_GT, filter_Y, filter_P, filter_Proj)
		attributes(d)$shinemas2R.object = "cross"
	}

 	# 5.4. raw information on levels and variables present in SHiNeMaS ----------
 	if( query.type == "variable"){ d = query.variable(); attributes(d)$shinemas2R.object = "variable"
 }
 	if( query.type == "person"){ d = query.person(); attributes(d)$shinemas2R.object = "person"
 }
 	if( query.type == "year"){ d = query.year(); attributes(d)$shinemas2R.object = "year"
 }
 	if( query.type == "project"){ d = query.project(); attributes(d)$shinemas2R.object = "project"
 }
 	if( query.type == "seed.lots"){ d = query.seed.lots(); attributes(d)$shinemas2R.object = "seed.lots"
 }
 	if( query.type == "selection.person"){ d = query.selection.person(); attributes(d)$shinemas2R.object = "selection.person"
 }
 	if( query.type == "reproduction.type"){ d = query.reproduction.type(); attributes(d)$shinemas2R.object = "reproduction.type"
 }
 	if( query.type == "germplasm"){ d = query.germplasm(); attributes(d)$shinemas2R.object = "germplasm"
 }
 	if( query.type == "germplasm.type"){ d = query.germplasm.type(); attributes(d)$shinemas2R.object = "germplasm.type"
 }
 	

	# 5.5. data with variable on specific seed-lots ----------	
	if(query.type == "data-classic") {
		if(data.type == "seed-lots") { message("1. Query SHiNeMaS ..."); d = query.data.seed_lots(filter_G, filter_GT, filter_Y, filter_P, filter_V, filter_SL, filter_Proj) }
		if(data.type == "relation") { message("1. Query SHiNeMaS ..."); d = query.data.relation(filter_G, filter_GT, filter_Y, filter_P, filter_R, filter_V, filter_SL, filter_Proj) }	
	}

	if(query.type == "data-S" | query.type == "data-SR") { 
		if(query.type == "data-S") { message("1. Query SHiNeMaS ..."); tab = query.S(filter_Y) }
		if(query.type=="data-SR") { message("1. Query SHiNeMaS ..."); tab = query.SR(year.in) }
		
		if(nrow(tab) > 0) {
			vec.seed_lots = tab[,"sl"]
			# filter on year already done with the query
			if(data.type == "seed-lots") { dv = query.data.seed_lots(filter_G, filter_GT, Y = NULL, filter_P, filter_R, filter_V, SL = get.filters(filter.in = vec.seed_lots, filter.out = NULL, filter.on = "son", sql.son.tag = "sl1.name", sql.father.tag = "sl2.name"), filter_Proj) } 
			if(data.type == "relation") { dv = query.data.relation(filter_G, filter_GT, Y = NULL, filter_P, filter_R, filter_V, SL = get.filters(filter.in = vec.seed_lots, filter.out = NULL, filter.on = "son", sql.son.tag = "sl1.name", sql.father.tag = "sl2.name"), filter_Proj) }
			
			tab = plyr::rename(tab, replace = c("sl" = "son"))
			if( !is.null(dv) ) { d = join(tab, dv, by = "son" ) } else { d = NULL }
			} else { d = NULL }
		}		

	# Set up datasets
	if( !is.null(unique(d$variable_name)[1]) ) { variable = unique(d$variable_name) }
	if( is.null(d) ) { variable = NULL }

	if( query.type == "data-classic" | query.type == "data-S" | query.type == "data-SR" ) {
			if( !is.null(d) & !is.null(variable)) {
			vec_variable = na.omit(unique(as.character(d$variable_name)))		
			
			if(length(vec_variable) != 0) { # If there are no variables, nothing is done
				message("2. Set up data set ... \n")	
											
				# correlated variable for both data.type = relation and data.type = seed.lots
				d1 = d # en attendant de pourvoir séparer (cf demande à Yannick) ----------
				print("en attendant de pourvoir séparer (cf demande à Yannick)")
				
				# non correlated variable only for data.type = relation
				if(data.type == "relation") { d2 = NULL }
				
				if(data.type == "seed-lots") { d2 = NULL }
				
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
						
						if(data.type == "seed-lots") { data$ID = paste(as.character(data$sl)) }
						
						data$var_meth = paste(data$variable_name, data$method_name, sep = "---")
						var_meth = unique(data$var_meth)
						
						if( is.element("NA---NA", var_meth) ) {
							data = data[-which(data$var_meth == "NA---NA"),]
							var_meth = var_meth[-which(var_meth == "NA---NA")]
						}
						
						print("For redondant information, à virer quand on aura l'unicité dans la base")
						data = unique(data)

						D = select(data, -method_name, -variable_name, -raw_data, -method_name, -var_meth, -quali_quanti_notes)
						D = unique(D)
						
						D = cbind.data.frame(D, matrix(NA, ncol = length(var_meth), nrow = nrow(D)))
						colnames(D)[(ncol(D) - length(var_meth) + 1) : ncol(D)] = var_meth
						
						pb <- txtProgressBar(min = 0, max = length(var_meth), style = 3)
						for(j in 1:length(var_meth)) {
							v = var_meth[j]
							row = which(data$var_meth == v)
							data_tmp = droplevels(data[row,])
							print("cf pb unicité, donné différente pour un meme ID!") # Cf C14_RAB_2008_001 -> C14_RAB_2010_0001
							data_tmp <- data_tmp[!duplicated(data_tmp$ID),]
							id = data_tmp$ID
							D[which(D$ID %in% id), v] = data_tmp$raw_data
							setTxtProgressBar(pb, j)
						}
						cat("\n")
					} else { D = NULL }
					
					return(D)
				}
				
				out.d = lapply(list("datasets.with.correlated.variables" = d1, 
														"datasets.with.non.correlated.variables" = d2),
											 arrange.data, data.type
											 )
				
				# description of methods
				filter_V = V.sql(vec_variable)
				m = query.methods(filter_V)
				m$"variable---methods" = paste(m$variable_name, m$method_name, sep = "---")
				var_meth_to_keep = c(colnames(out.d$datasets.with.correlated.variables), 
														 colnames(out.d$datasets.with.non.correlated.variables)
				)
				var_meth_to_keep = var_meth_to_keep[grep("---", var_meth_to_keep)]
				m = m[is.element(m$"variable---methods", var_meth_to_keep),]
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
	d = query.methods(filter_V)
	attributes(d)$shinemas2R.object = "methods"
	}


d = list("data" = d, "info_db" = info_db)
return(d)
}

