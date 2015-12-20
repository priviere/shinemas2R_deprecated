get.ggplot_network.relation.map = function(map, data, relation = "reproduction", relation.type = "recolte", name = "harvested seed-lots", pie.size, hide.labels.parts, labels.size){	
	
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
	
	all_year = sort(unique(as.numeric(as.character(net.info$year))))
	
	tmp = NULL
	for(i in all_year){tmp = c(tmp, list(i))}
	all_year = c(tmp, list(all_year))
	
	out = list()
	n = NULL
	
	for(y in all_year){
		net.info_tmp = filter(net.info, year %in% y)
		
		net.info.map = ddply(net.info_tmp, "person", summarise, variable = sum(variable))
		net.info.map = join(net.info.map, unique(net.info[,c("person", "long", "lat")]), by = "person")
		
		# delete if info is missing for long and lat and put a message
		no_lat_or_long = unique(c(which(is.na(net.info.map$long)), which(is.na(net.info.map$lat))))
		if( length(no_lat_or_long) > 0 ) {
			text = paste(as.character(net.info.map$person[no_lat_or_long]), collapse = ", ")
			warning(paste(y, collapse = ", "), ": ",text, " have no information for coordinates and are not represented on the map.")
			net.info.map = net.info.map[-no_lat_or_long,]
		}
		
		if( !is.null(hide.labels.parts) ) { if( hide.labels.parts != "all" ){ stop("With ggplot.type \"network-\" and ggplot.display = \"map\" hide.labels.parts can be NULL or \"all\".") } }
		
		p = get.ggplot_pie.on.ggplot(map, data = net.info.map, variable = "variable", factor = "person", x.origin = "long", y.origin = "lat", r = pie.size, hide.labels.parts = hide.labels.parts, labels.size = labels.size) 		
		t = tapply(net.info.map$variable, net.info.map$person, sum, na.rm = TRUE); min = min(t); max = max(t)	
		p = p + scale_fill_gradient(low = "green", high = "red", name = name, limits = c(min, max))
		p = p + ggtitle(paste(y, collapse = ", "))
		
		n = c(n, paste("map-[", paste(y, collapse = ", "), "]", sep = ""))
		
		out = c(out, list(p))
	}
	names(out) = n
	out = list("map" = out)
	return(out)
}
