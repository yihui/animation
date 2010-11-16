`highlight.def` <-
function(file = "r.lang") {
    cat(c("# R language definition file", "#", "# Author: Andre Simon", 
        "#   Mail: andre.simon1@gmx.de", "#   Date: 13.04.04", 
        "# ------------------------------------------", "# This file is a part of highlight, a free source code converter released under the GPL.", 
        "#", "# The file is used to describe keywords and special symbols of programming languages.", 
        "# See README in the highlight directory for details.", 
        "#", "# New definition files for future releases of highlight are always appreciated ;)", 
        "#", "# ----------", "# andre.simon1@gmx.de", "# http:/www.andre-simon.de/", 
        "# ", "# Modified by Yihui XIE", "# Homepage: http://www.yihui.name/en (English); http://www.yihui.name (Chinese)", 
        "#", "# For the process of making this file, please refer to:", 
        "# http://www.yihui.name/en/read.php/6.htm ", "# or http://r.yihui.name/misc/highlight.htm", 
        " ", "$KW_LIST(kwa)=if else repeat while function for in next break ifelse switch ", 
        "", "$KW_LIST(kwb)=NULL NA Inf NaN TRUE T FALSE F "), 
        file = file, sep = "\n")
    cat("\n$KW_LIST(kwc)=", file = file, append = TRUE)
    lst = search()
    lst = lst[grep("package:", lst)]
    x = NULL
    for (i in 1:length(lst)) x = c(x, ls(lst[i]))
    y = x[-grep("[]\\ \\|\\(\\)\\[\\{\\^\\$\\*\\+\\?~#%&=:!/@<>-]", 
        x)]
    kw = c("if", "else", "repeat", "while", "function", "for", 
        "in", "next", "break", "ifelse", "switch", "NULL", "NA", 
        "Inf", "NaN", "TRUE", "T", "FALSE", "F")
    y = y[!(y %in% kw)]
    cat(y, sep = " ", file = file, append = TRUE)
    cat(c("\n", "$KW_RE(kwd)=regex((\\w+?)\\s*\\()", "", "$STRINGDELIMITERS=\" '", 
        "", "$SL_COMMENT=# ", "", "$ESCCHAR=\\", "", "$SYMBOLS= ( ) [ ] { } , ; : & | < > !  = / * %  + -", 
        "", "$IDENTIFIER=regex([a-zA-Z_][\\w\\.]*)"), sep = "\n", 
        file = file, append = TRUE)
    cat("R language definition file completed in ", file, "\n")
}

