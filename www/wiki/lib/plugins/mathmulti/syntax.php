<?php

if(!defined('DOKU_INC')) define('DOKU_INC',realpath(dirname(__FILE__).'/../../').'/');
if(!defined('DOKU_PLUGIN')) define('DOKU_PLUGIN',DOKU_INC.'lib/plugins/');
require_once(DOKU_PLUGIN.'syntax.php');
require_once(DOKU_INC.'inc/io.php');


class syntax_plugin_mathmulti extends DokuWiki_Syntax_Plugin {

    function getInfo(){

      return array(
        'author' => 'Stephane Chamberland',
        'email'  => 'stephane.chamberland@ec.gc.ca',
        'date'   => '2006-05-23',
        'name'   => 'MathMulti Plugin'.(!$this->enable ? ' ('.$this->getLang($this->prefix.'disable').')' : ''),
        'desc'   => $this->getLang($this->prefix.'info').
                    (!$this->enable ? "\n(".$this->getLang($this->prefix.'disable').")" : ''),
        'url'    => 'http://wiki.splitbrain.org/plugin:math',
      );
    }

    function getType(){ return 'protected'; }
    function getPType(){ return 'normal'; }
    function getSort(){ return 209; }

    function connectTo($mode) {
      $this->Lexer->addSpecialPattern('\$\$.+?\$\$',$mode,'plugin_mathmulti');
      $this->Lexer->addSpecialPattern('\$.+?\$',$mode,'plugin_mathmulti');	  
    }

    function handle($match, $state, $pos, &$handler){

$contentstring = substr($match, 1, -1);
          $c_first = $contentstring{0};
          $c_last = $contentstring{strlen($contentstring)-1};
if($c_first=='$' && $c_last=='$'){
$contentstring=substr($contentstring,1,-1);
        $align = 'center';

} else {
        $align = 'normal';
$contentstring=trim($contentstring);
$contentstring='\\normalsize '.$contentstring;
}

        return (array($align, trim($contentstring)));
      return false;
    }

    function render($mode, &$renderer, $data) {

        if (!$data) return;   // skip rendering for the enter and exit patterns
        list($align, $eqn) = $data;

        if($mode == 'xhtml'){
            $eqn_html = $renderer->_xmlEntities($eqn);
                        $eqn_html =
                            $this->_render_mimetexcgi($eqn,$eqn_html,$size, $align);
            $renderer->doc .= $eqn_html;
            return true;
        }
        return false;
    }


    function _render_mimetexcgi($eqn,$eqn_html,$size,$align) {
        $myclass=' class="math"';
        if ($align != 'normal') {
            $myclass = ' class="media'.$align.'"';
		}
		
        return '<img src="'.'http://www.forkosh.dreamhost.com/mimetex.cgi'.'?'.
            $eqn_html.'" alt="'.$eqn_html.'" title="'.$eqn_html.'" '.$myclass.'/>';
    }

}

