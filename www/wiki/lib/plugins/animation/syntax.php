<?php
/**
 * Plugin ani: combine a sequence of images to constitute an animation"
 *
 * Syntax: <ani id|title|source|type|max|height|interval> - will be replaced with HTML & JS code
 * 
 * @license    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * @author     Yihui Xie <xie@yihui.name>
 */
 
if(!defined('DOKU_INC')) define('DOKU_INC',realpath(dirname(__FILE__).'/../../').'/');
if(!defined('DOKU_PLUGIN')) define('DOKU_PLUGIN',DOKU_INC.'lib/plugins/');
require_once(DOKU_PLUGIN.'syntax.php');
 
class syntax_plugin_animation extends DokuWiki_Syntax_Plugin {
 
    function getInfo(){
        return array(
            'author' => 'Yihui Xie',
            'email'  => 'xie@yihui.name',
            'date'   => '2008-06-02',
            'name'   => 'Animation Plugin',
            'desc'   => 'Generate an animation from a sequence of images, e.g. 1.png, 2.png, ...',
            'url'    => 'http://www.yihui.name',
        );
    }
 
    function getType(){ return 'container';}
    function getAllowedTypes() { return array('container','substition','protected','disabled','formatting','paragraphs'); }
	 
    function getSort(){
        return 122;
    }
 
    function connectTo($mode) {
      $this->Lexer->addEntryPattern('<ani.*?>(?=.*?</ani>)',$mode,'plugin_animation');      
}

	function postConnect() {
	  $this->Lexer->addExitPattern('</ani>', 'plugin_animation');
    }
	 
    function handle($match, $state, $pos, &$handler){
		switch ($state) {

            case DOKU_LEXER_ENTER :
            	$source = trim(substr($match, 4, -1));
				list($para,$title) = preg_split('/\|/u',$source,2);
                list($id, $url, $type, $max, $height, $interval) = preg_split('/\s+/u',trim($para),6);
                return array($state, array($id, $url, $type, $max, $height, $interval, $title));

            case DOKU_LEXER_UNMATCHED :
                return array (
                    $state,
                    array($match)
                );

            default :
                return array (
                    $state,
                    array('')
                );
		}

    }
 
    function render($mode, &$renderer, $data) {
        if($mode == 'xhtml'){
			list($state, $match) = $data;
			switch ($state) {
              case DOKU_LEXER_ENTER : 
			list($id, $url, $type, $max, $height, $interval, $title) = $match;
            $renderer->doc .= 
			"<div align=\"center\" class=\"anidemo\" title=\"$title\">"
			."<fieldset>"
			."<legend align=\"center\">$title</legend>"
			."<div id=\"loading$id\" class=\"loading\">loading animation frames... 0%</div>"
			."<div id=\"divPreload$id\" class=\"divPreload\">"
			."<script language=\"JavaScript\" type=\"text/javascript\">"
			."	var source$id = \"$url\";"
			."	var imgtype$id = \"$type\";"
			."	var tmp$id = 0;"
			."	var nmax$id=$max; "
			."	var n$id=1;"
			."	var t$id;"
			."	for(i = 1; i <= nmax$id; i++){"
			."		document.write(\"<div class=\\\"divFrame\\\" id=\\\"divPreload\" + \"$id\" + i + \"\\\"><img src=\\\"\" + source$id + i + \".\" + imgtype$id + \"\\\"\" + \" id = \\\"img\" + \"$id\" + i + \"\\\" onload = \\\"loading(\\'$id\\')\\\" onerror = \\\"loading(\\'$id\\')\\\" alt=\\\"$title\\\" title=\\\"$title\\\" /></div>\");"
			."}"
			."</script>"
			."</div>"
			."<div class=\"btncontrol\">"
			."<input name=\"nmax$id\" type=\"hidden\" id=\"nmax$id\" value=\"$max\" />"
			."<input name=\"height$id\" type=\"hidden\" id=\"height$id\" value=\"$height\" />"
			."<input name=\"btnPlay$id\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnPlay$id\" title=\"Play\" onclick=\"playAni('$id')\" value=\"  &gt;  \" /> "
			."<input name=\"btnPause$id\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnPause$id\" title=\"Pause\" onclick=\"pauseAni('$id')\" value=\"  O  \" /> "
			."<input name=\"btnFast$id\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnFast$id\" title=\"Speed up\" onclick=\"fastAni('$id',1)\" value=\"  +  \" /> "
			."<input name=\"btnSlow$id\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnSlow$id\" title=\"Slow down\" onclick=\"fastAni('$id',-1)\" value=\"  -  \" /> "
			."<input name=\"btnPrev$id\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnPrev$id\" title=\"Previous frame\" onclick=\"prevAni('$id',1)\" value=\"  &lt;&lt;  \" /> "
			."<input name=\"btnNext$id\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnNext$id\" title=\"Next frame\" onclick=\"prevAni('$id',-1)\" value=\"  &gt;&gt;  \" /> "
			."<input name=\"btnFirst$id\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnFirst$id\" title=\"First frame\" onclick=\"firstAni('$id',true)\" value=\"  |&lt;  \" /> "
			."<input name=\"btnLast$id\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnLast$id\" title=\"Last frame\" onclick=\"firstAni('$id',false)\" value=\"  &gt;|  \" /> "
			."<input name=\"btnMore$id\" type=\"submit\" disabled=\"disabled\" class=\"anibutton\" id=\"btnMore$id\" title=\"More controls\" onclick=\"btnMore('$id')\" value=\"  &lt;&gt;  \" />"
			."</div>"
			."<div id=\"morePar$id\" class=\"morepar\">"
			."<label title=\"Which frame to go?\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\">View frame <input name=\"txtFrame$id\" type=\"text\" id=\"txtFrame$id\" onblur=\"txtFrame(this.value, '$id')\" value=\"1\" size=\"4\" class=\"text\" />/$max</label> "
			."<label title=\"Loop or not?\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\"><input name=\"checkLoop$id\" type=\"checkbox\" id=\"checkLoop$id\" checked=\"checked\"/>Loop</label> "
			."<label title=\"Time interval for the animation (in sec)\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\">Time Interval: <input name=\"txtInterval$id\" type=\"text\" id=\"txtInterval$id\" onblur=\"txtInterval(this)\" value=\"$interval\" size=\"4\" class=\"text\" /></label> "
			."<label title=\"Increment in time interval\" onmouseover=\"this.style.backgroundColor='#8cacbb'\" onmouseout=\"this.style.backgroundColor='#ffffff'\">Step: <input name=\"txtStep$id\" type=\"text\" id=\"txtStep$id\" onblur=\"txtInterval(this)\" value=\"0.1\" size=\"4\" class=\"text\" />"
			."</label>"
			."</div><hr /><div class=\"description\">";
			break;
                case DOKU_LEXER_UNMATCHED :
				list($note)=$match;
				if(trim($match)!=""){
                    $renderer->doc .= $renderer->_xmlEntities($note);
				}
                    break;

                case DOKU_LEXER_EXIT :
			$renderer->doc .="</div></fieldset></div>";
                    break;
        	}
            return true;
    	}
        return false;
	}
}
 