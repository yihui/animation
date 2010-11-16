`ani.stop` <- function() {
    dev.off()
    if (isTRUE(ani.options("footer")))
        footer = paste("<div class=\"footer\">Created by R package \"<a href=\"http://cran.r-project.org/package=animation\" target=\"_blank\">animation ", packageDescription("animation", fields = "Version"), "</a>\" written by <a href=\"http://yihui.name/\" target=\"_blank\">Yihui XIE</a>.<br>",
            Sys.time(), "</div>", sep = "")
    else footer = ifelse(is.character(ani.options("footer")), sprintf("<div class=\"footer\">%s</div>", ani.options("footer")), "")
    ani.file = file.path(getwd(), ani.options("filename"))
    imgdir = ani.options("imgdir")
    if (file.exists(imgdir)) ani.options(nmax = length(list.files(imgdir)))
    html = paste("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><title>",
        ani.options("title"), "</title><script language=\"JavaScript\" type=\"text/javascript\" src=\"FUN.js\"></script><link href=\"ANI.css\" rel=\"stylesheet\" type=\"text/css\" /></head><body onload=loading('ANIR')>",
        "<div align=\"center\" class=\"anidemo\" title=\"", ani.options("title"),
        "\"><fieldset><legend align=\"center\">", ani.options("title"),
        "</legend><div id=\"loadingANIR\" class=\"loading\">loading animation frames... </div><div id=\"divPreloadANIR\" class=\"divPreload\">\n<script language=\"JavaScript\" type=\"text/javascript\">\n var sourceANIR = \"", imgdir, "/\"; var imgtypeANIR = \"",
        ani.options("ani.type"), "\"; var tmpANIR = 0; var nmaxANIR=",
        ani.options("nmax"), "; var nANIR=1; var tANIR;\n for(i = 1; i <= nmaxANIR; i++){",
        "document.write(\"", "<div class=\\\"divFrame\\\" id=\\\"divPreloadANIR\" + i + \"\\\"><img src=\\\"\" + sourceANIR + i + \".\" + imgtypeANIR + \"\\\"\" + \" id = \\\"img\" + \"ANIR\" + i + \"\\\" alt=\\\"",
        ani.options("title"), "\\\" title=\\\"", ani.options("title"),
        "\\\" /></div>\"", ");}\n</script></div><div class=\"btncontrol\"><input name=\"nmaxANIR\" type=\"hidden\" id=\"nmaxANIR\" value=\"",
        ani.options("nmax"), "\" /><input name=\"heightANIR\" type=\"hidden\" id=\"heightANIR\" value=\"",
        ani.options("ani.height"), "\" /><input name=\"btnPlayANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnPlayANIR\" title=\"Play\" onclick=\"playAni('ANIR')\" value=\"  &gt;  \" /> <input name=\"btnPauseANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnPauseANIR\" title=\"Pause\" onclick=\"pauseAni('ANIR')\" value=\"  O  \" /> <input name=\"btnFastANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnFastANIR\" title=\"Speed up\" onclick=\"fastAni('ANIR',1)\" value=\"  +  \" /> <input name=\"btnSlowANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnSlowANIR\" title=\"Slow down\" onclick=\"fastAni('ANIR',-1)\" value=\"  -  \" /> <input name=\"btnPrevANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnPrevANIR\" title=\"Previous frame\" onclick=\"prevAni('ANIR',1)\" value=\"  &lt;&lt;  \" /> <input name=\"btnNextANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnNextANIR\" title=\"Next frame\" onclick=\"prevAni('ANIR',-1)\" value=\"  &gt;&gt;  \" /> <input name=\"btnFirstANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnFirstANIR\" title=\"First frame\" onclick=\"firstAni('ANIR',true)\" value=\"  |&lt;  \" /> <input name=\"btnLastANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnLastANIR\" title=\"Last frame\" onclick=\"firstAni('ANIR',false)\" value=\"  &gt;|  \" /> <input name=\"btnMoreANIR\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnMoreANIR\" title=\"More controls\" onclick=\"btnMore('ANIR')\" value=\"  &lt;&gt;  \" /></div><div id=\"moreParANIR\" class=\"morepar\"><label title=\"Which frame to go?\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\">View <input name=\"txtFrameANIR\" type=\"text\" id=\"txtFrameANIR\" onblur=\"txtFrame(this.value, 'ANIR')\" value=\"1\" size=\"4\" class=\"text\" />/",
        ani.options("nmax"), " frame</label> <label title=\"Loop or not?\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\"><input name=\"checkLoopANIR\" type=\"checkbox\" id=\"checkLoopANIR\" ", ifelse(ani.options("loop"), "checked=\"checked\"", ""),"/>Loop</label> <label title=\"Time interval for the animation (in sec)\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\">Time Interval: <input name=\"txtIntervalANIR\" type=\"text\" id=\"txtIntervalANIR\" onblur=\"txtInterval(this)\" value=\"",
        ani.options()$interval[2], "\" size=\"4\" class=\"text\" /></label> <label title=\"Increment in time interval\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\">Step: <input name=\"txtStepANIR\" type=\"text\" id=\"txtStepANIR\" onblur=\"txtInterval(this)\" value=\"0.1\" size=\"4\" class=\"text\" /></label></div><div class=\"description\">",
        ani.options("description"), "</div></fieldset>", footer,
        "</div>", "</body></html>", sep = "")
    cat(html, file = ani.file)
    ani.options(interval = ani.options()$interval[2])
    if (ani.options("autobrowse"))
        on.exit(browseURL(paste("file://", ani.file, sep = "")),
            add = TRUE)
    options(prompt = ani.options("withprompt")[1])
    ani.options(withprompt = ani.options("withprompt")[2])
    setwd(ani.options("outdir")[2])
    ani.options(outdir = ani.options("outdir")[1])
    message(ani.options("nmax"), " animation frames recorded.")
    message("HTML animation page created: ", normalizePath(ani.file))
}
