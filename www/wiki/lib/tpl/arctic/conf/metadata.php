<?php
/**
 * configuration-manager metadata for the arctic-template
 * 
 * @license:    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * @author:     Michael Klier <chi@chimeric.de>
 */

$meta['sidebar']                  = array('multichoice', '_choices' => array('left', 'right', 'both', 'none'));
$meta['pagename']                 = array('string', '_pattern' => '#[a-z0-9]*#');
$meta['trace']                    = array('onoff');
$meta['main_sidebar_always']	    = array('onoff');
$meta['wiki_actionlinks']         = array('multichoice', '_choices' => array('links', 'buttons'));
$meta['user_sidebar_namespace']   = array('string', '_pattern' => '#^[a-z:]*#');
$meta['group_sidebar_namespace']  = array('string', '_pattern' => '#^[a-z:]*#');
$meta['left_sidebar_order']       = array('string', '_pattern' => '#[a-z0-9,]*#');
$meta['left_sidebar_content']     = array('multicheckbox', '_choices' => array('main','toc','user','group','namespace','toolbox','index','trace','extra'));
$meta['right_sidebar_order']      = array('string', '_pattern' => '#[a-z0-9,]*#');
$meta['right_sidebar_content']    = array('multicheckbox', '_choices' => array('main','toc','user','group','namespace','toolbox','index','trace','extra'));
$meta['search']                   = array('multichoice', '_choices' => array('left', 'right'));
$meta['closedwiki']               = array('onoff');
//Setup vim:ts=2:sw=2:
?>
