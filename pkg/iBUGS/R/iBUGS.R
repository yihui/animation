iBUGS <- function() {
    options(guiToolkit = "RGtk2")
    if (.Platform$OS.type == "unix") galert('iBUGS does not support *nix yet!', 'Warning', delay = 5)
    g = ggroup(horizontal = FALSE, container = gwindow("iBUGS - Intelligent (Open|Win)BUGS Interface"))
    g1 = ggroup(container = g, expand = TRUE)
    g2 = ggroup(container = g)
    txt = gtext("model\n{\n\n}", container = g1, wrap = FALSE,
        font.attr = c(family = "monospace", size = "large", styles = "normal",
            weights = "light"), expand = TRUE)
    gbutton("Open", container = g2, handler = function(h, ...) {
        s = gfile("Open Model", initialfilename = basename(bugs.options("model.file")))
        if (!is.na(s)) {
            svalue(txt) = readLines(s)
            tag(txt, "src.file") = s
            tooltip(txt) = s
            bugs.options(model.file = s)
        }
        focus(txt)
    })
    gbutton("Save", container = g2, handler = function(h, ...) {
        s = tag(txt, "src.file")
        if (is.null(s))
            s = gfile("Save the Model", type = "save", initialfilename = basename(bugs.options("model.file")))
        if (!is.na(s)) {
            writeLines(svalue(txt), s)
            bugs.options(model.file = s)
            tag(txt, "src.file") = s
            tooltip(txt) = s
        }
    })
    gbutton("Preferences", container = g2, handler = function(h,
        ...) {
        g = ggroup(horizontal = FALSE, container = gw <- gwindow("Options"))
        ## data & parameters
        g1 = ggroup(container = g, expand = TRUE)
        ## other options
        g2 = glayout(container = ggroup(container = g), expand = TRUE,
            spacing = 2)
        ## buttons
        g3 = ggroup(container = g)
        g.data = gtable(data.frame(data = unlist(sapply(grep("^[^(package:)]",
            search(), value = TRUE), ls))), multiple = TRUE,
            container = g1, expand = TRUE)
        svalue(g.data) = bugs.options("data")
        addHandlerMouseMotion(g.data, handler = function(h, ...) focus(h$obj))
        con = textConnection(svalue(txt))
        model.line = gsub("^[[:space:]]+|[[:space:]]+$", "",
            readLines(con))
        b = which(model.line == "}")
        par.list = ""
        if (length(b) >= 2) {
            par.list = gsub("([[:space:]]+|)(~|<-).*", "", grep("~|<-",
                model.line[(b[length(b) - 1] + 1):(b[length(b)] -
                  1)], value = TRUE))
        }
        par.list = unique(c(bugs.options("parameters.to.save"),
            par.list))
        par.list = par.list[nzchar(par.list)]
        g.parameters.to.save = gtable(data.frame(parameters.to.save = par.list,
            stringsAsFactors = FALSE), multiple = TRUE, container = g1,
            expand = TRUE)
        svalue(g.parameters.to.save) = bugs.options("parameters.to.save")
        close(con)
        addHandlerMouseMotion(g.parameters.to.save, handler = function(h,
            ...) focus(h$obj))
        addhandlerdoubleclick(g.parameters.to.save, handler = function(h,
            ...) {
            gi = ginput("Well, you beat me! It seems I have not figured out all the parameter names... Please manually input them here:",
                title = "Parameters to Save", icon = "question")
            if (!is.na(gi) && gi != "")
                g.parameters.to.save[, ] = c(g.parameters.to.save[],
                  gi)
            g.parameters.to.save[, ] = g.parameters.to.save[][!duplicated(g.parameters.to.save[,
                , drop = FALSE])]
            g.parameters.to.save[, ] = g.parameters.to.save[,
                ][nzchar(g.parameters.to.save[, ])]
        })
        opt.names = setdiff(names(bugs.options()), c("data",
            "parameters.to.save"))
        for (i in 1:ceiling(length(opt.names)/3)) {
            for (j in 1:3) {
                if (3 * i - (3 - j) <= length(opt.names)) {
                  g2[i, 2 * j - 1] = opt.names[3 * i - (3 - j)]
                  g2[i, 2 * j] = (tmp <- gedit(bugs.options(opt.names[3 *
                    i - (3 - j)]), container = g2))
                  id(tmp) = opt.names[3 * i - (3 - j)]
                  addhandlerblur(tmp, handler = function(h, ...) {
                    v = svalue(h$obj)
                    warn.level = getOption("warn")
                    options(warn = -1)
                    eval(parse(text = sprintf("bugs.options(%s = if (!nzchar(v)) NULL else ifelse(!is.na(as.integer(v)),  as.integer(v), ifelse(!is.na(as.logical(v)), as.logical(v), v)))",
                      id(h$obj))))
                    options(warn = warn.level)
                  })
                  addHandlerMouseMotion(tmp, handler = function(h,
                    ...) focus(h$obj))
                }
            }
        }
        gbutton("ok", container = g3, handler = function(h, ...) {
            bugs.options(data = as.character(svalue(g.data)),
                parameters.to.save = as.character(svalue(g.parameters.to.save)))
            dispose(gw)
        })
        gbutton("cancel", container = g3, handler = function(h,
            ...) {
            dispose(gw)
        })
        size(g1) = c(size(g1)[1], 200)
    })
    gbutton("Execute", container = g2, handler = function(h,
        ...) {
        writeLines(svalue(txt), bugs.options("model.file"))
        assign(bugs.options("model.name"), with(bugs.options(), {
            bugs(data, if (!is.null(bugs.options("inits")))
                eval(parse(text = bugs.options("inits")))
            else NULL, parameters.to.save, model.file, n.chains,
                n.iter, n.burnin, n.thin, n.sims, bin, debug,
                DIC, digits, codaPkg, bugs.directory, program,
                working.directory, clearWD, useWINE, WINE, newWINE,
                WINEPATH, bugs.seed, summary.only, save.history,
                over.relax)
        }), envir = .GlobalEnv)
        message("(*) Returned values have been saved to the R object '",
            bugs.options("model.name"), "'")
    })
    gbutton("Demo", container = g2, handler = function(h, ...) {
        if (isTRUE(gconfirm("I will overwrite the current model and show the demo. Do you want to continue?"))) {
            assign("Ex.Y", rnorm(100, mean = rnorm(1, mean = 5)),
                envir = .GlobalEnv)
            assign("Ex.N", 100, envir = .GlobalEnv)
            svalue(txt) = c("model", "{", "  ## sampling distribution: Normal(mu, 1)",
                "  for(i in 1:Ex.N){", "    Ex.Y[i] ~ dnorm(mu,1)",
                "  }", "  ## prior: Normal(5, 1)", "  mu ~ dnorm(5, 1)",
                "}")
            bugs.options(data = c("Ex.Y", "Ex.N"), parameters.to.save = "mu")
        }
    })
    gbutton("Help", container = g2, handler = function(h, ...) {
        gmessage(paste(1:7, ". ", c("Write the BUGS model in the textbox;",
            "Make sure data objects are in the current R session;", "Click the Preference button and set the options;",
            "Execute!", "Or you can try the demo first;", "I might crash R if certain options were not correctly specified! (to be improved on error-catching...)",
            "For more information, see the help page ?iBUGS. Feedback and collaboration always welcome -- xie@yihui.name"),
            sep = "", collapse = "\n"), "Help")
    })
    invisible(NULL)
}