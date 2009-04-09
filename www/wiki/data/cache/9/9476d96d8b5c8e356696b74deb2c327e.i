a:155:{i:0;a:3:{i:0;s:14:"document_start";i:1;a:0:{}i:2;i:0;}i:1;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:0;}i:2;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:1;}i:3;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:-1;i:1;i:0;i:2;i:1;i:3;s:0:"";}i:2;i:1;}i:4;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:44:"Miscellaneous functions in package animation";i:1;i:1;i:2;i:1;}i:2;i:1;}i:5;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:1;}i:2;i:1;}i:6;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:59;}i:7;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:177:"
Some of these functions are occasionally used in my daily life, and some are the implementations of my quick ideas when I see something interesting (like the visual illusions).";}i:2;i:60;}i:8;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:237;}i:9;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:239;}i:10;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:1;i:1;i:238;i:2;i:1;i:3;s:44:"Miscellaneous functions in package animation";}i:2;i:239;}i:11;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:18:""Tidy up" R source";i:1;i:2;i:2;i:239;}i:2;i:239;}i:12;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:239;}i:13;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:269;}i:14;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:14:"
The function ";}i:2;i:270;}i:15;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:284;}i:16;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:13:"tidy.source()";}i:2;i:286;}i:17;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:299;}i:18;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:15:" is defined as:";}i:2;i:301;}i:19;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:316;}i:20;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:1817:"
> tidy.source
function(source = "clipboard", keep.comment = TRUE, 
    keep.blank.line = FALSE, begin.comment, end.comment, ...) {
    tidy.block = function(block.text) {
        exprs = parse(text = block.text)
        n = length(exprs)
        res = character(n)
        for (i in 1:n) {
            dep = paste(deparse(exprs[i]), collapse = "\n")
            res[i] = substring(dep, 12, nchar(dep) - 1)
        }
        return(res)
    }
    text.lines = readLines(source, warn = FALSE)
    if (keep.comment) {
        identifier = function() paste(sample(LETTERS), collapse = "")
        if (missing(begin.comment)) 
            begin.comment = identifier()
        if (missing(end.comment)) 
            end.comment = identifier()
        text.lines = gsub("^[[:space:]]+|[[:space:]]+$", "", 
            text.lines)
        while (length(grep(sprintf("%s|%s", begin.comment, end.comment), 
            text.lines))) {
            begin.comment = identifier()
            end.comment = identifier()
        }
        head.comment = substring(text.lines, 1, 1) == "#"
        if (any(head.comment)) {
            text.lines[head.comment] = gsub("\"", "'", text.lines[head.comment])
            text.lines[head.comment] = sprintf("%s=\"%s%s\"", 
                begin.comment, text.lines[head.comment], end.comment)
        }
        blank.line = text.lines == ""
        if (any(blank.line) & keep.blank.line) 
            text.lines[blank.line] = sprintf("%s=\"%s\"", begin.comment, 
                end.comment)
        text.tidy = tidy.block(text.lines)
        text.tidy = gsub(sprintf("%s = \"|%s\"", begin.comment, 
            end.comment), "", text.tidy)
    }
    else {
        text.tidy = tidy.block(text.lines)
    }
    cat(paste(text.tidy, collapse = "\n"), "\n", ...)
    invisible(text.tidy)
} 
";i:1;s:1:"r";}i:2;i:323;}i:21;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:2150;}i:22;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:70:"As you have seen, it's quite simple. When I write R code, I'd like to ";}i:2;i:2152;}i:23;a:3:{i:0;s:18:"doublequoteopening";i:1;a:0:{}i:2;i:2222;}i:24;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:4:"tidy";}i:2;i:2223;}i:25;a:3:{i:0;s:18:"doublequoteclosing";i:1;a:0:{}i:2;i:2227;}i:26;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:159:" them up, because I don't want to type the spaces (either those around operators or those for indents). You just have to copy your code to the clipboard, then ";}i:2;i:2228;}i:27;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:2387;}i:28;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:13:"tidy.source()";}i:2;i:2389;}i:29;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:2402;}i:30;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:102:", and the (more standard) code will be printed in the console. For example, this is the original code:";}i:2;i:2404;}i:31;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:2506;}i:32;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:345:"
f = tempfile()
writeLines('
 # rotation of the word "Animation"
# in a loop; change the angle and color
# step by step
for (i in 1:360) {
# redraw the plot again and again
plot(1,ann=FALSE,type="n",axes=FALSE)
# rotate; use rainbow() colors
text(1,1,"Animation",srt=i,col=rainbow(360)[i],cex=7*i/360)
# pause for a while
Sys.sleep(0.01)}
', f)
";i:1;s:1:"r";}i:2;i:2513;}i:33;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:2868;}i:34;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:16:"And this is the ";}i:2;i:2870;}i:35;a:3:{i:0;s:18:"doublequoteopening";i:1;a:0:{}i:2;i:2886;}i:36;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:4:"tidy";}i:2;i:2887;}i:37;a:3:{i:0;s:18:"doublequoteclosing";i:1;a:0:{}i:2;i:2891;}i:38;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:9:" version:";}i:2;i:2892;}i:39;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:2901;}i:40;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:375:"
> tidy.source(f)
# rotation of the word 'Animation'
# in a loop; change the angle and color
# step by step
for (i in 1:360) {
   # redraw the plot again and again
   plot(1, ann = FALSE, type = "n", axes = FALSE)
   # rotate; use rainbow() colors
   text(1, 1, "Animation", srt = i, col = rainbow(360)[i], cex = 7 *
       i/360)
   # pause for a while
   Sys.sleep(0.01)
}
";i:1;s:1:"r";}i:2;i:2908;}i:41;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:3295;}i:42;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:239;i:1;i:3294;i:2;i:2;i:3;s:18:""Tidy up" R source";}i:2;i:3295;}i:43;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:16:"Visual Illusions";i:1;i:2;i:2;i:3295;}i:2;i:3295;}i:44;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:3295;}i:45;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:3323;}i:46;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:58:"
Perhaps visual illusions can inspire ideas in animations.";}i:2;i:3324;}i:47;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:3382;}i:48;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:3384;}i:49;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:3295;i:1;i:3383;i:2;i:2;i:3;s:16:"Visual Illusions";}i:2;i:3384;}i:50;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:27:"Scintillating grid illusion";i:1;i:3;i:2;i:3384;}i:2;i:3384;}i:51;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:3;}i:2;i:3384;}i:52;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:3421;}i:53;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:24:"
White dots? Black dots?";}i:2;i:3422;}i:54;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:3446;}i:55;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:3448;}i:56;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:8:"Illusion";i:1;i:4;i:2;i:3448;}i:2;i:3448;}i:57;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:4;}i:2;i:3448;}i:58;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:3464;}i:59;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:3465;}i:60;a:3:{i:0;s:13:"internalmedia";i:1;a:7:{i:0;s:42:":animation:scintillating_grid_illusion.png";i:1;s:27:"Scintillating grid illusion";i:2;s:6:"center";i:3;N;i:4;N;i:5;s:5:"cache";i:6;s:7:"details";}i:2;i:3466;}i:61;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:3542;}i:62;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:3544;}i:63;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:6:"R code";i:1;i:4;i:2;i:3544;}i:2;i:3544;}i:64;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:4;}i:2;i:3544;}i:65;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:20:"
vi.grid.illusion()
";i:1;s:1:"r";}i:2;i:3565;}i:66;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:3597;}i:67;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:3384;i:1;i:3596;i:2;i:3;i:3;s:27:"Scintillating grid illusion";}i:2;i:3597;}i:68;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:21:"Hermann grid illusion";i:1;i:3;i:2;i:3597;}i:2;i:3597;}i:69;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:3;}i:2;i:3597;}i:70;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:3628;}i:71;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:32:"
Gray dots at the intersections?";}i:2;i:3629;}i:72;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:3661;}i:73;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:3663;}i:74;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:8:"Illusion";i:1;i:4;i:2;i:3663;}i:2;i:3663;}i:75;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:4;}i:2;i:3663;}i:76;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:3679;}i:77;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:3680;}i:78;a:3:{i:0;s:13:"internalmedia";i:1;a:7:{i:0;s:36:":animation:hermann_grid_illusion.png";i:1;s:21:"Hermann grid illusion";i:2;s:6:"center";i:3;N;i:4;N;i:5;s:5:"cache";i:6;s:7:"details";}i:2;i:3681;}i:79;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:3745;}i:80;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:3747;}i:81;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:6:"R code";i:1;i:4;i:2;i:3747;}i:2;i:3747;}i:82;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:4;}i:2;i:3747;}i:83;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:80:"
vi.grid.illusion(type = "h", lwd = 22, nrow = 5, ncol = 5, 
    col = "white")
";i:1;s:1:"r";}i:2;i:3768;}i:84;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:3860;}i:85;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:3597;i:1;i:3859;i:2;i:3;i:3;s:21:"Hermann grid illusion";}i:2;i:3860;}i:86;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:12:"Lilac Chaser";i:1;i:3;i:2;i:3860;}i:2;i:3860;}i:87;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:3;}i:2;i:3860;}i:88;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:3882;}i:89;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:19:"
Green dots moving?";}i:2;i:3883;}i:90;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:3902;}i:91;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:3904;}i:92;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:9:"Animation";i:1;i:4;i:2;i:3904;}i:2;i:3904;}i:93;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:4;}i:2;i:3904;}i:94;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:3921;}i:95;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:3922;}i:96;a:3:{i:0;s:6:"plugin";i:1;a:4:{i:0;s:9:"animation";i:1;a:2:{i:0;i:1;i:1;a:7:{i:0;s:5:"lilac";i:1;s:63:"http://s288.photobucket.com/albums/ll181/xieyihui/lilac_chaser/";i:2;s:3:"png";i:3;s:2:"16";i:4;s:3:"480";i:5;s:4:"0.05";i:6;s:30:"Visual Illusions: Lilac Chaser";}}i:2;i:1;i:3;s:122:"<ani lilac http://s288.photobucket.com/albums/ll181/xieyihui/lilac_chaser/ png 16 480 0.05|Visual Illusions: Lilac Chaser>";}i:2;i:3923;}i:97;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:4045;}i:98;a:3:{i:0;s:6:"plugin";i:1;a:4:{i:0;s:9:"animation";i:1;a:2:{i:0;i:3;i:1;a:1:{i:0;s:97:"Stare at the center cross for a few (say 30) seconds to experience the phenomena of the illusion.";}}i:2;i:3;i:3;s:97:"Stare at the center cross for a few (say 30) seconds to experience the phenomena of the illusion.";}i:2;i:4046;}i:99;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:4143;}i:100;a:3:{i:0;s:6:"plugin";i:1;a:4:{i:0;s:9:"animation";i:1;a:2:{i:0;i:4;i:1;a:1:{i:0;s:0:"";}}i:2;i:4;i:3;s:6:"</ani>";}i:2;i:4144;}i:101;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:4150;}i:102;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:4152;}i:103;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:6:"R code";i:1;i:4;i:2;i:4152;}i:2;i:4152;}i:104;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:4;}i:2;i:4152;}i:105;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:360:"
oopt = ani.options(ani.height = 480, ani.width = 480, outdir = getwd(), nmax = 1,
    interval = 0.05, title = "Visual Illusions: Lilac Chaser",
    description = "Stare at the center cross for a few (say 30) seconds
    to experience the phenomena of the illusion.")
ani.start()
par(pty = "s", mar = rep(1, 4))
vi.lilac.chaser()
ani.stop()
ani.options(oopt)
";i:1;s:1:"r";}i:2;i:4173;}i:106;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:4545;}i:107;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:3860;i:1;i:4544;i:2;i:3;i:3;s:12:"Lilac Chaser";}i:2;i:4545;}i:108;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:31:"Create RSS feed from a CSV file";i:1;i:2;i:2;i:4545;}i:2;i:4545;}i:109;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:4545;}i:110;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:4588;}i:111;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:4:"
An ";}i:2;i:4589;}i:112;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:3:"RSS";}i:2;i:4593;}i:113;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:29:" feed is essentially just an ";}i:2;i:4596;}i:114;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:3:"XML";}i:2;i:4625;}i:115;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:43:" file, thus the creation is easy just with ";}i:2;i:4628;}i:116;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:4671;}i:117;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:5:"cat()";}i:2;i:4673;}i:118;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:4678;}i:119;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:67:" to write some tags into a text file. The elments of an item in an ";}i:2;i:4680;}i:120;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:3:"RSS";}i:2;i:4747;}i:121;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:23:" feed usually contains ";}i:2;i:4750;}i:122;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:4773;}i:123;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:5:"title";}i:2;i:4775;}i:124;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:4780;}i:125;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:2:", ";}i:2;i:4782;}i:126;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:4784;}i:127;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:4:"link";}i:2;i:4786;}i:128;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:4790;}i:129;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:2:", ";}i:2;i:4792;}i:130;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:4794;}i:131;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:6:"author";}i:2;i:4796;}i:132;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:4802;}i:133;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:2:", ";}i:2;i:4804;}i:134;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:4806;}i:135;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:11:"description";}i:2;i:4808;}i:136;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:4819;}i:137;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:2:", ";}i:2;i:4821;}i:138;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:4823;}i:139;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:7:"pubDate";}i:2;i:4825;}i:140;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:4832;}i:141;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:2:", ";}i:2;i:4834;}i:142;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:4836;}i:143;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:4:"guid";}i:2;i:4838;}i:144;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:4842;}i:145;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:6:", and ";}i:2;i:4844;}i:146;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:4850;}i:147;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:8:"category";}i:2;i:4852;}i:148;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:4860;}i:149;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:46:", etc, which are stored in the CSV data file. ";}i:2;i:4862;}i:150;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:4908;}i:151;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:55:"
write.rss(entry = "http://r.yihui.name/news/rss.csv")
";i:1;s:1:"r";}i:2;i:4915;}i:152;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:4982;}i:153;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:4545;i:1;i:0;i:2;i:2;i:3;s:31:"Create RSS feed from a CSV file";}i:2;i:4982;}i:154;a:3:{i:0;s:12:"document_end";i:1;a:0:{}i:2;i:4982;}}