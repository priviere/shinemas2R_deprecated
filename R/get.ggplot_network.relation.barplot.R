#' Function use in get.ggplot
#' @description
#' draw barplot for network relations
#' 
get.ggplot_network.relation.barplot = function(data, combi, relation = "reproduction", relation.type = "recolte", name = "harvested seed-lots", nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col, ggplot.type){
	
	if(relation == "cross.info") {
		net.info = droplevels(filter(data$network.info, cross.info %in% relation.type))
		net.info$variable = as.numeric(net.info$cross) # to get a column of 1		
	}
	
	if(relation == "reproduction") {
		net.info = droplevels(filter(data$network.info, reproduction %in% relation.type))
		net.info$variable = as.numeric(net.info$reproduction) # to get a column of 1		
	}
	
	if(relation == "diffusion") {
		net.info = droplevels(filter(data$network.info, diffusion %in% relation.type))
		net.info$variable = as.numeric(net.info$diffusion) # to get a column of 1		
	}
	
	if(relation == "mixture") {
		net.info = droplevels(filter(data$network.info, mixture %in% relation.type))
		net.info$variable = as.numeric(net.info$mixture) # to get a column of 1		
	}
	
	if(relation == "selection") {
		net.info = droplevels(filter(data$network.info, selection %in% relation.type))
		net.info$variable = as.numeric(net.info$selection) # to get a column of 1		
	}

	if( nrow(net.info) > 0 ){
		net.info.barplot = plyr::rename(net.info, replace = c(variable = name))
		
		p_barplot = NULL	
		
		for(comb in combi) {
			x.axis = comb[1] # compulsory
			if( length(comb) == 2 ) { in.col = comb[2] } else { in.col = NULL } # optionnal
			p = get.ggplot_plot.it(d = net.info.barplot, titre = NULL, ggplot.display = "barplot", vec_variables = name, x.axis = x.axis, in.col = in.col, ggplot.type = ggplot.type, nb_parameters_per_plot_x.axis = nb_parameters_per_plot_x.axis, nb_parameters_per_plot_in.col = nb_parameters_per_plot_in.col)	
			p_barplot = c(p_barplot, p)
		}
		names(p_barplot) = unlist(lapply(combi, function(x){paste(x[1], x[2], sep="-")}))
		
		out = list("barplot" = p_barplot)
	} else { out = NULL }
	
	return(out)
}