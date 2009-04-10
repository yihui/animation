<?php
/**
 * Initialize some defaults needed for DokuWiki
 */

  // start timing Dokuwiki execution
  function delta_time($start=0) {
    list($usec, $sec) = explode(" ", microtime());
    return ((float)$usec+(float)$sec)-((float)$start);
  }
  define('DOKU_START_TIME', delta_time());

  // if available load a preload config file
  $preload = fullpath(dirname(__FILE__)).'/preload.php';
  if (@file_exists($preload)) include($preload);

  // define the include path
  if(!defined('DOKU_INC')) define('DOKU_INC',fullpath(dirname(__FILE__).'/../').'/');

  // define config path (packagers may want to change this to /etc/dokuwiki/)
  if(!defined('DOKU_CONF')) define('DOKU_CONF',DOKU_INC.'conf/');

  // check for error reporting override or set error reporting to sane values
  if (!defined('DOKU_E_LEVEL') && @file_exists(DOKU_CONF.'report_e_all')) {
    define('DOKU_E_LEVEL', E_ALL);
  }
  if (!defined('DOKU_E_LEVEL')) {
    if(defined('E_DEPRECATED')){ // since php 5.3
      error_reporting(E_ALL & ~E_NOTICE & ~E_DEPRECATED);
    }else{
      error_reporting(E_ALL ^ E_NOTICE);
    }
  } else {
    error_reporting(DOKU_E_LEVEL);
  }

  // init memory caches
  global $cache_revinfo;  $cache_revinfo = array();
  global $cache_wikifn;   $cache_wikifn = array();
  global $cache_cleanid;  $cache_cleanid = array();
  global $cache_authname; $cache_authname = array();
  global $cache_metadata; $cache_metadata = array();

  //set the configuration cascade - but only if its not already been set in preload.php
  global $config_cascade;
  if (empty($config_cascade)) {
    $config_cascade = array(
      'main' => array(
        'default'   => array(DOKU_CONF.'dokuwiki.php'),
        'local'     => array(DOKU_CONF.'local.php'),
        'protected' => array(DOKU_CONF.'local.protected.php'),
      ),
      'acronyms'  => array(
        'default'   => array(DOKU_CONF.'acronyms.conf'),
        'local'     => array(DOKU_CONF.'acronyms.local.conf'),
      ),
      'entities'  => array(
        'default'   => array(DOKU_CONF.'entities.conf'),
        'local'     => array(DOKU_CONF.'entities.local.conf'),
      ),
      'interwiki' => array(
        'default'   => array(DOKU_CONF.'interwiki.conf'),
        'local'     => array(DOKU_CONF.'interwiki.local.conf'),
      ),
      'license' => array(
        'default'   => array(DOKU_CONF.'license.php'),
        'local'     => array(DOKU_CONF.'license.local.php'),
      ),
      'mediameta' => array(
        'default'   => array(DOKU_CONF.'mediameta.php'),
        'local'     => array(DOKU_CONF.'mediameta.local.php'),
      ),
      'mime'      => array(
        'default'   => array(DOKU_CONF.'mime.conf'),
        'local'     => array(DOKU_CONF.'mime.local.conf'),
      ),
      'scheme'    => array(
        'default'   => array(DOKU_CONF.'scheme.conf'),
        'local'     => array(DOKU_CONF.'scheme.local.conf'),
      ),
      'smileys'   => array(
        'default'   => array(DOKU_CONF.'smileys.conf'),
        'local'     => array(DOKU_CONF.'smileys.local.conf'),
      ),
      'wordblock' => array(
        'default'   => array(DOKU_CONF.'wordblock.conf'),
        'local'     => array(DOKU_CONF.'wordblock.local.conf'),
      ),
    );
  }

  //prepare config array()
  global $conf;
  $conf = array();

  // load the global config file(s)
  foreach (array('default','local','protected') as $config_group) {
    if (empty($config_cascade['main'][$config_group])) continue;
    foreach ($config_cascade['main'][$config_group] as $config_file) {
      if (@file_exists($config_file)) {
        include($config_file);
      }
    }
  }

  //prepare language array
  global $lang;
  $lang = array();

  //load the language files
  require_once(DOKU_INC.'inc/lang/en/lang.php');
  if ( $conf['lang'] && $conf['lang'] != 'en' ) {
    require_once(DOKU_INC.'inc/lang/'.$conf['lang'].'/lang.php');
  }

  //prepare license array()
  global $license;
  $license = array();

  // load the license file(s)
  foreach (array('default','local') as $config_group) {
    if (empty($config_cascade['license'][$config_group])) continue;
    foreach ($config_cascade['license'][$config_group] as $config_file) {
      if(@file_exists($config_file)){
        include($config_file);
      }
    }
  }

  // define baseURL
  if(!defined('DOKU_REL')) define('DOKU_REL',getBaseURL(false));
  if(!defined('DOKU_URL')) define('DOKU_URL',getBaseURL(true));
  if(!defined('DOKU_BASE')){
    if($conf['canonical']){
      define('DOKU_BASE',DOKU_URL);
    }else{
      define('DOKU_BASE',DOKU_REL);
    }
  }

  // define whitespace
  if(!defined('DOKU_LF')) define ('DOKU_LF',"\n");
  if(!defined('DOKU_TAB')) define ('DOKU_TAB',"\t");

  // define cookie and session id
  if (!defined('DOKU_COOKIE')) define('DOKU_COOKIE', 'DW'.md5(DOKU_REL));

  // define Plugin dir
  if(!defined('DOKU_PLUGIN'))  define('DOKU_PLUGIN',DOKU_INC.'lib/plugins/');

  // define main script
  if(!defined('DOKU_SCRIPT')) define('DOKU_SCRIPT','doku.php');

  // define Template baseURL
  if(!defined('DOKU_TPL')) define('DOKU_TPL',
                                  DOKU_BASE.'lib/tpl/'.$conf['template'].'/');

  // define real Template directory
  if(!defined('DOKU_TPLINC')) define('DOKU_TPLINC',
                                  DOKU_INC.'lib/tpl/'.$conf['template'].'/');

  // make session rewrites XHTML compliant
  @ini_set('arg_separator.output', '&amp;');

  // make sure global zlib does not interfere FS#1132
  @ini_set('zlib.output_compression', 'off');

  // increase PCRE backtrack limit
  @ini_set('pcre.backtrack_limit', '20971520');

  // enable gzip compression if supported
  $conf['gzip_output'] &= (strpos($_SERVER['HTTP_ACCEPT_ENCODING'],'gzip') !== false);
  if ($conf['gzip_output'] &&
      !defined('DOKU_DISABLE_GZIP_OUTPUT') &&
      function_exists('ob_gzhandler')) {
    ob_start('ob_gzhandler');
  }

  // init session
  if (!headers_sent() && !defined('NOSESSION')){
    session_name("DokuWiki");
    if (version_compare(PHP_VERSION, '5.2.0', '>')) {
      session_set_cookie_params(0,DOKU_REL,'',($conf['securecookie'] && is_ssl()),true);
    }else{
      session_set_cookie_params(0,DOKU_REL,'',($conf['securecookie'] && is_ssl()));
    }
    session_start();

    // load left over messages
    if(isset($_SESSION[DOKU_COOKIE]['msg'])){
      $MSG = $_SESSION[DOKU_COOKIE]['msg'];
      unset($_SESSION[DOKU_COOKIE]['msg']);
    }
  }

  // kill magic quotes
  if (get_magic_quotes_gpc() && !defined('MAGIC_QUOTES_STRIPPED')) {
    if (!empty($_GET))    remove_magic_quotes($_GET);
    if (!empty($_POST))   remove_magic_quotes($_POST);
    if (!empty($_COOKIE)) remove_magic_quotes($_COOKIE);
    if (!empty($_REQUEST)) remove_magic_quotes($_REQUEST);
    @ini_set('magic_quotes_gpc', 0);
    define('MAGIC_QUOTES_STRIPPED',1);
  }
  @set_magic_quotes_runtime(0);
  @ini_set('magic_quotes_sybase',0);

  // don't let cookies ever interfere with request vars
  $_REQUEST = array_merge($_GET,$_POST);

  // we don't want a purge URL to be digged
  if($_REQUEST['purge'] && $_SERVER['HTTP_REFERER']) unset($_REQUEST['purge']);

  // disable gzip if not available
  if($conf['compression'] == 'bz2' && !function_exists('bzopen')){
    $conf['compression'] = 'gz';
  }
  if($conf['compression'] == 'gz' && !function_exists('gzopen')){
    $conf['compression'] = 0;
  }

  // fix dateformat for upgraders
  if(strpos($conf['dformat'],'%') === false){
    $conf['dformat'] = '%Y/%m/%d %H:%M';
  }

  // precalculate file creation modes
  init_creationmodes();

  // make real paths and check them
  init_paths();
  init_files();

  // automatic upgrade to script versions of certain files
  scriptify(DOKU_CONF.'users.auth');
  scriptify(DOKU_CONF.'acl.auth');


/**
 * Checks paths from config file
 */
function init_paths(){
  global $conf;

  $paths = array('datadir'   => 'pages',
                 'olddir'    => 'attic',
                 'mediadir'  => 'media',
                 'metadir'   => 'meta',
                 'cachedir'  => 'cache',
                 'indexdir'  => 'index',
                 'lockdir'   => 'locks',
                 'tmpdir'    => 'tmp');

  foreach($paths as $c => $p){
    if(empty($conf[$c]))  $conf[$c] = $conf['savedir'].'/'.$p;
    $conf[$c]             = init_path($conf[$c]);
    if(empty($conf[$c]))  nice_die("The $c ('$p') does not exist, isn't accessible or writable.
                               You should check your config and permission settings.
                               Or maybe you want to <a href=\"install.php\">run the
                               installer</a>?");
  }

  // path to old changelog only needed for upgrading
  $conf['changelog_old'] = init_path((isset($conf['changelog']))?($conf['changelog']):($conf['savedir'].'/changes.log'));
  if ($conf['changelog_old']=='') { unset($conf['changelog_old']); }
  // hardcoded changelog because it is now a cache that lives in meta
  $conf['changelog'] = $conf['metadir'].'/_dokuwiki.changes';
  $conf['media_changelog'] = $conf['metadir'].'/_media.changes';
}

/**
 * Checks the existance of certain files and creates them if missing.
 */
function init_files(){
  global $conf;

  $files = array( $conf['indexdir'].'/page.idx');

  foreach($files as $file){
    if(!@file_exists($file)){
      $fh = @fopen($file,'a');
      if($fh){
        fclose($fh);
        if($conf['fperm']) chmod($file, $conf['fperm']);
      }else{
        nice_die("$file is not writable. Check your permissions settings!");
      }
    }
  }
}

/**
 * Returns absolute path
 *
 * This tries the given path first, then checks in DOKU_INC.
 * Check for accessability on directories as well.
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function init_path($path){
  // check existance
  $p = fullpath($path);
  if(!@file_exists($p)){
    $p = fullpath(DOKU_INC.$path);
    if(!@file_exists($p)){
      return '';
    }
  }

  // check writability
  if(!@is_writable($p)){
    return '';
  }

  // check accessability (execute bit) for directories
  if(@is_dir($p) && !@file_exists("$p/.")){
    return '';
  }

  return $p;
}

/**
 * Sets the internal config values fperm and dperm which, when set,
 * will be used to change the permission of a newly created dir or
 * file with chmod. Considers the influence of the system's umask
 * setting the values only if needed.
 */
function init_creationmodes(){
  global $conf;

  // Legacy support for old umask/dmask scheme
  unset($conf['dmask']);
  unset($conf['fmask']);
  unset($conf['umask']);
  unset($conf['fperm']);
  unset($conf['dperm']);

  // get system umask, fallback to 0 if none available
  $umask = @umask();
  if(!$umask) $umask = 0000;

  // check what is set automatically by the system on file creation
  // and set the fperm param if it's not what we want
  $auto_fmode = 0666 & ~$umask;
  if($auto_fmode != $conf['fmode']) $conf['fperm'] = $conf['fmode'];

  // check what is set automatically by the system on file creation
  // and set the dperm param if it's not what we want
  $auto_dmode = $conf['dmode'] & ~$umask;
  if($auto_dmode != $conf['dmode']) $conf['dperm'] = $conf['dmode'];
}

/**
 * remove magic quotes recursivly
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function remove_magic_quotes(&$array) {
  foreach (array_keys($array) as $key) {
      // handle magic quotes in keynames (breaks order)
      $sk = stripslashes($key);
      if($sk != $key){
          $array[$sk] = $array[$key];
          unset($array[$key]);
          $key = $sk;
      }

      // do recursion if needed
      if (is_array($array[$key])) {
          remove_magic_quotes($array[$key]);
      }else {
          $array[$key] = stripslashes($array[$key]);
      }
  }
}

/**
 * Returns the full absolute URL to the directory where
 * DokuWiki is installed in (includes a trailing slash)
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function getBaseURL($abs=null){
  global $conf;
  //if canonical url enabled always return absolute
  if(is_null($abs)) $abs = $conf['canonical'];

  if($conf['basedir']){
    $dir = $conf['basedir'];
  }elseif(substr($_SERVER['SCRIPT_NAME'],-4) == '.php'){
    $dir = dirname($_SERVER['SCRIPT_NAME']);
  }elseif(substr($_SERVER['PHP_SELF'],-4) == '.php'){
    $dir = dirname($_SERVER['PHP_SELF']);
  }elseif($_SERVER['DOCUMENT_ROOT'] && $_SERVER['SCRIPT_FILENAME']){
    $dir = preg_replace ('/^'.preg_quote($_SERVER['DOCUMENT_ROOT'],'/').'/','',
                         $_SERVER['SCRIPT_FILENAME']);
    $dir = dirname('/'.$dir);
  }else{
    $dir = '.'; //probably wrong
  }

  $dir = str_replace('\\','/',$dir);             // bugfix for weird WIN behaviour
  $dir = preg_replace('#//+#','/',"/$dir/");     // ensure leading and trailing slashes

  //handle script in lib/exe dir
  $dir = preg_replace('!lib/exe/$!','',$dir);

  //handle script in lib/plugins dir
  $dir = preg_replace('!lib/plugins/.*$!','',$dir);

  //finish here for relative URLs
  if(!$abs) return $dir;

  //use config option if available, trim any slash from end of baseurl to avoid multiple consecutive slashes in the path
  if($conf['baseurl']) return rtrim($conf['baseurl'],'/').$dir;

  //split hostheader into host and port
  list($host,$port) = explode(':',$_SERVER['HTTP_HOST']);
  if(!$port)  $port = $_SERVER['SERVER_PORT'];
  if(!$port)  $port = 80;

  if(!is_ssl()){
    $proto = 'http://';
    if ($port == '80') {
      $port='';
    }
  }else{
    $proto = 'https://';
    if ($port == '443') {
      $port='';
    }
  }

  if($port) $port = ':'.$port;

  return $proto.$host.$port.$dir;
}

/**
 * Check if accessed via HTTPS
 *
 * Apache leaves ,$_SERVER['HTTPS'] empty when not available, IIS sets it to 'off'.
 * 'false' and 'disabled' are just guessing
 *
 * @returns bool true when SSL is active
 */
function is_ssl(){
    if (preg_match('/^(|off|false|disabled)$/i',$_SERVER['HTTPS'])){
        return false;
    }else{
        return true;
    }
}

/**
 * Append a PHP extension to a given file and adds an exit call
 *
 * This is used to migrate some old configfiles. An added PHP extension
 * ensures the contents are not shown to webusers even if .htaccess files
 * do not work
 *
 * @author Jan Decaluwe <jan@jandecaluwe.com>
 */
function scriptify($file) {
  // checks
  if (!is_readable($file)) {
    return;
  }
  $fn = $file.'.php';
  if (@file_exists($fn)) {
    return;
  }
  $fh = fopen($fn, 'w');
  if (!$fh) {
    nice_die($fn.' is not writable. Check your permission settings!');
  }
  // write php exit hack first
  fwrite($fh, "# $fn\n");
  fwrite($fh, '# <?php exit()?>'."\n");
  fwrite($fh, "# Don't modify the lines above\n");
  fwrite($fh, "#\n");
  // copy existing lines
  $lines = file($file);
  foreach ($lines as $line){
    fwrite($fh, $line);
  }
  fclose($fh);
  //try to rename the old file
  io_rename($file,"$file.old");
}

/**
 * print a nice message even if no styles are loaded yet.
 */
function nice_die($msg){
  echo<<<EOT
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
  <html>
    <head><title>DokuWiki Setup Error</title></head>
    <body style="font-family: Arial, sans-serif">
      <div style="width:60%; margin: auto; background-color: #fcc;
                  border: 1px solid #faa; padding: 0.5em 1em;">
      <h1 style="font-size: 120%">DokuWiki Setup Error</h1>
      <p>$msg</p>
      </div>
    </body>
  </html>
EOT;
  exit;
}


/**
 * A realpath() replacement
 *
 * This function behaves similar to PHP's realpath() but does not resolve
 * symlinks or accesses upper directories
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @author <richpageau at yahoo dot co dot uk>
 * @link   http://de3.php.net/manual/en/function.realpath.php#75992
 */
function fullpath($path,$exists=false){
    static $run = 0; 
    $root  = '';
    $iswin = (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN' || @$GLOBALS['DOKU_UNITTEST_ASSUME_WINDOWS']);

    // find the (indestructable) root of the path - keeps windows stuff intact
    if($path{0} == '/'){
        $root = '/';
    }elseif($iswin){
        // match drive letter and UNC paths
        if(preg_match('!^([a-zA-z]:)(.*)!',$path,$match)){
            $root = $match[1].'/';
            $path = $match[2];
        }else if(preg_match('!^(\\\\\\\\[^\\\\/]+\\\\[^\\\\/]+[\\\\/])(.*)!',$path,$match)){
            $root = $match[1];
            $path = $match[2];
        }
    }
    $path = str_replace('\\','/',$path);

    // if the given path wasn't absolute already, prepend the script path and retry
    if(!$root){
        $base = dirname($_SERVER['SCRIPT_FILENAME']);
        $path = $base.'/'.$path;
        if($run == 0){ // avoid endless recursion when base isn't absolute for some reason
            $run++;
            return fullpath($path,$exists);
        }
    }
    $run = 0;

    // canonicalize
    $path=explode('/', $path);
    $newpath=array();
    foreach($path as $p) {
        if ($p === '' || $p === '.') continue;
           if ($p==='..') {
              array_pop($newpath);
              continue;
        }
        array_push($newpath, $p);
    }
    $finalpath = $root.implode('/', $newpath);

    // check for existance when needed (except when unit testing)
    if($exists && !defined('DOKU_UNITTEST') && !@file_exists($finalpath)) {
        return false;
    }
    return $finalpath;
}



//Setup VIM: ex: et ts=2 enc=utf-8 :
