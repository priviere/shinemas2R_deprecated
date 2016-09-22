#' Function use in get.ggplot
#' @description
#' get network representation in ggplot
#' 
get.ggplot_plot.network = function(data, vertex.color, vertex.size, hide.labels.parts, display.labels.sex, labels.generation, organise.sl, labels.size = 1) {
	n = data$network
	
	if(!is.null(vertex.color)) { 
		if(vertex.color == "year" | vertex.color == "person" | vertex.color == "germplasm") {
			gp = (get.vertex.attribute(n, vertex.color))	
			col.vertex = hue_pal()(length(unique(get.vertex.attribute(n, vertex.color)))) # hue_pal from scale show_col(hue_pal()(10))	
		}
	} else { gp = col.vertex = NULL }
	
	label.edge = NULL
	
	if(labels.generation == "local") { 
		b = n$mel
		label.edge = unlist(b)[grep("atl.generation_local", names(unlist(b)))] 
	}
	
	if(labels.generation == "total") { 
		b = n$mel
		label.edge = unlist(b)[grep("atl.generation_total", names(unlist(b)))] 
	}
	
	label.vertex = get.vertex.attribute(n, "vertex.names") 
	
	p = get.ggplot_ggnet.custom(n, size = vertex.size, node.group = gp, node.color = col.vertex, label.nodes = label.vertex, segment.color = col.edge, segment.label = label.edge, organise.sl = organise.sl)
	plotcoord = p[[1]]
	pnet = p[[2]]
	
	# add text labels
	if(is.null(hide.labels.parts)) { 
		label = label.vertex 
	} else { 
		label = unlist(lapply(label.vertex, get.ggplot_hide.labels.part, hide.labels.parts))
	}
	
	if( is.null(hide.labels.parts)){ hide.labels.parts = "NULL"}
	if(display.labels.sex & hide.labels.parts != "all") { 
		sex = as.character(get.vertex.attribute(n, "sex"))
		w = which(sex != "" )
		label[w] = paste(label[w], sex[w], sep = "-")
	}
	
	d = cbind.data.frame(plotcoord, label)
	pnet = pnet + geom_text(data = d, aes(x = X1, y = X2, label = label), size = labels.size)	
	
	return(list("pnet"= pnet, "plotcoord" = plotcoord))
}