<?php
/*************************************************************************************
 * rns.php
 * -----
 * Author: Philippe Grosjean <phgrosjean@sciviews.org>
 * Copyright: (c) 2006 Philippe Grosjean
 * Release Version: 1.0.0
 *
 * R NAMESPACE language file for GeSHi.
 *
 * CHANGES
 * -------
 * 2006/02/24 (1.0.0)
 *  -  First Release (compiled for R 2.2.1)
 *
 * TODO
 * ----
 *  -
 ************************************************************************************/

$language_data = array (
	'LANG_NAME' => 'rns',
	'COMMENT_SINGLE' => array(1 => '#'),
	'COMMENT_MULTI' => array(),
	'CASE_KEYWORDS' => GESHI_CAPS_NO_CHANGE,
	'QUOTEMARKS' => array("'", '"'),
	'ESCAPE_CHAR' => '\\',
	'KEYWORDS' => array(
      2 => array(
		  'useDynLib', 'S3method', 'importMethodsFrom', 'importFrom',
		  'importClassesFrom', 'import', 'exportPattern', 'exportMethods',
		  'exportClasses', 'export'
		  )
		),
	'SYMBOLS' => array(
		'(', ')'
		),
	'CASE_SENSITIVE' => array(
		GESHI_COMMENTS => false,
		1 => true,
		2 => true,
		3 => true
		),
  'STYLES' => array(
    'KEYWORDS' => array(
      2 => 'color: #009900; font-weight: bold;'
      ),
    'COMMENTS' => array(
      1 => 'color: #808080; font-style: italic;',
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
		),
	'STRICT_MODE_APPLIES' => GESHI_NEVER,
	'SCRIPT_DELIMITERS' => array(
		),
	'HIGHLIGHT_STRICT_BLOCK' => array(
		)
);

?>