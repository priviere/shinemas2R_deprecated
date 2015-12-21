# 0. help -----------------------------------------------------------------
#' Display pies on ggplot object such as network or map within \code{get.ggplot}
#'
#' @description
#' \code{get.ggplot_pie.on.ggplot} display pies on ggplot object such as network or map
#'
#' @param ggplot a ggplot object on wich put the pies
#' 
#' @param data A data set with at least four columns: the variable, the factor, the X and Y coordinates for the pie.
#' 
#' @param variable Name of the column of data with the variable
#'
#' @param factor Name of the column of data with the factor. factor is a location.
#'
#' @param x.origin the x origin of the pie
#' 
#' @param y.origin the y origin of the pie
#' 
#' @param r the radius of the pie. If the radius is too big and the pie do not fit on the ggplot object, an error is returned.
#' 
#' @param hide.labels.parts see hide.labels.parts argument in \code{get.ggplot}
#' 
#' @param label.size Size of the label. label correspond to factor
#' 
#' @param precision The precision in the drawing of the pie. The higher the better.
#' 
#' @return The function returns a ggplot with pies on it 
#' 
#' @author Pierre Rivière
#'
get.ggplot_pie.on.ggplot = function(
	ggplot, 
	data,
	variable,
	factor,
	x.origin = 1, 
	y.origin = 1, 
	r = 1, 
	hide.labels.parts = NULL,
	labels.size = 2,
	precision = 10000)
{
	
ggplot.tmp = ggplot	

if(!is.factor(data[1, factor])) { stop(factor, "must be a factor") }

colnames(data)[which(colnames(data) == factor)] = "factor"
todo = as.character(unique(data$factor)) # add a pie for each level of the factor

colnames(data)[which(colnames(data) == x.origin)] = "x.origin"
colnames(data)[which(colnames(data) == y.origin)] = "y.origin"
colnames(data)[which(colnames(data) == variable)] = "variable"


for(do in todo) {
	
	d = droplevels(filter(data, factor == do))
	d = arrange(d, variable)
	
	if( length(unique(as.character(d[1, "x.origin"]))) > 1 ) { stop("It must be the same value in the x.origin column for a given level of factor") }
	if( length(unique(as.character(d[1, "y.origin"]))) > 1 ) { stop("It must be the same value in the y.origin column for a given level of factor") }

	x.ori = d[1, "x.origin"]
	y.ori = d[1, "y.origin"]
	
	ids = factor(c(1:nrow(d)))
	values = as.numeric(as.character(d$variable)); names(values) = ids
	proportions = rep(1 / length(ids), times = length(ids)); names(proportions) = ids
	
	x1 = seq(-r, r, length.out = precision); y1 = sqrt(r^2 - x1^2) # because of pythagore sqrt(x^2 + y^2) = r
	x2 = seq(r, -r, length.out = precision); y2 = - sqrt(r^2 - x2^2) # because of pythagore sqrt(x^2 + y^2) = r
	
	x = c(x1, x2); y = c(y1, y2)
	x = x + x.ori; y = y + y.ori
	
	
	dgg = ggplot$data	
	
	test = colnames(dgg)[1] == "long"
	if( is.null(test) ) { test = FALSE }
	if( length(test) == 0 ) { test = FALSE }

	if(test) { # check if the pie fit ont the map when putting plots on map

		lon.range = range(dgg$long)
		test.x = unique(x)
		test.x = length(test.x) == 1 & is.na(test.x[1])
		if( !test.x ) { x.range = range(x, na.rm = TRUE) } else { x.range = c(NA, NA) }
		
		lat.range = range(dgg$lat, na.rm = TRUE)
		test.y = unique(y)
		test.y = length(test.y) == 1 & is.na(test.y[1])
		if( !test.y ) { y.range = range(y, na.rm = TRUE) } else { y.range = c(NA, NA) }
		
		continue = TRUE
		if( is.na(x.range[1]) | is.na(x.range[2]) |	is.na(y.range[1]) | is.na(y.range[2]) ) { warning("No pie for ", do, " because there are no information on coordinates."); continue = FALSE }
		if(continue) { 
			if( x.range[1] < lon.range[1] | x.range[2] > lon.range[2] | y.range[1] < lat.range[1] | y.range[2] > lat.range[2] ) { stop("pie.size is too big and pie does not fit on the map.") }
		}
		 
	} else { continue = TRUE }
	
	if(continue) {
		peri = c(0, sqrt((x[2:length(x)] - x[1:(length(x)-1)])^2 + (y[2:length(y)] - y[1:(length(y)-1)])^2 )) # because of pythagore
		
		a = cumsum(proportions)
		p = sum(peri) # = 2 * pi * r
		
		b = NULL; for(i in 1:length(a)) { b = c(b, p * a[i]) } # Get the portion of perimeter for each element of "a"
		
		tt = NULL; for(i in 1:length(b)) { tt = c(tt, max(which(cumsum(peri) <= b[i]))) }
		
		b = c(0, tt)
		cx = cy = id = NULL
		for(i in 1:(length(b)-1)) {	
			t = c((b[i]+1):b[i+1])
			cx = c(cx, x.ori, x[t])
			cy = c(cy, y.ori, y[t])
			id = c(id, rep(names(a)[i], times = (length(t) + 1)))
		}
		
		datapoly <- data.frame(id = id, x = cx, y = cy, value = values[id])
		
		ggplot.tmp = ggplot.tmp + geom_polygon(data = datapoly, aes(x = x, y = y, fill = value, group = id, colour = NULL)) # colour = NULL to delete the aes(colour = group) in ggplot argument (for example ggnet.custom)
	}
}

	p = ggplot.tmp + coord_fixed() # to have perfect circle	

	# labels
	data$lab = sapply(data$factor, get.ggplot_hide.labels.part, hide.labels.parts)
	data = unique(data[,c("factor", "x.origin", "y.origin", "lab")])
	
	p = p + geom_text(data = data, aes(x = x.origin, y = y.origin, label = lab), size = labels.size)
	
	return(p)
}

