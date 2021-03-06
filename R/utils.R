make.me.quick = function(app){
    app[["Statusbar"]] = "Data exchange with R..."
    app[["Screenupdating"]] = FALSE
    app[["Calculation"]] = -4135 # xlCalculationManual = -4135
    invisible(NULL)
}


make.me.slow = function(app){
    app[["Statusbar"]] = ""
    app[["Screenupdating"]] = TRUE
    app[["Calculation"]] = -4105 # xlCalculationAutomatic = -4105
    invisible(NULL)
}


get_sheet = function(wb, sheet){
    if (!is.character(sheet) & !is.numeric(sheet)) 
        stop('Argument "xl.sheet" should be character or numeric.')
    sh.count = wb[['Sheets']][['Count']]
    sheets = sapply(seq_len(sh.count), function(sh) wb[['Sheets']][[sh]][['Name']])
    if (is.numeric(sheet)){
        if (sheet>length(sheets)) 
            stop ("too large sheet number. In workbook only ",length(sheets)," sheet(s)." )
        wb[["Sheets"]][[sheet]]
    } else {
        sheet_num = which(tolower(sheet) == tolower(sheets)) 
        if (length(sheet_num) == 0) stop ("sheet ",sheet," doesn't exist." )
        wb[["Sheets"]][[sheet_num]]
    }
}

names_to_matrix = function(name,splitter = "|")
    # Convert rownames/colnames with items delimited by symbol 'splitted'
    # to matrix with each label in it's own cell and remove sequentally repeated
    # labels.
{
    if (!is.null(name)){
        splitted = strsplit(as.character(name),split = splitter,fixed = TRUE)
        el.len = max(unlist(lapply(splitted,length)))
        column.nums = 1:el.len
        res = vapply(splitted,"[",column.nums,FUN.VALUE = as.character(column.nums))
        if (!is.matrix(res)) res = t(res)
        res[is.na(res)] = ""
        width = NCOL(res)
        if ((NROW(res)>0) & (width>1)){
            boundary = logical(width-1)
            for (i in (1:NROW(res))){
                boundary = boundary | (res[i,1:(width-1)] !=  res[i,2:width])
                res[i,c(FALSE,!boundary)] = ""
            }
        }
        t(res)
    } else NULL
}


## stop if condition with message
stopif = function(cond,...){
    if (cond) {
        stop(do.call(paste0,c(list(...))),call. = FALSE)
    }
    invisible()
}
