a:33:{i:0;a:3:{i:0;s:14:"document_start";i:1;a:0:{}i:2;i:0;}i:1;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:0;}i:2;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:1;}i:3;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:-1;i:1;i:0;i:2;i:1;i:3;s:0:"";}i:2;i:1;}i:4;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:25:"K-Means Cluster Algorithm";i:1;i:1;i:2;i:1;}i:2;i:1;}i:5;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:1;}i:2;i:1;}i:6;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:40;}i:7;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:49:"
Move! Average! Cluster! Move! Average! Cluster! ";}i:2;i:41;}i:8;a:3:{i:0;s:6:"entity";i:1;a:1:{i:0;s:3:"...";}i:2;i:90;}i:9;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:" ";}i:2;i:93;}i:10;a:3:{i:0;s:6:"smiley";i:1;a:1:{i:0;s:5:"FIXME";}i:2;i:94;}i:11;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:99;}i:12;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:101;}i:13;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:1;i:1;i:100;i:2;i:1;i:3;s:25:"K-Means Cluster Algorithm";}i:2;i:101;}i:14;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:9:"Animation";i:1;i:2;i:2;i:101;}i:2;i:101;}i:15;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:101;}i:16;a:3:{i:0;s:6:"p_open";i:1;a:0:{}i:2;i:122;}i:17;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:123;}i:18;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:1;i:1;a:7:{i:0;s:6:"kmeans";i:1;s:66:"http://s288.photobucket.com/albums/ll181/xieyihui/k-means_cluster/";i:2;s:3:"png";i:3;s:2:"20";i:4;s:3:"480";i:5;s:1:"2";i:6;s:46:"Demonstration of the K-means Cluster Algorithm";}}i:2;i:1;}i:2;i:124;}i:19;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:263;}i:20;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:3;i:1;a:1:{i:0;s:48:"Move! Average! Cluster! Move! Average! Cluster! ";}}i:2;i:3;}i:2;i:264;}i:21;a:3:{i:0;s:6:"entity";i:1;a:1:{i:0;s:3:"...";}i:2;i:312;}i:22;a:3:{i:0;s:5:"cdata";i:1;a:1:{i:0;s:1:"
";}i:2;i:315;}i:23;a:3:{i:0;s:6:"plugin";i:1;a:3:{i:0;s:9:"animation";i:1;a:2:{i:0;i:4;i:1;a:1:{i:0;s:0:"";}}i:2;i:4;}i:2;i:316;}i:24;a:3:{i:0;s:7:"p_close";i:1;a:0:{}i:2;i:322;}i:25;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:324;}i:26;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:101;i:1;i:323;i:2;i:2;i:3;s:9:"Animation";}i:2;i:324;}i:27;a:3:{i:0;s:6:"header";i:1;a:3:{i:0;s:6:"R code";i:1;i:2;i:2;i:324;}i:2;i:324;}i:28;a:3:{i:0;s:12:"section_open";i:1;a:1:{i:0;i:2;}i:2;i:324;}i:29;a:3:{i:0;s:4:"code";i:1;a:2:{i:0;s:528:"
oopt = ani.options(ani.height = 480, ani.width = 480, outdir = getwd(), interval = 2,
    nmax = 50, title = "Demonstration of the K-means Cluster Algorithm",
    description = "Move! Average! Cluster! Move! Average! Cluster! ...")
ani.start()
par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0))
cent = 1.5 * c(1, 1, -1, -1, 1, -1, 1, -1); x = NULL
for (i in 1:8) x = c(x, rnorm(25, mean = cent[i]))
x = matrix(x, ncol = 2)
colnames(x) = c("X1", "X2")
kmeans.ani(x, centers = 4, pch = 1:4, col = 1:4)
ani.stop()
ani.options(oopt)
";i:1;s:1:"r";}i:2;i:349;}i:30;a:3:{i:0;s:13:"section_close";i:1;a:0:{}i:2;i:888;}i:31;a:3:{i:0;s:12:"section_edit";i:1;a:4:{i:0;i:324;i:1;i:0;i:2;i:2;i:3;s:6:"R code";}i:2;i:888;}i:32;a:3:{i:0;s:12:"document_end";i:1;a:0:{}i:2;i:888;}}