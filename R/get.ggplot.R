# 0. help -----------------------------------------------------------------
#' Get ggplot objects from \code{get.data}
#'
#' @description
#' \code{get.ggplot} generates ggplot object from \code{get.data} data-set
#'
#' @param data output from get.data with query.type = "network" or query.type = "data-...".
#' 
#' @param correlated_group Name of the group of correlation in data. NULL by default.
#' 
#' @param fuse_g_and_s Fuse germplasm and selection name information in a column named germplasm
#' 
#' @param ggplot.type the type of plot you wish.
#' NULL by default: according to the type of data, it will be "network-all" or "data-all". "X-all" means that all the "X-" objects are done. 
#' The possibilites are: 
#' \itemize{
#' \item for "network-": 
#' "network-network",
#' "network-reproduction-harvested",
#' "network-reproduction-positive-inter-selected",
#' "network-reproduction-negative-inter-selected",
#' "network-reproduction-crossed",
#' "network-diffusion-sent",
#' "network-diffusion-received",
#' "network-diffusion-relation",
#' "network-mixture",
#' "network-positive-intra-selected",
#' "network-Mdist".
#'
#' \item for "data-":
#' \itemize{
#' 		\item "data-barplot"
#' 		\item "data-boxplot"
#' 		\item "data-interaction"
#' 		\item "data-radar"
#' 		\item "data-biplot" 
#' 		\item "data-pie.on.map" (only for data-classic).
#' 		\item "data-pie.on.network"	(only for data-classic).
#' 		}
#' }
#' 
#' @param ggplot.display For "network-" data: "barplot", "map". It can be a vector of several elements i.e. c("barplot", "map"). NULL by default: both are done.
#' 
#' @param ggplot.on For "data-" type. "father" or "son" depending on which seed-lot you want to plot.
#' 
#' @param x.axis factor displayed on the x.axis of a plot: "germplasm", "year" or "person" referring to the attributes of a seed-lots. If NULL, all the combinaison are done for x.axis and in.col.
#' 
#' @param in.col factor displayed in color of a plot: "germplasm", "year" or "person" referring to the attributes of a seed-lots. If NULL, in.col is not displayed. Note it is compulsory for data-biplot and data-radar as in these cases x.axis is not used.
#' 
#' @param vec_variables For "data-" type : a vector of variables displayed.
#' 
#' @param nb_parameters_per_plot_x.axis The number of parameters per plot on x axis arguments
#'
#' @param nb_parameters_per_plot_in.col The number of parameters per plot for in.col arguments
#'
#' @param vertex.size For ggplot.type = "network", size of the vertex
#' 
#' @param vertex.color For ggplot.type = "network", color of the vertex. It can be chosen according to  "person", "germplasm" or "year". If NULL, it is in black.
#' 
#' @param organise.sl For ggplot.type = "network", organise seed-lots for an easier visualisation
#' 
#' @param labels.on "son" or "father". For ggplot.type = "data-biplot" choose if labels are on son or father seed-lots. For other "data-..." plots, there are no labels as it is managed by x.axis and in.col. 
#' 
#' 
#' @param hide.labels.parts For ggplot.type = network-network and data-biplot.
#' Parts of the label hidden: "germplasm", "person", "year", "person:germplasm", "year:germplasm", "person:year", "all". "all" means that no labels are dispayed. If NULL labels are displayed. Labels are based on seed-lots names under the form germplasm_year_person_digit. 
#' For "data-biplot", the default value is NULL.
#' For easier visualisation, Digit is never display unless you choose NULL.
#' Note that with ggplot.type "network-" and ggplot.display = "map", hide.labels.part can be NULL or "all" as only person can be display.
#' 
#' @param display.labels.sex For ggplot.type = "network-network", if TRUE, display the sex of the seed-lot if it has been used in a cross. Nothing is displayed if hide.labels.parts = "all".
#' 
#' @param labels.generation For ggplot.type = "network-network", if TRUE, display generation for each reproduction
#' 
#' @param labels.size Size of the labels
#' 
#' @param location.map Location of the map see \code{?map} for more details.
#' 
#' @param pie.size Size of the pie when using pies
#' 
#' @return The function returns a list with several ggplot objects according to the data and ggplot.type used.
#' 
#' \enumerate{
#' 
#' \item For "network-" type it returns a list with ggplot objects representing the network and for each relation (i) barplots with the number of populations (ii) maps for each year
#' 
#' 	\itemize{
#' 	\item the network (ggplot.type = "network-network")
#' 
#' 	\item a series of ggplots for reproduction:
#' 		\itemize{
#' 		\item harvested seed-lots (ggplot.type = "network-reproduction-harvested")
#' 		\item positive inter selected seed-lots (ggplot.type = "network-reproduction-positive-inter-selected")
#' 		\item negative inter selected seed-lots (ggplot.type = "network-reproduction-negative-inter-selected")
#' 		\item seed-lots involved in crosses (ggplot.type = "network-reproduction-crossed")
#' 		}
#' 	
#' \item a series of ggplots for diffusion representing:
#' 	\itemize{
#' 	\item the seed-lots sent (ggplot.type = "network-diffusion-sent")
#' 	\item the seed-lots received (ggplot.type = "network-diffusion-received")
#' 	\item the relation between seed-lots on maps (ggplot.type = "network-diffusion-relation"). The size of the arrows is proprotionnal to the number of diffusions.
#' 	}
#' 	
#' \item a series of ggplots for mixture (ggplot.type = "network-mixture"). Note that mixture of replications are not counted here.
#' 
#' \item a series of ggplots for selection (ggplot.type = "network-positive-intra-selected") 
#' 
#' \item, If Mdist is not NULL, draw ??? Cf ma thèse !!!0
#' }
#' 
#' \item For "data-" type, plots are displayed for each variable of vec_variables for "data-barplot", "data-boxplot", "data-interation". It is all possibles pairs for "data-biplot". It is all the variables for "data-radar".
#' 
#' }
#' 
#' @author Pierre Riviere
#' 
#' @seealso \code{\link{get.data}}
#' 
get.ggplot <- function(
	data,
	correlated_group = NULL,
	fuse_g_and_s = FALSE,
	ggplot.type = NULL,
	ggplot.display = NULL,
	ggplot.on = "son",
	x.axis = NULL,
	in.col = NULL,
	vec_variables = NULL,
	nb_parameters_per_plot_x.axis = NULL,
	nb_parameters_per_plot_in.col = NULL,
	vertex.size = 3,
	vertex.color = "year", 
	organise.sl = FALSE,
	labels.on = "son",
	hide.labels.parts = "all", 
	display.labels.sex = TRUE, 
	labels.generation = TRUE,
	labels.size = 3,
	location.map = "france", 
	pie.size = .5
)
# lets go !!! ----------
{
check.arg = function(x, vec_x) { length(which(is.element(x, vec_x))) > 0 }

info_db = data$info_db
data = data$data

# 1. Check parameters and assign automatic parameters ########## ----------
# 1.1. data -----------

shinemas2R.object = attributes(data)$shinemas2R.object

test1 = shinemas2R.object == "network"
test2 = length(grep("data", shinemas2R.object)) > 0 
test = unique(c(test1, test2))
test = length(test) == 1 & test[1]
if( test ){ stop("data must come from shinemas2R::get.data") }


if( 
	is.null(data$data) & 
	is.null(data$data.with.correlated.variables) & 
	is.null(data$network)
) { message("data is NULL: nothing is done !"); return(NULL) }


if( test2 ){
	if( is.null(correlated_group) ) {
		data = data$data	
	} else { 
		data_tmp = data$data.with.correlated.variables
		if(is.element(correlated_group, names(d))) {
			data = data_tmp[[correlated_group]]
		} else { stop(correlated_group, "is not a group of the data set. Possibles groups are: ", paste(names(data_tmp), collapse = ", "), ".") }
	}
}


if( shinemas2R.object == "data-S-seed-lots" | shinemas2R.object == "data-S-relation" | shinemas2R.object == "data-SR-seed-lots" | shinemas2R.object == "data-SR-relation" ) {
	ggplot.type.dataS.dataSR = TRUE
} else { ggplot.type.dataS.dataSR = FALSE }


# 1.2. ggplot.type ----------

test = is.element(ggplot.type, c(
	# network-
	"network-network",
	"network-reproduction-harvested",
	"network-reproduction-positive-inter-selected",
	"network-reproduction-positive-inter-selected",
	"network-reproduction-negative-inter-selected",
	"network-reproduction-crossed",
	"network-diffusion-sent",
	"network-diffusion-received",
	"network-diffusion-relation",
	"network-mixture",
	"network-positive-intra-selected",
	
	# data-
	"data-barplot", 
	"data-boxplot", 
	"data-interaction", 
	"data-radar", 
	"data-biplot", 
	"data-pie.on.map", 
	"data-pie.on.network"
))
not_in_data = ggplot.type[!test]
if( length(not_in_data) > 0 ) { stop("ggplot.type ", paste(not_in_data, collapse = ", "), " are not possible.
																		 
																		 ggplot.type must be 
																		 
																		 netwok- type:
																		 \"network-network\",
																		 \"network-reproduction-harvested\",
																		 \"network-reproduction-positive-inter-selected\",
																		 \"network-reproduction-positive-inter-selected\",
																		 \"network-reproduction-negative-inter-selected\",
																		 \"network-reproduction-crossed\",
																		 \"network-diffusion-sent\",
																		 \"network-diffusion-received\",
																		 \"network-diffusion-relation\",
																		 \"network-mixture\",
																		 \"network-positive-intra-selected\"
																		 
																		 or data- type:
																		 \"data-barplot\", 
																		 \"data-boxplot\", 
																		 \"data-interaction\", 
																		 \"data-radar\", 
																		 \"data-biplot\", 
																		 \"data-pie.on.map\",
																		 \"data-pie.on.network\".") 
}


# 1.2.1. network ----------
vec_all_ggplot_network = 	c("network-network",
														"network-reproduction-harvested",
														"network-reproduction-positive-inter-selected",
														"network-reproduction-positive-inter-selected",
														"network-reproduction-negative-inter-selected",
														"network-reproduction-crossed",
														"network-diffusion-sent",
														"network-diffusion-received",
														"network-diffusion-relation",
														"network-mixture",
														"network-positive-intra-selected")

if(is.null(ggplot.type) & test1) { 
	ggplot.type = vec_all_ggplot_network	
	message("As ggplot.type is NULL, ggplot.type is set to ", paste(vec_all_ggplot_network, collapse = ", "))
	}

if( test1 & length(grep("network-", ggplot.type)) == 0 ) { stop("With data from \"network\", ggplot.type must be ", paste(vec_all_ggplot_network, collapse = ", \n")) }


# 1.2.2. data ----------
vec_all_ggplot_data = c("data-barplot", 
												"data-boxplot", 
												"data-interaction", 
												"data-radar", 
												"data-biplot")
# not "data-pie.on.map" AND "data-pie.on.network"

if(is.null(ggplot.type) & test2) { 
	ggplot.type = vec_all_ggplot_data
	message("As ggplot.type is NULL, ggplot.Type is set to ", paste(vec_all_ggplot_data, collapse = ", "))
	if( ggplot.type.dataS.dataSR ) { 
		ggplot.type = c("data-barplot", "data-boxplot", "data-interaction") 
		message("As ggplot.type is NULL and data come from \"data-S\" or \"data-SR\", ggplot.type is set to \"data-barplot\", \"data-boxplot\", \"data-interaction\".")
	}
}


if( test2 & length(grep("data-", ggplot.type)) == 0 ) { stop("With data from \"data-...\", ggplot.type must be", paste(vec_all_ggplot_data, collapse = ", \n")) }


# 1.3. ggplot.display ----------

# 1.3.1. network ----------

if(!is.null(ggplot.type)) { 
	if( length(ggplot.type) == 1 ) { 
		if( ggplot.type == "network-diffusion-relation" ) { 
			ggplot.display = "map" 
			message("With ggplot.type == \"network-diffusion-relation\", ggplot.display is set to \"map\".")
			} 
	}
}

check.ggplot.display = TRUE
if(!is.null(ggplot.type)) { 
	if( length(ggplot.type) == 1 ) { 
		if( ggplot.type == "network-network" ) { 
			check.ggplot.display = FALSE
		} 
	}
}


if(check.ggplot.display & test1 & is.null(ggplot.display)) { 
	ggplot.display = c("barplot", "map") 
	message("As ggplot.display is NULL, ggplot.display is set to c(\"barplot\", \"map\"). Note that for ggplot.type == \"network-diffusion-relation\", ggplot.display is set to \"map\" ")
	} 

if(check.ggplot.display & test1 & !is.null(ggplot.display)) { 
	if( !check.arg(ggplot.display, c("barplot", "map")) ) { stop("With ggplot.type in network- type, ggplot.display must be \"barplot\" or \"map\".") }
}

# 1.3.2. data ----------
if( ggplot.type == "data-pie.on.map") { ggplot.display = "map"}
# No problems with ggplot.display as it is related to ggplot.type directly (i.e. for ggplot.type = "data.radar", ggplot.display = "radar")

# 1.4. x.axis and in.col ----------

if( ggplot.type.dataS.dataSR ) {
	in.col = "sl_statut"; check.in.col = FALSE
	x.axis = "expe_name"; check.x.axis = FALSE
	message("With \"data-S\" and \"data-SR\", in.col and x.axis are set automaticaly.")
} else { check.in.col = check.x.axis = TRUE }

if( is.null(x.axis) ) { is.null_x.axis = TRUE } else { is.null_x.axis = FALSE }
if( is.null(in.col) ) { is.null_in.col = TRUE } else { is.null_in.col = FALSE }


if( check.arg(ggplot.type, c("data-radar", "data-biplot", "data-pie.on.network")) & !is.null_x.axis ){
	message("With ggplot.type \"data-radar\"and \"data-biplot\", x.axis is not use.")
}

if( check.arg(ggplot.type, c("data-barplot", "data-boxplot", "data-interaction")) & !is.null_x.axis & check.x.axis ) { if( !check.arg(x.axis, c("germplasm", "year", "person")) ) { stop("x.axis must be \"germplasm\", \"year\" or \"person\".") } }

if( check.arg(ggplot.type, c("data-pie.on.map")) & !is.null_x.axis & check.x.axis ) { if( !check.arg(x.axis, c("germplasm", "year")) ) { stop("x.axis must be \"germplasm\" or \"year\".") } }

if( !is.null_in.col & check.in.col ) { if( !check.arg(in.col, c("germplasm", "year", "person")) ) { stop("in.col must be \"germplasm\", \"year\" or \"person\".") } }


combi = list(c(x.axis, in.col))

combi_all = list( 	# all possibilities of factor combinaisons for barplot, boxplot, interaction
	combi1 = c("germplasm", "year"),
	combi2 = c("germplasm", "person"),
	combi3 = c("person", "year"),
	combi4 = c("person", "germplasm"),
	combi5 = c("year", "person"),
	combi6 = c("year", "germplasm")
)	


# For network
if(check.ggplot.display & check.arg(ggplot.display, c("barplot")) & is.null_x.axis & is.null_in.col ){
	combi = combi_all
	message("As x.axis and in.col are NULL, all the combinaisons of x.axis and in.col are done for barplot.")
}


if(check.ggplot.display & check.arg(ggplot.display, c("barplot")) & is.null_x.axis & !is.null_in.col ){
	if( in.col == "person ") { combi = list( combi1 = c("year", in.col), combi2 = c("germplasm", in.col)) }
	if( in.col == "year ") { combi = list( combi1 = c("person", in.col), combi2 = c("germplasm", in.col)) }
	if( in.col == "germplasm ") { combi = list( combi1 = c("year", in.col), combi2 = c("person", in.col)) } 
	message("As x.axis is NULL, all the combinaisons of in.col=", in.col, " and x.axis are done for barplot.")
}

# For data
if( check.arg(ggplot.type, c("data-barplot", "data-boxplot", "data-interaction")) & is.null_x.axis & is.null_in.col ){
	combi = combi_all
	message("As x.axis and in.col are NULL, all the combinaisons of x.axis and in.col are done for data-barplot, data-boxplot and data-interaction.")
}

if( check.arg(ggplot.type, c("data-barplot", "data-boxplot", "data-interaction")) & is.null_x.axis & !is.null_in.col ){
		if( in.col == "person ") { combi = list( combi1 = c("year", in.col), combi2 = c("germplasm", in.col)) }
	if( in.col == "year ") { combi = list( combi1 = c("person", in.col), combi2 = c("germplasm", in.col)) }
	if( in.col == "germplasm ") { combi = list( combi1 = c("year", in.col), combi2 = c("person", in.col)) }
	message("As x.axis is NULL, all the combinaisons of in.col=", in.col, " and x.axis are done for  data-barplot, data-boxplot and data-interaction.")
}

if( check.arg(ggplot.type, c("data-radar", "data-biplot"))) {
	if(is.null_in.col){
		message("As in.col is NULL, each in.col are done for data-radar and data-biplot.")
		combi_in.col = NULL
		for(comb in combi_all) { combi_in.col = c(combi_in.col, comb[2]) }
		combi_in.col = unique(combi_in.col)
	} else { combi_in.col = in.col }
} 


if( check.arg(ggplot.type, c("data-pie.on.map")) & is.null_x.axis){
	x.axis = "year"
	message("As x.axis is NULL, x.axis = \"person\".")
}

# 1.5. vec_variables and correlated variable for data- type ----------

if( test2 & is.null(vec_variables[1]) ) { stop("With ggplot.type with data-, vec_variables must be not NULL.") }

if( length(vec_variables) > 0 & length(grep("network", shinemas2R.object)) > 0 ){ stop("With data in \"network-\", vec_variables must be NULL (default setting)." ) }


if( test2 ){
	
	if( fuse_g_and_s ) { 
		data$son_germplasm = sapply(as.character(data$son), function(x){unlist(strsplit(x,"_"))[1]}) 
		data$father_germplasm = sapply(as.character(data$father), function(x){unlist(strsplit(x,"_"))[1]}) 
	} 
	
	test = is.element(vec_variables, colnames(data))
	not_in_data = vec_variables[!test]
	if( length(not_in_data) == length(vec_variables) ) { message("None elements of vec_variables are in data."); return(NULL) }
	if( length(not_in_data) > 0 ) { message("Variables ", paste(not_in_data, collapse = ", "), " are not in data.") }
	
	vec_variables = vec_variables[test] # update vec_variables
	for(var in vec_variables) {
			data[,var] = as.numeric(as.character(data[,var])) # A Virer quand les données seront propres dans get.data ----------
			print("A Virer quand les données seront propres dans get.data")
		}
	
	# Delete expe where there are not data for bouquet AND vrac, do that by putting NA
	if( shinemas2R.object == "data-S-seed-lots" | shinemas2R.object == "data-S-relation" | shinemas2R.object == "data-SR-seed-lots" | shinemas2R.object == "data-SR-relation" ) {
		
		expe_to_keep = NULL
		vec_expe = unique(data$expe)
		for(var in vec_variables){
			for(exp in vec_expe){
				d_tmp = droplevels(filter(data, expe == exp))
				t = tapply(d_tmp[,var], d_tmp$sl_statut, mean, na.rm = TRUE)
				
				# function used after
				isnat = function(t, sl_statut){
					t1 = t[grep(sl_statut, names(t))]
					if( length(t1) > 0 ) { if(is.na(t1)) { t1 = TRUE } else { t1 = FALSE } } else { t1 = FALSE}
					return(t1)
				}
				
				if( shinemas2R.object == "data-S-seed-lots" | shinemas2R.object == "data-S-relation" ) {
					t1 = isnat(t, "bouquetS")
					t2 = isnat(t, "vracS")
					test = t1 | t2 
				} 
				if( shinemas2R.object == "data-SR-seed-lots" | shinemas2R.object == "data-SR-relation" ) {
					t1 = isnat(t, "bouquetR")
					t2 = isnat(t, "vracR")
					test = t1 | t2 
				}
				if( test ) { data[which(data$expe == exp), var] = NA }
			}
		}
	}

	lv = length(vec_variables)
	a = 0
	for(var in vec_variables){
		w = which(is.na(data[,var]))
		if(length(w) == nrow(data)) { 
			warning(var, " has only NA and has been removed from the dataset")
			data = data[,-which(colnames(data) == var)]
			vec_variables = vec_variables[-which(vec_variables == var)]
			a = a + 1
		}
	}
	
	if(a == lv) { warning("No ggplot can be done as there are no variables anymore in the dataset"); return(NULL) }
	
# 1.6. ggplot.on ----------
	# only for relation data, not for seed-lots data
	if( ggplot.on == "son" ){
		colnames(data)[which(colnames(data) == "son_germplasm")] = "germplasm"
		colnames(data)[which(colnames(data) == "son_person")] = "person"
		colnames(data)[which(colnames(data) == "son_year")] = "year"
	}
	
	if( ggplot.on == "father" ){
		colnames(data)[which(colnames(data) == "father_germplasm")] = "germplasm"
		colnames(data)[which(colnames(data) == "father_person")] = "person"
		colnames(data)[which(colnames(data) == "father_year")] = "year"
	}
}


# 1.7. labels ----------

test = check.arg(ggplot.type, c("network-network", "data-biplot")) | check.arg(ggplot.type, c("map"))
if( test ){
	if(!is.element(labels.on, c("son", "father"))) { stop("labels.on must be \"son\" or \"father\".") }
	
	mess = "hide.labels.parts must be NULL, \"all\", \"germplasm\", \"person\", \"year\", \"person:germplasm\", \"year:germplasm\" or \"person:year\"."
	if( !is.null(hide.labels.parts) ) {
		if( length(hide.labels.parts) > 1  ) { stop(mess) }
		if( !is.element(hide.labels.parts, c("all", "germplasm", "person", "year", "person:germplasm", "year:germplasm", "person:year")) ) { stop(mess) }
		if( check.arg(ggplot.type, "data-biplot") & hide.labels.parts == "all") { 
			hide.labels.parts = NULL 
			message("For data-biplot, hide.labels.parts has been set to NULL instead of \"all\".")
		}
	}
}



# 2. Initialisation ########## ----------

# 2.1. Get the ggplot objects ----------
LIST.PLOTS = NULL

# 2.2. Get the map if needed ----------
if( check.arg("map", ggplot.display) ) {
	dmap = map_data(location.map)
	p = ggplot(data = dmap)
	p = p + geom_polygon(aes(x = long, y = lat, group = group), colour = "grey50", fill = "white")
	map = p + theme(panel.background = element_rect(fill = "white"), panel.grid = element_blank(), axis.title = element_blank() ) + scale_x_continuous(breaks = NULL) + scale_y_continuous(breaks = NULL)	
}


# 3. Plot for network- type ########## ----------

# 3.1. network-network ----------
if( check.arg("network-network", ggplot.type) ) {

	p_network = get.ggplot_plot.network(data, vertex.color, vertex.size, hide.labels.parts, display.labels.sex, labels.generation, organise.sl = organise.sl, labels.size = labels.size)$pnet
	
	LIST.PLOTS = c(LIST.PLOTS, list("network-network" = p_network))
}

# 3.2. network-reproduction-sown ----------
if( check.arg("network-reproduction-sown", ggplot.type) ) {
	
	if( check.arg("barplot", ggplot.display) ) { 
		out_barplot = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "reproduction", relation.type = c(gettext("sown"), gettext("harvest-sow")), name = gettext("sown seed-lots"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)
	} else { out_barplot = NULL }
	
	if( check.arg("map", ggplot.display) ) {
		out_map = get.ggplot_network.relation.map(map, data = data, relation = "reproduction", relation.type = c(gettext("sown"), gettext("harvest-sow")), name = gettext("sown seed-lots"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
	} else { out_map = NULL }
	
	out = list("network-reproduction-sown" = c(out_barplot, out_map))	
	LIST.PLOTS = c(LIST.PLOTS, out)	
}

# 3.2. network-reproduction-harvested ----------
if( check.arg("network-reproduction-harvested", ggplot.type) ) {

		if( check.arg("barplot", ggplot.display) ) { 
		out_barplot = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "reproduction", relation.type = c(gettext("harvest"), gettext("harvest-sow")), name = gettext("harvested seed-lots"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)
	} else { out_barplot = NULL }

	if( check.arg("map", ggplot.display) ) {
	out_map = get.ggplot_network.relation.map(map, data = data, relation = "reproduction", relation.type = c(gettext("harvest"), gettext("harvest-sow")), name = gettext("harvested seed-lots"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
	} else { out_map = NULL }
	
	out = list("network-reproduction-harvested" = c(out_barplot, out_map))	
	LIST.PLOTS = c(LIST.PLOTS, out)	
	}

# 3.3. network-reproduction-positive-inter-selected ----------
if( check.arg("network-reproduction-positive-inter-selected", ggplot.type) ) {
	
	if( check.arg("barplot", ggplot.display) ) { 
		out_barplot = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "reproduction", relation.type = gettext("harvest-sow"), name = gettext("positive-inter-selected seed-lots"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)
	} else { out_barplot = NULL }
	
	if( check.arg("map", ggplot.display) ) {
		out_map = get.ggplot_network.relation.map(map, data = data, relation = "reproduction", relation.type = gettext("harvest-sow"), name = gettext("positive-inter-selected seed-lots"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
	} else { out_map = NULL }
	
	out = list("network-reproduction-positive-inter-selected" = c(out_barplot, out_map))	
	LIST.PLOTS = c(LIST.PLOTS, out)	
}

# 3.4. network-reproduction-negative-inter-selected ----------
if( check.arg("network-reproduction-negative-inter-selected", ggplot.type) ) {
	
	if( check.arg("barplot", ggplot.display) ) { 
		out_barplot = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "reproduction", relation.type = gettext("sow"), name = gettext("negative-inter-selected seed-lots"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)
	} else { out_barplot = NULL }
	
	if( check.arg("map", ggplot.display) ) {
		out_map = get.ggplot_network.relation.map(map, data = data, relation = "reproduction", relation.type = gettext("sow"), name = gettext("negative-inter-selected seed-lots"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
	} else { out_map = NULL }
	
	out = list("network-reproduction-negative-inter-selected" = c(out_barplot, out_map))	
	LIST.PLOTS = c(LIST.PLOTS, out)	
}

# A CONTINUER ET VERIFIER pour diffusion SI C EST OK une fois qu'il y aura la colonne event year !!!!!!!!!! ---------------------

# 3.5. network-diffusion-sent ----------
if( check.arg("network-diffusion-sent", ggplot.type) ) {
	
	if( check.arg("barplot", ggplot.display) ) { 
		out_barplot = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "diffusion", relation.type = c(gettext("give"), gettext("give-receive")), name = gettext("diffusion-sent seed-lots"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)
	} else { out_barplot = NULL }
	
	if( check.arg("map", ggplot.display) ) {
		out_map = get.ggplot_network.relation.map(map, data = data, relation = "diffusion", relation.type = c(gettext("give"), gettext("give-receive")), name = gettext("diffusion-sent seed-lots"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
	} else { out_map = NULL }
	
	out = list("network-diffusion-sent" = c(out_barplot, out_map))	
	LIST.PLOTS = c(LIST.PLOTS, out)	
}

# 3.6. network-diffusion-received ----------
if( check.arg("network-diffusion-received", ggplot.type) ) {
	
	if( check.arg("barplot", ggplot.display) ) { 
		out_barplot = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "diffusion", relation.type = c(gettext("receive"), gettext("give-receive")), name = gettext("diffusion-received seed-lots"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)
	} else { out_barplot = NULL }
	
	if( check.arg("map", ggplot.display) ) {
		out_map = get.ggplot_network.relation.map(map, data = data, relation = "diffusion", relation.type = c(gettext("receive"), gettext("give-receive")), name = gettext("diffusion-received seed-lots"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
	} else { out_map = NULL }
	
	out = list("network-diffusion-received" = c(out_barplot, out_map))	
	LIST.PLOTS = c(LIST.PLOTS, out)	
}

# 3.7. network-diffusion-relation ----------
if( check.arg("network-diffusion-relation", ggplot.type) ) {
	
	data.diff = droplevels(filter(data$network.info, !is.na(id.diff)))
	vec_id.diff = as.character(unique(data.diff$id.diff))
	son_person = son_lat = son_long = father_person = father_lat = father_long = event_year = diff = NULL
	
	# A METTRE A JOUR QUAND ON AURA EVENT YEAR --------------------------
	print("A METTRE A JOUR QUAND ON AURA EVENT YEAR")
	data.diff$event_year = data.diff$year
	print("A METTRE A JOUR QUAND ON AURA EVENT YEAR")
	
	for(id in vec_id.diff) { # ajouter "event year" pour ajouter de la couleur et faire le split
		data.diff.tmp = filter(data.diff, id.diff == id)
		r = 1 #  which(data.diff.tmp[,"diffusion"] == gettext("receive"))
		d = 2 # which(data.diff.tmp[,"diffusion"] == gettext("give"))
		son_person = c(son_person, as.character(data.diff.tmp[r, "person"]))
		son_lat = c(son_lat, data.diff.tmp[r, "lat"])
		son_long = c(son_long, data.diff.tmp[r, "long"])
		father_person = c(father_person, as.character(data.diff.tmp[d, "person"]))
		father_lat = c(father_lat, data.diff.tmp[d, "lat"])
		father_long = c(father_long, data.diff.tmp[d, "long"])
		event_year = c(event_year, as.character(data.diff.tmp[1, "event_year"]))
		diff = c(diff, paste(as.character(data.diff.tmp[r, "person"]), 
												 as.character(data.diff.tmp[d, "person"]), 
												 as.character(data.diff.tmp[1, "event_year"]), sep = "-")
						 )
	}
	
	d.diff.map = cbind.data.frame(factor(son_person), son_lat, son_long, factor(father_person), father_lat, father_long, factor(event_year), factor(diff))
	colnames(d.diff.map) = c("son_person", "son_lat", "son_long", "father_person", "father_lat", "father_long", "event_year", "diff")
	
	# Add size regarding the number of diffusion for one diff
	s = table(d.diff.map$diff)
	d.diff.map$nb_diffusions = as.numeric(as.character((s[d.diff.map$diff])))

	# check if it fits on the map, otherwise it sends an error
	dgg = map$data
		
	lon.range = range(dgg$lon)
	x.range = range(c(d.diff.map$son_long, d.diff.map$father_long), na.rm = TRUE)	
	lat.range = range(dgg$lat)
	y.range = range(c(d.diff.map$son_lat, d.diff.map$father_lat), na.rm = TRUE)
	
	if( x.range[1] < lon.range[1] | x.range[2] > lon.range[2] | y.range[1] < lat.range[1] | y.range[2] > lat.range[2] ) { stop("The information do not fit on the map. You should zoom out.") } 
	
	# Do ggplot  -------------------
	
	all_year = sort(unique(as.numeric(as.character(d.diff.map$event_year))))

	tmp = NULL
	for(i in all_year){tmp = c(tmp, list(i))}
	all_year = c(tmp, list(all_year))
	
	out = list()
	n = NULL
	
	for(y in all_year){
		d.diff.map_tmp = filter(d.diff.map, event_year %in% y)
		
		# delete if info is missing for long and lat and put a message
		no_lat_or_long_son = unique(c(
			which(is.na(d.diff.map_tmp$son_long)), 
			which(is.na(d.diff.map_tmp$son_lat)))
			)
		no_lat_or_long_father = unique(c(
			which(is.na(d.diff.map_tmp$father_long)), 
			which(is.na(d.diff.map_tmp$father_lat)))
		)
		
		t = NULL
		if( length(no_lat_or_long_son) > 0 ) { t = c(t, as.character(d.diff.map_tmp$person[no_lat_or_long_son])) }
		if( length(no_lat_or_long_father) > 0 ) { t = c(t, as.character(d.diff.map_tmp$person[no_lat_or_long_father])) }
		if( length(t) == 0 ) { t = NULL }

		if( !is.null(t) ) {
			text = paste(t, collapse = ", ")
			message(paste(y, collapse = ", "), ": ",text, " have no informations for coordinates and are not represented on the map.")
			d.diff.map_tmp = d.diff.map_tmp[-unique(c(no_lat_or_long_son, no_lat_or_long_father)),]
		}

		if( !is.null(hide.labels.parts) ) { if( hide.labels.parts != "all" ){ stop("With ggplot.type \"network-\" and ggplot.display = \"map\" hide.labels.parts can be NULL or \"all\".") } }
		
		p = map + geom_segment(data = d.diff.map_tmp, aes(x = son_long, y = son_lat, xend = father_long, yend = father_lat, size = nb_diffusions), arrow = arrow(length = unit(0.5, "cm")))
		p = p +  scale_size(range = c(1,3))
		
		if( is.null(hide.labels.parts) ){
			p = p + geom_text(data = d.diff.map_tmp, aes(x = son_long, y = son_lat, label = son_person), size = labels.size)
			p = p + geom_text(data = d.diff.map_tmp, aes(x = father_long, y = father_lat, label = father_person), size = labels.size)
		}
		
		p = p + ggtitle(paste(y, collapse = ", "))
		
		n = c(n, paste("map-[", paste(y, collapse = ", "), "]", sep = ""))
		
		out = c(out, list(p))
		
		}
	names(out) = n
	out_map = list("map" = out)
	out = list("network-diffusion-relation" = out_map)
	LIST.PLOTS = c(LIST.PLOTS, out)	
}

# 3.8. network-mixture ----------
if( check.arg("network-mixture", ggplot.type) ) {
	
	if( check.arg("barplot", ggplot.display) ) { 
		out_barplot = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "mixture", relation.type = "mixture", name = gettext("mixed seed-lots"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)
	} else { out_barplot = NULL }
	
	if( check.arg("map", ggplot.display) ) {
		out_map = get.ggplot_network.relation.map(map, data = data, relation = "mixture", relation.type = "mixture", name = gettext("mixed seed-lots"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
	} else { out_map = NULL }
	
	out = list("network-mixture" = c(out_barplot, out_map))	
	LIST.PLOTS = c(LIST.PLOTS, out)	
}

# 3.9. network-positive-intra-selected ----------
if( check.arg("network-positive-intra-selected", ggplot.type) ) {
	
	if( check.arg("barplot", ggplot.display) ) { 
		out_barplot = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "selection", relation.type = "selection", name = gettext("positive-intra-selected seed-lots"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)
	} else { out_barplot = NULL }
	
	if( check.arg("map", ggplot.display) ) {
		out_map = get.ggplot_network.relation.map(map, data = data, relation = "selection", relation.type = "selection", name = gettext("positive-intra-selected seed-lots"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
	} else { out_map = NULL }
	
	out = list("network-positive-intra-selected" = c(out_barplot, out_map))	
	LIST.PLOTS = c(LIST.PLOTS, out)	
}

# 3.10. "network-reproduction-crossed" ----------
if( check.arg("network-reproduction-crossed", ggplot.type) ){
	
	if( check.arg("barplot", ggplot.display) ) { 
		out_barplot_cross = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "cross.info", relation.type = "cross", name = gettext("cross"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)
		
		out_barplot_father = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "cross.info", relation.type = "father", name = gettext("cross father"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)

		out_barplot_grandfather = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "cross.info", relation.type = "grandfather", name = gettext("cross grandfather"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)

		out_barplot_mother = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "cross.info", relation.type = "mother", name = gettext("cross mother"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)

		out_barplot_grandmother = get.ggplot_network.relation.barplot(data = data, combi = combi, relation = "cross.info", relation.type = "grandmother", name = gettext("cross grandmother"), nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, ggplot.type = ggplot.type)
		
		out_barplot = list("cross" = out_barplot_cross,
											 "father" = out_barplot_father,
											 "grandfather" = out_barplot_grandfather,
											 "mother" = out_barplot_mother,
											 "grandmother" = out_barplot_grandmother
											 )
	} else { out_barplot = NULL }

	if( check.arg("map", ggplot.display) ) {
		out_map_cross = get.ggplot_network.relation.map(map, data = data, relation = "cross.info", relation.type = "cross", name = gettext("cross"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
		
		out_map_father = get.ggplot_network.relation.map(map, data = data, relation = "cross.info", relation.type = "father", name = gettext("cross father"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
		
		out_map_grandfather = get.ggplot_network.relation.map(map, data = data, relation = "cross.info", relation.type = "grandfather", name = gettext("cross grandfather"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
		
		out_map_mother = get.ggplot_network.relation.map(map, data = data, relation = "cross.info", relation.type = "mother", name = gettext("cross mother"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
		
		out_map_grandmother = get.ggplot_network.relation.map(map, data = data, relation = "cross.info", relation.type = "grandmother", name = gettext("cross grandmother"), pie.size = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
		
			out_map = list("cross" = out_map_cross,
									 "father" = out_map_father,
									 "grandfather" = out_map_grandfather,
									 "mother" = out_map_mother,
									 "grandmother" = out_map_grandmother
									 )
		
	} else { out_map = NULL }

		
	out = list("network-reproduction-crossed" = list("barplot" = out_barplot, "map" = out_map))
	LIST.PLOTS = c(LIST.PLOTS, out)	
}


# 4. Plot for data- type ########## ----------

# 4.1. data-barplot ----------
if( check.arg("data-barplot", ggplot.type) ) {
	list.plots = NULL
	for(comb in combi) {
		x.axis = comb[1] # compulsory
		if( length(comb) == 2 ) { in.col = comb[2] } else { in.col = NULL } # optionnal
		out = get.ggplot_plot.it(d = data, titre = NULL, ggplot.display = "barplot", x.axis = x.axis, in.col = in.col, ggplot.type = "data-barplot", vec_variables = vec_variables, nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col)
		out = list(out)
		list.plots = c(list.plots, out)
	}
	
	if(!ggplot.type.dataS.dataSR){
		names(list.plots) = unlist(lapply(combi, function(x){paste(x[1], x[2], sep="-")}))
		list.plots = list("data-barplot" = list.plots)
	} else {
		names(list.plots) = "data-barplot" # In order to delete "expe_name-sl_statut"
	}
	LIST.PLOTS = c(LIST.PLOTS, list.plots)
}

# 4.2. data-boxplot ----------
if( check.arg("data-boxplot", ggplot.type) ) {		
	list.plots = NULL
	for(comb in combi) {
		x.axis = comb[1] # compulsory
		if( length(comb) == 2 ) { in.col = comb[2] } else { in.col = NULL } # optionnal
		out = get.ggplot_plot.it(d = data, titre = NULL, ggplot.display = "boxplot", x.axis = x.axis, in.col = in.col, ggplot.type = "data-boxplot", vec_variables = vec_variables, nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col)
		out = list(out)
		list.plots = c(list.plots, out)
	}

	if(!ggplot.type.dataS.dataSR){
		names(list.plots) = unlist(lapply(combi, function(x){paste(x[1], x[2], sep="-")}))
		list.plots = list("data-boxplot" = list.plots)
	} else {
		names(list.plots) = "data-boxplot" # In order to delete "expe_name-sl_statut"
	}
	LIST.PLOTS = c(LIST.PLOTS, list.plots)
}

# 4.3. data-interaction ----------
if( check.arg("data-interaction", ggplot.type) ) {
	list.plots = NULL
	for(comb in combi) {
		x.axis = comb[1] # compulsory
		if( length(comb) == 2 ) { in.col = comb[2] } else { in.col = NULL } # optionnal
		out = get.ggplot_plot.it(d = data, titre = NULL, ggplot.display = "interaction", x.axis = x.axis, in.col = in.col, ggplot.type = "data-interaction", vec_variables = vec_variables, nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col)
		out = list(out)
		list.plots = c(list.plots, out)
	}
	
	if(!ggplot.type.dataS.dataSR){
		names(list.plots) = unlist(lapply(combi, function(x){paste(x[1], x[2], sep="-")}))
		list.plots = list("data-interaction" = list.plots)
	} else {
		names(list.plots) = "data-interaction" # In order to delete "expe_name-sl_statut"
	}
	LIST.PLOTS = c(LIST.PLOTS, list.plots)
}

# 4.4. data-radar ----------
if( check.arg("data-radar", ggplot.type) & length(vec_variables) > 1 ) {
	list.plots = NULL
	for(in.col in combi_in.col) {
		out = get.ggplot_plot.it(d = data, titre = NULL, ggplot.display = "radar", x.axis = NULL, in.col = in.col, ggplot.type = "data-radar", vec_variables = vec_variables, nb_parameters_per_plot_x.axis = NULL, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col)
		out = list(out)
		list.plots = c(list.plots, out)
	} 
	names(list.plots) = paste("NA-", combi_in.col, sep = "")
	list.plots = list("data-radar" = list.plots)
	LIST.PLOTS = c(LIST.PLOTS, list.plots)
}
if( check.arg("data-radar", ggplot.type) & length(vec_variables) < 2 ) { warning("No radar plot because there is only one variable in vec_variables. You need at least two variables.") }

# 4.5. data-biplot ----------
if( check.arg("data-biplot", ggplot.type) & length(vec_variables) > 1 ) {
	list.plots = NULL
	for(in.col in combi_in.col) {
		out = get.ggplot_plot.it(d = data, titre = NULL, ggplot.display = "biplot", x.axis = NULL, in.col = in.col, ggplot.type = "data-biplot", vec_variables, nb_parameters_per_plot_x.axis = NULL, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col, labels.on = labels.on, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
		out = list(out)
		list.plots = c(list.plots, out)
	}
	names(list.plots) = paste("NA-", combi_in.col, sep = "")
	list.plots = list("data-biplot" = list.plots)
	LIST.PLOTS = c(LIST.PLOTS, list.plots)
}
if( check.arg("data-biplot", ggplot.type) & length(vec_variables) < 2 ) { warning("No biplot plot because there is only one variable in vec_variables. You need at least two variables.") }

# 4.6. data-pie.on.map ----------
if( check.arg("data-pie.on.map", ggplot.type) ) {
	colnames(data)[which(colnames(data) == x.axis)] = "x.axis"
	vec_x.axis = sort(unique(data$x.axis))
	
	list.plots = n = NULL
	for(var in vec_variables){
		data_var = data
		colnames(data_var)[which(colnames(data_var) == var)] = "variable"
		
		if( ggplot.on == "son" ){ 
			colnames(data_var)[which(colnames(data_var) == "son_lat")] = "lat" 
			colnames(data_var)[which(colnames(data_var) == "son_long")] = "long" 
			}
		if( ggplot.on == "father" ){ 
			colnames(data_var)[which(colnames(data_var) == "father_lat")] = "lat" 
			colnames(data_var)[which(colnames(data_var) == "father_long")] = "long" 
			}
				
		out = NULL

		for(x in vec_x.axis){
			data.map = filter(data_var, x.axis %in% x)

			# delete if info is missing for long and lat and put a message
			no_lat_or_long = unique(c(which(is.na(data.map$long)), which(is.na(data.map$lat))))
			if( length(no_lat_or_long) > 0 ) {
				text = paste(unique(as.character(data.map$person[no_lat_or_long])), collapse = ", ")
				warning(paste(x, collapse = ", "), ": ",text, " have no information for coordinates and are not represented on the map.")
				data.map = data.map[-no_lat_or_long,]
			}
			
			if( !is.null(hide.labels.parts) ) { if( hide.labels.parts != "all" ){ stop("With ggplot.type \"network-\" and ggplot.display = \"map\" hide.labels.parts can be NULL or \"all\".") } }
			
			p = get.ggplot_pie.on.ggplot(map, data = data.map, variable = "variable", factor = "person", x.origin = "long", y.origin = "lat", r = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size) 		
			p = p + scale_fill_gradient(low = "green", high = "red", name = var)
			p = p + ggtitle(paste(x, collapse = ", "))
			
			n = c(n, paste("map-[", paste(x, collapse = ", "), "]", sep = ""))
			
			out = c(out, list(p))
		}
		names(out) = n
		out = list(out)
		list.plots = c(list.plots, out)
	}
	names(list.plots) = vec_variables
	list.plots = list("data-pie.on.map" = list.plots)
	LIST.PLOTS = c(LIST.PLOTS, list.plots)
		}

# 4.7. data-pie.on.network ----------
if( check.arg("data-pie.on.network", ggplot.type) ) {
	
	if( ggplot.on == "son" ){ colnames(data)[which(colnames(data) == "son")] = "sl" }
	if( ggplot.on == "father" ){ colnames(data)[which(colnames(data) == "father")] = "sl" }
	
	list.plots = NULL
	for(var in vec_variables){
		vec_sl = unique(as.character(data$sl))
		
		test = unique(is.element(vec_sl, get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "seed.lots")$data))
		encrypt = length(test) == 1 & !test

		if(encrypt){
			
			v = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "person")$data
			vec = paste("person-", c(1:length(v)), sep = ""); names(vec) = v
			vec_person = vec
			
			v = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "year")$data
			vec = c(2000:(2000+length(v))); names(vec) = v
			vec_year = vec
			
			v = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "germplasm")$data
			vec = paste("germplasm-", c(1:length(v)), sep = ""); names(vec) = v
			vec_germplasm = vec
			
			reverse_encrypt_sl = function(sl, vec_germplasm, vec_person, vec_year){
				a = unlist(strsplit(as.character(sl), "_"))
				gs = as.character(a[1])
				gs = unlist(strsplit(as.character(gs), "#"))
				g = names(vec_germplasm)[which(vec_germplasm == as.character(gs[1]))]
				if( is.na(gs[2]) ) { s = NULL } else { s = paste("#", gs[2], sep = "") }
				p = names(vec_person)[which(vec_person == as.character(a[2]))]
				y = names(vec_year)[which(vec_year == as.character(a[3]))]
				d = as.character(a[4])
				sl = paste(g, s, "_", p, "_", y, "_", d, sep = "")
				return(sl)
			}
			
			vec_sl = sapply(vec_sl, reverse_encrypt_sl, vec_germplasm, vec_person, vec_year)
			}
		
		n = get.data(db_user = info_db$db_user, db_host = info_db$db_host, db_name = info_db$db_name, db_password = info_db$db_password, query.type = "network", seed.lot.in = vec_sl, filter.on = "father-son", network.info = FALSE)
		
		if(encrypt){ n = encrypt.data(n) }
		
		n = n$data
		
		p = get.ggplot_plot.network(n, vertex.color, vertex.size, hide.labels.parts, display.labels.sex, labels.generation, organise.sl = organise.sl, labels.size = labels.size)
		p_net = p$pnet
		plotcoord = p$plotcoord
		colnames(plotcoord)[which(colnames(plotcoord) == "id")] = "sl"
		d_tmp = join(data[,c("sl", var)], plotcoord, by = "sl")
		tokeep = which(!is.na(d_tmp[,var]))
		d_tmp = d_tmp[tokeep,]
		d_tmp$sl = factor(d_tmp$sl)

		p = get.ggplot_pie.on.ggplot(p_net, data = d_tmp, variable = var, factor = "sl", x.origin = "X1", y.origin = "X2", r = pie.size*5, hide.labels.parts = hide.labels.parts, labels.size = labels.size)
		# pie.size*5 to oversize the vertex size
		
		p = p + scale_fill_gradient(low = "green", high = "red", name = var)
		
		out = list("network" = p_net, "pie.on.network" = p)
		out = list(out)
		list.plots = c(list.plots, out)
	}
	names(list.plots) = vec_variables
	list.plots = list("data-pie.on.network" = list.plots)
	LIST.PLOTS = c(LIST.PLOTS, list.plots)
	}
	
return(LIST.PLOTS)
}


