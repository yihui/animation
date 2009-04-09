a:192:{i:0;a:3:{i:0;s:14:"document_start";i:1;a:0:{}i:2;i:0;}i:1;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:0;}i:2;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:1;}i:3;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:-1;i:1;i:0;i:2;i:1;i:3;s:0:"";}i:2;i:1;}i:4;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:29:"Creating HTML animation pages";i:1;i:1;i:2;i:1;}i:2;i:1;}i:5;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:1;}i:2;i:1;}i:6;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:44;}i:7;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:148:"
This page is to explain what happens behind the animation functions. Generally speaking, there are three steps to follow when we want to create an ";}i:2;i:45;}i:8;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:4:"HTML";}i:2;i:193;}i:9;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:63:" animation page. First, make some preparations (copy necessary ";}i:2;i:197;}i:10;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:3:"CSS";}i:2;i:260;}i:11;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:5:" and ";}i:2;i:263;}i:12;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:2:"JS";}i:2;i:268;}i:13;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:16:" files) for the ";}i:2;i:270;}i:14;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:4:"HTML";}i:2;i:286;}i:15;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:51:" file and open a graphics device for the next step ";}i:2;i:290;}i:16;a:3:{i:0;s:6:"entity";i:1;a:1:{i:0;s:2:"--";}i:2;i:341;}i:17;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:" ";}i:2;i:343;}i:18;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:344;}i:19;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:11:"ani.start()";}i:2;i:346;}i:20;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:357;}i:21;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:55:"; second, make a series of plots using any R functions ";}i:2;i:359;}i:22;a:3:{i:0;s:6:"entity";i:1;a:1:{i:0;s:2:"--";}i:2;i:414;}i:23;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:75:" these plots will be recorded as image frames one by one; third, write the ";}i:2;i:416;}i:24;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:4:"HTML";}i:2;i:491;}i:25;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:6:" file ";}i:2;i:495;}i:26;a:3:{i:0;s:6:"entity";i:1;a:1:{i:0;s:2:"--";}i:2;i:501;}i:27;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:" ";}i:2;i:503;}i:28;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:504;}i:29;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:10:"ani.stop()";}i:2;i:506;}i:30;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:516;}i:31;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:42:". Below is a typical process for creating ";}i:2;i:518;}i:32;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:4:"HTML";}i:2;i:560;}i:33;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:17:" animation pages:";}i:2;i:564;}i:34;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:581;}i:35;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:72:"
ani.options(...)
ani.start(...)
for (i in 1:nmax) plot(...)
ani.stop()
";i:1;N;}i:2;i:588;}i:36;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:668;}i:37;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:13:"The function ";}i:2;i:670;}i:38;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:683;}i:39;a:3:{i:0;s:12:"internallink";i:1;a:2:{i:0;s:7:"options";i:1;s:13:"ani.options()";}i:2;i:685;}i:40;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:710;}i:41;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:153:" will tell the following functions some options to make an animation, such as the time interval, the maximum frames, the width and height of images, etc.";}i:2;i:712;}i:42;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:865;}i:43;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:867;}i:44;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:1;i:1;i:866;i:2;i:1;i:3;s:29:"Creating HTML animation pages";}i:2;i:867;}i:45;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:11:"ani.start()";i:1;i:2;i:2;i:867;}i:2;i:867;}i:46;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:867;}i:47;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:890;}i:48;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:29:"
In the beginning, two files ";}i:2;i:891;}i:49;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:920;}i:50;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:7:"ANI.css";}i:2;i:922;}i:51;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:929;}i:52;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:5:" and ";}i:2;i:931;}i:53;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:936;}i:54;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:6:"FUN.js";}i:2;i:938;}i:55;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:944;}i:56;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:36:" are copied to the output directory ";}i:2;i:946;}i:57;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:982;}i:58;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:6:"outdir";}i:2;i:984;}i:59;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:990;}i:60;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:25:". Then a graphics device ";}i:2;i:992;}i:61;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:1017;}i:62;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:7:"ani.dev";}i:2;i:1019;}i:63;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:1026;}i:64;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:53:" is opened to record the plots as image files in the ";}i:2;i:1028;}i:65;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:1081;}i:66;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:7:"images/";}i:2;i:1083;}i:67;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:1090;}i:68;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:10:" directory";}i:2;i:1092;}i:69;a:3:{i:0;s:4:"nest";i:1;a:1:{i:0;a:3:{i:0;a:3:{i:0;s:13:"footnote_open";i:1;a:0:{}i:2;i:1102;}i:1;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:117:"it will be created if it does not exist, or all the files in this directory will be removed before new plots are made";}i:2;i:1104;}i:2;a:3:{i:0;s:14:"footnote_close";i:1;a:0:{}i:2;i:1221;}}}i:2;i:1102;}i:70;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:35:". The format of the image files is ";}i:2;i:1223;}i:71;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:1258;}i:72;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:24:"paste(%d, '.', ani.type)";}i:2;i:1260;}i:73;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:1284;}i:74;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:76:", thus the files will be named from 1 to the maximum number of image frames.";}i:2;i:1286;}i:75;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:1362;}i:76;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:1364;}i:77;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:867;i:1;i:1363;i:2;i:2;i:3;s:11:"ani.start()";}i:2;i:1364;}i:78;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:10:"Make plots";i:1;i:2;i:2;i:1364;}i:2;i:1364;}i:79;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:1364;}i:80;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:1386;}i:81;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:104:"
Then some high-level plotting commands (typically in a loop) are executed and the plots are written to ";}i:2;i:1387;}i:82;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:1491;}i:83;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:7:"images/";}i:2;i:1493;}i:84;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:1500;}i:85;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:2:". ";}i:2;i:1502;}i:86;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:1504;}i:87;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:1506;}i:88;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:1364;i:1;i:1505;i:2;i:2;i:3;s:10:"Make plots";}i:2;i:1506;}i:89;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:10:"ani.stop()";i:1;i:2;i:2;i:1506;}i:2;i:1506;}i:90;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:1506;}i:91;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:1528;}i:92;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:60:"
In the end, we have obtained all the animation frames, and ";}i:2;i:1529;}i:93;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:1589;}i:94;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:10:"ani.stop()";}i:2;i:1591;}i:95;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:1601;}i:96;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:15:" will write an ";}i:2;i:1603;}i:97;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:4:"HTML";}i:2;i:1618;}i:98;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:5:" file";}i:2;i:1622;}i:99;a:3:{i:0;s:4:"nest";i:1;a:1:{i:0;a:6:{i:0;a:3:{i:0;s:13:"footnote_open";i:1;a:0:{}i:2;i:1627;}i:1;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:9:"just use ";}i:2;i:1629;}i:2;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:1638;}i:3;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:5:"cat()";}i:2;i:1640;}i:4;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:1645;}i:5;a:3:{i:0;s:14:"footnote_close";i:1;a:0:{}i:2;i:1647;}}}i:2;i:1627;}i:100;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:36:" containing the animation driven by ";}i:2;i:1649;}i:101;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:2:"JS";}i:2;i:1685;}i:102;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:6:". The ";}i:2;i:1687;}i:103;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:2:"JS";}i:2;i:1693;}i:104;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:35:" code also works as a loop: in the ";}i:2;i:1695;}i:105;a:3:{i:0;s:13:"emphasis_open";i:1;a:0:{}i:2;i:1730;}i:106;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"i";}i:2;i:1732;}i:107;a:3:{i:0;s:14:"emphasis_close";i:1;a:0:{}i:2;i:1733;}i:108;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:22:"-th step, display the ";}i:2;i:1735;}i:109;a:3:{i:0;s:13:"emphasis_open";i:1;a:0:{}i:2;i:1757;}i:110;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"i";}i:2;i:1759;}i:111;a:3:{i:0;s:14:"emphasis_close";i:1;a:0:{}i:2;i:1760;}i:112;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:37:"-th image element and hide the rest. ";}i:2;i:1762;}i:113;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:1799;}i:114;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:1801;}i:115;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:1506;i:1;i:1800;i:2;i:2;i:3;s:10:"ani.stop()";}i:2;i:1801;}i:116;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:8:"Examples";i:1;i:2;i:2;i:1801;}i:2;i:1801;}i:117;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:1801;}i:118;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:1821;}i:119;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:51:"
Below are two examples using functions in package ";}i:2;i:1822;}i:120;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:1873;}i:121;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:9:"animation";}i:2;i:1875;}i:122;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:1884;}i:123;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:36:" and some custom R code to generate ";}i:2;i:1886;}i:124;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:4:"HTML";}i:2;i:1922;}i:125;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:30:" animation pages respectively.";}i:2;i:1926;}i:126;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:1956;}i:127;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:1958;}i:128;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:1801;i:1;i:1957;i:2;i:2;i:3;s:8:"Examples";}i:2;i:1958;}i:129;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:15:"Brownian Motion";i:1;i:3;i:2;i:1958;}i:2;i:1958;}i:130;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:3;}i:2;i:1958;}i:131;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:1983;}i:132;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:14:"
The function ";}i:2;i:1984;}i:133;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:1998;}i:134;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:17:"brownian.motion()";}i:2;i:2000;}i:135;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:2017;}i:136;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:16:" in the package ";}i:2;i:2019;}i:137;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:2035;}i:138;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:9:"animation";}i:2;i:2037;}i:139;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:2046;}i:140;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:50:" has given a demonstration of the Brownian Motion.";}i:2;i:2048;}i:141;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:2098;}i:142;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:569:"
# create an HTML animation page of Brownian Motion
# store the old option to restore it later
oopt = ani.options(interval = 0.05, nmax = 100, ani.dev = png, ani.type = "png",
    title = "Demonstration of Brownian Motion",
    description = "Random walk on the 2D plane: for each point (x, y), 
    x = x + rnorm(1) and y = y + rnorm(1).")
ani.start()
opar = par(mar = c(3, 3, 1, 0.5), mgp = c(2, .5, 0), tcl = -0.3,
    cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)
brownian.motion(pch = 21, cex = 5, col = "red", bg = "yellow")
par(opar)
ani.stop()
ani.options(oopt)
";i:1;s:1:"r";}i:2;i:2105;}i:143;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:2684;}i:144;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:27:"The animation is like this:";}i:2;i:2686;}i:145;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:2713;}i:146;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:2713;}i:147;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:1;i:1;a:7:{i:0;s:2:"bm";i:1;s:66:"http://i288.photobucket.com/albums/ll181/xieyihui/brownian_motion/";i:2;s:3:"png";i:3;s:3:"100";i:4;s:3:"480";i:5;s:4:"0.05";i:6;s:32:"Demonstration of Brownian Motion";}}i:2;i:1;}i:2;i:2715;}i:148;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:2840;}i:149;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:3;i:1;a:1:{i:0;s:90:"Random walk on the 2D plane: for each point (x, y), x = x + rnorm(1) and y = y + rnorm(1).";}}i:2;i:3;}i:2;i:2841;}i:150;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:2931;}i:151;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:4;i:1;a:1:{i:0;s:0:"";}}i:2;i:4;}i:2;i:2932;}i:152;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:2938;}i:153;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:2940;}i:154;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:1958;i:1;i:2939;i:2;i:3;i:3;s:15:"Brownian Motion";}i:2;i:2940;}i:155;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:17:"Gradient polygons";i:1;i:3;i:2;i:2940;}i:2;i:2940;}i:156;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:3;}i:2;i:2940;}i:157;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:2967;}i:158;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:88:"
Here is some code to produce an animation illustrating the gradient colors in polygons.";}i:2;i:2968;}i:159;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:3056;}i:160;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:343:"
y = 0.1 + runif(20, 0.2, 1)
xx = c(1, 1:20, 20)
yy = c(0, y, 0)
cl = seq(255, 0, length = 50)
for (i in 1:50) {
    yy = rbind(yy, c(0, y - (1 - cl[i]/255) * min(y), 0))
    plot(xx, yy[1, ], type = "n", xlab = "x", ylab = "y")
    for (j in 1:i) polygon(xx, yy[j + 1, ], col = rgb(1, cl[j]/255,
        0), border = NA)
    Sys.sleep(0.1)
}
";i:1;s:1:"r";}i:2;i:3063;}i:161;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:3416;}i:162;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:36:"We can also put the animation in an ";}i:2;i:3418;}i:163;a:3:{i:0;s:7:"acronym";i:1;a:1:{i:0;s:4:"HTML";}i:2;i:3454;}i:164;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:26:" animation page like this:";}i:2;i:3458;}i:165;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:3484;}i:166;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:890:"
oopt = ani.options(interval = 0.2, nmax = 50, ani.dev = png, ani.type = "png",
    ani.height = 350, ani.width = 500,
    title = "Demonstration of Polygons with Gradient Colors",
    description = "The graph actually consists of a series of polygons, 
    each with a redder color starting from yellow.")
ani.start()
opar = par(mar = c(3, 3, 1, 0.5), mgp = c(2, .5, 0), tcl = -0.3,
    cex.axis = 0.8, cex.lab = 0.8, cex.main = 1)

####################
y = 0.1 + runif(20, 0.2, 1)
xx = c(1, 1:20, 20)
yy = c(0, y, 0)
cl = seq(255, 0, length = 50)
for (i in 1:50) {
    yy = rbind(yy, c(0, y - (1 - cl[i]/255) * min(y), 0))
    plot(xx, yy[1, ], type = "n", xlab = "x", ylab = "y")
    for (j in 1:i) polygon(xx, yy[j + 1, ], col = rgb(1, cl[j]/255,
        0), border = NA)
#    Sys.sleep(0.1)
#    not need to 'sleep' here!
}

####################
par(opar)
ani.stop()
ani.options(oopt)
";i:1;s:1:"r";}i:2;i:3491;}i:167;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:4391;}i:168;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:70:"This is the animation (it may look different with your output because ";}i:2;i:4393;}i:169;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:4463;}i:170;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"y";}i:2;i:4465;}i:171;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:4466;}i:172;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:12:" is random):";}i:2;i:4468;}i:173;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:4480;}i:174;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:4480;}i:175;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:1;i:1;a:7:{i:0;s:2:"gp";i:1;s:68:"http://i288.photobucket.com/albums/ll181/xieyihui/gradient_polygons/";i:2;s:3:"png";i:3;s:2:"50";i:4;s:3:"350";i:5;s:3:"0.2";i:6;s:46:"Demonstration of Polygons with Gradient Colors";}}i:2;i:1;}i:2;i:4482;}i:176;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:4621;}i:177;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:3;i:1;a:1:{i:0;s:99:"The graph actually consists of a series of polygons, each with a redder color starting from yellow.";}}i:2;i:3;}i:2;i:4622;}i:178;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:4721;}i:179;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:4;i:1;a:1:{i:0;s:0:"";}}i:2;i:4;}i:2;i:4722;}i:180;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:4728;}i:181;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:4730;}i:182;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:2940;i:1;i:4729;i:2;i:3;i:3;s:17:"Gradient polygons";}i:2;i:4730;}i:183;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:11:"Discussions";i:1;i:2;i:2;i:4730;}i:2;i:4730;}i:184;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:4730;}i:185;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:4753;}i:186;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:28:"
Post the discussions here. ";}i:2;i:4754;}i:187;a:3:{i:0;s:6:"smiley";i:1;a:1:{i:0;s:3:"^_^";}i:2;i:4782;}i:188;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:4785;}i:189;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:4786;}i:190;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:4730;i:1;i:0;i:2;i:2;i:3;s:11:"Discussions";}i:2;i:4786;}i:191;a:3:{i:0;s:12:"document_end";i:1;a:0:{}i:2;i:4786;}}