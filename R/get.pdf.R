# 0. help -----------------------------------------------------------------
#' Get a pdf by concatenating outputs from \code{get.ggplot} and \code{get.table}
#'
#' @description
#' \code{get.pdf} generates a pdf file using LaTeX
#'
#' @param dir Directory where the pdf should be created
#'
#' @param form.name Name of the pdf file and the folder that contains all the raw information. See details.
#' 
#' @param LaTeX_head Path of tex file containing the head of the LaTeX document. It contains the packages and macros used in LaTeX_body. If NULL, a default LaTeX head is generated.
#' 
#' @param LaTeX_body A list that contains the elements to be displayed in the pdf.
#' This list must contain the following elements:
#' 
#' \itemize{
#' 	\item "titlepage": a list containing the following elements:
#' 	\itemize{
#' 		\item "title": the title of the document. Nothing by default.
#' 		\item "authors": the authors of the document. Nothing by default.
#' 		\item "email": the corresponding email. Nothing by default.
#' 		\item "date": the date of the document. Nothing by default.
#' 	}
#' 	
#' 	\item "tableofcontents": if TRUE, a table of content is displayed.
#' 	
#' 	\item "chapter": name of a chapter
#' 	
#' 	\item "section": name of a section
#' 	
#' 	\item "subsection": name of a subsection
#' 	
#' 	\item "subsubsection": name of a subsubsection
#' 	
#' 	\item "text": text to add
#' 	
#' 	\item "includepdf": path of a .pdf to include. It includes entire document.
#' 	
#' 	\item "includeimage": a list containing the following elements:
#' 	\itemize{
#' 	 \item "content": path of image to include. It can be a pdf, png, jpeg ...
#' 	 \item "caption": caption of the image
#' 	\item "width" : width of the picture in textwidth unit. 1 means the same width as the text. It is 1 by default.
#' 	}
#' 	
#' 	\item "input": path of a .tex to insert
#' 	
#' 	\item "table": a list containing the following elements:
#' 	\itemize{
#' 		\item "content": output from \code{get.table}
#' 		\item "caption": caption of the table
#' 		\item "landscape": If TRUE, the table is in landscape. FALSE by default.
#' 		\item "display.rownames": If TRUE, displays the row names of the table. FALSE by default.
#' 	}
#' 	
#' 	\item "figure": a list containing the following elements:
#' 	\itemize{
#' 		\item "content" : output from \code{get.ggplot}
#' 		\item "caption" : caption of the figure
#' 		\item "layout" : the layout of the plots. It is a matrix under the form layout = matrix(c(1:4), ncol = 2, nrow = 2). It is layout = matrix(1, ncol = 1, nrow= 1) by default.
#' 		\item "width" : width of the figure in textwidth unit. 1 means the same width as the text. It is 1 by default.
#' 		\item "landscape" : If TRUE, the figure is in landscape. FALSE by default.
#' 	}
#' 	}
#' 	
#' @param compile.tex If TRUE compile the pdf.
#' 
#' @param color1 For table, color of the head of the table. White by default.
#'
#' @param color2 For table, color of the row. White by default. The color of the rows is an alternation of white and color2.
#' 
#' 
#' @details 
#' The function creates one folder named "form.name" (first argument of the function).
#' This folder contains two folders: "figures" where all the pdf of the plots are stored and "tex.files" where all the .tex generated are stored.
#' The pdf generated is moved from "./form.name/tex.files" to the current directory.
#' 
#' Note this function works if you have installed LaTeX and the following packages: longtable, lscape, graphicx, pdfpages, float, hyperref and fancyhdr.
#' To download LaTeX, go to http://latex-project.org/ftp.html
#' 
#' Note that the argument [H] from the package float is used by default for figures and tables.
#' 
#' If you use LaTeX macro, do not forget to use escape mode, for example \code{\\textbf{}}.
#' 
#' @return The function returns a pdf which is the result of the concatenation as well as folders with raw data (see Details).
#' 
#' @author Pierre Riviere
#' 
#' @examples 
#' # See the vignette
#' 
#' @seealso \code{\link{get.ggplot}}, \code{\link{get.table}}
#' 
get.pdf = function(
	dir = "./",
	form.name,
	LaTeX_head = NULL,
	LaTeX_body,
	compile.tex = TRUE,
	color1 = "white",
	color2 = "white"
)
	# lets go !!! ----------
{
	# 1. Error messages ----------
	a = dir(dir)
	if( !file.exists(dir) ){ stop("directory ", dir, " does not exist.") }
	setwd(dir)
	
	n = unique(names(LaTeX_body))
	n.ok = c("titlepage", "tableofcontents", "chapter", "section", "subsection", "subsubsection", "table", "figure", "text", "includepdf", "input")
	test = n[which(!is.element(n, n.ok))]
	
	if(length(test) > 0) {
		if(length(test) == 1) { toprint = test }
		if(length(test) > 1) { toprint = paste(test, collapse = ", ") }
		stop(paste(toprint," is not an element of LaTeX_body. Possibles elements are : ", paste(n.ok, collapse = ", "), ".", sep = ""))
	}
	
	for(i in 1:length(LaTeX_body)) {

		d = LaTeX_body[i]
		n = names(d)

		if( n == "titlepage" ) { 
			nnn = names(d[[1]])
			for( nn in nnn ) {
				if( !is.element(nn, c("title", "authors", "email", "date")) ) { stop("Elements of titlepage must be \"title\", \"authors\", \"email\" or \"date\".") } 
			}
			
			dd = d[["titlepage"]]
			
			t = dd[["title"]]; if(!is.null(t)) { 
				if(!is.null(names(t))) { stop("Elements of title within titlepage must be characters") } 
				if(!is.character(t)) { stop("Elements of title within titlepage must be characters") } 
			}
			
			t = dd[["authors"]]; if(!is.null(t)) { 
				if(!is.null(names(t))) { stop("Elements of authors within titlepage must be characters") } 
				if(!is.character(t)) { stop("Elements of authors within titlepage must be characters") } 
			}
			
			t = dd[["email"]]; if(!is.null(t)) { 
				if(!is.null(names(t))) { stop("Elements of email within titlepage must be characters") } 
				if(!is.character(t)) { stop("Elements of email within titlepage must be characters") } 
			}
			
			t = dd[["date"]]; if(!is.null(t)) { 
				if(!is.null(names(t))) { stop("Elements of date within titlepage must be characters") } 
				if(!is.character(t)) { stop("Elements of date within titlepage must be characters") } 
			}
		}
		
		if( n == "tableofcontents" ) { if ( !is.element(d[[1]], c(TRUE, FALSE)) ) { stop("Element of tableofcontents must be TRUE or FALSE") } }
		
		if( n == "chapter" ) { 
			if(!is.null(names(d[[1]]))) { stop("Elements of chapter must be characters") } 
			if(!is.character(d[[1]])) { stop("Elements of chapter must be characters") } 
		}
		
		if( n == "section" ) { 
			if(!is.null(names(d[[1]]))) { stop("Elements of section must be characters") } 
			if(!is.character(d[[1]])) { stop("Elements of section must be characters") } 
		}
		
		if( n == "subsection" ) { 
			if(!is.null(names(d[[1]]))) { stop("Elements of subsection must be characters") } 
			if(!is.character(d[[1]])) { stop("Elements of subsection must be characters") } 
		}
		
		if( n == "subsubsection" ) { 
			if(!is.null(names(d[[1]]))) { stop("Elements of subsubsection must be characters") } 
			if(!is.character(d[[1]])) { stop("Elements of subsubsection must be characters") } 
		}
		
		if( n == "table" ) { 
			nnn = names(d[[1]])
			for( nn in nnn ) {
				if( !is.element(nn, c("content", "caption", "landscape", "display.rownames")) ) { stop("Elements of table must be \"content\", \"caption\", \"landscape\", \"display.rownames\".") }
				}
						 
			dd = d[["table"]]
			
			# nothing for content
			
			t = dd[["caption"]]; if(!is.null(t)) { 
				if(!is.null(names(t))) { stop("Elements of caption within table must be characters") } 
				if(!is.character(t)) { stop("Elements of caption within table must be characters") } 
			}
			
			t = dd[["landscape"]]; if(!is.null(t)) { 
				if ( !is.element(t, c(TRUE, FALSE)) ) { stop("Element of landscape within table must be TRUE or FALSE") }
			}
			
			t = dd[["display.rows"]]; if(!is.null(t)) { 
				if ( !is.element(t, c(TRUE, FALSE)) ) { stop("Element of display.rows within table must be TRUE or FALSE") }
			}
		}
		
		if( n == "figure" ) { 
			nnn = names(d[[1]])
			for( nn in nnn ) {
				if( !is.element(nn, c("content", "caption", "layout", "width", "landscape")) ) { stop("Elements of figure must be \"content\", \"caption\", \"layout\", \"width\", \"landscape\".") } 
				}
			
			dd = d[["figure"]]
			
			# nothing for content
			
			t = dd[["caption"]]; if(!is.null(t)) { 
				if(!is.null(names(t))) { stop("Elements of caption within figure must be characters") } 
				if(!is.character(t)) { stop("Elements of caption within figure must be characters") } 
			}
			
			# nothing for layout
			
			t = dd[["width"]]; if(!is.null(t)) { 
				if ( !is.numeric(t) ) { stop("Element of width within table must be numeric") }
			}
			
			t = dd[["landscape"]]; if(!is.null(t)) { 
				if ( !is.element(t, c(TRUE, FALSE)) ) { stop("Element of landscape within table must be TRUE or FALSE") }
			}
			
			}

		if( n == "text" ) { 
			if(!is.null(names(d[[1]]))) { stop("Elements of text must be characters") } 
			if(!is.character(d[[1]])) { stop("Elements of text must be characters") } 
		}

		if( n == "includepdf" ) { 
			if(!is.null(names(d[[1]]))) { stop("Elements of includepdf must be a character") }
			if(!is.character(d[[1]])) { stop("Elements of includepdf must be a character") } 
			if( !file.exists(d[[1]]) ) { stop(d[[1]], " does not exist") }
		}
		
		
		if( n == "includeimage" ) { 
			
			dd = d[["includeimage"]]
			nnn = names(dd)
			for( nn in nnn ) {
				if( !is.element(nn, c("content", "caption", "width")) ) { stop("Elements of includeimage must be \"content\", \"caption\", \"width\".") }
			}
			
			t = dd[["caption"]]; if(!is.null(t)) { 
				if(!is.null(names(t))) { stop("Elements of caption within includeimage must be characters") } 
				if(!is.character(t)) { stop("Elements of caption within includeimage must be characters") } 
			}

			t = dd[["width"]]; if(!is.null(t)) { 
				if ( !is.numeric(t) ) { stop("Element of width within table must be numeric") }
			}
			
			t = dd["content"]; if(!is.null(t)) {
				if(!is.character(t) ) { stop("Elements of input must be a character") } 
				if( !file.exists(t) ) { stop(t, " does not exist ") }
			}
		}
		
		
	if( n == "input" ) { 
			if(!is.null(names(d[[1]]))) { stop("Elements of input must be a character") } 
			if(!is.character(d[[1]])) { stop("Elements of input must be a character") } 
			if( !file.exists(d[[1]]) ) { stop(d[[1]], " does not exist ") }
	}
		
	}

	
	# 2. create folders ----------
	we_are_here = getwd()
	setwd(dir)
	if( is.element(form.name, dir()) ) { stop("The folder ",form.name, " already exists ! Delete the folder ", form.name," or find a new name.") }
	system(paste("mkdir ", form.name, sep="")) # bug when there is not enought memory !!!
	setwd(form.name)
	system("mkdir tex.files")
	system("mkdir figures")
	
	# 3. functions used in get.pdf ----------
	text.to.tex = function(text = "bla bla_bla#ok") {
		list.tex = NULL
		for(i in 1 :length(text)) {
			S = unlist(strsplit(as.character(text[i]), ""))
			S[which(S=="#")] = "$\\sharp$"
			S[which(S=="_")] = "\\_"
			S[which(S=="%")] = "\\%"
			list.tex = c(list.tex , paste(S, collapse="") )
		}
		return(list.tex)
	}
	
	# 4. Open connection to write the .tex ---------- 
	sink(paste("./tex.files/", form.name,".tex", sep = ""))
	
	
	# 5. LaTeX head ----------
	message("1. Get LaTeX head ...")
	
	to.put.in.LaTeX.head = "
	\\documentclass[12pt]{book}

	% Package requiered
	\\usepackage{longtable}
	\\usepackage{lscape}
	\\usepackage{graphicx}
	\\usepackage{pdfpages}
	\\usepackage{float}
	\\usepackage[a4paper=true, colorlinks=true, linkcolor=black,urlcolor=blue, citecolor=black]{hyperref}
	\\usepackage{colortbl}

	% Footnote and headnote
	\\usepackage{fancyhdr}
	\\pagestyle{fancy}
	\\fancyhead{} % clear all header fields
	\\renewcommand{\\headrulewidth}{0pt} % no line in header area
	\\fancyfoot{} % clear all footer fields
	\\fancyfoot[LE,RO]{\\scriptsize  Empowered by SHiNeMaS} % page number in outer position of footer line
	\\fancyfoot[RE,LO]{} % other info in inner position of footer line
	
	% figures folder
	\\graphicspath{{../figures/}}

	\\begin{document}
	"
	
	if( is.null(LaTeX_head) ) { 
		cat(to.put.in.LaTeX.head)
		to.add.in.LaTeX_head = NULL
		}	else { 
		LaTeX_head = scan(paste(we_are_here, "/", LaTeX_head, sep = ""), "caracter", sep = "\n", quiet = TRUE) 
		
		# To add in LaTeX.head because it is compulsory
		
		test = function(to.add, x.check, x.toadd, LaTeX_head){ 
			a = NULL
			for(i in 1:length(x.check)) { a = c(a, grep(x.check[i], LaTeX_head)) }
			if( length(a) == 0 ) { 
				to.add = c(to.add, x.toadd); message(x.toadd, " has been added to LaTeX head.")
			} 
			return(to.add) 
		}

			to.add = NULL
			to.add = test(to.add, c("\\\\documentclass", "book}"), "\\documentclass[12pt]{book}", LaTeX_head)
			if( !is.null(to.add) ) { cat(to.add, sep = "\n") }
		
		to.add = NULL
		to.add = test(to.add, "longtable}", "\\usepackage{longtable}", LaTeX_head)
		to.add = test(to.add, "lscape}", "\\usepackage{lscape}", LaTeX_head)
		to.add = test(to.add, "graphicx}", "\\usepackage{graphicx}", LaTeX_head)
		to.add = test(to.add, "colortbl}", "\\usepackage{colortbl}", LaTeX_head)
		to.add = test(to.add, "pdfpages}", "\\usepackage{pdfpages}", LaTeX_head)
		to.add = test(to.add, "hyperref}", "\\usepackage[a4paper=true, colorlinks=true, linkcolor=black, urlcolor=blue, citecolor=black]{hyperref}", LaTeX_head)
		to.add = test(to.add, "float}", "\\usepackage{float}", LaTeX_head)
		to.add = test(to.add, "fancyhdr}", "\\usepackage{fancyhdr}", LaTeX_head)
		to.add = test(to.add, c("\\\\pagestyle", "fancy}"), "\\pagestyle{fancy}", LaTeX_head)
		to.add = test(to.add, "\\\\fancyhead", "\\fancyhead{}", LaTeX_head)
		to.add = test(to.add, "\\\\headrulewidth", "\\renewcommand{\\headrulewidth}{0pt}", LaTeX_head)
		to.add = test(to.add, "\\\\fancyfoot", "\\fancyfoot{}", LaTeX_head)
		to.add = test(to.add, "\\\\fancyhead", "\\fancyhead{}", LaTeX_head)
		to.add = test(to.add, c("\\\\fancyfoot", "LE,RO"), "\\fancyfoot[LE,RO]{\\scriptsize  Empowered by SHiNeMaS}", LaTeX_head)
		to.add = test(to.add, c("\\\\fancyfoot", "RE,LO"), "\\fancyfoot[RE,LO]{}", LaTeX_head)
		to.add = test(to.add, c("\\\\graphicspath", "../figures/"), "\\graphicspath{{../figures/}}", LaTeX_head)
		
		if( !is.null(to.add) ) { 
			cat(to.add, sep = "\n")
			cat(LaTeX_head, sep = "\n") 
		} else { cat(LaTeX_head, sep = "\n") }
		
		to.add = NULL
		to.add = test(to.add, "document}", "\\begin{document}", LaTeX_head)
		if( !is.null(to.add) ) { 
			cat(to.add, sep = "\n")
		}
		
		}
	
	# 6. LaTeX body ----------
	message("2. Get LaTeX body ...")
	
	for(i in 1:length(LaTeX_body)) {
		d = LaTeX_body[i]
		n = names(d)
		
		if(n == "titlepage") { 
			title = d[[1]][["title"]]
			authors = d[[1]][["authors"]]
			email = d[[1]][["email"]]
			date = d[[1]][["date"]]
			
			cat("
					\\begin{titlepage}
					\\begin{center}
					~\\\\
					\\vfill
					\\Huge", title,
					"\\vfill
					\\Large", authors, "\\\\
					~\\\\
					\\normalsize
					correspondance : \\href{mailto:", email, "}{", email,"}
					\\vfill",
					date,
					"
					\\vfill
					\\end{center}
					\\end{titlepage}
					\\normalsize
					\\pagestyle{empty}
					\\newpage
					~\\\\
					\\vfill
					\\newpage
					")
		}
		
		if(n == "tableofcontents") { if(d[[1]]) { cat("\\tableofcontents \n") } }
		if(n == "chapter") { cat("\\chapter{",text.to.tex(d[[1]]),"} \n \n") }
		if(n == "section") { cat("\\section{",text.to.tex(d[[1]]),"} \n \n") }
		if(n == "subsection") { cat("\\subsection{",text.to.tex(d[[1]]),"} \n \n") }
		if(n == "subsubsection") { cat("\\subsubsection{",text.to.tex(d[[1]]),"} \n \n") }
		if(n == "text") { cat(text.to.tex(d[[1]]),"\n \n") }
		if(n == "includepdf") { cat("\\includepdf[page=-]{", we_are_here ,"/", d[["includepdf"]] , "} \n \n", sep = "") }
		if(n == "input") { cat("\\input{", we_are_here ,"/", d[["input"]], "} \n \n", sep = "") }

		if(n == "table") {
			
			tex.tab = function(d, tab, lab.tab){
				display.rownames = d[["display.rownames"]]
				if(is.null(display.rownames)){ display.rownames = FALSE }
				if (attributes(tab)$invert == FALSE) {
					colnames(tab) = sapply(colnames(tab), function(x) { paste(unlist(strsplit(x, "\\.")), collapse = " ") } ) # change "." to space (" ")
				}
				if( display.rownames | attributes(tab)$invert == TRUE ) { tab = cbind.data.frame(rownames(tab), tab); colnames(tab) = c("", "value") }

				caption = d[["caption"]]
				if(is.null(caption)){caption = ""}
				caption =	text.to.tex(caption)
				
				t = xtable(x = tab, caption = caption, label = lab.tab)		
				align(t) = paste(c("|", rep(paste("p{",1/(ncol(t)),"\\textwidth}|",sep=""), times = (ncol(t)+1))), collapse = "")
				
				# Color of lines
				if( nrow(tab) > 1) { 
					rws1 <- seq(1, (nrow(tab)), by = 2)
					if( nrow(tab) %% 2 == 0 ) { 
						col1 <- c(rep(paste("\\hline \\rowcolor{", color2, "} ~", sep = ""), length(rws1)))
					} else { 	col1 <- c(rep(paste("\\hline \\rowcolor{", color2, "} ~", sep = ""), (length(rws1)-1)), "\\hline")
					}
					rws2 <- seq(2, (nrow(tab)), by = 2)
				} else { rws1 = col1 = NULL; rws2 = 1 }
				
				col2 <- rep("\\hline ", length(rws2))
				rws = c(-1, rws1, rws2)
				col = c(paste("\\hline \\rowcolor{", color1, "}", sep = ""), col1, col2)
				
				
				landscape = d[["landscape"]]
				if(is.null(landscape)){ landscape = FALSE}
				
				if(landscape) { cat("\\begin{landscape} \n") }
				print(t, align = align, tabular.environment = "longtable", floating = FALSE, table.placement= "H", include.rownames=FALSE, add.to.row = list(pos = as.list(rws), command = col), hline.after = 0)
				cat("\n")
				if(landscape) { cat("\\end{landscape} \n") }
			}
			
			d = d[["table"]]
			list.tab = d[["content"]]
			if ( !is.null(ncol(list.tab)) ) { list.tab = list(list.tab) } # In case there is only one table not in a list
			
			if(!is.null(list.tab)) {
			
			 if(length(list.tab) >1) {
			   l = list.tab$duplicated_infos
			   t = list()
			   for(i in 1:length(l)){
			     t1 = l[[i]]$"duplicated_infos_seed-lots"
			     t2 = l[[i]]$duplicated_infos_variables
			     t_tmp = list("t1" = t1, "t2" = t2)
			     t = c(t, t_tmp)
			   }
			   
			   l = list.tab$not_duplicated_infos
			   for(i in 1:length(l)){
			     t1 = l[[i]]
			     t_tmp = list("t1" = t1)
			     t = c(t, t_tmp)
			   }
			   
			   list.tab = t
			   list.tab = list.tab[!sapply(list.tab, is.null)]
			   
			   if( length(list.tab) > 0 ) {
			     # labels for duplicated infos
			     lab.tab.sl = lab.tab.var = NULL
			     for(azerty in 1:length(list.tab)){
			       lab.tab.sl = c(lab.tab.sl, as.character(round(runif(1,0,10000000000))))
			       lab.tab.sl = rep(lab.tab.sl, each = 2) # Two times the same as the two tables are by pairs
			       lab.tab.var = c(lab.tab.var, as.character(round(runif(1,0,10000000000))))
			       lab.tab.var = rep(lab.tab.var, each = 2) # Two times the same as the two tables are by pairs
			     }
			     
			     
			     for(i in 1:length(list.tab)) { # take all elements of the list
			       tab = list.tab[[i]]
			       
			       attr = attributes(tab)$get.table.object
			       
			       if( attr == "duplicated_infos_seed-lots" ){ 
			         cat(gettext(paste("The following seeds-lots present in table (\\ref{", lab.tab.sl[i],"}) are linked to variables present in table (\\ref{", lab.tab.var[i],"}). \n", sep = "")))
			         tex.tab(d = d, tab = tab, lab.tab = lab.tab.sl[i])
			       }
			       
			       if( attr == "duplicated_infos_variables" ){ 
			         cat(gettext(paste("The following variables in table (\\ref{", lab.tab.var[i],"}) are linked to seeds-lots present in table (\\ref{", lab.tab.sl[i],"}) \n.", sep = "")))
			         tex.tab(d = d, tab = tab, lab.tab = lab.tab.var[i])
			       }
			       
			       if( attr == "not_duplicated_variables" ){
			         tex.tab(d = d, tab = tab, lab.tab = NULL)
			       }
			     }
			   } else { cat(gettext("No data \n \n")) }
			 }else{ # Only one table present with no name in the list
			   tab = list.tab[[1]]
			   tex.tab(d = d, tab = tab, lab.tab = NULL)
			 }	

			} else { cat(gettext("No data \n \n")) }
		}
		
		if(n == "figure")	{
			d = d [["figure"]]
			list_ggplots_in = d [["content"]]
			
			if( is.ggplot(list_ggplots_in[[1]]) |  is.ggplot(list_ggplots_in) ) { 
				list_ggplots_in = list(list_ggplots_in) # In case it is a ggplot alone or not in a list
			} else { 
				list_ggplots_in = list_ggplots_in[!is.na(names(list_ggplots_in))]
			}
			
			if( length(list_ggplots_in) == 0 ) { list_ggplots_in = NULL } # It is the case when you do something like p_score = PPBstats::get.ggplot(comp.mu, ggplot.type = "score", nb_parameters_per_plot = 15)[person] and this person is not present, then it return a list names NA
			if(!is.null(list_ggplots_in)) {		
				caption = d[["caption"]]
				if( is.null(caption) ) { caption = "" }
				
				character_to_delete = c("\\.", "\n", "\t", "'", " ", "ù", "û", "ü", "ÿ", "à", "â", "ç", "é", "è", "ê", "ë", "ï", "î", "ô")
				names(character_to_delete) = c("", "", "", "_", "_", "u", "u", "u", "y", "a", "a", "c", "e", "e", "e", "e", "i", "i", "o")
				
				fig.name = caption
				for(c in character_to_delete) { char = which(character_to_delete == c); fig.name = gsub(c, names(character_to_delete)[char], fig.name) }
				fig.name = paste(na.omit(unlist(strsplit(fig.name, ""))[1:100]), collapse = "") # if it is too long pdf() does not work
				
				figure.name = paste(fig.name, "_", as.character(round(runif(1,0,10000000000))), ".pdf", sep="") # to have unicity in the name of the pdf
				pdf(paste("figures/",figure.name, sep=""))
				
				# Get a single list with one plot per element of the list
				# Ok with five levels : list(list(list(list(list(a)))))
				list_ggplots = list()
				test = TRUE
				while(test){
					for( g in list_ggplots_in) {
						if( is.list(g) & is.ggplot(g) ) { 
							list_ggplots = c(list_ggplots, list(g)); test = FALSE 
						} else {
							for(gg in g){
								if( is.list(gg) & is.ggplot(gg) ) { 
									list_ggplots = c(list_ggplots, list(gg)); test = FALSE 
								} else {
									for(ggg in gg){
										if( is.list(ggg) & is.ggplot(ggg) ) { 
											list_ggplots = c(list_ggplots, list(ggg)); test = FALSE 
										} else {
											for(gggg in ggg){
												if( is.list(gggg) & is.ggplot(gggg) ) { 
													list_ggplots = c(list_ggplots, list(gggg)); test = FALSE 
												} else {
													for(ggggg in gggg){
														if( is.list(ggggg) & is.ggplot(ggggg) ) { 
															list_ggplots = c(list_ggplots, list(ggggg)); test = FALSE 
														}	
													}	
												}
											}
										} 
									}
								}
							}
						}
					}
				}
				
				
				# Print the plots	
				# greatly inspired from http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_%28ggplot2%29/
				layout = d[["layout"]]
				if(is.null(layout)){ layout = matrix(1, ncol = 1, nrow= 1) }
				
				nb_p = length(list_ggplots)
				
				if (nb_p == 1) {
					print(list_ggplots[[1]])
				} else {
					a = rep(c(1:max(layout)), times = nb_p) # more than needed, but ok
					for (i in 1:nb_p) {
						if(a[i] == 1) {
							# Set up the page
							grid.newpage()
							pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
						}	
						# Get the i,j matrix positions of the regions that contain this subplot
						matchidx <- as.data.frame(which(layout == a[i], arr.ind = TRUE))
						print(list_ggplots[[i]], vp = viewport(layout.pos.row = matchidx$row, layout.pos.col = matchidx$col))
					}
				}
				
				dev.off()
				
				nb_pages = as.numeric(sub("NumberOfPages: ", "", system(paste("pdftk figures/", figure.name," dump_data | grep 'NumberOfPages'", sep=""), intern = TRUE)))
				
				width = d[["width"]]
				if(is.null(width)){ width = 1}
				
				landscape = d[["landscape"]]
				if(is.null(landscape)){ landscape = FALSE}
				
				if(landscape) { cat("\\begin{landscape} \n") }
				
				for(p in 1:nb_pages) {
					cat("\\begin{figure}[H] \n", "\\begin{center} \n")
					if(p == 1) { cat("\\caption{",text.to.tex(caption),"} \n", sep="") }
					cat(
						"\\includegraphics[page=", p,",width=", width, "\\textwidth]{", figure.name, "} \n",
						"\\end{center} \n",
						"\\end{figure} \n", sep="")
				}
				if(landscape) { cat("\\end{landscape} \n") }
				cat("\n")
			} else { cat(gettext("No data \n \n")) } 
		}
		
		if(n == "includepicture")	{
			d = d [["includepicture"]]
			
			caption = d[["caption"]]
			if( is.null(caption) ) { caption = "" }
			
			content = d[["content"]]
			
			width = d[["width"]]
			if(is.null(width)){ width = 1}
			
			cat(
				"\\begin{center} \n",
				"\\caption{",text.to.tex(caption),"} \n",
				"\\includegraphics[page=-,width=", width, "\\textwidth]{", we_are_here ,"/", content, "} \n",
				"\\end{center} \n",
				"\\end{figure} \n", sep=""
				)
		}
		
		
		
		}
	
	cat("\\end{document}")
	
	# 7. Close connexion of the .tex ----------
	sink()
	
	# 8. Compile .tex two times ----------
	if(compile.tex) {
		message("3. Compilation of .tex ...")
		
		setwd("tex.files/")
		system(paste("pdflatex -no-file-line-error -interaction=nonstopmode ", form.name, ".tex",sep=""))
		system(paste("pdflatex -no-file-line-error -interaction=nonstopmode ", form.name, ".tex",sep=""))
		system(paste("cp ", form.name,".pdf ../", sep=""))
		system(paste("cp ", form.name,".pdf ../../", sep=""))
		setwd("..")
		message(paste(dir, form.name, sep = ""), ".pdf has been compiled.", sep = "")
	}
	
	setwd(we_are_here)	
	}
