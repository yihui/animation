`ani.options` <- function(...) {
    mf = list(interval = 1, nmax = 50, ani.width = 480,
        ani.height = 480, outdir = tempdir(), filename = "index.htm",
        withprompt = "ANI> ", ani.type = "png", ani.dev = png,
        title = "Statistical Animations Using R", description = "This is an animation.",
        footer = TRUE, autobrowse = TRUE)
    if (is.null(getOption("ani")))
        options(ani = mf)
    else mf = getOption("ani")
    lst = list(...)
    if (length(lst)) {
        if (is.null(names(lst)) & !is.list(lst[[1]])) {
            getOption("ani")[unlist(lst)][[1]]
        }
        else {
            omf = mf
            mc = list(...)
            if (is.list(mc[[1]]))
                mc = mc[[1]]
            if (length(mc) > 0)
                mf[pmatch(names(mc), names(mf))] = mc
            options(ani = mf)
            return(invisible(omf))
        }
    }
    else {
        getOption("ani")
    }
}

`ani.stop` <- function() {
    if (ani.options("footer"))
        footer = paste("<div class=\"footer\">Created by R package \"<a href=\"http://cran.r-project.org/package=animation\" target=\"_blank\">animation</a>\" written by <a href=\"http://www.yihui.name/\" target=\"_blank\">Yihui XIE</a>.<br>",
            Sys.time(), "</div>", sep = "")
    else footer = NULL

    html = paste("<script language=\"JavaScript\" type=\"text/javascript\" src=\"http://www.yihui.name/fun/FUN.js\"></script><link href=\"http://www.yihui.name/fun/ANI.css\" rel=\"stylesheet\" type=\"text/css\" />",
        "<div align=\"center\" class=\"anidemo\" title=\"", ani.options("title"),
        "\"><fieldset><legend align=\"center\">", ani.options("title"),
        "</legend><div id=\"loadingANIR\" class=\"loading\">loading animation frames... </div><div id=\"divPreloadANIR\" class=\"divPreload\">\n<script language=\"JavaScript\" type=\"text/javascript\">\n var sourceANIR = \"",ani.options("outdir")
        ,"\"; var imgtypeANIR = \"",
        ani.options("ani.type"), "\"; var tmpANIR = 0; var nmaxANIR=",
        ani.options("nmax"), "; var nANIR=1; var tANIR;var ii='';var jj;\n for(i = 1; i <= nmaxANIR; i++){",
        "ii='';for(jj=1;jj<=3-i.toString().length;jj++){ii+=0;}ii=ii+i;document.write(\"", "<div class=\\\"divFrame\\\" id=\\\"divPreloadANIR\" + i + \"\\\"><img src=\\\"\" + sourceANIR + ii + \".\" + imgtypeANIR + \"\\\"\" + \" id = \\\"img\" + \"ANIR\" + i + \"\\\" alt=\\\"",
        ani.options("title"), "\\\" title=\\\"", ani.options("title"),
        "\\\" /></div>\"", ");}\n</script></div><div class=\"btncontrol\"><input name=\"nmaxANIR\" type=\"hidden\" id=\"nmaxANIR\" value=\"",
        ani.options("nmax"), "\" /><input name=\"heightANIR\" type=\"hidden\" id=\"heightANIR\" value=\"",
        ani.options("ani.height"), "\" /><input name=\"btnPlayANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnPlayANIR\" title=\"Play\" onclick=\"playAni('ANIR')\" value=\"  &gt;  \" /> <input name=\"btnPauseANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnPauseANIR\" title=\"Pause\" onclick=\"pauseAni('ANIR')\" value=\"  O  \" /> <input name=\"btnFastANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnFastANIR\" title=\"Speed up\" onclick=\"fastAni('ANIR',1)\" value=\"  +  \" /> <input name=\"btnSlowANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnSlowANIR\" title=\"Slow down\" onclick=\"fastAni('ANIR',-1)\" value=\"  -  \" /> <input name=\"btnPrevANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnPrevANIR\" title=\"Previous frame\" onclick=\"prevAni('ANIR',1)\" value=\"  &lt;&lt;  \" /> <input name=\"btnNextANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnNextANIR\" title=\"Next frame\" onclick=\"prevAni('ANIR',-1)\" value=\"  &gt;&gt;  \" /> <input name=\"btnFirstANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnFirstANIR\" title=\"First frame\" onclick=\"firstAni('ANIR',true)\" value=\"  |&lt;  \" /> <input name=\"btnLastANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnLastANIR\" title=\"Last frame\" onclick=\"firstAni('ANIR',false)\" value=\"  &gt;|  \" /> <input name=\"btnMoreANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnMoreANIR\" title=\"More controls\" onclick=\"btnMore('ANIR')\" value=\"  &lt;&gt;  \" /></div><div id=\"moreParANIR\" class=\"morepar\"><label title=\"Which frame to go?\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\">View <input name=\"txtFrameANIR\" type=\"text\" id=\"txtFrameANIR\" onblur=\"txtFrame(this.value, 'ANIR')\" value=\"1\" size=\"4\" class=\"text\" />/",
        ani.options("nmax"), " frame</label> <label title=\"Loop or not?\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\"><input name=\"checkLoopANIR\" type=\"checkbox\" id=\"checkLoopANIR\" checked=\"checked\"/>Loop</label> <label title=\"Time interval for the animation (in sec)\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\">Time Interval: <input name=\"txtIntervalANIR\" type=\"text\" id=\"txtIntervalANIR\" onblur=\"txtInterval(this)\" value=\"",
        ani.options("interval"), "\" size=\"4\" class=\"text\" /></label> <label title=\"Increment in time interval\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\">Step: <input name=\"txtStepANIR\" type=\"text\" id=\"txtStepANIR\" onblur=\"txtInterval(this)\" value=\"0.1\" size=\"4\" class=\"text\" /></label></div><div class=\"description\">",
        ani.options("description"), "</div></fieldset>", footer,
        "</div><script language=\"JavaScript\" type=\"text/javascript\">document.body.onload=loading(\"ANIR\");</script>", sep = "")

    cat(ani.options("nmax"), "animation frames recorded.\n")

    cat(html)
    ani.options(interval = ani.options("interval")[2])

}

setwd('/ftp/ftpdir/pub/ADE-User/data/')
x=file.info(list.files(pattern='.*\\.ps$'))
x=x[order(x$atime),]
x=rownames(x)[nrow(x)]
x=substr(x,1,nchar(x)-3)
ani.options(ani.type='gif',outdir=sprintf('http://pbil.univ-lyon1.fr/cgi-bin/Rweb/nph-imageDump.pl?/ftp/ftpdir/pub/ADE-User/data/%s',x),nmax=5)
rm(x)

for (i in seq(1,360,len=5)) {
    plot(1, ann = F, type = "n", axes = F)
    text(1, 1, "Animation", srt = i, col = rainbow(360)[i], cex = 7 * 
        i/360)
    box()
}

ani.stop()
