<?php
/**
 *  Dokuwiki installation assistance
 *
 *  @author      Chris Smith <chris@jalakai.co.uk>
 */

if(!defined('DOKU_INC')) define('DOKU_INC',dirname(__FILE__).'/');
if(!defined('DOKU_CONF')) define('DOKU_CONF',DOKU_INC.'conf/');
if(!defined('DOKU_LOCAL')) define('DOKU_LOCAL',DOKU_INC.'conf/');

// check for error reporting override or set error reporting to sane values
if (!defined('DOKU_E_LEVEL')) { error_reporting(E_ALL ^ E_NOTICE); }
else { error_reporting(DOKU_E_LEVEL); }

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

// language strings
require_once(DOKU_INC.'inc/lang/en/lang.php');
$LC = preg_replace('/[^a-z\-]+/','',$_REQUEST['l']);
if(!$LC) $LC = 'en';
if($LC && $LC != 'en' ) {
    require_once(DOKU_INC.'inc/lang/'.$LC.'/lang.php');
}

// initialise variables ...
$error = array();

$dokuwiki_hash = array(
    '2005-09-22'   => 'e33223e957b0b0a130d0520db08f8fb7',
    '2006-03-05'   => '51295727f79ab9af309a2fd9e0b61acc',
    '2006-03-09'   => '51295727f79ab9af309a2fd9e0b61acc',
    '2006-11-06'   => 'b3a8af76845977c2000d85d6990dd72b',
    '2007-05-24'   => 'd80f2740c84c4a6a791fd3c7a353536f',
    '2007-06-26'   => 'b3ca19c7a654823144119980be73cd77',
    '2008-05-04'   => '1e5c42eac3219d9e21927c39e3240aad',
    'rc2009-02-06' => 'ec8c04210732a14fdfce0f7f6eead865',
);



// begin output
header('Content-Type: text/html; charset=utf-8');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $LC?>"
 lang="<?php echo $LC?>" dir="<?php echo $lang['direction']?>">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><?php echo $lang['i_installer']?></title>
    <style type="text/css">
        body { width: 90%; margin: 0 auto; font: 84% Verdana, Helvetica, Arial, sans-serif; }
        img { border: none }
        br.cl { clear:both; }
        code { font-size: 110%; color: #800000; }
        fieldset { border: none }
        label { display: block; margin-top: 0.5em; }
        select.text, input.text { width: 30em; margin: 0 0.5em; }
    </style>
    <script type="text/javascript" language="javascript">
        function acltoggle(){
            var cb = document.getElementById('acl');
            var fs = document.getElementById('acldep');
            if(!cb || !fs) return;
            if(cb.checked){
                fs.style.display = '';
            }else{
                fs.style.display = 'none';
            }
        }
        window.onload = function(){
            acltoggle();
            var cb = document.getElementById('acl');
            if(cb) cb.onchange = acltoggle;
        };
    </script>
</head>
<body style="">
    <h1 style="float:left">
        <img src="lib/exe/fetch.php?media=wiki:dokuwiki-128.png&w=64"
             style="vertical-align: middle;" alt="" />
        <?php echo $lang['i_installer']?>
    </h1>
    <div style="float:right; margin: 1em;">
        <?php langsel()?>
    </div>
    <br class="cl" />

    <div style="float: right; width: 34%;">
        <?php
            if(@file_exists(DOKU_INC.'inc/lang/'.$LC.'/install.html')){
                include(DOKU_INC.'inc/lang/'.$LC.'/install.html');
            }else{
                print "<div lang=\"en\" dir=\"ltr\">\n";
                include(DOKU_INC.'inc/lang/en/install.html');
                print "</div>\n";
            }
        ?>
    </div>

    <div style="float: left; width: 58%;">
        <?php
            if(! (check_functions() && check_permissions()) ){
                echo '<p>'.$lang['i_problems'].'</p>';
                print_errors();
                print_retry();
            }elseif(!check_configs()){
                echo '<p>'.$lang['i_modified'].'</p>';
                print_errors();
            }elseif($_REQUEST['submit']){
                if(!check_data($_REQUEST['d'])){
                    print_errors();
                    print_form($_REQUEST['d']);
                }elseif(!store_data($_REQUEST['d'])){
                    echo '<p>'.$lang['i_failure'].'</p>';
                    print_errors();
                }else{
                    echo '<p>'.$lang['i_success'].'</p>';
                }
            }else{
                print_form($_REQUEST['d']);
            }
        ?>
    </div>

<div style="clear: both">
  <a href="http://dokuwiki.org/"><img src="lib/tpl/default/images/button-dw.png" alt="driven by DokuWiki" /></a>
  <a href="http://www.php.net"><img src="lib/tpl/default/images/button-php.gif" alt="powered by PHP" /></a>
</div>
</body>
</html>
<?php

/**
 * Print the input form
 */
function print_form($d){
    global $lang;
    global $LC;

    if(!is_array($d)) $d = array();
    $d = array_map('htmlspecialchars',$d);

    if(!isset($d['acl'])) $d['acl']=1;

    ?>
    <form action="" method="post">
    <input type="hidden" name="l" value="<?php echo $LC ?>" />
    <fieldset>
        <label for="title"><?php echo $lang['i_wikiname']?>
        <input type="text" name="d[title]" id="title" value="<?php echo $d['title'] ?>" style="width: 20em;" />
        </label>

        <fieldset style="margin-top: 1em;">
            <label for="acl">
            <input type="checkbox" name="d[acl]" id="acl" <?php echo(($d['acl'] ? 'checked="checked"' : ''));?> />
            <?php echo $lang['i_enableacl']?></label>

            <fieldset id="acldep">
                <label for="superuser"><?php echo $lang['i_superuser']?></label>
                <input class="text" type="text" name="d[superuser]" id="superuser" value="<?php echo $d['superuser'] ?>" />

                <label for="fullname"><?php echo $lang['fullname']?></label>
                <input class="text" type="text" name="d[fullname]" id="fullname" value="<?php echo $d['fullname'] ?>" />

                <label for="email"><?php echo $lang['email']?></label>
                <input class="text" type="text" name="d[email]" id="email" value="<?php echo $d['email'] ?>" />

                <label for="password"><?php echo $lang['pass']?></label>
                <input class="text" type="password" name="d[password]" id="password" />

                <label for="confirm"><?php echo $lang['passchk']?></label>
                <input class="text" type="password" name="d[confirm]" id="confirm" />

                <label for="policy"><?php echo $lang['i_policy']?></label>
                <select class="text" name="d[policy]" id="policy">
                    <option value="0" <?php echo ($d['policy'] == 0)?'selected="selected"':'' ?>><?php echo $lang['i_pol0']?></option>
                    <option value="1" <?php echo ($d['policy'] == 1)?'selected="selected"':'' ?>><?php echo $lang['i_pol1']?></option>
                    <option value="2" <?php echo ($d['policy'] == 2)?'selected="selected"':'' ?>><?php echo $lang['i_pol2']?></option>
                </select>
            </fieldset>
        </fieldset>

    </fieldset>
    <fieldset id="process">
        <input class="button" type="submit" name="submit" value="<?php echo $lang['btn_save']?>" />
    </fieldset>
    </form>
    <?php
}

function print_retry() {
  global $lang;
  global $LC;
?>
    <form action="" method="get">
      <fieldset>
        <input type="hidden" name="l" value="<?php echo $LC ?>" />
        <input class="button" type="submit" value="<?php echo $lang['i_retry'];?>" />
      </fieldset>
    </form>
<?php
}

/**
 * Check validity of data
 *
 * @author Andreas Gohr
 */
function check_data(&$d){
    global $lang;
    global $error;

    //autolowercase the username
    $d['superuser'] = strtolower($d['superuser']);

    $ok = true;

    // check input
    if(empty($d['title'])){
        $error[] = sprintf($lang['i_badval'],$lang['i_wikiname']);
        $ok      = false;
    }
    if($d['acl']){
        if(!preg_match('/^[a-z1-9_]+$/',$d['superuser'])){
            $error[] = sprintf($lang['i_badval'],$lang['i_superuser']);
            $ok      = false;
        }
        if(empty($d['password'])){
            $error[] = sprintf($lang['i_badval'],$lang['pass']);
            $ok      = false;
        }
        if($d['confirm'] != $d['password']){
            $error[] = sprintf($lang['i_badval'],$lang['passchk']);
            $ok      = false;
        }
        if(empty($d['fullname']) || strstr($d['fullname'],':')){
            $error[] = sprintf($lang['i_badval'],$lang['fullname']);
            $ok      = false;
        }
        if(empty($d['email']) || strstr($d['email'],':') || !strstr($d['email'],'@')){
            $error[] = sprintf($lang['i_badval'],$lang['email']);
            $ok      = false;
        }
    }
    return $ok;
}

/**
 * Writes the data to the config files
 *
 * @author  Chris Smith <chris@jalakai.co.uk>
 */
function store_data($d){
    global $LC;
    $ok = true;
    $d['policy'] = (int) $d['policy'];

    // create local.php
    $now    = date('r');
    $output = <<<EOT
<?php
/**
 * Dokuwiki's Main Configuration File - Local Settings
 * Auto-generated by install script
 * Date: $now
 */

EOT;
    $output .= '$conf[\'title\'] = \''.addslashes($d['title'])."';\n";
    $output .= '$conf[\'lang\'] = \''.addslashes($LC)."';\n";
    if($d['acl']){
        $output .= '$conf[\'useacl\'] = 1'.";\n";
        $output .= "\$conf['superuser'] = '@admin';\n";
    }
    $ok = $ok && fileWrite(DOKU_LOCAL.'local.php',$output);


    if ($d['acl']) {
        // create users.auth.php
        // --- user:MD5password:Real Name:email:groups,comma,seperated
        $output = join(":",array($d['superuser'], md5($d['password']), $d['fullname'], $d['email'], 'admin,user'));
        $output = @file_get_contents(DOKU_CONF.'users.auth.php.dist')."\n$output\n";
        $ok = $ok && fileWrite(DOKU_LOCAL.'users.auth.php', $output);

        // create acl.auth.php
        $output = <<<EOT
# acl.auth.php
# <?php exit()?>
# Don't modify the lines above
#
# Access Control Lists
#
# Auto-generated by install script
# Date: $now

EOT;
        if($d['policy'] == 2){
            $output .=  "*               @ALL          0\n";
            $output .=  "*               @user         8\n";
        }elseif($d['policy'] == 1){
            $output .=  "*               @ALL          1\n";
            $output .=  "*               @user         8\n";
        }else{
            $output .=  "*               @ALL          8\n";
        }
        $ok = $ok && fileWrite(DOKU_LOCAL.'acl.auth.php', $output);
    }
    return $ok;
}

/**
 * Write the given content to a file
 *
 * @author  Chris Smith <chris@jalakai.co.uk>
 */
function fileWrite($filename, $data) {
    global $error;
    global $lang;

    if (($fp = @fopen($filename, 'wb')) === false) {
        $filename = str_replace($_SERVER['DOCUMENT_ROOT'],'{DOCUMENT_ROOT}/', $filename);
        $error[]  = sprintf($lang['i_writeerr'],$filename);
        return false;
    }

    if (!empty($data)) { fwrite($fp, $data);  }
    fclose($fp);
    return true;
}


/**
 * check installation dependent local config files and tests for a known
 * unmodified main config file
 *
 * @author      Chris Smith <chris@jalakai.co.uk>
 */
function check_configs(){
    global $error;
    global $lang;
    global $dokuwiki_hash;

    $ok = true;

    $config_files = array(
        'local' => DOKU_LOCAL.'local.php',
        'users' => DOKU_LOCAL.'users.auth.php',
        'auth'  => DOKU_LOCAL.'acl.auth.php'
    );


    // main dokuwiki config file (conf/dokuwiki.php) must not have been modified
    $installation_hash = md5(preg_replace("/(\015\012)|(\015)/","\012",
                             @file_get_contents(DOKU_CONF.'dokuwiki.php')));
    if (!in_array($installation_hash, $dokuwiki_hash)) {
        $error[] = sprintf($lang['i_badhash'],$installation_hash);
        $ok = false;
    }

    // configs shouldn't exist
    foreach ($config_files as $file) {
        if (@file_exists($file)) {
            $file    = str_replace($_SERVER['DOCUMENT_ROOT'],'{DOCUMENT_ROOT}/', $file);
            $error[] = sprintf($lang['i_confexists'],$file);
            $ok      = false;
        }
    }
    return $ok;
}


/**
 * Check other installation dir/file permission requirements
 *
 * @author      Chris Smith <chris@jalakai.co.uk>
 */
function check_permissions(){
    global $error;
    global $lang;

    $dirs = array(
        'conf'      => DOKU_LOCAL,
        'data'      => DOKU_INC.'data',
        'pages'     => DOKU_INC.'data/pages',
        'attic'     => DOKU_INC.'data/attic',
        'media'     => DOKU_INC.'data/media',
        'meta'      => DOKU_INC.'data/meta',
        'cache'     => DOKU_INC.'data/cache',
        'locks'     => DOKU_INC.'data/locks',
        'index'     => DOKU_INC.'data/index',
        'tmp'       => DOKU_INC.'data/tmp'
    );

    $ok = true;
    foreach($dirs as $dir){
        if(!@file_exists("$dir/.") || !@is_writable($dir)){
            $dir     = str_replace($_SERVER['DOCUMENT_ROOT'],'{DOCUMENT_ROOT}', $dir);
            $error[] = sprintf($lang['i_permfail'],$dir);
            $ok      = false;
        }
    }
    return $ok;
}

/**
 * Check the availability of functions used in DokuWiki and the PHP version
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function check_functions(){
    global $error;
    global $lang;
    $ok = true;

    if(version_compare(phpversion(),'4.3.3','<')){
        $error[] = sprintf($lang['i_phpver'],phpversion(),'4.3.3');
        $ok = false;
    }

    $funcs = explode(' ','addslashes basename call_user_func chmod copy fgets '.
                         'file file_exists fseek flush filesize ftell fopen '.
                         'glob header ignore_user_abort ini_get mail mkdir '.
                         'ob_start opendir parse_ini_file readfile realpath '.
                         'rename rmdir serialize session_start unlink usleep '.
                         'preg_replace file_get_contents');

    if (!function_exists('mb_substr')) {
      $funcs[] = 'utf8_encode';
      $funcs[] = 'utf8_decode';
    }

    foreach($funcs as $func){
        if(!function_exists($func)){
            $error[] = sprintf($lang['i_funcna'],$func);
            $ok = false;
        }
    }
    return $ok;
}

/**
 * Print language selection
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function langsel(){
    global $lang;
    global $LC;

    $dir = DOKU_INC.'inc/lang';
    $dh  = opendir($dir);
    if(!$dh) return;

    $langs = array();
    while (($file = readdir($dh)) !== false) {
        if(preg_match('/^[\._]/',$file)) continue;
        if(is_dir($dir.'/'.$file) && @file_exists($dir.'/'.$file.'/lang.php')){
            $langs[] = $file;
        }
    }
    closedir($dh);
    sort($langs);


    echo '<form action="">';
    echo $lang['i_chooselang'];
    echo ': <select name="l" onchange="submit()">';
    foreach($langs as $l){
        $sel = ($l == $LC) ? 'selected="selected"' : '';
        echo '<option value="'.$l.'" '.$sel.'>'.$l.'</option>';
    }
    echo '</select> ';
    echo '<input type="submit" value="'.$lang['btn_update'].'" />';
    echo '</form>';
}

/**
 * Print gloabl error array
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function print_errors(){
    global $error;
    echo '<ul>';
    foreach ($error as $err){
        echo "<li>$err</li>";
    }
    echo '</ul>';
}

/**
 * remove magic quotes recursivly
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function remove_magic_quotes(&$array) {
  foreach (array_keys($array) as $key) {
    if (is_array($array[$key])) {
      remove_magic_quotes($array[$key]);
    }else {
      $array[$key] = stripslashes($array[$key]);
    }
  }
}

