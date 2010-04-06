bugs.options <- function(...) {
    if (is.null(getOption("iBUGS"))) {
        bugs.directory = ""
        program = ""
        ## looking for (Win|Open)BUGS
        if (.Platform$OS.type == "windows") {
            if (nzchar(prog <- Sys.getenv("ProgramFiles")) &&
                length(bugs.dir <- list.files(prog, "^(Open|Win)BUGS.*")) &&
                length(bugs.exe <- dirname(list.files(file.path(prog,
                  bugs.dir), pattern = "(Open|Win)BUGS.*\\.exe$",
                  full.names = TRUE, recursive = TRUE)))) {
                ## if I can find OpenBUGS, use it prior to WinBUGS
                program = ifelse(length(grep("OpenBUGS", bugs.exe)),
                  "OpenBUGS", "WinBUGS")
                ## ignore multiple directories if BUGS installed in multiple places
                bugs.directory = bugs.exe[grep(program, bugs.exe)][1]
            }
        }
        else gmessage("I'm not intelligent for Linux and Mac for the time being... \nPlease specify the 'bugs.directory' and 'program' arguments manually in the 'Preference' panel.\nI'm considering using JAGS under Linux. Would anyone help me?",
            "Stupid iBUGS")
        if (program == "OpenBUGS" && !require(BRugs)) {
            galert("I need the BRugs package to call OpenBUGS",
                "Install BRugs")
            install.packages("BRugs")
        }
        data = unlist(sapply(grep("^[^(package:)]", search(),
            value = TRUE), ls))
        inits = NULL
        parameters.to.save = ""
        model.file = "model.bug"
        n.chains = 3
        n.iter = 2000
        n.burnin = floor(n.iter/2)
        n.sims = 1000
        n.thin = max(1, floor(n.chains * (n.iter - n.burnin)/n.sims))
        bin = as.integer((n.iter - n.burnin)/n.thin)
        debug = FALSE
        DIC = TRUE
        digits = 5
        codaPkg = FALSE
        working.directory = NULL
        clearWD = FALSE
        useWINE = .Platform$OS.type != "windows"
        WINE = NULL
        newWINE = TRUE
        WINEPATH = NULL
        bugs.seed = NULL
        summary.only = FALSE
        save.history = !summary.only
        over.relax = FALSE
        model.name = "bugs.model"
        mf = list(data = data, inits = inits, parameters.to.save = parameters.to.save,
            model.file = model.file, n.chains = n.chains, n.iter = n.iter,
            n.burnin = n.burnin, n.thin = n.thin, n.sims = n.sims,
            bin = bin, debug = debug, DIC = DIC, digits = digits,
            codaPkg = codaPkg, bugs.directory = bugs.directory,
            program = program, working.directory = working.directory,
            clearWD = clearWD, useWINE = useWINE, WINE = WINE,
            newWINE = newWINE, WINEPATH = WINEPATH, bugs.seed = bugs.seed,
            summary.only = summary.only, save.history = save.history,
            over.relax = over.relax, model.name = model.name)
        options(iBUGS = mf)
    }
    else mf = getOption("iBUGS")
    lst = list(...)
    if (length(lst)) {
        if (is.null(names(lst)) & !is.list(lst[[1]])) {
            getOption("iBUGS")[unlist(lst)][[1]]
        }
        else {
            omf = mf
            mc = list(...)
            if (is.list(mc[[1]]))
                mc = mc[[1]]
            if (length(mc) > 0)
                mf[pmatch(names(mc), names(mf))] = mc
            options(iBUGS = mf)
            invisible(omf)
        }
    }
    else {
        getOption("iBUGS")
    }
}

