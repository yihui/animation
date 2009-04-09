<?php
    if(!defined('DOKU_INC')) define('DOKU_INC',dirname(__FILE__).'/../../');
    define('DOKU_MEDIAMANAGER',1);

    require_once(DOKU_INC.'inc/init.php');
    require_once(DOKU_INC.'inc/lang/en/lang.php');
    require_once(DOKU_INC.'inc/lang/'.$conf['lang'].'/lang.php');
    require_once(DOKU_INC.'inc/media.php');
    require_once(DOKU_INC.'inc/common.php');
    require_once(DOKU_INC.'inc/search.php');
    require_once(DOKU_INC.'inc/template.php');
    require_once(DOKU_INC.'inc/auth.php');

    trigger_event('MEDIAMANAGER_STARTED',$tmp=array());
    session_write_close();  //close session

    // handle passed message
    if($_REQUEST['msg1']) msg(hsc($_REQUEST['msg1']),1);
    if($_REQUEST['err']) msg(hsc($_REQUEST['err']),-1);


    // get namespace to display (either direct or from deletion order)
    if($_REQUEST['delete']){
        $DEL = cleanID($_REQUEST['delete']);
        $IMG = $DEL;
        $NS  = getNS($DEL);
    }elseif($_REQUEST['edit']){
        $IMG = cleanID($_REQUEST['edit']);
        $NS  = getNS($IMG);
    }elseif($_REQUEST['img']){
        $IMG = cleanID($_REQUEST['img']);
        $NS  = getNS($IMG);
    }else{
        $NS = $_REQUEST['ns'];
        $NS = cleanID($NS);
    }

    // check auth
    $AUTH = auth_quickaclcheck("$NS:*");

    // create the given namespace (just for beautification)
    if($AUTH >= AUTH_UPLOAD) { io_createNamespace("$NS:xxx", 'media'); }

    // handle flash upload
    if($_FILES['Filedata']['tmp_name']){
        $_FILES['upload'] =& $_FILES['Filedata'];
        $JUMPTO = media_upload($NS,$AUTH);
        if($JUMPTO == false){
            header("HTTP/1.0 400 Bad Request");
            echo 'Upload failed';
        }
        echo 'ok';
        exit;
    }

    // give info on PHP catched upload errors
    if($_FILES['upload']['error']) switch($_FILES['upload']['error']){
        case 1:
        case 2:
            msg(sprintf($lang['uploadsize'],
                filesize_h(php_to_byte(ini_get('upload_max_filesize')))),-1);
            break;
        default:
            msg($lang['uploadfail'],-1);
    }

    // handle upload
    if($_FILES['upload']['tmp_name']){
        $JUMPTO = media_upload($NS,$AUTH);
        if($JUMPTO) $NS = getNS($JUMPTO);
    }

    // handle meta saving
    if($IMG && $_REQUEST['do']['save']){
        $JUMPTO = media_metasave($IMG,$AUTH,$_REQUEST['meta']);
    }

    // handle deletion
    if($DEL) {
        $INUSE = media_inuse($DEL);
        if(!$INUSE) {
            if(media_delete($DEL,$AUTH)) {
                msg(sprintf(noNS($id),$lang['deletesucc']),1);
            } else {
                msg(sprintf(noNS($DEL),$lang['deletefail']),-1);
            }
        } else {
            if(!$conf['refshow']) {
                unset($INUSE);
                msg(sprintf(noNS($DEL),$lang['mediainuse']),0);
            }
        }
    }

    // finished - start output
    header('Content-Type: text/html; charset=utf-8');
    include(template('mediamanager.php'));

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */
