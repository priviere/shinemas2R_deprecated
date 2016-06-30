# 0. help -----------------------------------------------------------------
#' Get table from \code{get.data}
#'
#' @description
#' \code{get.table} generates tables object from \code{get.data} data-set or ggplot.objet from \code{get.ggplot}.
#'
#' @param data It can be either output from \code{get.data} or ggplot.object from \code{get.ggplot}.
#' 
#' @param correlated_group Name of the group of correlation in data. NULL by default meaning that \code{shinemas2R::get.data()$data$data} is taken.
#' 
#' @param merge_g_and_s Fuse germplasm and selection name information in a column named germplasm. TRUE by default.
#' 
#' @param table.type the type of table you wish according to the type of data. 
#' For data coming from \code{get.data}, it can be :
#' 	\itemize{
#' 	\item "raw" display raw data. Useful with text for example
#' 	\item "mean" display for each variable columns with mean
#' 	\item "mean.sd" display for each variable columns with mean and standard deviation
#' 	\item "mean.sd.cv" display for each variable columns with mean, standard deviation and coefficient of variation
#' 	\item "summary" display "Min.", "1st Qu.", "Median", "3rd Qu.", "Max." of the data
#' 	}
#' 
#' @param table.on For "data-" type. father" or "son" depending on which seed-lot you want to display.
#' 
#' @param vec_variables Vector of variables displayed
#' 
#' @param nb_row The number of rows in the table
#'
#' @param nb_col The number of columns in the table. col_to_display remains fixed.
#'
#' @param nb_duplicated_rows Minimum number of duplicated rows for each variable of a table up to which the information is put in only one row. 
#' 
#' @param col_to_display Columns to display in the table. It can be a vector with "person", "germplasm", "year", "block", "X" and "Y". If NULL, none of these columns are displayed. The variables follow these columns. For data-S and data-SR type, the column "expe" and "sl_statut" are added by default.
#' 
#' @param invert_row_col If TRUE, invert row and col in the table. This is possible only for col_to_display = NULL.
#' 
#' @return The function returns a list with two elements
#' \itemize{
#' \item "duplicated_infos" : lists of two elements with seed-lots involved and variable values
#' \item "not_duplicated_infos": a list with the table of non duplicated information
#' }
#' 
#' @author Pierre Riviere
#' 
#' @examples 
#' # See the vignette
#' 
#' @seealso \code{\link{get.data}}, \code{\link{get.ggplot}}
#' 
#'
get.table <- function(
	data,
	correlated_group = NULL,
	merge_g_and_s = FALSE,
	table.type = NULL,
	table.on = "son",
	vec_variables = NULL,
	nb_row = NULL,
	nb_col = NULL,
	nb_duplicated_rows = 10,
	col_to_display = c("person", "germplasm", "year", "block", "X", "Y"),
	invert_row_col = FALSE
)
	# lets go !!! ----------
{
	if( is.ggplot(data) ) {
		data = data$data
		test = is.element("toto", colnames(data))
		if(test) { 
			list_tab = select(data, -toto) 
			x.axis = attributes(p)$x.axis
			in.col = attributes(p)$in.col
			if( !is.null(x.axis) ) { colnames(list_tab)[which(colnames(list_tab) == "x.axis")] = x.axis }
			if( !is.null(in.col) ) { colnames(list_tab)[which(colnames(list_tab) == "in.col")] = in.col }
			} else { stop("ggplot object must come from shinemas2R::get.ggplot with ggplot.type = \"barplot\", \"boxplot\", \"interaction\", \"radar\" or \"interaction\".")}
		
	} else {
		data = data$data
		# 0. Error messages ----------
		shinemas2R.object = attributes(data)$shinemas2R.object
		
		mess = "data must be a ggplot object or come from shinemas2R::get.data"
		if( is.null(shinemas2R.object) ) { stop(mess) }
		if( !is.element(shinemas2R.object, 
										c("data-classic-relation", 
											"data-S-relation", 
											"data-SR-relation", 
											"data-classic-seed-lots",
											"data-S-seed-lots", 
											"data-SR-seed-lots")) 
		) { stop(mess) }  
		
		
		if( 
			is.null(data$data) & 
			is.null(data$data.with.correlated.variables)
		) { message("data is NULL: nothing is done !"); return(NULL) }
		
		if( is.null(correlated_group) ) {
			data = data$data	
		} else { 
			data_tmp = data$data.with.correlated.variables
			if(is.element(correlated_group, names(d))) {
				data = data_tmp[[correlated_group]]
			} else { stop(correlated_group, "is not a group of the data set. Possibles groups are: ", paste(names(data_tmp), collapse = ", "), ".") }
		}
		
		if( !is.null(col_to_display) ) {
			test = is.element(col_to_display, c("person", "germplasm", "year", "block", "X", "Y"))
			t = unique(test)
			if( (length(t) == 1 & !t[1]) | length(t) == 2 ){ stop("col_to_display must be a vector with \"person\", \"year\", \"germplasm\", \"block\", \"X\" and/or \"Y\".") }
		} 
		
		if( is.null(col_to_display) & (table.type == "mean" | table.type == "mean.sd" | table.type == "mean.sd.cv") )  { stop("With table.type = \"mean.sd.cv\", col_to_display must not be NULL.") }
		if( !is.null(col_to_display) & table.type == "summary" ) { stop("With table.type = \"summary\", col_to_display must not be NULL.") }
		
		
		# 2. germplasm column and update vec_variables ----------

		if( merge_g_and_s ) { 
			data$son_germplasm = sapply(as.character(data$son), function(x){unlist(strsplit(x,"_"))[1]}) 
			data$father_germplasm = sapply(as.character(data$father), function(x){unlist(strsplit(x,"_"))[1]}) 
		} 
		
		test = is.element(vec_variables, colnames(data))
		var_not_in_data = vec_variables[!test]
		var_in_data = vec_variables[test]
		
		if( length(var_not_in_data) == length(vec_variables) ) { warning("None elements of vec_variables are in data."); return(NULL) }
		
		if( length(var_not_in_data) > 0 ) { 
			warning("Variables ", paste(var_not_in_data, collapse = ", "), " are not in data.") 
			vec_variables = var_in_data
		}
		
		a = 0
		for(var in vec_variables){
			w = which(is.na(data[,var]))
			if(length(w) == nrow(data)) { 
				warning(var, " has only NA and has been removed from the dataset")
				data = data[,-which(colnames(data) == var)]
				a = a + 1
			}
		}
		
		# 3. Set up data set ----------
		if( is.element(shinemas2R.object, "data-classic-relation") ) { vec_variables = colnames(data)[c(29:ncol(data))] }
		if( is.element(shinemas2R.object, c("data-S-relation", "data-SR-relation")) ) { vec_variables = colnames(data)[c(33:ncol(data))] }
		
		if( is.element(shinemas2R.object, "data-classic-seed-lots") ) { vec_variables = colnames(data)[c(5:ncol(data))] }
		if( is.element(shinemas2R.object, c("data-S-seed-lots", "data-SR-seed-lots")) ) { vec_variables = colnames(data)[c(9:ncol(data))] }
		
		
		# get rid off rows and cols with only NA
		x = data
		
		x_head = x[,c(1:(ncol(x) - length(vec_variables)))]
		x_var = x[,c((ncol(x) - length(vec_variables) + 1):ncol(x))]
		if( is.null(ncol(x_var)) ) { x_var = as.data.frame(matrix(x_var, ncol = 1)); colnames(x_var) = vec_variables }
		
		
		# get rid off rows with only NA
		tokeep = apply(x_var, 1, function(x){length(which(is.na(x))) != length(x)})
		x_var = x_var[tokeep,]; if( is.null(ncol(x_var)) ) { x_var = as.data.frame(matrix(x_var, ncol = 1)); colnames(x_var) = vec_variables }
		x_head = x_head[tokeep,]; if( is.null(ncol(x_head)) ) { x_head = as.data.frame(matrix(x_head, ncol = 1)); colnames(x_head) = vec_variables }
		
		# get rid off columns with only NA in x_var
		tokeep = apply(x_var, 2, function(x){length(which(is.na(x))) != length(x)})
		notkept = vec_variables[!tokeep]
		if( length(notkept) > 0 ) { warning(paste(notkept, collapse = ", "), " has only NA and has been removed from the dataset") }
		
		x_var = x_var[,tokeep]; 
		vec_variables = vec_variables[tokeep]
		if( is.null(ncol(x_var)) ) { x_var = as.data.frame(matrix(x_var, ncol = 1)); colnames(x_var) = vec_variables }
		
		# 4. col_to_display ----------
		if(!is.null(col_to_display)){ # If NULL, nothing to do
			
			ctd = ctn = NULL
			if( table.on == "son" & is.element("person", col_to_display)){ ctd = c(ctd, "son_person"); ctn = c(ctn, "person") }
			if( table.on == "son" & is.element("germplasm", col_to_display)){ ctd = c(ctd, "son_germplasm"); ctn = c(ctn, "germplasm") }
			if( table.on == "son" & is.element("year", col_to_display)){ ctd = c(ctd, "son_year"); ctn = c(ctn, "year") }
			
			if( table.on == "father" & is.element("person", col_to_display)){ ctd = c(ctd, "son_person"); ctn = c(ctn, "person") }
			if( table.on == "father" & is.element("germplasm", col_to_display)){ ctd = c(ctd, "father_germplasm"); ctn = c(ctn, "germplasm") }
			if( table.on == "father" & is.element("year", col_to_display)){ ctd = c(ctd, "father_year"); ctn = c(ctn, "year") }
			
			if(is.element("block", col_to_display)) { ctd = c(ctd, "block"); ctn = c(ctn, "block") }
			if(is.element("X", col_to_display)) { ctd = c(ctd, "X"); ctn = c(ctn, "X") }
			if(is.element("Y", col_to_display)) { ctd = c(ctd, "Y"); ctn = c(ctn, "Y") }
			
			if( shinemas2R.object == "data-S-seed-lots" | shinemas2R.object == "data-S-relation" | shinemas2R.object == "data-SR-seed-lots" | shinemas2R.object == "data-SR-relation" ) {
				ctd = c(ctd, "expe", "sl_statut"); ctn = c(ctn, "expe", "sl_statut")
			}
			
			x_head = x_head[,ctd]; if( is.null(ncol(x_head)) ) { x_head = as.data.frame(matrix(x_head, ncol = 1)) }
			colnames(x_head) = ctn
		}
		
		data = cbind.data.frame(x_head, x_var)
		
		
		# 5. functions to get the table based on table.type ----------
		transform.tab = function(tab, table.type, invert_row_col, vec_variables){
			
			t = NULL # Depending on table.on, some elements of tab are not used
			
			fun.raw = function(tab, vec_variables)	{
				tab_head = tab[,c(1:(ncol(tab) - length(vec_variables)))]
				if( is.null(ncol(tab_head)) ) { tab_head = as.data.frame(matrix(tab_head, ncol = 1)); colnames(tab_head) = colnames(tab)[1] }
				tab_var = tab[,c((ncol(tab) - length(vec_variables) + 1):ncol(tab))]
				if( is.null(ncol(tab_var)) ) { tab_var = as.data.frame(matrix(tab_var, ncol = 1)); colnames(tab_var) = vec_variables }
				tab_var = cbind.data.frame(tab_head, tab_var)
				return(tab)
			}
			
			fun.mean.sd.cv = function(tab,vec_variables, display = "mean"){ 
				tab_head = tab[,c(1:(ncol(tab) - length(vec_variables)))]
				if( is.null(ncol(tab_head)) ) { tab_head = as.data.frame(matrix(tab_head, ncol = 1)); colnames(tab_head) = colnames(tab)[1] }
				tab_var = tab[,c((ncol(tab) - length(vec_variables) + 1):ncol(tab))]
				if( is.null(ncol(tab_var)) ) { tab_var = as.data.frame(matrix(tab_var, ncol = 1)); colnames(tab_var) = vec_variables }
				
				tab_head$id_azerty = factor(apply(tab_head, 1, function(x){paste(x, collapse = "")}))
				colnames(tab_head)[ncol(tab_head)] = "id_azerty"
				tab_head = arrange(tab_head, id_azerty)
				
				t = tab_head[!duplicated(tab_head$id_azerty),] 
				t = select(t, - id_azerty)
				vec_var = NULL
				for(i in 1:ncol(tab_var)){
					warning("virer le as num as char quand les données seront prorpes ?!?")
					mean = tapply(as.numeric(as.character(tab_var[,i])), tab_head$id_azerty, mean, na.rm = TRUE)
					sd = tapply(as.numeric(as.character(tab_var[,i])), tab_head$id_azerty, sd, na.rm = TRUE)
					cv = sd / mean
					
					if(display == "mean") { 
						tab_var_tmp = cbind.data.frame(mean) 
						colnames(tab_var_tmp) = paste(colnames(tab_var)[i], "mean")
					}
					
					if(display == "mean.sd") { 
						tab_var_tmp = cbind.data.frame(mean, sd) 
						colnames(tab_var_tmp) = paste(colnames(tab_var)[i], c("mean", "sd"))
					}
					
					if(display == "mean.sd.cv") { 
						tab_var_tmp = cbind.data.frame(mean, sd, cv) 
						colnames(tab_var_tmp) = paste(colnames(tab_var)[i], c("mean", "sd", "cv"))
					}
					vec_var = c(vec_var, colnames(tab_var_tmp))
					t = cbind.data.frame(t, tab_var_tmp)
				} 
				out = list("t" = t, "vec_var" = vec_var)
				return(out)
			}
			
			fun.summary = function(tab, vec_variables){ 
				tab_head = tab[,c(1:(ncol(tab) - length(vec_variables)))]
				if( is.null(ncol(tab_head)) ) { tab_head = as.data.frame(matrix(tab_head, ncol = 1)); colnames(tab_head) = colnames(tab)[1] }
				tab_var = tab[,c((ncol(tab) - length(vec_variables) + 1):ncol(tab))]
				if( is.null(ncol(tab_var)) ) { tab_var = as.data.frame(matrix(tab_var, ncol = 1)); colnames(tab_var) = vec_variables }
				
				tab_head$id_azerty = factor(apply(tab_head, 1, function(x){paste(x, collapse = "")}))
				colnames(tab_head)[ncol(tab_head)] = "id_azerty"
				tab_head = arrange(tab_head, id_azerty)
				
				t = tab_head[!duplicated(tab_head$id_azerty),] 
				t = select(t, - id_azerty)
				vec_var = NULL
				for(i in 1:ncol(tab_var)){
					q1 = tapply(as.numeric(as.character(tab_var[,i])), tab_head$id_azerty, function(x){min(x, na.rm = TRUE)})
					q2 = tapply(as.numeric(as.character(tab_var[,i])), tab_head$id_azerty, function(x){quantile(x, 0.25, na.rm = TRUE)})
					q3 = tapply(as.numeric(as.character(tab_var[,i])), tab_head$id_azerty, function(x){quantile(x, 0.5, na.rm = TRUE)})
					q4 = tapply(as.numeric(as.character(tab_var[,i])), tab_head$id_azerty, function(x){quantile(x, 0.75, na.rm = TRUE)})
					q5 = tapply(as.numeric(as.character(tab_var[,i])), tab_head$id_azerty, function(x){max(x, na.rm = TRUE)})
					tab_var_tmp = cbind.data.frame(q1, q2, q3, q4, q5)
					colnames(tab_var_tmp) = paste(colnames(tab_var)[i], c("Min", "25%", "50%", "75%", "Max"))
					vec_var = c(vec_var, colnames(tab_var_tmp))
					t = cbind.data.frame(t, tab_var_tmp)
				} 
				
				out = list("t" = t, "vec_var" = vec_var)
				return(out)
			}
			
			
			if(table.type == "mean") { 
				out = fun.mean.sd.cv(tab, vec_variables, display = "mean") 
				t = out$t
				vec_variables = out$vec_var
			}
			if(table.type == "mean.sd") { 
				out = fun.mean.sd.cv(tab, vec_variables, display = "mean.sd") 
				t = out$t
				vec_variables = out$vec_var
			}
			if(table.type == "mean.sd.cv") { 
				out = fun.mean.sd.cv(tab, vec_variables, display = "mean.sd.cv") 
				t = out$t
				vec_variables = out$vec_var
			}
			if(table.type == "summary") { 
				out = fun.summary(tab, vec_variables) 
				t = out$t
				vec_variables = out$vec_var
			}
			if(table.type == "raw") { 
				t = fun.raw(tab, vec_variables) 
			}
			
			t = unique(t) # For information linked to seed-lots display several times because of individuals
			# useful also for t coming from mean.sd.cv and summary
			# note than if block X Y is deleted, and it is the same line for each rep, one is deleted
			
			if(invert_row_col & is.null(col_to_display)) { 
				t = t(t); t = as.data.frame(t) 
				t = cbind.data.frame(rownames(t), t)
				colnames(t) = c("variable", "value")
			}
			
			out = list("tab" = t, "vec_variables" = vec_variables)
			return(out)
		}
		
		
		# 6. function to get tables based on nb_row and nb_col and omit rows with only NA ----------
		reshape.tables = function(tab, nb_row, nb_col, vec_variables, nb_duplicated_rows, col_to_display){
			
			if( is.null(nb_row) ) { nb_row = nrow(tab) }
			if( is.null(nb_col) ) { nb_col = ncol(tab) }
			
			if(!is.data.frame(tab)){ stop("tab must be a dataframe.")}
			tab$split_row = rep(c(1:nrow(tab)), each = nb_row)[1:nrow(tab)]
			tab =  plyr:::splitter_d(tab, .(split_row))
			
			fun = function(x, nb_row, nb_col, vec_variables, col_to_display){ 
				x = select(x, -split_row)
				x_head = x[,c(1:(ncol(x) - length(vec_variables)))]
				if( is.null(ncol(x_head)) ) { x_head = as.data.frame(matrix(x_head, ncol = 1)); colnames(x_head) = colnames(x)[1] }
				x_var = x[,c((ncol(x) - length(vec_variables) + 1):ncol(x))]
				if( is.null(ncol(x_var)) ) { x_var = as.data.frame(matrix(x_var, ncol = 1)); colnames(x_var) = vec_variables }
				
				if(length(vec_variables) > 0){
					
					if( length(vec_variables) <= nb_col ) { 
						seq_var = c(1, (length(vec_variables) + 1 )) 
					} else {
						seq_var = seq(1, length(vec_variables), nb_col)
						seq_var = c(seq_var, (length(vec_variables) + 1) ) # + 1 because after it takes seq_var[i+1]-1
					}
					
					list_tabs = list()
					for(i in 1:(length(seq_var)-1)){
						if( i > 0 ) { # 0 if length(seq_var) == 1
							
							if(!is.na(seq_var[i+1])) { 
								x_var_tmp = x_var[,c(seq_var[i]:(seq_var[i+1]-1))] 
							} else {
								x_var_tmp = x_var[,seq_var[i]]
							}
							
							if( is.null(ncol(x_var_tmp)) ) { x_var_tmp = as.data.frame(matrix(x_var_tmp, ncol = 1)); colnames(x_var_tmp) = colnames(x_var)[seq_var[i]] }
							
							t = apply(x_var_tmp, 2, function(x){ as.numeric(as.factor(as.character(x))) })
							if( is.null(ncol(t)) ) { 
								tt = as.data.frame(matrix(t, ncol = length(t)))
								colnames(tt) = names(t)
								t = tt  
							}
							t = apply(t, 1, function(x){paste(x, collapse="")})
							
							tt = table(factor(t))
							vec_dup = tt[which(tt >= nb_duplicated_rows)]
							name_vec_dup = names(tt)[is.element(tt, vec_dup)]
							
							vec_not_dup = tt[which(tt < nb_duplicated_rows)]
							name_vec_not_dup = names(tt)[is.element(tt, vec_not_dup)]
							
							# Groups of data frame to reduce duplicated information ----------
							if(length(name_vec_dup)>0){
								for(j in name_vec_dup){ 
									w = which(t == j) 
									x_var_tmp_1 = x_var_tmp[w[1],] # take only one as there are all the same
									x_head_tmp_1 = x_head[w,]					
									
									# table with id
									x_head_tmp_1 = x_head[w,]
									if( is.null(ncol(x_head_tmp_1)) ) { x_head_tmp_1 = as.data.frame(matrix(x_head_tmp_1, ncol = 1)); colnames(x_head_tmp_1) = colnames(x_head)[1] }
									
									if(!is.null(col_to_display)){ # If NULL, nothing to do
										id = apply(x_head_tmp_1, 1, function(x){paste(x, collapse = "-")})
										id = paste(id, collapse = ", ")
										id = as.data.frame(matrix(id), ncol = 1)
										colnames(id) = gettext("seed-lots")
										attributes(id)$get.table.object = "duplicated_infos_seed-lots"
										id = list(id); names(id) = "duplicated_infos_seed-lots"
										list_tabs = c(list_tabs, id)
									}
									
									# table with variables
									x_tmp = x_var_tmp_1
									if( is.null(ncol(x_tmp)) ) { x_tmp = as.data.frame(matrix(x_tmp, ncol = 1)); colnames(x_tmp) = colnames(x_var)[seq_var[i]] }
									attributes(x_tmp)$get.table.object = "duplicated_infos_variables"
									x_tmp = list(x_tmp); names(x_tmp) = "duplicated_infos_variables"
									list_tabs = c(list_tabs, x_tmp)
								}
							}
							
							# Groups of data frame with no duplicated information ----------
							if( length(name_vec_not_dup)>0){
								w = which(t %in% name_vec_not_dup) 
								x_var_tmp_1 = x_var_tmp[w,]
								if( is.null(ncol(x_var_tmp_1)) ) { x_var_tmp_1 = as.data.frame(matrix(x_var_tmp_1, ncol = 1)); colnames(x_var_tmp_1) = colnames(x_var)[seq_var[i]] }
								x_head_tmp_1 = x_head[w,]
								if( is.null(ncol(x_head_tmp_1)) ) { x_head_tmp_1 = as.data.frame(matrix(x_head_tmp_1, ncol = 1)); colnames(x_head_tmp_1) = colnames(x_head)[1] }
								
								x_tmp = cbind.data.frame(x_head_tmp_1, x_var_tmp_1)
								attributes(x_tmp)$get.table.object = "not_duplicated_variables"
								list_tabs = c(list_tabs, list(x_tmp))
							}
							
						}
					}
				} else { list_tabs = NULL }
				
				return(list_tabs)
			}
			
			tab = lapply(tab, fun, nb_row, nb_col, vec_variables, col_to_display)
			
			# Make tab in one single list
			tab_ok = list()
			for(i in 1:length(tab)){
				tab_tmp = tab[[i]]
				for(j in 1:length(tab_tmp)){
					tab_ok = c(tab_ok, tab_tmp[j])
				}
			}
			
			return(tab_ok)
		}
		
		
		# 7. Run functions ----------
		out = transform.tab(data, table.type, invert_row_col, vec_variables)
		tab = out$tab
		vec_variables = out$vec_variables
		
		list_tab = reshape.tables(tab, nb_row, nb_col, vec_variables, nb_duplicated_rows, col_to_display)
		
		
		# Delete NULL elements
		list_tab = list_tab[!sapply(list_tab, is.null)]
		
		# reorganise list_tab
		attr = unlist(sapply(list_tab, function(x) { attributes(x)$get.table.object }))
		duplicated_infos_sl = grep("duplicated_infos_seed-lots", attr)
		duplicated_infos_variables = grep("duplicated_infos_variables", attr)
		
		if(length(duplicated_infos_variables)>0){
			
			# Get rid off information with only NA
			tokeep = NULL
			for(i in 1:length(duplicated_infos_sl)){
				t = list_tab[duplicated_infos_variables[[i]]]$duplicated_infos_variables
				if( length(which(is.na(t))) < length(t) ) { tokeep = c(tokeep, i) }
			}
			
			if( !is.null(tokeep) ) {
				duplicated_infos = list()
				for(i in tokeep){
					tmp = c(list_tab[duplicated_infos_sl[i]], 
									list_tab[duplicated_infos_variables[i]]
					)
					tmp = list(tmp); names(tmp) = paste("set", i, sep= "-")
					duplicated_infos = c(duplicated_infos, tmp)
				}
			}	else { duplicated_infos = NULL }
		} else { duplicated_infos = NULL }
		
		not_duplicated_infos = list_tab[grep("not_duplicated_variables", attr)]
		if(length(not_duplicated_infos)>0){
			names(not_duplicated_infos) = paste("set", c(1:length(not_duplicated_infos)), sep= "-")
		} else { not_duplicated_infos = NULL }
		
		list_tab = list("duplicated_infos" = duplicated_infos, "not_duplicated_infos" = not_duplicated_infos)
		
	}

	return(list_tab)
}



