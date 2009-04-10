<?php
/*************************************************************************************
 * r.php
 * -----
 * Author: Philippe Grosjean <phgrosjean@sciviews.org>
 * Copyright: (c) 2006 Philippe Grosjean
 * Release Version: 1.2.1
 *
 * R language file for GeSHi.
 *
 * CHANGES
 * -------
 * 2006/03/26 (1.2.1)
 * - Style for R output is changed from #< to #!
 * - Link for R functions is now http://wiki.r-project.org/rwiki/rhelp.php
 * 2006/02/11 (1.2.0)
 * - Correction of GeSHi bug for dots in keywords (in geshi.php)
 * - Avoid highlighting of keywords when not used as functions
 * - Separate highlighting of generic functions
 * - Separate highlighting of constants (TRUE/FALSE/NA/NULL,...)
 * - Special highlighting mode for transcript: recognize prompts (> / + )
 * -   and highlight output in blue when there is '#<' in front of it
 * - A couple of other fine tunings
 * 2006/02/08 (1.1.0)
 *  - Slight fine-tuning (regexpr and order of keywords)
 * 2005/11/19 (1.0.0)
 *  - First Release
 *
 * TODO (updated 2006/02/08)
 * -------------------------
 *  - Exhaustive list for functions/generic
 *  - Definitive links to R functions help
 ************************************************************************************/

$language_data = array (
  'LANG_NAME' => 'r',
  'COMMENT_SINGLE' => array(1 => '##', 2 => '#!', 3 => '#'),
  'COMMENT_MULTI' => array(),
  'CASE_KEYWORDS' => GESHI_CAPS_NO_CHANGE,
  'QUOTEMARKS' => array("'", '"', '`'),
  'ESCAPE_CHAR' => '\\',
  'KEYWORDS' => array(
    1 => array(
        'while', 'repeat', 'next', 'in', 'if', 'function', 'for', 'else', 'break'
      ),
    2 => array(
        '.valueClassTest', '.userHooksEnv', '.untracedFunction', '.tryHelp',
		'.TraceWithMethods', '.subset2', '.subset', '.signalSimpleWarning',
		'.ShortPrimitiveSkeletons', '.Script', '.saveRDS', '.saveImage',
		'.S3method', '.readRDS', '.primUntrace', '.primTrace', '.Primitive',
		'.Platform', '.path.package', '.packages', '.Options', '.onUnload',
		'.onLoad', '.onAttach', '.NotYetUsed', '.NotYetImplemented',
		'.noGenerics', '.MFclass', '.mergeExportMethods', '.Machine', '.Library',
		'.libPaths', '.leap.seconds', '.Last.value', '.Last.lib', '.Last',
		'.knownS3Generics', '.isMethodsDispatchOn', '.Internal', '.ImportFrom',
		'.Import', '.helpForCall', '.handleSimpleError', '.GlobalEnv',
		'.getXlevels', '.Fortran', '.First.sys', '.First.lib', '.First',
		'.find.package', '.External.graphics', '.External', '.Export',
		'.EmptyPrimitiveSkeletons', '.dynLibs', '.doTracePrint', '.Devices',
		'.Device', '.Deprecated', '.Defunct', '.checkMFClasses',
		'.Call.graphics', '.Call', '.C', '.BasicFunsList', '.BasicClasses',
		'.BaseNamespaceEnv', '.AutoloadEnv', '.Autoloaded', '.Alias',
		'zip.unpack', 'zip.file.extract', 'xyz.coords', 'xy.coords',
		'xpdrows.data.frame', 'write.table', 'write.socket', 'write.ftable',
		'write.dcf', 'win.version', 'win.print', 'win.metafile', 'win.graph',
		'which.min', 'which.max', 'weighted.residuals', 'weighted.mean',
		'variable.names', 'url.show', 'upper.tri', 'update.packageStatus',
		'update.packages', 'unix.time', 'type.convert', 'ts.union', 'ts.plot',
		'ts.intersect', 'trunc.POSIXt', 'trunc.Date', 'topo.colors',
		'terrain.colors', 'system.time', 'system.file', 'Sys.timezone',
		'Sys.time', 'sys.status', 'sys.source', 'Sys.sleep', 'Sys.setlocale',
		'sys.save.image', 'Sys.putenv', 'sys.parents', 'sys.parent',
		'sys.on.exit', 'sys.nframe', 'Sys.localeconv', 'sys.load.image',
		'Sys.info', 'Sys.getpid', 'Sys.getlocale', 'Sys.getenv', 'sys.function',
		'sys.frames', 'sys.frame', 'Sys.Date', 'sys.calls', 'sys.call',
		'symbol.For', 'symbol.C', 'storage.mode', 'stat.anova', 'split.screen',
		'spec.taper', 'spec.pgram', 'spec.ar', 'source.url', 'sort.list',
		'smooth.spline', 'slice.index', 'sink.number', 'shell.exec',
		'shapiro.test', 'select.list', 'seek.connection', 'scatter.smooth',
		'scan.url', 'save.image', 'remove.packages', 'reg.finalizer',
		'rect.hclust', 'read.table.url', 'read.table', 'read.socket', 'read.fwf',
		'read.ftable', 'read.delim2', 'read.delim', 'read.dcf', 'read.csv2',
		'read.csv', 'read.00Index', 'R.version.string', 'R.Version', 'R.version',
		'R.home', 'qr.X', 'qr.solve', 'qr.resid', 'qr.R', 'qr.qy', 'qr.qty',
		'qr.Q', 'qr.fitted', 'qr.coef', 'ps.options', 'prop.trend.test',
		'prop.test', 'prop.table', 'proc.time', 'PP.test', 'power.t.test',
		'power.prop.test', 'power.anova.test', 'pos.to.env', 'plot.xy',
		'plot.window', 'plot.new', 'path.expand', 'parse.dcf', 'parent.frame',
		'parent.env', 'panel.smooth', 'pairwise.wilcox.test', 'pairwise.table',
		'pairwise.t.test', 'pairwise.prop.test', 'package.skeleton',
		'package.description', 'package.dependencies', 'package.contents',
		'p.adjust.methods', 'p.adjust', 'order.dendrogram', 'oneway.test',
		'on.exit', 'old.packages', 'object.size', 'nls.control', 'new.env',
		'nclass.Sturges', 'nclass.scott', 'nclass.FD', 'native.enc', 'na.pass',
		'na.omit', 'na.fail', 'na.exclude', 'na.contiguous', 'na.action',
		'mood.test', 'month.name', 'month.abb', 'model.weights', 'model.tables',
		'model.response', 'model.offset', 'model.extract', 'memory.size',
		'memory.profile', 'memory.limit', 'mem.limits', 'mcnemar.test',
		'max.col', 'match.fun', 'match.call', 'match.arg', 'mat.or.vec',
		'margin.table', 'mantelhaen.test', 'make.unique',
		'make.tables.aovprojlist', 'make.tables.aovproj', 'make.socket',
		'make.search.html', 'make.packages.html', 'make.names', 'make.link',
		'lsf.str', 'ls.str', 'ls.print', 'ls.diag', 'lower.tri', 'loess.smooth',
		'loess.control', 'lm.wfit.null', 'lm.wfit', 'lm.influence',
		'lm.fit.null', 'lm.fit', 'list.files', 'link.html.help',
		'library.dynam.unload', 'library.dynam', 'layout.show', 'lag.plot',
		'La.svd', 'La.eigen', 'La.chol2inv', 'La.chol', 'ks.test', 'is.vector',
		'is.unsorted', 'is.tskernel', 'is.ts', 'is.table', 'is.symbol',
		'is.stepfun', 'is.single', 'is.recursive', 'is.real', 'is.R', 'is.qr',
		'is.primitive', 'is.pairlist', 'is.ordered', 'is.object', 'is.numeric',
		'is.null', 'is.nan', 'is.name', 'is.mts', 'is.matrix', 'is.logical',
		'is.loaded', 'is.list', 'is.language', 'is.integer', 'is.infinite',
		'is.function', 'is.finite', 'is.factor', 'is.expression',
		'is.environment', 'is.empty.model', 'is.element', 'is.double',
		'is.data.frame', 'is.complex', 'is.character', 'is.call', 'is.atomic',
		'is.array', 'inverse.rle', 'inverse.gaussian', 'interaction.plot',
		'installed.packages', 'install.packages', 'influence.measures',
		'index.search', 'help.start', 'help.search', 'heat.colors',
		'graphics.off', 'glm.fit.null', 'glm.fit', 'glm.control',
		'generic.skeleton', 'gc.time', 'flush.console', 'floor',
		'fixup.package.URLs', 'fixup.libraries.URLs', 'fixPre1.8', 'fisher.test',
		'filled.contour', 'file.symlink', 'file.show', 'file.rename',
		'file.remove', 'file.path', 'file.info', 'file.exists', 'file.create',
		'file.copy', 'file.choose', 'file.append', 'file.access', 'factor.scope',
		'expand.model.frame', 'expand.grid', 'eval.parent', 'erase.screen',
		'empty.dump', 'eff.aovlist', 'dyn.unload', 'dyn.load', 'dump.frames',
		'drop.terms', 'drop.scope', 'download.packages', 'download.file',
		'do.call', 'DLL.version', 'dir.create', 'df.residual', 'df.kernel',
		'dev.set', 'dev.print', 'dev.prev', 'dev.off', 'dev.next', 'dev.list',
		'dev.interactive', 'dev.cur', 'dev.copy2eps', 'dev.copy', 'dev.control',
		'delete.response', 'de.setup', 'de.restore', 'de.ncols', 'data.matrix',
		'data.entry', 'data.class', 'CRAN.packages', 'cov.wt', 'count.fields',
		'contrib.url', 'contr.treatment', 'contr.sum', 'contr.poly',
		'contr.helmert', 'complete.cases', 'codes.ordered', 'codes.factor',
		'codes', 'co.intervals', 'cmdscale', 'cm.colors', 'close.socket',
		'close.screen', 'close.connection', 'choose.files', 'chisq.test',
		'check.options', 'char.expand', 'case.names', 'capture.output',
		'c.POSIXlt', 'bw.ucv', 'bw.SJ', 'bw.nrd0', 'bw.nrd', 'bw.bcv',
		'bug.report', 'Box.test', 'binom.test', 'axis.POSIXct', 'axis.Date',
		'attr.all.equal', 'arima0.diag', 'arima.sim', 'ar.yw', 'ar.ols',
		'ar.mle', 'ar.burg', 'anovalist.lm', 'all.vars', 'all.names',
		'add.scope'
	    ),
      3 => array(
        'with', 'window', 'wilcox.test', 'weights', 'weekdays', 'vcov',
		'var.test', 'upgrade', 'update', 'unstack', 'unique', 'TukeyHSD',
		'tsSmooth', 'tsdiag', 'truncate', 'transform', 'toString', 'time',
		'text', 'terms', 'tail', 't.test', 't', 'summary', 'sum', 'subset',
		'str', 'start', 'stack', 'sqrt', 'split', 'solve', 'show', 'seq',
		'se.contrast', 'se.aovlist', 'se.aov', 'scale', 'rstudent', 'rstandard',
		'rowsum', 'row.names', 'round', 'rev', 'residuals', 'resid','rep',
		'relevel', 'rbind', 'range', 'quarters', 'quantile', 'quade.test',
		'qqnorm', 'proj', 'profile', 'print', 'princomp', 'predict', 'prcomp',
		'ppr', 'points', 'plot', 'persp', 'pacf', 'Ops', 'open', 'names',
		'months', 'model.matrix', 'model.frame', 'merge', 'mean', 'logLik',
		'lines', 'length', 'labels', 'lag', 'kruskal.test', 'kappa', 'julian',
		'is.na', 'image', 'hist', 'head', 'hatvalues', 'friedman.test',
		'frequency', 'formula', 'format', 'flush', 'fligner.test',
		'fitted.values', 'fitted', 'family', 'extractAIC', 'end', 'effects',
		'edit', 'duplicated', 'dummy.coef', 'drop1', 'dimnames', 'dim', 'diff',
		'dfbetas', 'dfbeta', 'deviance', 'determinant', 'deriv3', 'deriv',
		'density', 'deltat', 'cut', 'cor.test', 'cophenetic', 'cooks.distance',
		'contour', 'confint', 'conditionMessage', 'conditionCall', 'coerce',
		'coefficients', 'coef', 'cbind', 'c', 'by', 'boxplot', 'biplot',
		'bartlett.test', 'barplot', 'as.vector', 'as.ts', 'as.table',
		'as.symbol', 'as.stepfun', 'as.single', 'as.real', 'as.qr', 'as.POSIXlt',
		'as.POSIXct', 'as.pairlist', 'as.ordered', 'as.numeric', 'as.null',
		'as.name', 'as.matrix', 'as.logical', 'as.list', 'as.integer',
		'as.hclust', 'as.function', 'as.formula', 'as.factor', 'as.expression',
		'as.environment', 'as.double', 'as.dist', 'as.difftime', 'as.dendrogram',
		'as.Date', 'as.data.frame', 'as.complex', 'as.character', 'as.call',
		'as.array', 'any', 'ansari.test', 'anova', 'all.equal', 'all', 'AIC',
		'aggregate', 'add1', 'abs'
	  ),
	4 => array(
	    'zapsmall', 'yinch', 'xyinch', 'xtabs', 'xor', 'xinch', 'xfig', 'xemacs',
		'xedit', 'X11', 'x11', 'wsbrowser', 'writeLines', 'writeClipboard',
		'writeChar', 'writeBin', 'write', 'withRestarts', 'withCallingHandlers',
		'winMenuNames', 'winMenuItems', 'winMenuDelItem', 'winMenuDel',
		'winMenuAddItem', 'winMenuAdd', 'windows', 'winDialogString',
		'winDialog', 'WinAnsi', 'which', 'warnings', 'warning', 'vignette', 'vi',
		'Version', 'version', 'vector', 'varimax', 'var', 'validSlotNames',
		'validObject', 'UseMethod', 'url', 'unz', 'untrace', 'unsplit',
		'unserialize', 'unRematchDefinition', 'unname', 'unlockBinding',
		'unloadNamespace', 'unlist', 'unlink',  'unix', 'uniroot', 'union',
		'undebug', 'unclass', 'typeof',  'tsp', 'ts', 'trySilent', 'tryNew',
		'tryCatch', 'try', 'trunc', 'trigamma', 'tracingState', 'traceOn',
		'traceOff', 'traceback', 'trace', 'toupper', 'topicName', 'topenv',
		'tolower', 'toeplitz', 'title', 'textConnection', 'tetragamma',
		'testVirtual', 'termplot', 'tempfile', 'tempdir', 'taskCallbackManager',
		'tapply', 'tanh', 'tan', 'tabulate', 'table', 'system', 'symnum',
		'symbols', 'switch', 'sweep', 'SweaveSyntConv', 'SweaveSyntaxNoweb',
		'SweaveSyntaxLatex', 'Sweave', 'svd', 'supsmu', 'suppressWarnings',
		'superClassDepth', 'sunflowerplot', 'summaryRprof', 'substring',
        'substr', 'substituteFunctionArgs', 'substituteDirect', 'substitute',
		'sub', 'strwrap', 'strwidth', 'structure', 'StructTS', 'strsplit',
		'strptime', 'stripchart', 'strheight', 'strftime', 'stopifnot', 'stop',
		'stl', 'stepfun', 'step', 'stem', 'stdout', 'stdin', 'stderr', 'stars',
		'Stangle', 'standardGeneric', 'SSweibull', 'SSmicmen', 'SSlogis',
		'SSgompertz', 'SSfpl', 'SSfol', 'SSbiexp', 'SSasympOrig', 'SSasympOff',
		'SSasymp', 'sQuote', 'sprintf', 'splinefun', 'spline',
		'spectrum', 'source', 'sortedXyData', 'sort', 'socketSelect',
		'socketConnection', 'smoothEnds', 'smooth', 'slotNames', 'slot', 'sink',
		'sinh', 'single', 'sin', 'simpleWarning', 'simpleError',
		'simpleCondition', 'sigToEnv', 'signif', 'SignatureMethod', 'signature',
		'signalCondition', 'sign', 'shQuote', 'showMlist', 'showMethods',
		'showExtends', 'showDefault', 'showConnections', 'showClass', 'shell',
		'setwd', 'setValidity', 'setReplaceMethod', 'setPrimitiveMethods',
		'setPackageName', 'setOldClass', 'setNamespaceInfo', 'setNames',
		'setMethod', 'setIs', 'setHook', 'setGroupGeneric', 'setGeneric',
		'setequal', 'setdiff', 'setDataPart', 'setClassUnion', 'setClass',
		'setCConverterStatus', 'setAs', 'set.seed', 'sessionData', 'serialize',
		'sequence', 'selfStart', 'selectMethod', 'segments', 'seek',
		'searchpaths', 'search', 'sealClass', 'sd', 'screeplot', 'screen',
		'scan', 'savePlot', 'saveNamespaceImage', 'savehistory', 'save',
		'sapply', 'sample', 'rwilcox', 'rweibull', 'RweaveLatexSetup',
		'RweaveLatexOptions', 'RweaveLatex', 'runmed', 'runif', 'rug',
		'RtangleWritedoc', 'RtangleSetup', 'Rtangle', 'rt', 'rsignrank', 'Rprof',
		'rpois', 'rowSums', 'rownames', 'rowMeans', 'row', 'rnorm', 'RNGversion',
		'RNGkind', 'rnbinom', 'rmultinom', 'rm', 'rlogis', 'rlnorm', 'rle',
		'rhyper', 'rgeom', 'rgb2hsv', 'rgb', 'rgamma', 'rf', 'rexp', 'return',
		'restartFormals', 'restartDescription', 'restart', 'reshapeWide',
		'reshapeLong', 'reshape', 'resetGeneric', 'resetClass', 'requireMethods',
		'require', 'representation', 'replications', 'replicate', 'replayPlot',
		'replace', 'reorder', 'removeTaskCallback', 'removeMethodsObject',
		'removeMethods', 'removeMethod', 'removeGeneric', 'removeClass',
		'removeCConverter', 'remove', 'rematchDefinition', 'registerS3methods',
		'registerS3method', 'regexpr', 'reformulate', 'rect', 'recover',
		'recordPlot', 'reconcilePropertiesAndPrototype', 'Recall', 'real',
		'readLines', 'readline', 'readClipboard', 'readChar', 'readBin', 'Re',
		'rchisq', 'rcauchy', 'rbinom', 'rbeta', 'rank', 'rainbow', 'r2dtable',
		'qwilcox', 'qweibull', 'Quote', 'quote', 'qunif', 'quit', 'quasipoisson',
		'quasibinomial', 'quasi', 'qtukey', 'qt', 'qsignrank', 'qr', 'qqplot',
		'qqline', 'qpois', 'qnorm', 'qnbinom', 'qlogis', 'qlnorm', 'qhyper',
		'qgeom', 'qgamma', 'qf', 'qexp', 'qchisq', 'qcauchy', 'qbirthday',
		'qbinom', 'qbeta', 'q', 'pwilcox', 'pweibull', 'pushBackLength',
		'pushBack', 'punif', 'ptukey', 'pt', 'psignrank', 'psigamma', 'provide',
		'prototype', 'promptMethods', 'promptData', 'promptClass', 'prompt',
		'promax', 'profiler', 'prod', 'prmatrix', 'printNoClass', 'printCoefmat',
		'prettyNum', 'pretty', 'preplot', 'ppois', 'ppoints', 'power',
		'postscript', 'possibleExtends', 'polyroot', 'polym', 'polygon', 'poly',
		'poisson', 'pnorm', 'png', 'pnbinom', 'pmin', 'pmax', 'pmatch', 'plogis',
		'plnorm', 'plclust', 'Platform', 'pipe', 'piechart', 'pie', 'pictex',
		'pico', 'pi', 'phyper', 'pgeom', 'pgamma', 'pf', 'pexp', 'pentagamma',
		'pdf', 'pchisq', 'pcauchy', 'pbirthday', 'pbinom', 'pbeta', 'paste',
		'parseNamespaceFile', 'parse', 'par', 'palette', 'pairlist', 'page',
		'packageStatus', 'packageHasNamespace', 'packageEvent',
		'packageDescription', 'outer', 'ordered', 'order', 'options', 'optimize',
		'optimise', 'optim', 'oldClass', 'offset', 'objects', 'numericDeriv',
		'numeric', 'NROW', 'nrow', 'noquote', 'NLSstRtAsymptote',
		'NLSstLfAsymptote', 'NLSstClosestX', 'NLSstAsymptotic', 'nlsModel',
		'nls', 'nlm', 'nlevels', 'nextn', 'NextMethod', 'newestVersion',
		'newEmptyObject', 'newClassRepresentation', 'newBasic', 'new', 'NCOL',
		'ncol', 'nchar', 'nargs', 'naresid', 'naprint', 'napredict',
		'namespaceImportMethods', 'namespaceImportFrom',
		'namespaceImportClasses', 'namespaceImport', 'namespaceExport',
		'n2mfrow', 'mvfft', 'mtext', 'mosaicplot', 'monthplot', 'mode', 'Mod',
		'mlistMetaName', 'missingArg', 'missing', 'min', 'mget',
		'methodsPackageMetaName', 'MethodsListSelect', 'MethodsList', 'methods',
		'MethodAddCoerce', 'metaNameUndo', 'message', 'mergeMethods', 'menu',
		'medpolish', 'median', 'max', 'matrix', 'matpoints', 'matplot',
		'matlines', 'matchSignature', 'match', 'mapply', 'manova',
		'manglePackageName', 'makeStandardGeneric', 'makePrototypeFromClassDef',
		'makepredictcall', 'makeMethodsList', 'makeGeneric', 'makeExtends',
		'makeClassRepresentation', 'makeARIMA', 'makeActiveBinding',
		'mahalanobis', 'mad', 'MacRoman', 'Machine', 'machine', 'lsfit', 'ls',
		'lowess', 'loglin', 'logical', 'logb', 'log2', 'log1p', 'log10', 'log',
		'loess', 'lockEnvironment', 'lockBinding', 'locator', 'local', 'loadURL',
		'loadNamespace', 'loadMethod', 'loadings', 'loadingNamespaceInfo',
		'loadhistory', 'loadedNamespaces', 'load', 'lm', 'listFromMlist', 'list',
		'linearizeMlist', 'line', 'limitedLabels', 'license', 'licence',
		'library', 'lgamma', 'lfactorial', 'levels', 'LETTERS', 'letters',
		'legend', 'lcm', 'lchoose', 'lbeta', 'layout', 'lapply', 'languageEl',
		'ksmooth', 'kronecker', 'knots', 'kmeans', 'kernel', 'kernapply',
		'KalmanSmooth', 'KalmanRun', 'KalmanLike', 'KalmanForecast', 'jpeg',
		'jitter', 'isVirtualClass', 'isSeekable', 'isSealedMethod',
		'isSealedClass', 'isRestart', 'isoreg', 'isOpen', 'ISOLatin1',
		'ISOdatetime', 'ISOdate', 'isNamespace', 'isIncomplete', 'isGroup',
		'isGrammarSymbol', 'isGeneric', 'isClassUnion', 'isClassDef', 'isClass',
		'isBaseNamespace', 'is', 'IQR', 'invokeRestartInteractively',
		'invokeRestart', 'invisible', 'intersect', 'interactive', 'interaction',
		'integrate', 'integer', 'insertMethod', 'initialize', 'inherits',
		'influence', 'importIntoEnv', 'Im', 'ifelse', 'identify', 'identical',
		'I', 'httpclient', 'hsv', 'HoltWinters', 'history', 'Hershey', 'help',
		'heatmap', 'hclust', 'hat', 'hasTsp', 'hasMethod', 'hasArg', 'gzfile',
		'gzcon', 'gsub', 'grid', 'grey', 'grep', 'gray', 'globalenv', 'glm',
		'gl', 'getwd', 'getVirtual', 'getValidity', 'getTaskCallbackNames',
		'getSubclasses', 'getSlots', 'getS3method', 'getPrototype',
		'getProperties', 'getPackageName', 'getOption', 'getNumCConverters',
		'getNativeSymbolInfo', 'getNamespaceVersion', 'getNamespaceUsers',
		'getNamespaceName', 'getNamespaceInfo', 'getNamespaceImports',
		'getNamespaceExports', 'getNamespace', 'getMethodsMetaData',
		'getMethodsForDispatch', 'getMethods', 'getMethod', 'getInitial',
		'getHook', 'getGroup', 'getGenerics', 'getGeneric', 'getFunction',
		'getFromNamespace', 'getExtends', 'getExportedValue', 'geterrmessage',
		'getenv', 'getDataPart', 'getConnection', 'getClassPackage',
		'getClassName', 'getClasses', 'getClassDef', 'getClass',
		'getCConverterStatus', 'getCConverterDescriptions', 'getAnywhere',
		'getAllSuperClasses', 'getAllMethods', 'getAllConnections', 'getAccess',
		'get', 'gctorture', 'gcinfo', 'gc', 'gaussian', 'gammaCody', 'Gamma',
		'gamma', 'functionBody', 'ftable', 'fourfoldplot',
		'forwardsolve', 'formatDL', 'formatC', 'formals', 'formalArgs', 'force',
		'fixInNamespace', 'fix', 'fivenum', 'findUnique', 'findRestart',
		'findMethod', 'findInterval', 'findFunction', 'findClass', 'find',
		'finalDefaultMethod', 'Filters', 'filter', 'file', 'fifo', 'fft',
		'factorial', 'factor', 'factanal', 'extends', 'expression', 'expm1',
		'exp', 'existsMethod', 'existsFunction', 'exists', 'example', 'evalq',
		'eval', 'environmentIsLocked', 'environment', 'emptyMethodsList',
		'embed', 'emacs', 'elNamed', 'el', 'eigen', 'ecdf', 'dwilcox',
		'dweibull', 'dunif', 'dumpMethods', 'dumpMethod', 'dump', 'dt',
		'dsignrank', 'drop', 'dQuote', 'dput', 'dpois', 'double', 'dotchart',
		'doPrimitiveMethod', 'dnorm', 'dnbinom', 'dmultinom', 'dlogis', 'dlnorm',
		'dist', 'dirname', 'dir', 'digamma', 'difftime', 'diffinv', 'diag',
		'dhyper', 'dget', 'dgeom', 'dgamma', 'dffits', 'df', 'dexp',
		'dev2bitmap', 'detach', 'det', 'deparse','demo', 'delay',
		'defaultPrototype', 'defaultDumpName', 'decompose', 'debugger', 'debug',
		'de', 'dchisq', 'dcauchy', 'dbinom', 'dbeta', 'date', 'dataentry',
		'data.frame', 'data', 'frame', 'D', 'cutree', 'cycle',
		'curve', 'cumsum', 'cumprod', 'cummin', 'cummax', 'crossprod', 'cpgram',
		'covratio', 'cov2cor', 'cov', 'cosh', 'cos', 'cor', 'coplot', 'convolve',
		'contributors', 'contrasts', 'contourLines', 'constrOptim', 'Conj',
		'conformMethod', 'conflicts', 'computeRestarts', 'complex',
		'completeSubclasses', 'completeExtends', 'completeClassDefinition',
		'compareVersion', 'comment', 'commandArgs', 'colSums', 'colours',
		'colors', 'colnames', 'colMeans', 'col2rgb', 'col', 'cm',
		'closeAllConnections', 'close', 'clearNames', 'classMetaName', 'class',
		'citation', 'chull', 'choose', 'chol2inv', 'chol', 'checkSlotAssignment',
		'chartr', 'charmatch', 'character', 'ceiling', 'ccf', 'category', 'cat',
		'casefold', 'capabilities', 'cancor', 'callNextMethod', 'callGeneric',
		'call', 'cacheMethod', 'cacheMetaData', 'cacheGenericsMetaData', 'C',
		'bzfile', 'bxp', 'builtins', 'browseURL', 'browser', 'browseEnv',
		'bringToTop', 'bquote', 'box', 'body', 'bmp', 'bitmap', 'binomial',
		'bindingIsLocked', 'bindingIsActive', 'beta', 'besselY', 'besselK',
		'besselJ', 'besselI', 'basename', 'bandwidth.kernel',
		'balanceMethodsList', 'backsolve', 'axTicks', 'axis', 'ave',
		'autoloader', 'autoload', 'attributes', 'attr', 'attachNamespace',
		'attach', 'atanh', 'atan2', 'atan', 'assocplot', 'assignMethodsMetaData',
		'assignInNamespace', 'assignClassDef', 'assign', 'asOneSidedFormula',
		'asNamespace', 'asMethodDefinition', 'asinh', 'asin', 'as', 'arrows',
		'array', 'ARMAtoMA', 'ARMAacf', 'arima0', 'arima', 'args', 'Arg', 'ar',
		'apropos', 'approxfun', 'approx', 'apply', 'append', 'aperm', 'aov',
		'allNames', 'allGenerics',  'alist', 'alias', 'agrep', 'addTaskCallback',
		'addNextMethod', 'addmargins', 'acosh', 'acos', 'acf2AR', 'acf',
		'abline', 'abbreviate'
	  )
    ),
  'SYMBOLS' => array(
    '(', ')', '[', ']', '{', '}',
    ),
  'CASE_SENSITIVE' => array(
    GESHI_COMMENTS => false,
    1 => true,
    2 => true,
    3 => true,
    4 => true
    ),
  'STYLES' => array(
    'KEYWORDS' => array(
      1 => 'color: #006600; font-weight: bold;',
      2 => 'color: #009900; font-weight: bold;',
      3 => 'color: #009900; font-weight: bold; font-style: italic;',
      4 => 'color: #009900; font-weight: bold;'
      ),
    'COMMENTS' => array(
      1 => 'color: #808080; font-style: italic;',
      2 => 'color: #111199;',
	  3 => 'color: #808080; font-style: italic;',
      'MULTI' => 'color: #808080; font-style: italic;'
      ),
    'ESCAPE_CHAR' => array(
      0 => 'color: #605000; font-weight: bold;'
      ),
    'BRACKETS' => array(
      0 => 'color: #ff0000;'
      ),
    'STRINGS' => array(
      0 => 'color: #bb900c;'
      ),
    'NUMBERS' => array(
      0 => 'color: #000000; font-weight: bold;'
      ),
    'METHODS' => array(
      1 => 'color: #009900; font-weight: bold; font-style: italic;'
      ),
    'SYMBOLS' => array(
      0 => 'color: #ff0000;'
      ),
    'REGEXPS' => array(
      1 => 'color: #aa2222; font-weight: bold;',
      3 => 'color: #ff0000; font-weight: bold;',
	  4 => 'color: #000000;',
      5 => 'color: #000000;'
      ),
    'SCRIPT' => array(
      0 => 'color: #00bbdd;',
      )
    ),
  'URLS' => array(
      1 => 'http://wiki.r-project.org/rwiki/rhelp.php?id={FNAME}',
	  2 => 'http://wiki.r-project.org/rwiki/rhelp.php?id={FNAME}',
	  3 => 'http://wiki.r-project.org/rwiki/rhelp.php?id={FNAME}',
	  4 => 'http://wiki.r-project.org/rwiki/rhelp.php?id={FNAME}'
  	),
  'OOLANG' => false,
  'OBJECT_SPLITTERS' => array(
	),
  'REGEXPS' => array(
        1 => array(
			GESHI_SEARCH => '(TRUE|FALSE|NULL|NA|NaN|Inf)',
			GESHI_REPLACE => '\\1\\\\',
			GESHI_MODIFIERS => '',
			GESHI_BEFORE => '',
			GESHI_AFTER => ''
			),
        3 => array(
			GESHI_SEARCH => '(^.{1,2}|\n)( ?)(\\\\\+|&gt;)( )',
			GESHI_REPLACE => ' \\3',
			GESHI_MODIFIERS => '',
			GESHI_BEFORE => '\\1',
			GESHI_AFTER => '\\4'
			),
        4 => array(
			GESHI_SEARCH => '([a-zA-Z|\.]\w*)((\\\\\.)+\w*\s*[,=\&|\\\\][^\.\(|\\\\])',
			GESHI_REPLACE => '\\1',
			GESHI_MODIFIERS => '',
			GESHI_BEFORE => '',
			GESHI_AFTER => '\\2'
			),
        5 => array(
			GESHI_SEARCH => '([a-zA-Z|\.]\w*)(\s*[,=\&|\\\\][^\.\(|\\\\])',
			GESHI_REPLACE => '\\1',
			GESHI_MODIFIERS => '',
			GESHI_BEFORE => '',
			GESHI_AFTER => '\\2'
			)
    ),
	'STRICT_MODE_APPLIES' => GESHI_NEVER,
	'SCRIPT_DELIMITERS' => array(
		),
	'HIGHLIGHT_STRICT_BLOCK' => array(
		)
);

?>