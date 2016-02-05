# 0. help -----------------------------------------------------------------
#' Plot a network with ggplot2 based on GGally::ggnet
#'
#' @param net an object of class \code{igraph} or \code{network}. If the object is of class \code{igraph}, the \link[intergraph:asNetwork]{intergraph} package is used to convert it to class \code{network}.
#' 
#' @param mode a placement method from the list of modes provided in the \link[sna:gplot.layout]{sna} package. Defaults to the Fruchterman-Reingold force-directed algorithm. If \code{mode} is set to \code{"geo"} and \code{net} contains two vertex attributes called \code{"lat"} and \code{"lon"}, these are used instead for geographic networks.
#' 
#' @param layout.par options to the placement method, as listed in \link[sna]{gplot.layout}.
#' 
#' @param size size of the network nodes. Defaults to 12. If the nodes are weighted, their area is
#'  proportionally scaled up to the size set by \code{size}.
#'  
#' @param alpha a level of transparency for nodes, vertices and arrows. Defaults to 0.75.
#' 
#' @param weight.method a weighting method for the nodes. Accepts \code{"indegree"}, \code{"outdegree"} or \code{"degree"} (the default). Set to \code{"none"} to plot unweighted nodes.
#' 
#' @param names a character vector of two elements to use as legend titles for the node groups and node weights. Defaults to empty strings.
#' 
#' @param node.group a vector of character strings to label the nodes, of the same length and order as the vertex names. Factors are converted to strings prior to plotting.
#' 
#' @param node.color a vector of character strings to color the nodes, holding as many colors as there are levels in \code{node.group}. Tries to default to \code{"Set1"} if missing.
#' 
#' @param node.alpha transparency of the nodes. Inherits from \code{alpha}.
#' 
#' @param segment.alpha transparency of the vertex links. Inherits from \code{alpha}.
#' 
#' @param segment.color color of the vertex links. Defaults to \code{"grey"}.
#' 
#' @param segment.size size of the vertex links, as a vector of values or as a single value. Defaults to 0.25.
#' 
#' @param segment.label labels for the vertex links at mid-edges. Label size will be set to 1 / \code{segment.size}, and label alpha will inherit from \code{alpha}.
#' 
#' @param arrow.size size of the vertex arrows for directed network plotting, in centimeters. Defaults to 0.
#' 
#' @param label.nodes label nodes with their vertex names attribute. If \code{TRUE}, all nodes are labelled. Also accepts a vector of character strings to match with vertex names.
#' 
#' @param top8.nodes use the top 8 nodes as node groups, colored with \code{"Set1"}. The rest of the network will be plotted as the ninth (grey) group. Experimental.
#' 
#' @param trim.labels removes '@@', 'http://', 'www.' and the ending '/' from vertex names. Cleans up labels for website and Twitter networks. Defaults to \code{TRUE}.
#' 
#' @param quantize.weights breaks node weights to quartiles. Fails when quartiles do not uniquely identify nodes.
#' 
#' @param subset.threshold deletes nodes prior to plotting, based on \code{weight.method} < \code{subset.threshold}. If \code{weight.method} is unspecified, total degree (Freeman's measure) is used. Defaults to 0 (no subsetting).
#' 
#' @param geo.outliers when \code{mode} is set to \code{"geo"}, trim geographic outliers (10% of most distant nodes). Defaults to \code{TRUE}.
#' 
#' @param legend.position location of the captions for node colors and weights. Accepts all positions supported by ggplot2 themes. Defaults to "right".
#' 
#' @param ... other arguments supplied to geom_text for the node labels. Arguments pertaining to the title or other items can be achieved through ggplot2 methods.
#' 
#' @seealso \code{\link{get.plot}}
#' 
#' @author Moritz Marbach and Francois Briatte for the core function. Pierre Rivière for the little changes in the output.
#' 
#' @details 
#' ggnet.custom is based on GGally::gget and returns two objects: the network and the matrix with the coordinates of each edge of the network.
#' This funtion, used in get.plot, is based on ggnet function from Gapply package coded by Moritz Marbach and Francois Briatte
#' for details see https://github.com/briatte/ggnet/blob/master/ggnet.R
#' 
#' The \code{weight.method} argument produces visually scaled nodes that are proportionally sized to their unweighted degree. To compute weighted centrality or degree measures, see Tore Opsahl's \code{tnet} package.
#' 
get.ggplot_ggnet.custom = function (net, mode = "fruchtermanreingold", layout.par = NULL, 
    size = 12, alpha = 0.75, weight.method = "none", names = c("", 
        ""), node.group = NULL, node.color = NULL, node.alpha = NULL, 
    segment.alpha = NULL, segment.color = "grey", segment.label = NULL, 
    segment.size = 0.25, arrow.size = 0, label.nodes = FALSE, 
    label.size = size/2, top8.nodes = FALSE, trim.labels = TRUE, 
    quantize.weights = FALSE, subset.threshold = 0, legend.position = "right", organise.sl = TRUE,
    ...) 
{
#    require(intergraph, quietly = TRUE)
#    require(network, quietly = TRUE)
#    require(RColorBrewer, quietly = TRUE)
#    require(sna, quietly = TRUE)
    if (class(net) == "igraph") { net = asNetwork(net) }
    if (class(net) != "network") 
        stop("net must be a network object of class 'network' or 'igraph'")
    vattr = network::list.vertex.attributes(net)
    weight = c("indegree", "outdegree", vattr)
    weight = ifelse(weight.method %in% weight | length(weight.method) > 
        1, weight.method, "freeman")
    quartiles = quantize.weights
    labels = label.nodes
    inherit <- function(x) ifelse(is.null(x), alpha, x)
    if (subset.threshold > 0) {
        network::delete.vertices(net, which(sna::degree(net, 
            cmode = weight) < subset.threshold))
    }
    m <- as.matrix.network.adjacency(net)
        
    if (mode == "geo" & all(c("lat", "lon") %in% vattr)) {
        plotcord = data.frame(X1 = as.numeric(net %v% "lon"), X2 = as.numeric(net %v% "lat"))
        plotcord$X1[abs(plotcord$X1) > quantile(abs(plotcord$X1), 0.9, na.rm = TRUE)] = NA
        plotcord$X2[is.na(plotcord$X1) | abs(plotcord$X2) > quantile(abs(plotcord$X2), 0.9, na.rm = TRUE)] = NA
        plotcord$X1[is.na(plotcord$X2)] = NA
    } else {
        placement <- paste0("gplot.layout.", mode)
        if (!exists(placement)) 
            stop("Unsupported placement method.")
        plotcord <- do.call(placement, list(m, layout.par))
        plotcord <- data.frame(plotcord)
        colnames(plotcord) = c("X1", "X2")
    }
    
    
    edglist <- as.matrix.network.edgelist(net)
    edges <- data.frame(plotcord[edglist[, 1], ], plotcord[edglist[, 2], ])

    if (!is.null(node.group)) {
        network::set.vertex.attribute(net, "elements", as.character(node.group))
        plotcord$group <- as.factor(network::get.vertex.attribute(net, 
            "elements"))
    }
    degrees <- data.frame(id = network.vertex.names(net), indegree = sapply(net$iel, 
        length), outdegree = sapply(net$oel, length))
    degrees$freeman <- with(degrees, indegree + outdegree)
    if (length(weight.method) == network.size(net)) {
        degrees$user = weight.method
        weight = "user"
    }
    if (weight.method %in% vattr) {
        degrees$user = net %v% weight.method
        names(degrees)[ncol(degrees)] = weight.method
        weight = weight.method
    }
    if (trim.labels) {
        degrees$id = gsub("@|http://|www.|/$", "", degrees$id)
    }
    if (top8.nodes) {
        all = degrees[, weight]
        top = degrees$id[order(all, decreasing = TRUE)[1:8]]
        top = which(degrees$id %in% top)
        plotcord$group = as.character(degrees$id)
        plotcord$group[-top] = paste0("(", weight, " > ", subset.threshold - 
            1, ")")
        node.group = plotcord$group
        node.color = brewer.pal(9, "Set1")[c(9, 1:8)]
    }
    colnames(edges) <- c("X1", "Y1", "X2", "Y2")
    plotcord$id <- as.character(degrees$id)
    if (is.logical(labels)) {
        if (!labels) {
            plotcord$id = ""
        }
    }     else {
        plotcord$id[-which(plotcord$id %in% labels)] = ""
    }
    edges$midX <- (edges$X1 + edges$X2)/2
    edges$midY <- (edges$Y1 + edges$Y2)/2
    
    
    # NEW : create segment.color
    b = net$mel
    relation = unlist(b)[grep("atl.relation", names(unlist(b)))]
    pal.relation = brewer.pal(9, "Set1")[c(9, 1:8)]
    pal.relation = pal.relation[1:length(unique(relation))]
    names(pal.relation) = unique(relation)
    segment.color = pal.relation[relation]
    
    edges$relation = relation
     
    # NEW: Reorganise seed-lots to better visualisation
    if(organise.sl){
    	a = plotcord
    	a$names = network.vertex.names(net)
    	a$g = sapply(a$names, function(x){ unlist(strsplit(x, "_"))[1] })
    	a$p = sapply(a$names, function(x){ unlist(strsplit(x, "_"))[2] })
    	a$y = sapply(a$names, function(x){ unlist(strsplit(x, "_"))[3] }) 
    	
    	b = edges
    	
    	# create a grid to put the seed-lots
    	sy = summary(factor(a$y))
    	sp = summary(factor(a$p))
    	
    	grid = matrix(0, ncol = length(sy), nrow = sum(sp))    	
    	col = c(1:length(sy)); names(col) = names(sy)
    	row = c(1: sum(sp)); names(row) = rep(names(sp), as.vector(sp))

    	# place the sl onthe grid
    	for(i in 1:nrow(a)) {
    		x1 = col[a$y[i]]
    		x2 = sample(row[grep(a$p[i], names(row))], 1)
    		
    		r = b[which( b$X1 == a$X1[i] & b$Y1 == a$X2[i] ), "relation"]
    		if( is.element("diffusion", r) ) { x1 = x1 + 0.5 }

    		b[which( b$X1 == a$X1[i] ), "X1"] = x1
    		b[which( b$Y1 == a$X2[i] ), "Y1"] = x2
    		b[which( b$X2 == a$X1[i] ), "X2"] = x1
    		b[which( b$Y2 == a$X2[i] ), "Y2"] = x2
    		a$X1[i] = x1
    		a$X2[i] = x2
    		
    	}
    	
    	plotcord$X1 = a$X1
    	plotcord$X2 = a$X2
    	
    	edges$X1 = b$X1
    	edges$Y1 = b$Y1
    	edges$X2 = b$X2
    	edges$Y2 = b$Y2	
    }
    
    
    pnet <- ggplot()
    pnet = pnet + geom_segment(aes(x = X1, y = Y1, xend = X2, yend = Y2, linetype = relation), data = edges, size = segment.size, alpha = inherit(segment.alpha), arrow = arrow(type = "closed", length = unit(arrow.size, "cm")))    
    
#    if (!is.null(segment.label) & length(segment.label) == nrow(edges)) {
#        pnet <- pnet + geom_text(aes(x = midX, y = midY), colour = segment.color, data = edges, label = segment.label, size = 1/segment.size, alpha = inherit(segment.alpha))
#    }




    if (weight.method == c("none")) {
       pnet <- pnet + geom_point(data = plotcord, aes(x = X1, y = X2, color = group), alpha = inherit(node.alpha), size = size)
    	}     else {
        plotcord$weight <- degrees[, weight]
        cat(nrow(plotcord), "nodes, weighted by", weight, "\n\n")
        print(head(degrees[order(-degrees[weight]), ]))
        sizer <- scale_size_area(names[2], max_size = size)
        if (quartiles) {
            plotcord$weight.label <- cut(plotcord$weight, breaks = quantile(plotcord$weight), 
                include.lowest = TRUE, ordered = TRUE)
            plotcord$weight <- as.integer(plotcord$weight.label)
            sizer <- scale_size_area(names[2], max_size = size, 
                labels = levels(plotcord$weight.label))
        }
        pnet <- pnet + geom_point(aes(size = weight), data = plotcord, 
            alpha = inherit(node.alpha)) + sizer
    }
    
    n = length(unique(suppressWarnings(na.omit(node.group))))
    if (length(node.color) != n & !is.null(node.group)) {
        warning("Node groups and node colors are of unequal length; using default colors.")
        if (n > 0 & n < 10) {
            node.color = brewer.pal(9, "Set1")[1:n]
        }
    }
        
    if (!is.null(node.group)) {

    	
#    	       pnet <- pnet + aes(colour = group) 
    	       
    }
    
#    if (length(unique(plotcord$id)) > 1 | unique(plotcord$id)[1] != 
#        "") {
#        pnet <- pnet + geom_text(aes(label = id), size = label.size, 
#            ...)
#    }

pnet <- pnet + scale_x_continuous(breaks = NULL) + scale_y_continuous(breaks = NULL) + 
        theme(panel.background = element_rect(fill = "white"), 
            panel.grid = element_blank(), axis.title = element_blank(), 
            legend.key = element_rect(colour = "white"), legend.position = legend.position)


names(node.color) = sort(unique(node.group))

pnet = pnet + scale_fill_manual(name="Group", values = node.color)


    return(list("plotcoord" = plotcord, "pnet" = pnet))
}
