#' Function used in get.ggplot
#' @description
#' hide parts of seed-lots labels
#' 
get.ggplot_hide.labels.part = function(label, hide.labels.parts) {
	if( !is.null(hide.labels.parts)){
		label = as.character(label)
		gs = sapply(label, function(x){unlist(strsplit(x,"_"))[1]})
		g = sapply(gs, function(x){unlist(strsplit(x,"#"))[1]})
		s = sapply(gs, function(x){unlist(strsplit(x,"#"))[2]})
		p = sapply(label, function(x){unlist(strsplit(x,"_"))[2]})
		y = sapply(label, function(x){unlist(strsplit(x,"_"))[3]})
		d = sapply(label, function(x){unlist(strsplit(x,"_"))[4]})					
		
		if(hide.labels.parts == "all") { label = "" }
		if(hide.labels.parts == "germplasm") { label = paste(s, p, y, sep = "_") }
		if(hide.labels.parts == "person") { label = paste(gs, y, sep = "_") }
		if(hide.labels.parts == "year") { label = paste(gs, p, sep = "_") }
		if(hide.labels.parts == "person:germplasm") { label = paste(s, y, sep = "_") }
		if(hide.labels.parts == "year:germplasm") { label = paste(s, p, sep = "_") }
		if(hide.labels.parts == "person:year") { label = gs }	
		label = sapply(label, function(x){sub("NA_", "", x)}) # if s is missing
	} else { label = label }
	
	return(label)
}
