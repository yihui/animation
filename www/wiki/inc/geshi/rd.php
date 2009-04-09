<?php
/*************************************************************************************
 * rd.php
 * -----
 * Author: Philippe Grosjean <phgrosjean@sciviews.org>
 * Copyright: (c) 2006 Philippe Grosjean
 * Release Version: 1.0.1
 *
 * Rd (R documentation) language file for GeSHi.
 *
 * CHANGES
 * -------
 * 2006/03/26 (1.0.1)
 * - R output is changed from #< to #!
 * 2006/02/24 (1.0.0)
 *  -  First Release (compiled for R 2.2.1)
 *
 * TODO
 * ----
 *  -
 ************************************************************************************/

$language_data = array (
	'LANG_NAME' => 'rd',
	'COMMENT_SINGLE' => array(1 => ' %', 2 => '#!',  3 => ' #', 4 => '#if', 5 => '#endif'),
	'COMMENT_MULTI' => array(),
	'CASE_KEYWORDS' => GESHI_CAPS_NO_CHANGE,
	'QUOTEMARKS' => array("'", '"', '`'),
	'ESCAPE_CHAR' => '\\',
	'KEYWORDS' => array(
	  1 => array(
          'ifndef', 'ifdef', 'endif'
          ),
      2 => array(
		  '\var', '\value', '\usepackage', '\usage', '\url', '\title',
		  '\testonly', '\tabular', '\tab', '\synopsis', '\strong', '\sQuote',
		  '\source', '\seealso', '\section', '\samp', '\S4method', '\references',
		  '\R', '\preformatted', '\pkg', '\option', '\note', '\name', '\method',
		  '\link', '\ldots', '\keyword', '\kbd', '\itemize', '\item',
		  '\inputencoding', '\format', '\file', '\examples', '\eqn', '\env',
		  '\enumerate', '\encoding', '\enc', '\emph', '\email', '\dQuote',
		  '\dots', '\dontshow', '\dontrun', '\docType', '\dfn', '\details',
		  '\description', '\describe', '\deqn', '\cr', '\concept', '\command',
		  '\code', '\cite', '\bold', '\author', '\arguments', '\alias',
		  '\acronym'
		  ),
	  3 => array(
	      '\zeta', '\Zeta', '\xi', '\Xi', '\vartheta', '\varsigma', '\varrho',
		  '\varpi', '\varphi', '\vareepsilon', '\upsilon', '\Upsilon', '\theta',
		  '\Theta', '\textasciicircum', '\textasciitilde', '\tau', '\Tau',
		  '\tan', '\sum', '\sin', '\sim', '\sigma', '\Sigma', '\rho', '\Rho',
		  '\psi', '\Psi', '\pi', '\Pi', '\phi', '\Phi', '\omega', '\Omega',
		  '\nu', '\Nu', '\nolimits', '\mu', '\Mu', '\min', '\mbox', '\max',
		  '\log', '\ln', '\limits', '\lim', '\lambda', '\Lambda', '\kappa',
		  '\Kappa', '\iota', '\Iota', '\int', '\gamma', '\Gamma', '\frac',
		  '\exp', '\eta', '\Eta', '\epsilon', '\Epsilon', '\dim', '\det',
		  '\delta', '\Delta', '\cot', '\cos', '\chi', '\Chi', '\beta', '\Beta',
		  '\arctan', '\arcsin', '\arccos', '\alpha', '\Alpha'
		  )
		),
	'SYMBOLS' => array(
		'{', '}', '$', '#', '_'
		),
	'CASE_SENSITIVE' => array(
		GESHI_COMMENTS => false,
		1 => true,
		2 => true,
		3 => true
		),
  'STYLES' => array(
    'KEYWORDS' => array(
      1 => 'color: #006600; font-weight: bold;',
      2 => 'color: #009900; font-weight: bold;',
      3 => 'color: #009900; font-weight: bold; font-style: italic;',
      ),
    'COMMENTS' => array(
      1 => 'color: #808080; font-style: italic;',
      2 => 'color: #111199;',
	  3 => 'color: #808080; font-style: italic;',
	  4 => 'color: #990000; font-weight: bold;',
	  5 => 'color: #990000; font-weight: bold;',
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
			)
		),
	'STRICT_MODE_APPLIES' => GESHI_NEVER,
	'SCRIPT_DELIMITERS' => array(
		),
	'HIGHLIGHT_STRICT_BLOCK' => array(
		)
);

?>