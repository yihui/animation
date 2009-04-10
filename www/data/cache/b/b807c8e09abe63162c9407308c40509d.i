a:44:{i:0;a:3:{i:0;s:14:"document_start";i:1;a:0:{}i:2;i:0;}i:1;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:0;}i:2;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:1;}i:3;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:-1;i:1;i:0;i:2;i:1;i:3;s:0:"";}i:2;i:1;}i:4;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:33:"The k-Nearest Neighbour Algorithm";i:1;i:1;i:2;i:1;}i:2;i:1;}i:5;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:1;}i:2;i:1;}i:6;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:48;}i:7;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:43:"
Let the people around me decide who I am. ";}i:2;i:49;}i:8;a:3:{i:0;s:6:"smiley";i:1;a:1:{i:0;s:5:"FIXME";}i:2;i:92;}i:9;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:97;}i:10;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:99;}i:11;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:1;i:1;i:98;i:2;i:1;i:3;s:33:"The k-Nearest Neighbour Algorithm";}i:2;i:99;}i:12;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:9:"Animation";i:1;i:2;i:2;i:99;}i:2;i:99;}i:13;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:99;}i:14;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:120;}i:15;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:121;}i:16;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:1;i:1;a:7:{i:0;s:3:"knn";i:1;s:76:"http://animation.r-forge.r-project.org/frames/k-nearest_neighbour_algorithm/";i:2;s:3:"png";i:3;s:2:"40";i:4;s:3:"500";i:5;s:1:"2";i:6;s:36:"Demonstration for kNN Classification";}}i:2;i:1;}i:2;i:122;}i:17;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:258;}i:18;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:3;i:1;a:1:{i:0;s:34:"For each row of the test set, the ";}}i:2;i:3;}i:2;i:259;}i:19;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"mathmulti";i:1;a:2:{i:0;s:6:"normal";i:1;s:13:"\normalsize k";}i:2;i:5;}i:2;i:293;}i:20;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:3;i:1;a:1:{i:0;s:144:" nearest (in Euclidean distance) training set vectors are found, and the classification is decided by majority vote, with ties broken at random.";}}i:2;i:3;}i:2;i:296;}i:21;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:440;}i:22;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:4;i:1;a:1:{i:0;s:0:"";}}i:2;i:4;}i:2;i:441;}i:23;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:447;}i:24;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:449;}i:25;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:99;i:1;i:448;i:2;i:2;i:3;s:9:"Animation";}i:2;i:449;}i:26;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:6:"R code";i:1;i:2;i:2;i:449;}i:2;i:449;}i:27;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:449;}i:28;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:478:"
library(animation)
oopt = ani.options(ani.height = 500, ani.width = 600, outdir = getwd(), nmax = 10,
    interval = 2, title = "Demonstration for kNN Classification",
    description = "For each row of the test set, the k nearest (in Euclidean
    distance) training set vectors are found, and the classification is
    decided by majority vote, with ties broken at random.")
ani.start()
par(mar = c(3, 3, 1, 0.5), mgp = c(1.5, 0.5, 0))
knn.ani()
ani.stop()
ani.options(oopt)
";i:1;s:1:"r";}i:2;i:474;}i:29;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:964;}i:30;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:449;i:1;i:963;i:2;i:2;i:3;s:6:"R code";}i:2;i:964;}i:31;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:13:"More Examples";i:1;i:2;i:2;i:964;}i:2;i:964;}i:32;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:964;}i:33;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:989;}i:34;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:9:"
Try the ";}i:2;i:990;}i:35;a:3:{i:0;s:14:"monospace_open";i:1;a:0:{}i:2;i:999;}i:36;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:4:"iris";}i:2;i:1001;}i:37;a:3:{i:0;s:15:"monospace_close";i:1;a:0:{}i:2;i:1005;}i:38;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:11:" data here:";}i:2;i:1007;}i:39;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:1018;}i:40;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:192:"
library(animation)
set.seed(11)
idx = sample(nrow(iris), 140)
trn = iris[idx, ]
tst = iris[-idx, ]
ani.options(interval = 0.5)
knn.ani(trn[, 1:2], tst[, 1:2], cl = trn$Species, 
    k = 30) 
";i:1;s:1:"r";}i:2;i:1025;}i:41;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:1227;}i:42;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:964;i:1;i:0;i:2;i:2;i:3;s:13:"More Examples";}i:2;i:1227;}i:43;a:3:{i:0;s:12:"document_end";i:1;a:0:{}i:2;i:1227;}}