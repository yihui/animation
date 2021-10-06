# CHANGES IN animation VERSION 2.7

- `saveGIF()` didn't work when the option `ani.dev` is set to a function (thanks, @stla, #120 #121).

- The `ani.res` option works for `saveHTML()` and `saveVideo()` now (thanks, @trevorld, #127 #129).

- The `ani.res` option works for arbitrary graphical devices now (thanks, @trevorld, #135).

# CHANGES IN animation VERSION 2.6

## NEW FEATURES

- add a new option `ani.res` to ani.options(), to control the resolution of png, jepg, bmp and tiff images when using saveGIF() (#99).

- saveGIF() and im.convert() now support converting using the 'magick' R package which does not require shelling out to external software.

## BUG FIXES

- The stopping criterion in kmeans.ani() was buggy: the iteration should stop only when the cluster centers do not change any more (thanks, Sen Zhou).

# CHANGES IN animation VERSION 2.5

## MAJOR CHANGES

- removed all examples from the package, since this package failed to pass R CMD check on CRAN for unknown reasons; all examples are still available on Github https://github.com/yihui/animation/tree/master/inst/examples and they will be moved to https://yihui.org/animation in the future

# CHANGES IN animation VERSION 2.4

## BUG FIXES

- saveGIF() on Windows might give an error message "the input line it too long" when the command to be passed to ImageMagick/GraphicsMagic is too long; now the command is quoted by double quotes (based on an answer to http://stackoverflow.com/q/682799/559676) (thanks, Aaron Dodd)

- save*() functions should overwrite the output file (#50, #60).

# CHANGES IN animation VERSION 2.3

## NEW FEATURES

- added a new argument 'navigator' to saveHTML() so that we can remove the navigator conveniently without having to understand SciAnimator library

## MAJOR CHANGES

- the default value for the argument `other.opts` in saveVideo() was changed to '-pix_fmt yuv420p' when the output format is MP4 (Skye Bender-deMoll, #49)

- the defunct functions highlight.def(), write.rss() and ani.news() were finally removed from this package

- the functions ani.start() and ani.stop() are defunct and will be removed in the next version of this package; please use saveHTML() instead

- the animation option `outdir` in ani.options() was removed because it was confusing to many users that the output is in a temporary directory by default; now all files are written relative to the current working directory (#31)

- the animation option `convert` in ani.options() is expected to be the path to ImageMagick/GraphicsMagick _without_ quotes, i.e. not the shQuote() version (#35)

- the animation option 'htmlfile' in ani.options() was removed, because it was only used in saveHTML() and g.brownian.motion(), and is not a general enough option

- the 'clean' argument in saveVideo() was removed: images will be created in the temporary directory, and will not be explicitly cleaned (R will clean them then it quits)

# CHANGES IN animation VERSION 2.2

## MINOR CHANGES

- datasets in this package are lazy loaded now, which means we no longer need, for example, data(pollen) -- just use pollen

- added an article in the articles/ directory of the package, which will be published in the Journal of Statistical Software; see citation('animation')

## BUG FIXES

- fixed #28: the single quotes in the example code of saveHTML() in the PDF manual were not correctly rendered (thanks, James Marca)

## DOCUMENTATION

- the animation website http://animation.yihui.org is being rebuilt with knitr and Jekyll on Github (contributions/pull requests are welcome): http://vis.supstat.com/categories.html#Animation-ref

# CHANGES IN animation VERSION 2.1

## MINOR CHANGES

- x- and y-axis in the top scatter plot in boot.iid() are switched; now x-axis is the sample value and y-axis is the index

- Rosling.bubbles() was rewritten to avoid .Internal() and the usage was slightly changed (see documentation)

# CHANGES IN animation VERSION 2.0-6

## NEW FEATURES

- demo('elephant') to show a winking pink elephant; who said elephants cannot dance? (thanks, Neil Gunther)

- all animations are using dev.hold() and dev.flush() now, so they will no longer flicker under Linux and Mac

## MINOR CHANGES

- saveGIF() and im.convert() returns the command for the conversion, which might be helpful for debugging. A note on the limit of ImageMagick or GraphicsMagick was added to the documentation of im.convert() (thanks, Florian Knorr)

- fixed a typo in ?animation (imgname should be img.name; thanks, Neuwirth Erich)

- ani.pause() gained an argument 'interval' to specify the time interval directly

# CHANGES IN animation VERSION 2.0-5

## BUG FIXES

- saveVideo() fails to recognize FFmpeg when R is in a non-interactive mode (thanks, Felipe Olmos)

## MINOR CHANGES

- saveHTML() will tell the user how to change the output dir

# CHANGES IN animation VERSION 2.0-4

## NEW FEATURES

- a new function boot.lowess() to examine the LOWESS fit with bootstrapping

## BUG FIXES

- saveSWF(): the path of images passed to SWF Tools has been fixed (using the absolute path instead of the relative one); the images are named like Rplot%03d.png now to avoid incorrect ordering under Windows (thanks, Michael Hoehle)

## MINOR CHANGES

- the dataset CLELAL09 gained a new variable 'team' to indicate the team that the rows correspond to

# CHANGES IN animation VERSION 2.0-3

## NEW FEATURES

- sim.qqnorm() gained a new argument 'last.plot' to do something after drawing the QQ plot, e.g. add a diagonal line (abline(0, 1))

## MINOR CHANGES

- for saveLatex(): when full.path = TRUE, \ will be replaced with / in the file path so that LaTeX can really find the animation file under Windows

- ani.options() will perform a simple check on the validity of the options and issue warnings if the device and the file extension do not match, or the width and height for the pdf() device are greater than 100 inches

# CHANGES IN animation VERSION 2.0-2

## NEW FEATURES

- demo('IBM') to show IBM stock closing prices from 2000 to 2010

- ani.record() gained a new argument 'replay.cur', which can be helpful when we want to capture low-level plot changes without storing all the plots in memory (default behaviour of ani.record())

- a new function saveVideo() to convert a sequence of images to a video using FFmpeg (thanks, Thomas Julou)

- we can easily create an animation using Rweb now; see a demo in system.file('misc', 'Rweb', 'demo.html', package = 'animation')

- a new function qpdf() as a wrapper to the program 'qpdf', which is mainly used to compress the PDF files (it is recommended over Pdftk)

- saveLatex() gained a new argument 'full.path': when the animation frames are not in the same directory with the LaTeX document, we can set full.path = TRUE to ensure LaTeX can find the image files

- grad.desc() gained two new arguments: 'gr' to provide the gradient function, and 'main' to specify to title of the plot (thanks, Zeno Adams)

- clt.ani() gained two arguments 'mean' and 'sd' to draw the theoretical limiting distribution

- a new demo('ggobi_animation') to show how to record GGobi plots as an animation in the HTML file

## SIGNIFICANT CHANGES

- saveMovie() was renamed to saveGIF() to better reflect what the function does; this change will not affect users because 'saveMovie' is still an alias to 'saveGIF' (i.e. they are identical)

## MINOR CHANGES

- saveSWF() puts all the image frames into the temp dir instead of ani.options('outdir') (similar to saveGIF())

- the location of the argument 'img.name' was moved to the 3rd place in saveSWF() to be consistent to other saveXXX() functions

- clt.ani() gained a new argument 'xlim' to set the x-axis limit of the histogram

- knn.ani() gained the ... argument to pass additional arguments to create the empty "frame" for the animation

## BUG FIXES

- use packageDescription() instead of packageVersion() in saveHTML() and ani.stop() because there is a weird error reported when using packageVersion() (thanks, Alex Tek)

# CHANGES IN animation VERSION 2.0-1

## NEW FEATURES

- demo('Xmas_card') contributed by Yuan Huang

- demo('flowers') to show how to download images from the Internet and create an animation

- a new function pdftk() as a wrapper to call the Pdftk toolkit (mainly for compressing PDF graphics output)

- saveLatex(), saveSWF() and saveMovie() can compress the PDF graphics using Pdftk (if available) now; if ani.options('ani.type') is 'pdf' and the 'pdftk' option is set, these functions will try the compression first

- new functions ani.record() and ani.replay() to record and replay the animations; they can be used to capture the changes in the graphics made by low-level plotting commands (see ?ani.record for examples)

## SIGNIFICANT CHANGES

- the function tidy.source() was completely removed from this package; users should go to the formatR package (tidy.source() is there now)

## MINOR CHANGES

- the argument 'expr' in saveHTML(), saveLatex(), saveMovie() and saveSWF() will be evaluated by eval(), so we may pass a real R expression (see ?expression) to 'expr', e.g. saveHTML(expression(for (i in 1:10) plot(runif(30)))); but note this argument does not *have to* be a real R expression -- you can still use an arbitrary R code chunk, e.g. saveHTML(for (i in 1:10) plot(runif(30))) (thanks, Aquery)

# CHANGES IN animation VERSION 2.0-0

## NEW FEATURES

- a new demo 'Xmas2': Merry Christmas with snowflakes (see demo('Xmas2', 'animation'); thanks, Jing Jiao)

- a new function saveHTML() to insert animations into HTML pages (this was designed to replace the old ani.start() and ani.stop(); the output is much more appealing; the JavaScript is based on the SciAnimator library and jQuery)

- ani.options() gained a new option 'autoplay' to indicate whether to autoplay the animation in the HTML page created by saveHTML()

- in fact ani.options() was rewritten, but this should not have any influence on users; the usage is the same

- ani.options() gained a new option 'use.dev' to decide whether to use the graphics device provided in ani.options('ani.dev') when calling saveHTML(), saveLatex(), saveMovie() and saveSWF()

- ani.options() has a couple of hidden options ('convert', 'swftools', 'img.fmt') which can be useful too; see ?ani.options for details

- a new function ani.pause(): it is a wrapper to Sys.sleep(interval) but it will not pause when called in a non-interactive graphics device (usually the off-screen devices); this is the recommended way to specify the pause in the animation now -- all the functions in this package have been adjusted to use ani.pause()

- a new demo('pollen') to show the hidden 'structure' in a large data (requires the rgl package)

- a new demo('CLEvsLAL') to `replay' the NBA game between CLE and LAL on 2009 Christmas (with a new dataset 'CLELAL09')

- a new demo('fireworks') to set fireworks using R (thanks, Weicheng Zhu)

- saveLatex() can work with the rgl package to produce 3D animations in a PDF document now; see demo('rgl_animation')

- a new demo('rgl_animation') to demonstrate how to insert rgl 3D animations into a LaTeX document and compile to PDF

- a new demo('use_Cairo') to show how to use the Cairo device in this package to obtain high-quality output

- a new demo('Sweave_animation') to show how to insert animations into Sweave documents

- a new demo('game_of_life') to demonstrate the (amusing) Game of Life (thanks, Linlin Yan)

## SIGNIFICANT CHANGES

- the documentation of this package has been tremendously revised; hopefully it is more clear to read now

- several arguments in saveMovie(), im.convert(), saveSWF() and saveLatex() were removed, because they can be specified by ani.options(); this can simplify the usage of these functions

## MINOR CHANGES

- the argument 'para' in saveMovie() was removed; the argument 'ani.first' was also removed from all the save*() functions, because this can be written in 'expr' and there is no need to provide an additional argument

- the path of the output in im.convert() and gm.convert() will be quoted, because sometimes users might supply a path containing spaces (thanks, Phalkun Chheng)

- the option 'filename' in ani.options() was renamed to 'htmlfile' so that the meaning of this option is more clear; 'footer' was renamed to 'verbose' too

- ani.options() can accept any arguments now

- im.convert() and gm.convert() will no longer stop() when the convert utility cannot be found; instead, they only issue warnings; a hidden option ani.options('convert') can be used to specify the location of convert.exe in ImageMagick

- saveMovie(), saveHTML(), saveSWF() and saveLatex() will try to open the output if ani.options('autobrowse') is TRUE; and they will keep the current working directory untouched when evaluating 'expr' (i.e.  'expr' will be evaluated under getwd())

# CHANGES IN animation VERSION 1.1-5

## NEW FEATURES

- the package has a NAMESPACE now (so .First.lib was changed to .onLoad accordingly)

- im.convert() and gm.convert() can accept a vector of time intervals now (i.e. the time interval between image frames does not have to be a constant any more)

- added a dataset 'iatemp' (yearly average temperature of central Iowa)

- saveLatex() can be used in Sweave to dynamically insert PDF animations now -- it will automatically detect if it was called in Sweave and output the relevant LaTeX code to the LaTeX document

## MINOR CHANGES

- saveSWF() is using system() instead of shell() to call *2swf commands now

# CHANGES IN animation VERSION 1.1-4

## NEW FEATURES

- demo('Mandelbrot') shows the Mandelbrot set

## SIGNIFICANT CHANGES

- the package is now maintained on GitHub (https://github.com/yihui/animation) and using roxygen to document functions

- the functions highlight.def(), write.rss() and tidy.source() were defunct because they are irrelevant

- ani.news() was removed from the package; we can use news(package = 'animation') instead

## MINOR CHANGES

- the MASS package is imported instead of being attached; in fact only lda() in MASS is used in the animation package.

- fixed a buglet in saveMovie(): outdir does not actually work.

- im.convert() will try to open the output using the default application in the OS (e.g.  using command 'xdg-open', or 'open')

# CHANGES IN animation VERSION 1.1-3

## NEW FEATURES

- demo('jumpingHorse') shows a horse jumping on the chess board (contributed by Linlin Yan)

- A new function im.convert() which comes from saveMovie() but serves as a more general- purpose function; it can convert a series of files (not necessarily produced in R) to GIF/MPEG, and tries its best to find ImageMagick automatically (even you only have LyX installed) Thanks, Kelvin Lam.

## MINOR CHANGES

- saveMovie() gained a new argument 'fileext' to specify the file extension of the image frames (the old approach to get the file ext is not appropriate if we use other graphics devices, e.g. Cairo); meanwhile, saveMovie() now uses im.convert() to convert images to an animation file.

- saveMovie() now generate the image frames in a temp directory and output the animation to the working directory by default (thanks, Thomas Julou)

# CHANGES IN animation VERSION 1.1-2

## NEW FEATURES

- demo('hanoi') will demonstrate the Tower of Hanoi game (contributed by Linlin Yan)

- A new function sample.ratio() to demonstrate the advantage of ratio estimation in sampling survey. (thanks, Amber Watkins)

## MINOR CHANGES

- added a note for the function newton.method() that the argument 'FUN' needs to be defined without braces. (thanks, Peter Ehlers)

- fixed a bug in saveLatex(): the frame number should start with 0 instead of 1. (thanks, Taiyun)

# CHANGES IN animation VERSION 1.1-1

## NEW FEATURES

- saveMovie() gained two new options: 'clean' to determin whether to delete individual image frames after conversion; 'cmd.fun' to decide which function to be used to invoke the OS command (system or shell)

## MINOR CHANGES

- improved the way to find 'convert' for saveMovie() under Windows which is a long-lasting confusing problem for Windows users (thanks, Yishuo Deng)

- fixed a bug caused by the 'outdir' option in ani.options() when 'outdir' is a relative path which makes ani.stop() fail (thanks, Paul Murrell)

# CHANGES IN animation VERSION 1.1-0

## NEW FEATURES

- three demos to illustrate recursion added: see demo('recur.leaf'), demo('recur.snow') and demo('recur.tree'); thanks, Taiyun!

- demo('Xmas') added

## MINOR CHANGES

- fixed a bug for the option 'interval': in the non-interactive environment, ani.start() and ani.stop() should use ani.options()$interval to obtain the REAL 'interval' (other than 0)

- a new argument 'install.animate' for saveLatex() to install the LaTeX 'animate' if it does not exist

- a new argument 'width.cutoff' for tidy.source() to decide the width of deparsed code

- removed the code to install ImageMagick in saveMovie()

- changed shell() to system() in saveMovie() (thanks, R. Woodrow Setzer)

- updated the LaTeX package 'animate'

# CHANGES IN animation VERSION 1.0-10

## NEW FEATURES

- a new function MC.hitormiss() to demonstrate the 'hit or miss' Monte Carlo integration

- a new function MC.samplemean() to demonstrate the 'sample mean' Monte Carlo integration

- a new function price.ani() to demonstrate the stock prices changing within a time span (inspired by Shen Dai)

## MINOR CHANGES

- we can specify the 'convert' command in saveMovie(); e.g. 'imconvert' under some Windows platforms (Thanks, James Pustejovsky)

# CHANGES IN animation VERSION 1.0-9

## NEW FEATURES

- saveLatex() to embed the animation into a LaTeX document (with LaTeX package 'animate').

- a new option 'imgdir' added to ani.options() so that users can specify the name of the image directory

- a message will come up if the animation option 'nmax' is changed; this will help users know the actual number of images in the current session; this message will only show in interactive mode

- saveMovie() will try to install ImageMagick automatically if 'convert' not found

## MINOR CHANGES

- query ani.options('interval') will return 0 if the animation is run in a non-interactive mode; this will save much time typically in 'R CMD check' (Thanks to Prof Ripley)

- the option 'nmax' will be adjusted to the *actual* number of images in the directory ani.options('imgdir'), because sometimes the actual number of images does not equal to ani.options('nmax')

- shortened the descriptions in Rd files and several changes in documentations

- fixed several buglets in ani.stop()

- changed the 'while' loop to 'for' loop in brownian.motion(); this will shorten the code by two lines

- ani.options('ani.dev') can be the name of a function (character), e.g. "png"

# CHANGES IN animation VERSION 1.0-8

## NEW FEATURES

- ecol.death.sim() to simulate the death of two species in a field

## MINOR CHANGES

- fixed an error in the example of HuSpeech

# CHANGES IN animation VERSION 1.0-7

## NEW FEATURES

- moving.block() to plot a subset of data by blocks

- ani.options() gained a new argument 'loop' to control the iteration of the animation in an HTML page: TRUE to interate for infinite times, and FALSE not to interate (only play once). Thanks, Marcin Kozak!

## MINOR CHANGES

- fixed a bug for in ani.stop(): when ani.options(footer = FALSE), ani.stop() will report an error for non-existent object 'footer'; I should have used the value ani.options("footer") in the code. Thanks, Marcin Kozak!

# CHANGES IN animation VERSION 1.0-6

## NEW FEATURES

- new function sim.qqnorm() to demonstrate QQ plots for random numbers from Normal dist'n.

# CHANGES IN animation VERSION 1.0-5

## NEW FEATURES

- new demo 'Sierpinski' for Sierpinski triangle; see demo(Sierpinski).

- ani.options('footer') was changed to allow a custom string to be written in the HTML page as the footer information. (Thanks, Jorge Nieves)

## SIGNIFICANT CHANGES

- tidy.source2() was merged into tidy.source(), and tidy.source() now returns a list of character vectors and also gains an argument 'output' to decide whether to output the tidied code (to R console or a file).

# CHANGES IN animation VERSION 1.0-4

## NEW FEATURES

- tidy.source2() is a improved version of tidy.source(); it preserves some comments in R code.

## MINOR CHANGES

- fixed a bug for normalizePath() in saveMovie() and saveSWF().

# CHANGES IN animation VERSION 1.0-3

## NEW FEATURES

- The famous 'pollen' data added. See the example for finding the letters hidden in the data.

- A function quincunx() added to simulate the Galton box or Bean Machine. (Thanks for the inspiration from Roger Koenker)

- A function least.squares() added to show the ordinary least square process. (Thanks for the inspiration from Daniel Goldstein)

- A function BM.circle() added to show the Brownian Motion in a circle.

- A function g.brownian.motion() added to demonstrate the Brownian Motion using Google Visulization API.

## MINOR CHANGES

- The Shapiro-Wilk normality tests are performed to independent sample means instead of the original 'cumulative' data. (Thanks, Duncan Murdoch)

- Arguments 'col.contour' and 'col.arrow' added to grad.desc() to specify the colors for the contour lines and arrows freely; the graphical parameters are no longer specified within the function using par().

- The path of SWF Tools in saveSWF() will be quoted by shQuote() instead of dQuote().  (Thanks, zhoulvjun)

# CHANGES IN animation VERSION 1.0-2

## NEW FEATURES

- A new function Rosling.bubbles() added to show the bubbles animations like those used in Hans Rosling's talk.

## MINOR CHANGES

- The argument 'swftools' is double quoted so that the SWF utilities can be executed correctly when the path contains spaces. (Thanks, Geng Yang)

# CHANGES IN animation VERSION 1.0-1

## NEW FEATURES

- The package has provided a wrapper to produce Flash animations using SWF Tools: saveSWF()

- A demo 'wordrotation' added to show the basic method to make animations. More demos will be added in future releases.

## MINOR CHANGES

- A new argument 'para' added to saveMovie() so that the graphics parameters can be set for the device.

# CHANGES IN animation VERSION 1.0-0

## NEW FEATURES

- ani.options() added to control animation parameters.  It is much better than ani.control() in previous versions.

- ani.start() and ani.stop() are modified. The former function opens a graphics device and the latter one create an HTML page with a new interface.

- A wiki has been build to support this package: http://animation.yihui.org (AniWiki: Animations in Statistics)

## MINOR CHANGES

- Graphical parameters can be set in ... argument for: brownian.motion(), buffon.needle(), clt.ani(), conf.int(), cv.ani(), lln.ani(), mwar.ani(), newton.method(), sample.cluster(), sample.strat().

- P-values are computed in clt.ani() to check the normality (using 'shapiro.test()').

## SIGNIFICANT CHANGES

- The vignette is abandoned and stopped being updated; the wiki http://animation.yihui.org will be used instead.

- The way to create HTML animations is significantly changed for the sake of a better interface and more flexible control of animations. Read the help files for ani.control(), ani.start(), ani.stop().

- The function savePNG() removed. The new way to create animation frames allows ANY graphics devices.

- ani.control() and checkargs() removed. The new way to control animation parameters is more flexible.

# CHANGES IN animation VERSION 0.2-0

## NEW FEATURES

- cv.nfeaturesLDA() to illustrate the process of k-fold cross-validation to find the optimum number of features in LDA.

## MINOR CHANGES

- A rectangular grid has been added to the plot in kmeans.ani() so that the moving of centers can be better observed.

- The default value for the argument "source" is set to be "clipboard".

## SIGNIFICANT CHANGES

- The code for clt.ani() has been modified to make better illustrations for the CLT.

# CHANGES IN animation VERSION 0.1-8

## MINOR CHANGES

- the function flip.coin() is slightly modified (a new argument 'grid' added and the digits of probabilities in the graph can be controlled)

# CHANGES IN animation VERSION 0.1-7

## NEW FEATURES

- conf.int() to illustrate the concept of confidence intervals.

- lln.ani() to illustrate the Law of Large Numbers.

- grad.desc() for the Gradient Descent Algorithm.

- bisection.method() for the illustration of the Bisection method.

- newton.method() for the demonstration of Newton-Raphson method.

## MINOR CHANGES

- A special function checkargs() is added to validate animation arguments, which can promote the efficiency of animation functions.

- It doesn't need Sys.sleep() when creating HTML pages, so the code is modified to avoid suspending in this case.

# CHANGES IN animation VERSION 0.1-6

## NEW FEATURES

- saveMovie() to create single movies using ImageMagick.

## MINOR CHANGES

- The number of tosses is added to the plot in flip.coin().

# CHANGES IN animation VERSION 0.1-5

## NEW FEATURES

- cli.ani() to illustrate the Centrol Limit Theorem (CLT).

- vi.grid.illusion() to illustrate two kinds of grid illusions (Scintillating grid illusion and Hermann grid illusion).

## MINOR CHANGES

- Argument '...' added to tidy.source() for more flexible control of the output.

# CHANGES IN animation VERSION 0.1-4

## NEW FEATURES

- write.rss() for creating RSS feed files from a CSV file containing RSS items.

- vi.lilac.chaser() for the visual illusion 'Lilac Chaser'.

## MINOR CHANGES

- The capability of PNG device is checked before creating png image files in savePNG().

- A bug in the assigning of 'interval' in the environment 'ANIenv' was fixed.

# CHANGES IN animation VERSION 0.1-3

## NEW FEATURES

- A new function highlight.def() added to dynamically generate the R definition file for the software Highlight.

- mwar.ani() to show moving window auto-regression.

- sample.simple() for simple random sampling without replacement.

- sample.strat() for stratified sampling.

- sample.cluster for cluster sampling.

- sample.system() for systematic sampling.

## MINOR CHANGES

- The string 'file://' was added before the path of the HTML animation page to avoid the error caused by browseURL in ani.stop().

- File 'ANI.css' and 'FUN.js' were moved to the directory 'js' (because they are not 'data'). Both files were modified slightly.

- The parameter for time interval can be passed to the HTML animation page now.

- The vignette was supplemented and modified accordingly.

# CHANGES IN animation VERSION 0.1-2

## MINOR CHANGES

- An argument 'col' added to flip.coin() to control colors of each face of the coin.

- The 'pageview' data updated to Dec 3, 2007.

- Points that have already been classified in knn.ani() are marked out in later steps of classification for the rest points.

- The values of PI are silently returned in buffon.needle().

- The result for the test set can be returned in knn.ani().

## SIGNIFICANT CHANGES

- The computation for kfcv() is changed so that the sample sizes will be more 'uniformly' allocated.

- A new function ani.control() added so that the controlling parameters can be more uniform and the scalability of the animation functions will also be better. All the animation functions are chanaged accordingly.

# CHANGES IN animation VERSION 0.1-1

## NEW FEATURES

- A news-reading function ani.news() added so that changes will be conveniently known.

- boot.iid() is available for demonstration of bootstrapping i.i.d data.

## MINOR CHANGES

- The arguments ... is added in animation functions to control PNG image files.

- The sample data is permuted before cv.ani() so that every time we do cross-validation, the splitting of trainig set and test set will change (instead of splitting 1:n into k parts). The tick marks of x-axis will change accordingly.

# CHANGES IN animation VERSION 0.1-0

- ani.start() to start an HTML page for animations.

- ani.stop() to complete the HTML animation page.

- brownian.motion() to demonstrate Brownian motion in the 2D plane.

- buffon.needle() to simulate the process of Buffon's needle.

- cv.ani() to demonstrate k-fold cross validation.

- flip.coin() to simulate tossing 'coins'.

- kfcv() to compute sample sizes for k-fold cross-validation.

- kmeans.ani() to show the process of K-Means cluster analysis.

- knn.ani() to show k-Nearest Neighbor algorithm.

- savePNG() to save PNG image files which constitute the basic animation frames in the HTML page.

- tidy.source() is a trivial function to 'tidy up' R code using the internal R function parse().

- 'pageview' is a daily page view data of my personal website.

