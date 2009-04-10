<?php
/**
 * Common DokuWiki functions
 *
 * @license    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * @author     Andreas Gohr <andi@splitbrain.org>
 */

if(!defined('DOKU_INC')) die('meh.');
require_once(DOKU_INC.'inc/io.php');
require_once(DOKU_INC.'inc/changelog.php');
require_once(DOKU_INC.'inc/utf8.php');
require_once(DOKU_INC.'inc/mail.php');
require_once(DOKU_INC.'inc/parserutils.php');
require_once(DOKU_INC.'inc/infoutils.php');

/**
 * These constants are used with the recents function
 */
define('RECENTS_SKIP_DELETED',2);
define('RECENTS_SKIP_MINORS',4);
define('RECENTS_SKIP_SUBSPACES',8);
define('RECENTS_MEDIA_CHANGES',16);

/**
 * Wrapper around htmlspecialchars()
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @see    htmlspecialchars()
 */
function hsc($string){
  return htmlspecialchars($string, ENT_QUOTES, 'UTF-8');
}

/**
 * print a newline terminated string
 *
 * You can give an indention as optional parameter
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function ptln($string,$indent=0){
  echo str_repeat(' ', $indent)."$string\n";
}

/**
 * strips control characters (<32) from the given string
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function stripctl($string){
  return preg_replace('/[\x00-\x1F]+/s','',$string);
}

/**
 * Return a secret token to be used for CSRF attack prevention
 *
 * @author  Andreas Gohr <andi@splitbrain.org>
 * @link    http://en.wikipedia.org/wiki/Cross-site_request_forgery
 * @link    http://christ1an.blogspot.com/2007/04/preventing-csrf-efficiently.html
 * @return  string
 */
function getSecurityToken(){
  return md5(auth_cookiesalt().session_id());
}

/**
 * Check the secret CSRF token
 */
function checkSecurityToken($token=null){
  if(is_null($token)) $token = $_REQUEST['sectok'];
  if(getSecurityToken() != $token){
    msg('Security Token did not match. Possible CSRF attack.',-1);
    return false;
  }
  return true;
}

/**
 * Print a hidden form field with a secret CSRF token
 *
 * @author  Andreas Gohr <andi@splitbrain.org>
 */
function formSecurityToken($print=true){
  $ret = '<div class="no"><input type="hidden" name="sectok" value="'.getSecurityToken().'" /></div>'."\n";
  if($print){
    echo $ret;
  }else{
    return $ret;
  }
}

/**
 * Return info about the current document as associative
 * array.
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function pageinfo(){
  global $ID;
  global $REV;
  global $RANGE;
  global $USERINFO;
  global $conf;
  global $lang;

  // include ID & REV not redundant, as some parts of DokuWiki may temporarily change $ID, e.g. p_wiki_xhtml
  // FIXME ... perhaps it would be better to ensure the temporary changes weren't necessary
  $info['id'] = $ID;
  $info['rev'] = $REV;

  if($_SERVER['REMOTE_USER']){
    $info['userinfo']     = $USERINFO;
    $info['perm']         = auth_quickaclcheck($ID);
    $info['subscribed']   = is_subscribed($ID,$_SERVER['REMOTE_USER'],false);
    $info['subscribedns'] = is_subscribed($ID,$_SERVER['REMOTE_USER'],true);
    $info['client']       = $_SERVER['REMOTE_USER'];

    // set info about manager/admin status
    $info['isadmin']   = false;
    $info['ismanager'] = false;
    if($info['perm'] == AUTH_ADMIN){
      $info['isadmin']   = true;
      $info['ismanager'] = true;
    }elseif(auth_ismanager()){
      $info['ismanager'] = true;
    }

    // if some outside auth were used only REMOTE_USER is set
    if(!$info['userinfo']['name']){
      $info['userinfo']['name'] = $_SERVER['REMOTE_USER'];
    }

  }else{
    $info['perm']       = auth_aclcheck($ID,'',null);
    $info['subscribed'] = false;
    $info['client']     = clientIP(true);
  }

  $info['namespace'] = getNS($ID);
  $info['locked']    = checklock($ID);
  $info['filepath']  = fullpath(wikiFN($ID));
  $info['exists']    = @file_exists($info['filepath']);
  if($REV){
    //check if current revision was meant
    if($info['exists'] && (@filemtime($info['filepath'])==$REV)){
      $REV = '';
    }elseif($RANGE){
      //section editing does not work with old revisions!
      $REV   = '';
      $RANGE = '';
      msg($lang['nosecedit'],0);
    }else{
      //really use old revision
      $info['filepath'] = fullpath(wikiFN($ID,$REV));
      $info['exists']   = @file_exists($info['filepath']);
    }
  }
  $info['rev'] = $REV;
  if($info['exists']){
    $info['writable'] = (is_writable($info['filepath']) &&
                         ($info['perm'] >= AUTH_EDIT));
  }else{
    $info['writable'] = ($info['perm'] >= AUTH_CREATE);
  }
  $info['editable']  = ($info['writable'] && empty($info['lock']));
  $info['lastmod']   = @filemtime($info['filepath']);

  //load page meta data
  $info['meta'] = p_get_metadata($ID);

  //who's the editor
  if($REV){
    $revinfo = getRevisionInfo($ID, $REV, 1024);
  }else{
    if (is_array($info['meta']['last_change'])) {
       $revinfo = $info['meta']['last_change'];
    } else {
      $revinfo = getRevisionInfo($ID, $info['lastmod'], 1024);
      // cache most recent changelog line in metadata if missing and still valid
      if ($revinfo!==false) {
        $info['meta']['last_change'] = $revinfo;
        p_set_metadata($ID, array('last_change' => $revinfo));
      }
    }
  }
  //and check for an external edit
  if($revinfo!==false && $revinfo['date']!=$info['lastmod']){
    // cached changelog line no longer valid
    $revinfo = false;
    $info['meta']['last_change'] = $revinfo;
    p_set_metadata($ID, array('last_change' => $revinfo));
  }

  $info['ip']     = $revinfo['ip'];
  $info['user']   = $revinfo['user'];
  $info['sum']    = $revinfo['sum'];
  // See also $INFO['meta']['last_change'] which is the most recent log line for page $ID.
  // Use $INFO['meta']['last_change']['type']===DOKU_CHANGE_TYPE_MINOR_EDIT in place of $info['minor'].

  if($revinfo['user']){
    $info['editor'] = $revinfo['user'];
  }else{
    $info['editor'] = $revinfo['ip'];
  }

  // draft
  $draft = getCacheName($info['client'].$ID,'.draft');
  if(@file_exists($draft)){
    if(@filemtime($draft) < @filemtime(wikiFN($ID))){
      // remove stale draft
      @unlink($draft);
    }else{
      $info['draft'] = $draft;
    }
  }

  // mobile detection
  $info['ismobile'] = clientismobile();

  return $info;
}

/**
 * Build an string of URL parameters
 *
 * @author Andreas Gohr
 */
function buildURLparams($params, $sep='&amp;'){
  $url = '';
  $amp = false;
  foreach($params as $key => $val){
    if($amp) $url .= $sep;

    $url .= $key.'=';
    $url .= rawurlencode((string)$val);
    $amp = true;
  }
  return $url;
}

/**
 * Build an string of html tag attributes
 *
 * Skips keys starting with '_', values get HTML encoded
 *
 * @author Andreas Gohr
 */
function buildAttributes($params,$skipempty=false){
  $url = '';
  foreach($params as $key => $val){
    if($key{0} == '_') continue;
    if($val === '' && $skipempty) continue;

    $url .= $key.'="';
    $url .= htmlspecialchars ($val);
    $url .= '" ';
  }
  return $url;
}


/**
 * This builds the breadcrumb trail and returns it as array
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function breadcrumbs(){
  // we prepare the breadcrumbs early for quick session closing
  static $crumbs = null;
  if($crumbs != null) return $crumbs;

  global $ID;
  global $ACT;
  global $conf;
  $crumbs = $_SESSION[DOKU_COOKIE]['bc'];

  //first visit?
  if (!is_array($crumbs)){
    $crumbs = array();
  }
  //we only save on show and existing wiki documents
  $file = wikiFN($ID);
  if($ACT != 'show' || !@file_exists($file)){
    $_SESSION[DOKU_COOKIE]['bc'] = $crumbs;
    return $crumbs;
  }

  // page names
  $name = noNSorNS($ID);
  if (useHeading('navigation')) {
    // get page title
    $title = p_get_first_heading($ID,true);
    if ($title) {
      $name = $title;
    }
  }

  //remove ID from array
  if (isset($crumbs[$ID])) {
    unset($crumbs[$ID]);
  }

  //add to array
  $crumbs[$ID] = $name;
  //reduce size
  while(count($crumbs) > $conf['breadcrumbs']){
    array_shift($crumbs);
  }
  //save to session
  $_SESSION[DOKU_COOKIE]['bc'] = $crumbs;
  return $crumbs;
}

/**
 * Filter for page IDs
 *
 * This is run on a ID before it is outputted somewhere
 * currently used to replace the colon with something else
 * on Windows systems and to have proper URL encoding
 *
 * Urlencoding is ommitted when the second parameter is false
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function idfilter($id,$ue=true){
  global $conf;
  if ($conf['useslash'] && $conf['userewrite']){
    $id = strtr($id,':','/');
  }elseif (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN' &&
      $conf['userewrite']) {
    $id = strtr($id,':',';');
  }
  if($ue){
    $id = rawurlencode($id);
    $id = str_replace('%3A',':',$id); //keep as colon
    $id = str_replace('%2F','/',$id); //keep as slash
  }
  return $id;
}

/**
 * This builds a link to a wikipage
 *
 * It handles URL rewriting and adds additional parameter if
 * given in $more
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function wl($id='',$more='',$abs=false,$sep='&amp;'){
  global $conf;
  if(is_array($more)){
    $more = buildURLparams($more,$sep);
  }else{
    $more = str_replace(',',$sep,$more);
  }

  $id    = idfilter($id);
  if($abs){
    $xlink = DOKU_URL;
  }else{
    $xlink = DOKU_BASE;
  }

  if($conf['userewrite'] == 2){
    $xlink .= DOKU_SCRIPT.'/'.$id;
    if($more) $xlink .= '?'.$more;
  }elseif($conf['userewrite']){
    $xlink .= $id;
    if($more) $xlink .= '?'.$more;
  }elseif($id){
    $xlink .= DOKU_SCRIPT.'?id='.$id;
    if($more) $xlink .= $sep.$more;
  }else{
    $xlink .= DOKU_SCRIPT;
    if($more) $xlink .= '?'.$more;
  }

  return $xlink;
}

/**
 * This builds a link to an alternate page format
 *
 * Handles URL rewriting if enabled. Follows the style of wl().
 *
 * @author Ben Coburn <btcoburn@silicodon.net>
 */
function exportlink($id='',$format='raw',$more='',$abs=false,$sep='&amp;'){
  global $conf;
  if(is_array($more)){
    $more = buildURLparams($more,$sep);
  }else{
    $more = str_replace(',',$sep,$more);
  }

  $format = rawurlencode($format);
  $id = idfilter($id);
  if($abs){
    $xlink = DOKU_URL;
  }else{
    $xlink = DOKU_BASE;
  }

  if($conf['userewrite'] == 2){
    $xlink .= DOKU_SCRIPT.'/'.$id.'?do=export_'.$format;
    if($more) $xlink .= $sep.$more;
  }elseif($conf['userewrite'] == 1){
    $xlink .= '_export/'.$format.'/'.$id;
    if($more) $xlink .= '?'.$more;
  }else{
    $xlink .= DOKU_SCRIPT.'?do=export_'.$format.$sep.'id='.$id;
    if($more) $xlink .= $sep.$more;
  }

  return $xlink;
}

/**
 * Build a link to a media file
 *
 * Will return a link to the detail page if $direct is false
 *
 * The $more parameter should always be given as array, the function then
 * will strip default parameters to produce even cleaner URLs
 *
 * @param string  $id     - the media file id or URL
 * @param mixed   $more   - string or array with additional parameters
 * @param boolean $direct - link to detail page if false
 * @param string  $sep    - URL parameter separator
 * @param boolean $abs    - Create an absolute URL
 */
function ml($id='',$more='',$direct=true,$sep='&amp;',$abs=false){
  global $conf;
  if(is_array($more)){
    // strip defaults for shorter URLs
    if(isset($more['cache']) && $more['cache'] == 'cache') unset($more['cache']);
    if(!$more['w']) unset($more['w']);
    if(!$more['h']) unset($more['h']);
    if(isset($more['id']) && $direct) unset($more['id']);
    $more = buildURLparams($more,$sep);
  }else{
    $more = str_replace('cache=cache','',$more); //skip default
    $more = str_replace(',,',',',$more);
    $more = str_replace(',',$sep,$more);
  }

  if($abs){
    $xlink = DOKU_URL;
  }else{
    $xlink = DOKU_BASE;
  }

  // external URLs are always direct without rewriting
  if(preg_match('#^(https?|ftp)://#i',$id)){
    $xlink .= 'lib/exe/fetch.php';
    if($more){
      $xlink .= '?'.$more;
      $xlink .= $sep.'media='.rawurlencode($id);
    }else{
      $xlink .= '?media='.rawurlencode($id);
    }
    return $xlink;
  }

  $id = idfilter($id);

  // decide on scriptname
  if($direct){
    if($conf['userewrite'] == 1){
      $script = '_media';
    }else{
      $script = 'lib/exe/fetch.php';
    }
  }else{
    if($conf['userewrite'] == 1){
      $script = '_detail';
    }else{
      $script = 'lib/exe/detail.php';
    }
  }

  // build URL based on rewrite mode
   if($conf['userewrite']){
     $xlink .= $script.'/'.$id;
     if($more) $xlink .= '?'.$more;
   }else{
     if($more){
       $xlink .= $script.'?'.$more;
       $xlink .= $sep.'media='.$id;
     }else{
       $xlink .= $script.'?media='.$id;
     }
   }

  return $xlink;
}



/**
 * Just builds a link to a script
 *
 * @todo   maybe obsolete
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function script($script='doku.php'){
#  $link = getBaseURL();
#  $link .= $script;
#  return $link;
  return DOKU_BASE.DOKU_SCRIPT;
}

/**
 * Spamcheck against wordlist
 *
 * Checks the wikitext against a list of blocked expressions
 * returns true if the text contains any bad words
 *
 * Triggers COMMON_WORDBLOCK_BLOCKED
 *
 *  Action Plugins can use this event to inspect the blocked data
 *  and gain information about the user who was blocked.
 *
 *  Event data:
 *    data['matches']  - array of matches
 *    data['userinfo'] - information about the blocked user
 *      [ip]           - ip address
 *      [user]         - username (if logged in)
 *      [mail]         - mail address (if logged in)
 *      [name]         - real name (if logged in)
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * Michael Klier <chi@chimeric.de>
 */
function checkwordblock(){
  global $TEXT;
  global $conf;
  global $INFO;

  if(!$conf['usewordblock']) return false;

  // we prepare the text a tiny bit to prevent spammers circumventing URL checks
  $text = preg_replace('!(\b)(www\.[\w.:?\-;,]+?\.[\w.:?\-;,]+?[\w/\#~:.?+=&%@\!\-.:?\-;,]+?)([.:?\-;,]*[^\w/\#~:.?+=&%@\!\-.:?\-;,])!i','\1http://\2 \2\3',$TEXT);

  $wordblocks = getWordblocks();
  //how many lines to read at once (to work around some PCRE limits)
  if(version_compare(phpversion(),'4.3.0','<')){
    //old versions of PCRE define a maximum of parenthesises even if no
    //backreferences are used - the maximum is 99
    //this is very bad performancewise and may even be too high still
    $chunksize = 40;
  }else{
    //read file in chunks of 200 - this should work around the
    //MAX_PATTERN_SIZE in modern PCRE
    $chunksize = 200;
  }
  while($blocks = array_splice($wordblocks,0,$chunksize)){
    $re = array();
    #build regexp from blocks
    foreach($blocks as $block){
      $block = preg_replace('/#.*$/','',$block);
      $block = trim($block);
      if(empty($block)) continue;
      $re[]  = $block;
    }
    if(count($re) && preg_match('#('.join('|',$re).')#si',$text,$matches)) {
      //prepare event data
      $data['matches'] = $matches;
      $data['userinfo']['ip'] = $_SERVER['REMOTE_ADDR'];
      if($_SERVER['REMOTE_USER']) {
          $data['userinfo']['user'] = $_SERVER['REMOTE_USER'];
          $data['userinfo']['name'] = $INFO['userinfo']['name'];
          $data['userinfo']['mail'] = $INFO['userinfo']['mail'];
      }
      $callback = create_function('', 'return true;');
      return trigger_event('COMMON_WORDBLOCK_BLOCKED', $data, $callback, true); 
    }
  }
  return false;
}

/**
 * Return the IP of the client
 *
 * Honours X-Forwarded-For and X-Real-IP Proxy Headers
 *
 * It returns a comma separated list of IPs if the above mentioned
 * headers are set. If the single parameter is set, it tries to return
 * a routable public address, prefering the ones suplied in the X
 * headers
 *
 * @param  boolean $single If set only a single IP is returned
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function clientIP($single=false){
  $ip = array();
  $ip[] = $_SERVER['REMOTE_ADDR'];
  if(!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
    $ip = array_merge($ip,explode(',',$_SERVER['HTTP_X_FORWARDED_FOR']));
  if(!empty($_SERVER['HTTP_X_REAL_IP']))
    $ip = array_merge($ip,explode(',',$_SERVER['HTTP_X_REAL_IP']));

  // some IPv4/v6 regexps borrowed from Feyd
  // see: http://forums.devnetwork.net/viewtopic.php?f=38&t=53479
  $dec_octet = '(?:25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|[0-9])';
  $hex_digit = '[A-Fa-f0-9]';
  $h16 = "{$hex_digit}{1,4}";
  $IPv4Address = "$dec_octet\\.$dec_octet\\.$dec_octet\\.$dec_octet";
  $ls32 = "(?:$h16:$h16|$IPv4Address)";
  $IPv6Address =
    "(?:(?:{$IPv4Address})|(?:".
    "(?:$h16:){6}$ls32" .
    "|::(?:$h16:){5}$ls32" .
    "|(?:$h16)?::(?:$h16:){4}$ls32" .
    "|(?:(?:$h16:){0,1}$h16)?::(?:$h16:){3}$ls32" .
    "|(?:(?:$h16:){0,2}$h16)?::(?:$h16:){2}$ls32" .
    "|(?:(?:$h16:){0,3}$h16)?::(?:$h16:){1}$ls32" .
    "|(?:(?:$h16:){0,4}$h16)?::$ls32" .
    "|(?:(?:$h16:){0,5}$h16)?::$h16" .
    "|(?:(?:$h16:){0,6}$h16)?::" .
    ")(?:\\/(?:12[0-8]|1[0-1][0-9]|[1-9][0-9]|[0-9]))?)";

  // remove any non-IP stuff
  $cnt = count($ip);
  $match = array();
  for($i=0; $i<$cnt; $i++){
    if(preg_match("/^$IPv4Address$/",$ip[$i],$match) || preg_match("/^$IPv6Address$/",$ip[$i],$match)) {
      $ip[$i] = $match[0];
    } else {
      $ip[$i] = '';
    }
    if(empty($ip[$i])) unset($ip[$i]);
  }
  $ip = array_values(array_unique($ip));
  if(!$ip[0]) $ip[0] = '0.0.0.0'; // for some strange reason we don't have a IP

  if(!$single) return join(',',$ip);

  // decide which IP to use, trying to avoid local addresses
  $ip = array_reverse($ip);
  foreach($ip as $i){
    if(preg_match('/^(127\.|10\.|192\.168\.|172\.((1[6-9])|(2[0-9])|(3[0-1]))\.)/',$i)){
      continue;
    }else{
      return $i;
    }
  }
  // still here? just use the first (last) address
  return $ip[0];
}

/**
 * Check if the browser is on a mobile device
 *
 * Adapted from the example code at url below
 *
 * @link http://www.brainhandles.com/2007/10/15/detecting-mobile-browsers/#code
 */
function clientismobile(){

    if(isset($_SERVER['HTTP_X_WAP_PROFILE'])) return true;

    if(preg_match('/wap\.|\.wap/i',$_SERVER['HTTP_ACCEPT'])) return true;

    if(!isset($_SERVER['HTTP_USER_AGENT'])) return false;

    $uamatches = 'midp|j2me|avantg|docomo|novarra|palmos|palmsource|240x320|opwv|chtml|pda|windows ce|mmp\/|blackberry|mib\/|symbian|wireless|nokia|hand|mobi|phone|cdm|up\.b|audio|SIE\-|SEC\-|samsung|HTC|mot\-|mitsu|sagem|sony|alcatel|lg|erics|vx|NEC|philips|mmm|xx|panasonic|sharp|wap|sch|rover|pocket|benq|java|pt|pg|vox|amoi|bird|compal|kg|voda|sany|kdd|dbt|sendo|sgh|gradi|jb|\d\d\di|moto';

    if(preg_match("/$uamatches/i",$_SERVER['HTTP_USER_AGENT'])) return true;

    return false;
}


/**
 * Convert one or more comma separated IPs to hostnames
 *
 * @author Glen Harris <astfgl@iamnota.org>
 * @returns a comma separated list of hostnames
 */
function gethostsbyaddrs($ips){
  $hosts = array();
  $ips = explode(',',$ips);

  if(is_array($ips)) {
    foreach($ips as $ip){
      $hosts[] = gethostbyaddr(trim($ip));
    }
    return join(',',$hosts);
  } else {
    return gethostbyaddr(trim($ips));
  }
}

/**
 * Checks if a given page is currently locked.
 *
 * removes stale lockfiles
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function checklock($id){
  global $conf;
  $lock = wikiLockFN($id);

  //no lockfile
  if(!@file_exists($lock)) return false;

  //lockfile expired
  if((time() - filemtime($lock)) > $conf['locktime']){
    @unlink($lock);
    return false;
  }

  //my own lock
  $ip = io_readFile($lock);
  if( ($ip == clientIP()) || ($ip == $_SERVER['REMOTE_USER']) ){
    return false;
  }

  return $ip;
}

/**
 * Lock a page for editing
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function lock($id){
  $lock = wikiLockFN($id);
  if($_SERVER['REMOTE_USER']){
    io_saveFile($lock,$_SERVER['REMOTE_USER']);
  }else{
    io_saveFile($lock,clientIP());
  }
}

/**
 * Unlock a page if it was locked by the user
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @return bool true if a lock was removed
 */
function unlock($id){
  $lock = wikiLockFN($id);
  if(@file_exists($lock)){
    $ip = io_readFile($lock);
    if( ($ip == clientIP()) || ($ip == $_SERVER['REMOTE_USER']) ){
      @unlink($lock);
      return true;
    }
  }
  return false;
}

/**
 * convert line ending to unix format
 *
 * @see    formText() for 2crlf conversion
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function cleanText($text){
  $text = preg_replace("/(\015\012)|(\015)/","\012",$text);
  return $text;
}

/**
 * Prepares text for print in Webforms by encoding special chars.
 * It also converts line endings to Windows format which is
 * pseudo standard for webforms.
 *
 * @see    cleanText() for 2unix conversion
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function formText($text){
  $text = str_replace("\012","\015\012",$text);
  return htmlspecialchars($text);
}

/**
 * Returns the specified local text in raw format
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function rawLocale($id){
  return io_readFile(localeFN($id));
}

/**
 * Returns the raw WikiText
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function rawWiki($id,$rev=''){
  return io_readWikiPage(wikiFN($id, $rev), $id, $rev);
}

/**
 * Returns the pagetemplate contents for the ID's namespace
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function pageTemplate($data){
  $id = $data[0];
  global $conf;
  global $INFO;

  $path = dirname(wikiFN($id));

  if(@file_exists($path.'/_template.txt')){
    $tpl = io_readFile($path.'/_template.txt');
  }else{
    // search upper namespaces for templates
    $len = strlen(rtrim($conf['datadir'],'/'));
    while (strlen($path) >= $len){
      if(@file_exists($path.'/__template.txt')){
        $tpl = io_readFile($path.'/__template.txt');
        break;
      }
      $path = substr($path, 0, strrpos($path, '/'));
    }
  }
  if(!$tpl) return '';

  // replace placeholders
  $file = noNS($id);
  $page = strtr($file,'_',' ');

  $tpl = str_replace(array(
                        '@ID@',
                        '@NS@',
                        '@FILE@',
                        '@!FILE@',
                        '@!FILE!@',
                        '@PAGE@',
                        '@!PAGE@',
                        '@!!PAGE@',
                        '@!PAGE!@',
                        '@USER@',
                        '@NAME@',
                        '@MAIL@',
                        '@DATE@',
                     ),
                     array(
                        $id,
                        getNS($id),
                        $file,
                        utf8_ucfirst($file),
                        utf8_strtoupper($file),
                        $page,
                        utf8_ucfirst($page),
                        utf8_ucwords($page),
                        utf8_strtoupper($page),
                        $_SERVER['REMOTE_USER'],
                        $INFO['userinfo']['name'],
                        $INFO['userinfo']['mail'],
                        $conf['dformat'],
                     ), $tpl);

  // we need the callback to work around strftime's char limit
  $tpl = preg_replace_callback('/%./',create_function('$m','return strftime($m[0]);'),$tpl);

  return $tpl;
}


/**
 * Returns the raw Wiki Text in three slices.
 *
 * The range parameter needs to have the form "from-to"
 * and gives the range of the section in bytes - no
 * UTF-8 awareness is needed.
 * The returned order is prefix, section and suffix.
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function rawWikiSlices($range,$id,$rev=''){
  list($from,$to) = split('-',$range,2);
  $text = io_readWikiPage(wikiFN($id, $rev), $id, $rev);
  if(!$from) $from = 0;
  if(!$to)   $to   = strlen($text)+1;

  $slices[0] = substr($text,0,$from-1);
  $slices[1] = substr($text,$from-1,$to-$from);
  $slices[2] = substr($text,$to);

  return $slices;
}

/**
 * Joins wiki text slices
 *
 * function to join the text slices with correct lineendings again.
 * When the pretty parameter is set to true it adds additional empty
 * lines between sections if needed (used on saving).
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function con($pre,$text,$suf,$pretty=false){

  if($pretty){
    if($pre && substr($pre,-1) != "\n") $pre .= "\n";
    if($suf && substr($text,-1) != "\n") $text .= "\n";
  }

  // Avoid double newline above section when saving section edit
  //if($pre) $pre .= "\n";
  if($suf) $text .= "\n";
  return $pre.$text.$suf;
}

/**
 * Saves a wikitext by calling io_writeWikiPage.
 * Also directs changelog and attic updates.
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @author Ben Coburn <btcoburn@silicodon.net>
 */
function saveWikiText($id,$text,$summary,$minor=false){
  /* Note to developers:
     This code is subtle and delicate. Test the behavior of
     the attic and changelog with dokuwiki and external edits
     after any changes. External edits change the wiki page
     directly without using php or dokuwiki.
  */
  global $conf;
  global $lang;
  global $REV;
  // ignore if no changes were made
  if($text == rawWiki($id,'')){
    return;
  }

  $file = wikiFN($id);
  $old = @filemtime($file); // from page
  $wasRemoved = empty($text);
  $wasCreated = !@file_exists($file);
  $wasReverted = ($REV==true);
  $newRev = false;
  $oldRev = getRevisions($id, -1, 1, 1024); // from changelog
  $oldRev = (int)(empty($oldRev)?0:$oldRev[0]);
  if(!@file_exists(wikiFN($id, $old)) && @file_exists($file) && $old>=$oldRev) {
    // add old revision to the attic if missing
    saveOldRevision($id);
    // add a changelog entry if this edit came from outside dokuwiki
    if ($old>$oldRev) {
      addLogEntry($old, $id, DOKU_CHANGE_TYPE_EDIT, $lang['external_edit'], '', array('ExternalEdit'=>true));
      // remove soon to be stale instructions
      $cache = new cache_instructions($id, $file);
      $cache->removeCache();
    }
  }

  if ($wasRemoved){
    // Send "update" event with empty data, so plugins can react to page deletion
    $data = array(array($file, '', false), getNS($id), noNS($id), false);
    trigger_event('IO_WIKIPAGE_WRITE', $data);
    // pre-save deleted revision
    @touch($file);
    clearstatcache();
    $newRev = saveOldRevision($id);
    // remove empty file
    @unlink($file);
    // remove old meta info...
    $mfiles = metaFiles($id);
    $changelog = metaFN($id, '.changes');
    $metadata  = metaFN($id, '.meta');
    foreach ($mfiles as $mfile) {
      // but keep per-page changelog to preserve page history and keep meta data
      if (@file_exists($mfile) && $mfile!==$changelog && $mfile!==$metadata) { @unlink($mfile); }
    }
    // purge meta data
    p_purge_metadata($id);
    $del = true;
    // autoset summary on deletion
    if(empty($summary)) $summary = $lang['deleted'];
    // remove empty namespaces
    io_sweepNS($id, 'datadir');
    io_sweepNS($id, 'mediadir');
  }else{
    // save file (namespace dir is created in io_writeWikiPage)
    io_writeWikiPage($file, $text, $id);
    // pre-save the revision, to keep the attic in sync
    $newRev = saveOldRevision($id);
    $del = false;
  }

  // select changelog line type
  $extra = '';
  $type = DOKU_CHANGE_TYPE_EDIT;
  if ($wasReverted) {
    $type = DOKU_CHANGE_TYPE_REVERT;
    $extra = $REV;
  }
  else if ($wasCreated) { $type = DOKU_CHANGE_TYPE_CREATE; }
  else if ($wasRemoved) { $type = DOKU_CHANGE_TYPE_DELETE; }
  else if ($minor && $conf['useacl'] && $_SERVER['REMOTE_USER']) { $type = DOKU_CHANGE_TYPE_MINOR_EDIT; } //minor edits only for logged in users

  addLogEntry($newRev, $id, $type, $summary, $extra);
  // send notify mails
  notify($id,'admin',$old,$summary,$minor);
  notify($id,'subscribers',$old,$summary,$minor);

  // update the purgefile (timestamp of the last time anything within the wiki was changed)
  io_saveFile($conf['cachedir'].'/purgefile',time());

  // if useheading is enabled, purge the cache of all linking pages
  if(useHeading('content')){
    require_once(DOKU_INC.'inc/fulltext.php');
    $pages = ft_backlinks($id);
    foreach ($pages as $page) {
      $cache = new cache_renderer($page, wikiFN($page), 'xhtml');
      $cache->removeCache();
    }
  }
}

/**
 * moves the current version to the attic and returns its
 * revision date
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function saveOldRevision($id){
  global $conf;
  $oldf = wikiFN($id);
  if(!@file_exists($oldf)) return '';
  $date = filemtime($oldf);
  $newf = wikiFN($id,$date);
  io_writeWikiPage($newf, rawWiki($id), $id, $date);
  return $date;
}

/**
 * Sends a notify mail on page change
 *
 * @param  string  $id       The changed page
 * @param  string  $who      Who to notify (admin|subscribers)
 * @param  int     $rev      Old page revision
 * @param  string  $summary  What changed
 * @param  boolean $minor    Is this a minor edit?
 * @param  array   $replace  Additional string substitutions, @KEY@ to be replaced by value
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function notify($id,$who,$rev='',$summary='',$minor=false,$replace=array()){
  global $lang;
  global $conf;
  global $INFO;

  // decide if there is something to do
  if($who == 'admin'){
    if(empty($conf['notify'])) return; //notify enabled?
    $text = rawLocale('mailtext');
    $to   = $conf['notify'];
    $bcc  = '';
  }elseif($who == 'subscribers'){
    if(!$conf['subscribers']) return; //subscribers enabled?
    if($conf['useacl'] && $_SERVER['REMOTE_USER'] && $minor) return; //skip minors
    $bcc  = subscriber_addresslist($id,false);
    if(empty($bcc)) return;
    $to   = '';
    $text = rawLocale('subscribermail');
  }elseif($who == 'register'){
    if(empty($conf['registernotify'])) return;
    $text = rawLocale('registermail');
    $to   = $conf['registernotify'];
    $bcc  = '';
  }else{
    return; //just to be safe
  }

  $ip   = clientIP();
  $text = str_replace('@DATE@',strftime($conf['dformat']),$text);
  $text = str_replace('@BROWSER@',$_SERVER['HTTP_USER_AGENT'],$text);
  $text = str_replace('@IPADDRESS@',$ip,$text);
  $text = str_replace('@HOSTNAME@',gethostsbyaddrs($ip),$text);
  $text = str_replace('@NEWPAGE@',wl($id,'',true,'&'),$text);
  $text = str_replace('@PAGE@',$id,$text);
  $text = str_replace('@TITLE@',$conf['title'],$text);
  $text = str_replace('@DOKUWIKIURL@',DOKU_URL,$text);
  $text = str_replace('@SUMMARY@',$summary,$text);
  $text = str_replace('@USER@',$_SERVER['REMOTE_USER'],$text);

  foreach ($replace as $key => $substitution) {
    $text = str_replace('@'.strtoupper($key).'@',$substitution, $text);
  }

  if($who == 'register'){
    $subject = $lang['mail_new_user'].' '.$summary;
  }elseif($rev){
    $subject = $lang['mail_changed'].' '.$id;
    $text = str_replace('@OLDPAGE@',wl($id,"rev=$rev",true,'&'),$text);
    require_once(DOKU_INC.'inc/DifferenceEngine.php');
    $df  = new Diff(split("\n",rawWiki($id,$rev)),
                    split("\n",rawWiki($id)));
    $dformat = new UnifiedDiffFormatter();
    $diff    = $dformat->format($df);
  }else{
    $subject=$lang['mail_newpage'].' '.$id;
    $text = str_replace('@OLDPAGE@','none',$text);
    $diff = rawWiki($id);
  }
  $text = str_replace('@DIFF@',$diff,$text);
  $subject = '['.$conf['title'].'] '.$subject;

  $from = $conf['mailfrom'];
  $from = str_replace('@USER@',$_SERVER['REMOTE_USER'],$from);
  $from = str_replace('@NAME@',$INFO['userinfo']['name'],$from);
  $from = str_replace('@MAIL@',$INFO['userinfo']['mail'],$from);

  mail_send($to,$subject,$text,$from,'',$bcc);
}

/**
 * extracts the query from a search engine referrer
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @author Todd Augsburger <todd@rollerorgans.com>
 */
function getGoogleQuery(){
  $url = parse_url($_SERVER['HTTP_REFERER']);
  if(!$url) return '';

  $query = array();
  parse_str($url['query'],$query);
  if(isset($query['q']))
    $q = $query['q'];        // google, live/msn, aol, ask, altavista, alltheweb, gigablast
  elseif(isset($query['p']))
    $q = $query['p'];        // yahoo
  elseif(isset($query['query']))
    $q = $query['query'];    // lycos, netscape, clusty, hotbot
  elseif(preg_match("#a9\.com#i",$url['host'])) // a9
    $q = urldecode(ltrim($url['path'],'/'));

  if(!$q) return '';
  $q = preg_split('/[\s\'"\\\\`()\]\[?:!\.{};,#+*<>\\/]+/',$q,-1,PREG_SPLIT_NO_EMPTY);
  return $q;
}

/**
 * Try to set correct locale
 *
 * @deprecated No longer used
 * @author     Andreas Gohr <andi@splitbrain.org>
 */
function setCorrectLocale(){
  global $conf;
  global $lang;

  $enc = strtoupper($lang['encoding']);
  foreach ($lang['locales'] as $loc){
    //try locale
    if(@setlocale(LC_ALL,$loc)) return;
    //try loceale with encoding
    if(@setlocale(LC_ALL,"$loc.$enc")) return;
  }
  //still here? try to set from environment
  @setlocale(LC_ALL,"");
}

/**
 * Return the human readable size of a file
 *
 * @param       int    $size   A file size
 * @param       int    $dec    A number of decimal places
 * @author      Martin Benjamin <b.martin@cybernet.ch>
 * @author      Aidan Lister <aidan@php.net>
 * @version     1.0.0
 */
function filesize_h($size, $dec = 1){
  $sizes = array('B', 'KB', 'MB', 'GB');
  $count = count($sizes);
  $i = 0;

  while ($size >= 1024 && ($i < $count - 1)) {
    $size /= 1024;
    $i++;
  }

  return round($size, $dec) . ' ' . $sizes[$i];
}

/**
 * return an obfuscated email address in line with $conf['mailguard'] setting
 *
 * @author Harry Fuecks <hfuecks@gmail.com>
 * @author Christopher Smith <chris@jalakai.co.uk>
 */
function obfuscate($email) {
  global $conf;

  switch ($conf['mailguard']) {
    case 'visible' :
      $obfuscate = array('@' => ' [at] ', '.' => ' [dot] ', '-' => ' [dash] ');
      return strtr($email, $obfuscate);

    case 'hex' :
      $encode = '';
      for ($x=0; $x < strlen($email); $x++) $encode .= '&#x' . bin2hex($email{$x}).';';
      return $encode;

    case 'none' :
    default :
      return $email;
  }
}

/**
 * Let us know if a user is tracking a page or a namespace
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function is_subscribed($id,$uid,$ns=false){
  if(!$ns) {
    $file=metaFN($id,'.mlist');
  } else {
    if(!getNS($id)) {
      $file = metaFN(getNS($id),'.mlist');
    } else {
      $file = metaFN(getNS($id),'/.mlist');
    }
  }
  if (@file_exists($file)) {
    $mlist = file($file);
    $pos = array_search($uid."\n",$mlist);
    return is_int($pos);
  }

  return false;
}

/**
 * Return a string with the email addresses of all the
 * users subscribed to a page
 *
 * @author Steven Danz <steven-danz@kc.rr.com>
 */
function subscriber_addresslist($id,$self=true){
  global $conf;
  global $auth;

  if (!$conf['subscribers']) return '';

  $users = array();
  $emails = array();

  // load the page mlist file content
  $mlist = array();
  $file=metaFN($id,'.mlist');
  if (@file_exists($file)) {
    $mlist = file($file);
    foreach ($mlist as $who) {
      $who = rtrim($who);
      if(!$self && $who == $_SERVER['REMOTE_USER']) continue;
      $users[$who] = true;
    }
  }

  // load also the namespace mlist file content
  $ns = getNS($id);
  while ($ns) {
    $nsfile = metaFN($ns,'/.mlist');
    if (@file_exists($nsfile)) {
      $mlist = file($nsfile);
      foreach ($mlist as $who) {
        $who = rtrim($who);
        if(!$self && $who == $_SERVER['REMOTE_USER']) continue;
        $users[$who] = true;
      }
    }
    $ns = getNS($ns);
  }
  // root namespace
  $nsfile = metaFN('','.mlist');
  if (@file_exists($nsfile)) {
    $mlist = file($nsfile);
    foreach ($mlist as $who) {
      $who = rtrim($who);
      if(!$self && $who == $_SERVER['REMOTE_USER']) continue;
      $users[$who] = true;
    }
  }
  if(!empty($users)) {
    foreach (array_keys($users) as $who) {
      $info = $auth->getUserData($who);
      if($info === false) continue;
      $level = auth_aclcheck($id,$who,$info['grps']);
      if ($level >= AUTH_READ) {
        if (strcasecmp($info['mail'],$conf['notify']) != 0) {
          $emails[] = $info['mail'];
        }
      }
    }
  }

  return implode(',',$emails);
}

/**
 * Removes quoting backslashes
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function unslash($string,$char="'"){
  return str_replace('\\'.$char,$char,$string);
}

/**
 * Convert php.ini shorthands to byte
 *
 * @author <gilthans dot NO dot SPAM at gmail dot com>
 * @link   http://de3.php.net/manual/en/ini.core.php#79564
 */
function php_to_byte($v){
    $l = substr($v, -1);
    $ret = substr($v, 0, -1);
    switch(strtoupper($l)){
        case 'P':
            $ret *= 1024;
        case 'T':
            $ret *= 1024;
        case 'G':
            $ret *= 1024;
        case 'M':
            $ret *= 1024;
        case 'K':
            $ret *= 1024;
        break;
    }
    return $ret;
}

/**
 * Wrapper around preg_quote adding the default delimiter
 */
function preg_quote_cb($string){
    return preg_quote($string,'/');
}

/**
 * Shorten a given string by removing data from the middle
 *
 * You can give the string in two parts, teh first part $keep
 * will never be shortened. The second part $short will be cut
 * in the middle to shorten but only if at least $min chars are
 * left to display it. Otherwise it will be left off.
 *
 * @param string $keep   the part to keep
 * @param string $short  the part to shorten
 * @param int    $max    maximum chars you want for the whole string
 * @param int    $min    minimum number of chars to have left for middle shortening
 * @param string $char   the shortening character to use
 */
function shorten($keep,$short,$max,$min=9,$char='⌇'){
    $max = $max - utf8_strlen($keep);
   if($max < $min) return $keep;
    $len = utf8_strlen($short);
    if($len <= $max) return $keep.$short;
    $half = floor($max/2);
    return $keep.utf8_substr($short,0,$half-1).$char.utf8_substr($short,$len-$half);
}

/**
 * Return the users realname or e-mail address for use
 * in page footer and recent changes pages
 *
 * @author Andy Webber <dokuwiki AT andywebber DOT com>
 */
function editorinfo($username){
    global $conf;
    global $auth;

    switch($conf['showuseras']){
      case 'username':
      case 'email':
      case 'email_link':
        $info = $auth->getUserData($username);
        break;
      default:
        return hsc($username);
    }

    if(isset($info) && $info) {
        switch($conf['showuseras']){
          case 'username':
            return hsc($info['name']);
          case 'email':
            return obfuscate($info['mail']);
          case 'email_link':
            $mail=obfuscate($info['mail']);
            return '<a href="mailto:'.$mail.'">'.$mail.'</a>';
          default:
            return hsc($username);
        }
    } else {
        return hsc($username);
    }
}

/**
 * Returns the path to a image file for the currently chosen license.
 * When no image exists, returns an empty string
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @param  string $type - type of image 'badge' or 'button'
 */
function license_img($type){
    global $license;
    global $conf;
    if(!$conf['license']) return '';
    if(!is_array($license[$conf['license']])) return '';
    $lic = $license[$conf['license']];
    $try = array();
    $try[] = 'lib/images/license/'.$type.'/'.$conf['license'].'.png';
    $try[] = 'lib/images/license/'.$type.'/'.$conf['license'].'.gif';
    if(substr($conf['license'],0,3) == 'cc-'){
        $try[] = 'lib/images/license/'.$type.'/cc.png';
    }
    foreach($try as $src){
        if(@file_exists(DOKU_INC.$src)) return $src;
    }
    return '';
}

/**
 * Checks if the given amount of memory is available
 *
 * If the memory_get_usage() function is not available the
 * function just assumes $bytes of already allocated memory
 *
 * @param  int $mem  Size of memory you want to allocate in bytes
 * @param  int $used already allocated memory (see above)
 * @author Filip Oscadal <webmaster@illusionsoftworks.cz>
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function is_mem_available($mem,$bytes=1048576){
  $limit = trim(ini_get('memory_limit'));
  if(empty($limit)) return true; // no limit set!

  // parse limit to bytes
  $limit = php_to_byte($limit);

  // get used memory if possible
  if(function_exists('memory_get_usage')){
    $used = memory_get_usage();
  }

  if($used+$mem > $limit){
    return false;
  }

  return true;
}

/**
 * Send a HTTP redirect to the browser
 *
 * Works arround Microsoft IIS cookie sending bug. Exits the script.
 *
 * @link   http://support.microsoft.com/kb/q176113/
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function send_redirect($url){
    // always close the session
    session_write_close();

    // check if running on IIS < 6 with CGI-PHP
    if( isset($_SERVER['SERVER_SOFTWARE']) && isset($_SERVER['GATEWAY_INTERFACE']) &&
        (strpos($_SERVER['GATEWAY_INTERFACE'],'CGI') !== false) &&
        (preg_match('|^Microsoft-IIS/(\d)\.\d$|', trim($_SERVER['SERVER_SOFTWARE']), $matches)) &&
        $matches[1] < 6 ){
        header('Refresh: 0;url='.$url);
    }else{
        header('Location: '.$url);
    }
    exit;
}

//Setup VIM: ex: et ts=2 enc=utf-8 :
