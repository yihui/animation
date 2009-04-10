<?php
/**
 * HTML output functions
 *
 * @license    GPL 2 (http://www.gnu.org/licenses/gpl.html)
 * @author     Andreas Gohr <andi@splitbrain.org>
 */

if(!defined('DOKU_INC')) die('meh.');
if(!defined('NL')) define('NL',"\n");
require_once(DOKU_INC.'inc/parserutils.php');
require_once(DOKU_INC.'inc/form.php');

/**
 * Convenience function to quickly build a wikilink
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_wikilink($id,$name=NULL,$search=''){
  static $xhtml_renderer = NULL;
  if(is_null($xhtml_renderer)){
    require_once(DOKU_INC.'inc/parser/xhtml.php');
    $xhtml_renderer = new Doku_Renderer_xhtml();
  }

  return $xhtml_renderer->internallink($id,$name,$search,true,'navigation');
}

/**
 * Helps building long attribute lists
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_attbuild($attributes){
  $ret = '';
  foreach ( $attributes as $key => $value ) {
    $ret .= $key.'="'.formtext($value).'" ';
  }
  return trim($ret);
}

/**
 * The loginform
 *
 * @author   Andreas Gohr <andi@splitbrain.org>
 */
function html_login(){
  global $lang;
  global $conf;
  global $ID;
  global $auth;

  print p_locale_xhtml('login');
  print '<div class="centeralign">'.NL;
  $form = new Doku_Form('dw__login');
  $form->startFieldset($lang['btn_login']);
  $form->addHidden('id', $ID);
  $form->addHidden('do', 'login');
  $form->addElement(form_makeTextField('u', ((!$_REQUEST['http_credentials']) ? $_REQUEST['u'] : ''), $lang['user'], 'focus__this', 'block'));
  $form->addElement(form_makePasswordField('p', $lang['pass'], '', 'block'));
  if($conf['rememberme']) {
      $form->addElement(form_makeCheckboxField('r', '1', $lang['remember'], 'remember__me', 'simple'));
  }
  $form->addElement(form_makeButton('submit', '', $lang['btn_login']));
  $form->endFieldset();
  html_form('login', $form);

  if($auth && $auth->canDo('addUser') && actionOK('register')){
    print '<p>';
    print $lang['reghere'];
    print ': <a href="'.wl($ID,'do=register').'" rel="nofollow" class="wikilink1">'.$lang['register'].'</a>';
    print '</p>';
  }

  if ($auth && $auth->canDo('modPass') && actionOK('resendpwd')) {
    print '<p>';
    print $lang['pwdforget'];
    print ': <a href="'.wl($ID,'do=resendpwd').'" rel="nofollow" class="wikilink1">'.$lang['btn_resendpwd'].'</a>';
    print '</p>';
  }
  print '</div>'.NL;
}

/**
 * prints a section editing button
 * used as a callback in html_secedit
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_secedit_button($matches){
  global $ID;
  global $INFO;

  $section = $matches[2];
  $name = $matches[1];

  $secedit  = '';
  $secedit .= '<div class="secedit">';
  $secedit .= html_btn('secedit',$ID,'',
                        array('do'      => 'edit',
                              'lines'   => "$section",
                              'rev' => $INFO['lastmod']),
                              'post', $name);
  $secedit .= '</div>';
  return $secedit;
}

/**
 * inserts section edit buttons if wanted or removes the markers
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_secedit($text,$show=true){
  global $INFO;

  if($INFO['writable'] && $show && !$INFO['rev']){
    $text = preg_replace_callback('#<!-- SECTION "(.*?)" \[(\d+-\d*)\] -->#',
                         'html_secedit_button', $text);
  }else{
    $text = preg_replace('#<!-- SECTION "(.*?)" \[(\d+-\d*)\] -->#','',$text);
  }

  return $text;
}

/**
 * Just the back to top button (in its own form)
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_topbtn(){
  global $lang;

  $ret  = '';
  $ret  = '<a class="nolink" href="#dokuwiki__top"><input type="button" class="button" value="'.$lang['btn_top'].'" onclick="window.scrollTo(0, 0)" title="'.$lang['btn_top'].'" /></a>';

  return $ret;
}

/**
 * Displays a button (using its own form)
 * If tooltip exists, the access key tooltip is replaced.
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_btn($name,$id,$akey,$params,$method='get',$tooltip=''){
  global $conf;
  global $lang;

  $label = $lang['btn_'.$name];

  $ret = '';
  $tip = '';

  //filter id (without urlencoding)
  $id = idfilter($id,false);

  //make nice URLs even for buttons
  if($conf['userewrite'] == 2){
    $script = DOKU_BASE.DOKU_SCRIPT.'/'.$id;
  }elseif($conf['userewrite']){
    $script = DOKU_BASE.$id;
  }else{
    $script = DOKU_BASE.DOKU_SCRIPT;
    $params['id'] = $id;
  }

  $ret .= '<form class="button btn_'.$name.'" method="'.$method.'" action="'.$script.'"><div class="no">';

  if(is_array($params)){
    reset($params);
    while (list($key, $val) = each($params)) {
      $ret .= '<input type="hidden" name="'.$key.'" ';
      $ret .= 'value="'.htmlspecialchars($val).'" />';
    }
  }

  if ($tooltip!='') {
      $tip = htmlspecialchars($tooltip);
  }else{
      $tip = htmlspecialchars($label);
  }

  $ret .= '<input type="submit" value="'.htmlspecialchars($label).'" class="button" ';
  if($akey){
    $tip .= ' ['.strtoupper($akey).']';
    $ret .= 'accesskey="'.$akey.'" ';
  }
  $ret .= 'title="'.$tip.'" ';
  $ret .= '/>';
  $ret .= '</div></form>';

  return $ret;
}

/**
 * show a wiki page
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_show($txt=''){
  global $ID;
  global $REV;
  global $HIGH;
  global $INFO;
  //disable section editing for old revisions or in preview
  if($txt || $REV){
    $secedit = false;
  }else{
    $secedit = true;
  }

  if ($txt){
    //PreviewHeader
    echo '<br id="scroll__here" />';
    echo p_locale_xhtml('preview');
    echo '<div class="preview">';
    $html = html_secedit(p_render('xhtml',p_get_instructions($txt),$info),$secedit);
    if($INFO['prependTOC']) $html = tpl_toc(true).$html;
    echo $html;
    echo '<div class="clearer"></div>';
    echo '</div>';

  }else{
    if ($REV) print p_locale_xhtml('showrev');
    $html = p_wiki_xhtml($ID,$REV,true);
    $html = html_secedit($html,$secedit);
    if($INFO['prependTOC']) $html = tpl_toc(true).$html;
    $html = html_hilight($html,$HIGH);
    echo $html;
  }
}

/**
 * ask the user about how to handle an exisiting draft
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_draft(){
  global $INFO;
  global $ID;
  global $lang;
  global $conf;
  $draft = unserialize(io_readFile($INFO['draft'],false));
  $text  = cleanText(con($draft['prefix'],$draft['text'],$draft['suffix'],true));

  print p_locale_xhtml('draft');
  $form = new Doku_Form('dw__editform');
  $form->addHidden('id', $ID);
  $form->addHidden('date', $draft['date']);
  $form->addElement(form_makeWikiText($text, array('readonly'=>'readonly')));
  $form->addElement(form_makeOpenTag('div', array('id'=>'draft__status')));
  $form->addElement($lang['draftdate'].' '. strftime($conf['dformat'],filemtime($INFO['draft'])));
  $form->addElement(form_makeCloseTag('div'));
  $form->addElement(form_makeButton('submit', 'recover', $lang['btn_recover'], array('tabindex'=>'1')));
  $form->addElement(form_makeButton('submit', 'draftdel', $lang['btn_draftdel'], array('tabindex'=>'2')));
  $form->addElement(form_makeButton('submit', 'show', $lang['btn_cancel'], array('tabindex'=>'3')));
  html_form('draft', $form);
}

/**
 * Highlights searchqueries in HTML code
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @author Harry Fuecks <hfuecks@gmail.com>
 */
function html_hilight($html,$phrases){
  $regex = join('|',array_map('preg_quote_cb',array_filter((array) $phrases)));

  if ($regex === '') return $html;
  $html = preg_replace_callback("/((<[^>]*)|$regex)/ui",'html_hilight_callback',$html);
  return $html;
}

/**
 * Callback used by html_hilight()
 *
 * @author Harry Fuecks <hfuecks@gmail.com>
 */
function html_hilight_callback($m) {
  $hlight = unslash($m[0]);
  if ( !isset($m[2])) {
    $hlight = '<span class="search_hit">'.$hlight.'</span>';
  }
  return $hlight;
}

/**
 * Run a search and display the result
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_search(){
  require_once(DOKU_INC.'inc/search.php');
  require_once(DOKU_INC.'inc/fulltext.php');
  global $conf;
  global $QUERY;
  global $ID;
  global $lang;

  print p_locale_xhtml('searchpage');
  flush();

  //check if search is restricted to namespace
  if(preg_match('/([^@]*)@([^@]*)/',$QUERY,$match)) {
      $id = cleanID($match[1]);
      if(empty($id)) {
        print '<div class="nothing">'.$lang['nothingfound'].'</div>';
        flush();
        return;
      }
  } else {
      $id = cleanID($QUERY);
  }

  //show progressbar
  print '<div class="centeralign" id="dw__loading">'.NL;
  print '<script type="text/javascript" charset="utf-8"><!--//--><![CDATA[//><!--'.NL;
  print 'showLoadBar();'.NL;
  print '//--><!]]></script>'.NL;
  print '<br /></div>'.NL;
  flush();

  //do quick pagesearch
  $data = array();

  $data = ft_pageLookup($id);
  if(count($data)){
    print '<div class="search_quickresult">';
    print '<h3>'.$lang['quickhits'].':</h3>';
    print '<ul class="search_quickhits">';
    foreach($data as $id){
      print '<li> ';
      $ns = getNS($id);
      if($ns){
        $name = shorten(noNS($id), ' ('.$ns.')',30);
      }else{
        $name = $id;
      }
      print html_wikilink(':'.$id,$name);
      print '</li> ';
    }
    print '</ul> ';
    //clear float (see http://www.complexspiral.com/publications/containing-floats/)
    print '<div class="clearer">&nbsp;</div>';
    print '</div>';
  }
  flush();

  //do fulltext search
  $data = ft_pageSearch($QUERY,$regex);
  if(count($data)){
    $num = 1;
    foreach($data as $id => $cnt){
      print '<div class="search_result">';
      print html_wikilink(':'.$id,useHeading('navigation')?NULL:$id,$regex);
      print ': <span class="search_cnt">'.$cnt.' '.$lang['hits'].'</span><br />';
      if($num < 15){ // create snippets for the first number of matches only #FIXME add to conf ?
        print '<div class="search_snippet">'.ft_snippet($id,$regex).'</div>';
      }
      print '</div>';
      flush();
      $num++;
    }
  }else{
    print '<div class="nothing">'.$lang['nothingfound'].'</div>';
  }

  //hide progressbar
  print '<script type="text/javascript" charset="utf-8"><!--//--><![CDATA[//><!--'.NL;
  print 'hideLoadBar("dw__loading");'.NL;
  print '//--><!]]></script>'.NL;
  flush();
}

/**
 * Display error on locked pages
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_locked(){
  global $ID;
  global $conf;
  global $lang;
  global $INFO;

  $locktime = filemtime(wikiLockFN($ID));
  $expire = @strftime($conf['dformat'], $locktime + $conf['locktime'] );
  $min    = round(($conf['locktime'] - (time() - $locktime) )/60);

  print p_locale_xhtml('locked');
  print '<ul>';
  print '<li><div class="li"><strong>'.$lang['lockedby'].':</strong> '.$INFO['locked'].'</div></li>';
  print '<li><div class="li"><strong>'.$lang['lockexpire'].':</strong> '.$expire.' ('.$min.' min)</div></li>';
  print '</ul>';
}

/**
 * list old revisions
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @author Ben Coburn <btcoburn@silicodon.net>
 */
function html_revisions($first=0){
  global $ID;
  global $INFO;
  global $conf;
  global $lang;
  /* we need to get one additionally log entry to be able to
   * decide if this is the last page or is there another one.
   * see html_recent()
   */
  $revisions = getRevisions($ID, $first, $conf['recent']+1);
  if(count($revisions)==0 && $first!=0){
    $first=0;
    $revisions = getRevisions($ID, $first, $conf['recent']+1);;
  }
  $hasNext = false;
  if (count($revisions)>$conf['recent']) {
    $hasNext = true;
    array_pop($revisions); // remove extra log entry
  }

  $date = @strftime($conf['dformat'],$INFO['lastmod']);

  print p_locale_xhtml('revisions');

  $form = new Doku_Form('page__revisions', wl($ID));
  $form->addElement(form_makeOpenTag('ul'));
  if($INFO['exists'] && $first==0){
    if (isset($INFO['meta']) && isset($INFO['meta']['last_change']) && $INFO['meta']['last_change']['type']===DOKU_CHANGE_TYPE_MINOR_EDIT)
      $form->addElement(form_makeOpenTag('li', array('class' => 'minor')));
    else
      $form->addElement(form_makeOpenTag('li'));
    $form->addElement(form_makeOpenTag('div', array('class' => 'li')));
    $form->addElement(form_makeTag('input', array(
      'type' => 'checkbox',
      'name' => 'rev2[]',
      'value' => 'current')));

    $form->addElement(form_makeOpenTag('span', array('class' => 'date')));
    $form->addElement($date);
    $form->addElement(form_makeCloseTag('span'));

    $form->addElement(form_makeTag('img', array(
      'src' =>  DOKU_BASE.'lib/images/blank.gif',
      'width' => '15',
      'height' => '11',
      'alt'    => '')));

    $form->addElement(form_makeOpenTag('a', array(
      'class' => 'wikilink1',
      'href'  => wl($ID))));
    $form->addElement($ID);
    $form->addElement(form_makeCloseTag('a'));

    $form->addElement(form_makeOpenTag('span', array('class' => 'sum')));
    $form->addElement(' &ndash; ');
    $form->addElement(htmlspecialchars($INFO['sum']));
    $form->addElement(form_makeCloseTag('span'));

    $form->addElement(form_makeOpenTag('span', array('class' => 'user')));
    $form->addElement((empty($INFO['editor']))?('('.$lang['external_edit'].')'):editorinfo($INFO['editor']));
    $form->addElement(form_makeCloseTag('span'));

    $form->addElement('('.$lang['current'].')');
    $form->addElement(form_makeCloseTag('div'));
    $form->addElement(form_makeCloseTag('li'));
  }

  foreach($revisions as $rev){
    $date   = strftime($conf['dformat'],$rev);
    $info   = getRevisionInfo($ID,$rev,true);
    $exists = page_exists($ID,$rev);

    if ($info['type']===DOKU_CHANGE_TYPE_MINOR_EDIT)
      $form->addElement(form_makeOpenTag('li', array('class' => 'minor')));
    else
      $form->addElement(form_makeOpenTag('li'));
    $form->addElement(form_makeOpenTag('div', array('class' => 'li')));
    if($exists){
      $form->addElement(form_makeTag('input', array(
        'type' => 'checkbox',
        'name' => 'rev2[]',
        'value' => $rev)));
    }else{
      $form->addElement(form_makeTag('img', array(
        'src' => DOKU_BASE.'lib/images/blank.gif',
        'width' => 14,
        'height' => 11,
        'alt' => '')));
    }

    $form->addElement(form_makeOpenTag('span', array('class' => 'date')));
    $form->addElement($date);
    $form->addElement(form_makeCloseTag('span'));

    if($exists){
      $form->addElement(form_makeOpenTag('a', array('href' => wl($ID,"rev=$rev,do=diff", false, '&'), 'class' => 'diff_link')));
      $form->addElement(form_makeTag('img', array(
        'src'    => DOKU_BASE.'lib/images/diff.png',
        'width'  => 15,
        'height' => 11,
        'title'  => $lang['diff'],
        'alt'    => $lang['diff'])));
      $form->addElement(form_makeCloseTag('a'));

      $form->addElement(form_makeOpenTag('a', array('href' => wl($ID,"rev=$rev",false,'&'), 'class' => 'wikilink1')));
      $form->addElement($ID);
      $form->addElement(form_makeCloseTag('a'));
    }else{
      $form->addElement(form_makeTag('img', array(
        'src' => DOKU_BASE.'lib/images/blank.gif',
        'width' => '15',
        'height' => '11',
        'alt'   => '')));
      $form->addElement($ID);
    }

    $form->addElement(form_makeOpenTag('span', array('class' => 'sum')));
    $form->addElement(' &ndash; ');
    $form->addElement(htmlspecialchars($info['sum']));
    $form->addElement(form_makeCloseTag('span'));

    $form->addElement(form_makeOpenTag('span', array('class' => 'user')));
    if($info['user']){
      $form->addElement(editorinfo($info['user']));
      if(auth_ismanager()){
        $form->addElement(' ('.$info['ip'].')');
      }
    }else{
      $form->addElement($info['ip']);
    }
    $form->addElement(form_makeCloseTag('span'));

    $form->addElement(form_makeCloseTag('div'));
    $form->addElement(form_makeCloseTag('li'));
  }
  $form->addElement(form_makeCloseTag('ul'));
  $form->addElement(form_makeButton('submit', 'diff', $lang['diff2']));
  html_form('revisions', $form);

  print '<div class="pagenav">';
  $last = $first + $conf['recent'];
  if ($first > 0) {
    $first -= $conf['recent'];
    if ($first < 0) $first = 0;
    print '<div class="pagenav-prev">';
    print html_btn('newer',$ID,"p",array('do' => 'revisions', 'first' => $first));
    print '</div>';
  }
  if ($hasNext) {
    print '<div class="pagenav-next">';
    print html_btn('older',$ID,"n",array('do' => 'revisions', 'first' => $last));
    print '</div>';
  }
  print '</div>';

}

/**
 * display recent changes
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @author Matthias Grimm <matthiasgrimm@users.sourceforge.net>
 * @author Ben Coburn <btcoburn@silicodon.net>
 */
function html_recent($first=0){
  global $conf;
  global $lang;
  global $ID;
  /* we need to get one additionally log entry to be able to
   * decide if this is the last page or is there another one.
   * This is the cheapest solution to get this information.
   */
  $recents = getRecents($first,$conf['recent'] + 1,getNS($ID));
  if(count($recents) == 0 && $first != 0){
    $first=0;
    $recents = getRecents($first,$conf['recent'] + 1,getNS($ID));
  }
  $hasNext = false;
  if (count($recents)>$conf['recent']) {
    $hasNext = true;
    array_pop($recents); // remove extra log entry
  }

  print p_locale_xhtml('recent');

  if (getNS($ID) != '')
    print '<div class="level1"><p>' . sprintf($lang['recent_global'], getNS($ID), wl('', 'do=recent')) . '</p></div>';

  $form = new Doku_Form('dw__recent', script(), 'get');
  $form->addHidden('sectok', null);
  $form->addHidden('do', 'recent');
  $form->addHidden('id', $ID);
  $form->addElement(form_makeOpenTag('ul'));

  foreach($recents as $recent){
    $date = strftime($conf['dformat'],$recent['date']);
    if ($recent['type']===DOKU_CHANGE_TYPE_MINOR_EDIT)
      $form->addElement(form_makeOpenTag('li', array('class' => 'minor')));
    else
      $form->addElement(form_makeOpenTag('li'));

    $form->addElement(form_makeOpenTag('div', array('class' => 'li')));

    $form->addElement(form_makeOpenTag('span', array('class' => 'date')));
    $form->addElement($date);
    $form->addElement(form_makeCloseTag('span'));

    $form->addElement(form_makeOpenTag('a', array('class' => 'diff_link', 'href' => wl($recent['id'],"do=diff", false, '&'))));
    $form->addElement(form_makeTag('img', array(
      'src'   => DOKU_BASE.'lib/images/diff.png',
      'width' => 15,
      'height'=> 11,
      'title' => $lang['diff'],
      'alt'   => $lang['diff']
    )));
    $form->addElement(form_makeCloseTag('a'));

    $form->addElement(form_makeOpenTag('a', array('class' => 'revisions_link', 'href' => wl($recent['id'],"do=revisions",false,'&'))));
    $form->addElement(form_makeTag('img', array(
      'src'   => DOKU_BASE.'lib/images/history.png',
      'width' => 12,
      'height'=> 14,
      'title' => $lang['btn_revs'],
      'alt'   => $lang['btn_revs']
    )));
    $form->addElement(form_makeCloseTag('a'));

    $form->addElement(html_wikilink(':'.$recent['id'],useHeading('navigation')?NULL:$recent['id']));

    $form->addElement(form_makeOpenTag('span', array('class' => 'sum')));
    $form->addElement(' &ndash; '.htmlspecialchars($recent['sum']));
    $form->addElement(form_makeCloseTag('span'));

    $form->addElement(form_makeOpenTag('span', array('class' => 'user')));
    if($recent['user']){
      $form->addElement(editorinfo($recent['user']));
      if(auth_ismanager()){
        $form->addElement(' ('.$recent['ip'].')');
      }
    }else{
      $form->addElement($recent['ip']);
    }
    $form->addElement(form_makeCloseTag('span'));

    $form->addElement(form_makeCloseTag('div'));
    $form->addElement(form_makeCloseTag('li'));
  }
  $form->addElement(form_makeCloseTag('ul'));

  $form->addElement(form_makeOpenTag('div', array('class' => 'pagenav')));
  $last = $first + $conf['recent'];
  if ($first > 0) {
    $first -= $conf['recent'];
    if ($first < 0) $first = 0;
    $form->addElement(form_makeOpenTag('div', array('class' => 'pagenav-prev')));
    $form->addElement(form_makeTag('input', array(
      'type'  => 'submit',
      'name'  => 'first['.$first.']',
      'value' => $lang['btn_newer'],
      'accesskey' => 'n',
      'title' => $lang['btn_newer'].' [N]',
      'class' => 'button'
    )));
    $form->addElement(form_makeCloseTag('div'));
  }
  if ($hasNext) {
    $form->addElement(form_makeOpenTag('div', array('class' => 'pagenav-next')));
    $form->addElement(form_makeTag('input', array(
      'type'  => 'submit',
      'name'  => 'first['.$last.']',
      'value' => $lang['btn_older'],
      'accesskey' => 'p',
      'title' => $lang['btn_older'].' [P]',
      'class' => 'button'
    )));
    $form->addElement(form_makeCloseTag('div'));
  }
  $form->addElement(form_makeCloseTag('div'));
  html_form('recent', $form);
}

/**
 * Display page index
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_index($ns){
  require_once(DOKU_INC.'inc/search.php');
  global $conf;
  global $ID;
  $dir = $conf['datadir'];
  $ns  = cleanID($ns);
  #fixme use appropriate function
  if(empty($ns)){
    $ns = dirname(str_replace(':','/',$ID));
    if($ns == '.') $ns ='';
  }
  $ns  = utf8_encodeFN(str_replace(':','/',$ns));

  echo p_locale_xhtml('index');
  echo '<div id="index__tree">';

  $data = array();
  search($data,$conf['datadir'],'search_index',array('ns' => $ns));
  echo html_buildlist($data,'idx','html_list_index','html_li_index');

  echo '</div>';
}

/**
 * Index item formatter
 *
 * User function for html_buildlist()
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_list_index($item){
  global $ID;
  $ret = '';
  $base = ':'.$item['id'];
  $base = substr($base,strrpos($base,':')+1);
  if($item['type']=='d'){
    $ret .= '<a href="'.wl($ID,'idx='.rawurlencode($item['id'])).'" class="idx_dir"><strong>';
    $ret .= $base;
    $ret .= '</strong></a>';
  }else{
    $ret .= html_wikilink(':'.$item['id']);
  }
  return $ret;
}

/**
 * Index List item
 *
 * This user function is used in html_build_lidt to build the
 * <li> tags for namespaces when displaying the page index
 * it gives different classes to opened or closed "folders"
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_li_index($item){
  if($item['type'] == "f"){
    return '<li class="level'.$item['level'].'">';
  }elseif($item['open']){
    return '<li class="open">';
  }else{
    return '<li class="closed">';
  }
}

/**
 * Default List item
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_li_default($item){
  return '<li class="level'.$item['level'].'">';
}

/**
 * Build an unordered list
 *
 * Build an unordered list from the given $data array
 * Each item in the array has to have a 'level' property
 * the item itself gets printed by the given $func user
 * function. The second and optional function is used to
 * print the <li> tag. Both user function need to accept
 * a single item.
 *
 * Both user functions can be given as array to point to
 * a member of an object.
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_buildlist($data,$class,$func,$lifunc='html_li_default'){
  $level = 0;
  $opens = 0;
  $ret   = '';

  foreach ($data as $item){

    if( $item['level'] > $level ){
      //open new list
      for($i=0; $i<($item['level'] - $level); $i++){
        if ($i) $ret .= "<li class=\"clear\">\n";
        $ret .= "\n<ul class=\"$class\">\n";
      }
    }elseif( $item['level'] < $level ){
      //close last item
      $ret .= "</li>\n";
      for ($i=0; $i<($level - $item['level']); $i++){
        //close higher lists
        $ret .= "</ul>\n</li>\n";
      }
    }else{
      //close last item
      $ret .= "</li>\n";
    }

    //remember current level
    $level = $item['level'];

    //print item
    $ret .= call_user_func($lifunc,$item);
    $ret .= '<div class="li">';

    $ret .= call_user_func($func,$item);
    $ret .= '</div>';
  }

  //close remaining items and lists
  for ($i=0; $i < $level; $i++){
    $ret .= "</li></ul>\n";
  }

  return $ret;
}

/**
 * display backlinks
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @author Michael Klier <chi@chimeric.de>
 */
function html_backlinks(){
  require_once(DOKU_INC.'inc/fulltext.php');
  global $ID;
  global $conf;
  global $lang;

  print p_locale_xhtml('backlinks');

  $data = ft_backlinks($ID);

  if(!empty($data)) {
      print '<ul class="idx">';
      foreach($data as $blink){
        print '<li><div class="li">';
        print html_wikilink(':'.$blink,useHeading('navigation')?NULL:$blink);
        print '</div></li>';
      }
      print '</ul>';
  } else {
      print '<div class="level1"><p>' . $lang['nothingfound'] . '</p></div>';
  }
}

/**
 * show diff
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_diff($text='',$intro=true){
  require_once(DOKU_INC.'inc/DifferenceEngine.php');
  global $ID;
  global $REV;
  global $lang;
  global $conf;

  // we're trying to be clever here, revisions to compare can be either
  // given as rev and rev2 parameters, with rev2 being optional. Or in an
  // array in rev2.
  $rev1 = $REV;

  if(is_array($_REQUEST['rev2'])){
    $rev1 = (int) $_REQUEST['rev2'][0];
    $rev2 = (int) $_REQUEST['rev2'][1];

    if(!$rev1){
        $rev1 = $rev2;
        unset($rev2);
    }
  }else{
    $rev2 = (int) $_REQUEST['rev2'];
  }

  if($text){                      // compare text to the most current revision
    $l_rev   = '';
    $l_text  = rawWiki($ID,'');
    $l_head  = '<a class="wikilink1" href="'.wl($ID).'">'.
               $ID.' '.strftime($conf['dformat'],@filemtime(wikiFN($ID))).'</a> '.
               $lang['current'];

    $r_rev   = '';
    $r_text  = cleanText($text);
    $r_head  = $lang['yours'];
  }else{
    if($rev1 && $rev2){            // two specific revisions wanted
      // make sure order is correct (older on the left)
      if($rev1 < $rev2){
        $l_rev = $rev1;
        $r_rev = $rev2;
      }else{
        $l_rev = $rev2;
        $r_rev = $rev1;
      }
    }elseif($rev1){                // single revision given, compare to current
      $r_rev = '';
      $l_rev = $rev1;
    }else{                        // no revision was given, compare previous to current
      $r_rev = '';
      $revs = getRevisions($ID, 0, 1);
      $l_rev = $revs[0];
    }

    // when both revisions are empty then the page was created just now
    if(!$l_rev && !$r_rev){
      $l_text = '';
    }else{
      $l_text = rawWiki($ID,$l_rev);
    }
    $r_text = rawWiki($ID,$r_rev);


    if(!$l_rev){
      $l_head = '&mdash;';
    }else{
      $l_info   = getRevisionInfo($ID,$l_rev,true);
      if($l_info['user']){ $l_user = editorinfo($l_info['user']);
        if(auth_ismanager()) $l_user .= ' ('.$l_info['ip'].')';
      } else { $l_user = $l_info['ip']; }
      $l_user  = '<span class="user">'.$l_user.'</span>';
      $l_sum   = ($l_info['sum']) ? '<span class="sum">'.hsc($l_info['sum']).'</span>' : '';
      if ($l_info['type']===DOKU_CHANGE_TYPE_MINOR_EDIT) $l_minor = 'class="minor"';

      $l_head = '<a class="wikilink1" href="'.wl($ID,"rev=$l_rev").'">'.
                $ID.' ['.strftime($conf['dformat'],$l_rev).']</a>'.
                '<br />'.$l_user.' '.$l_sum;
    }

    if($r_rev){
      $r_info   = getRevisionInfo($ID,$r_rev,true);
      if($r_info['user']){ $r_user = editorinfo($r_info['user']);
        if(auth_ismanager()) $r_user .= ' ('.$r_info['ip'].')';
      } else { $r_user = $r_info['ip']; }
      $r_user = '<span class="user">'.$r_user.'</span>';
      $r_sum  = ($r_info['sum']) ? '<span class="sum">'.hsc($r_info['sum']).'</span>' : '';
      if ($r_info['type']===DOKU_CHANGE_TYPE_MINOR_EDIT) $r_minor = 'class="minor"';

      $r_head = '<a class="wikilink1" href="'.wl($ID,"rev=$r_rev").'">'.
                $ID.' ['.strftime($conf['dformat'],$r_rev).']</a>'.
                '<br />'.$r_user.' '.$r_sum;
    }elseif($_rev = @filemtime(wikiFN($ID))){
      $_info   = getRevisionInfo($ID,$_rev,true);
      if($_info['user']){ $_user = editorinfo($_info['user']);
        if(auth_ismanager()) $_user .= ' ('.$_info['ip'].')';
      } else { $_user = $_info['ip']; }
      $_user = '<span class="user">'.$_user.'</span>';
      $_sum  = ($_info['sum']) ? '<span class="sum">'.hsc($_info['sum']).'</span>' : '';
      if ($_info['type']===DOKU_CHANGE_TYPE_MINOR_EDIT) $r_minor = 'class="minor"';

      $r_head  = '<a class="wikilink1" href="'.wl($ID).'">'.
               $ID.' ['.strftime($conf['dformat'],$_rev).']</a> '.
               '('.$lang['current'].')'.
                '<br />'.$_user.' '.$_sum;
    }else{
      $r_head = '&mdash; ('.$lang['current'].')';
    }
  }

  $df = new Diff(explode("\n",htmlspecialchars($l_text)),
                 explode("\n",htmlspecialchars($r_text)));

  $tdf = new TableDiffFormatter();
  if($intro) print p_locale_xhtml('diff');
  ?>
    <table class="diff">
      <tr>
        <th colspan="2" <?php echo $l_minor?>>
          <?php echo $l_head?>
        </th>
        <th colspan="2" <?php echo $r_minor?>>
          <?php echo $r_head?>
        </th>
      </tr>
      <?php echo $tdf->format($df)?>
    </table>
  <?php
}

/**
 * show warning on conflict detection
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_conflict($text,$summary){
  global $ID;
  global $lang;

  print p_locale_xhtml('conflict');
  $form = new Doku_Form('dw__editform');
  $form->addHidden('id', $ID);
  $form->addHidden('wikitext', $text);
  $form->addHidden('summary', $summary);
  $form->addElement(form_makeButton('submit', 'save', $lang['btn_save'], array('accesskey'=>'s')));
  $form->addElement(form_makeButton('submit', 'cancel', $lang['btn_cancel']));
  html_form('conflict', $form);
  print '<br /><br /><br /><br />'.NL;
}

/**
 * Prints the global message array
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_msgarea(){
    global $MSG;
    if(!isset($MSG)) return;

    $shown = array();
    foreach($MSG as $msg){
        $hash = md5($msg['msg']);
        if(isset($shown[$hash])) continue; // skip double messages
        print '<div class="'.$msg['lvl'].'">';
        print $msg['msg'];
        print '</div>';
        $shown[$hash] = 1;
    }
}

/**
 * Prints the registration form
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_register(){
  global $lang;
  global $conf;
  global $ID;

  print p_locale_xhtml('register');
  print '<div class="centeralign">'.NL;
  $form = new Doku_Form('dw__register', wl($ID));
  $form->startFieldset($lang['register']);
  $form->addHidden('do', 'register');
  $form->addHidden('save', '1');
  $form->addElement(form_makeTextField('login', $_POST['login'], $lang['user'], null, 'block', array('size'=>'50')));
  if (!$conf['autopasswd']) {
    $form->addElement(form_makePasswordField('pass', $lang['pass'], '', 'block', array('size'=>'50')));
    $form->addElement(form_makePasswordField('passchk', $lang['passchk'], '', 'block', array('size'=>'50')));
  }
  $form->addElement(form_makeTextField('fullname', $_POST['fullname'], $lang['fullname'], '', 'block', array('size'=>'50')));
  $form->addElement(form_makeTextField('email', $_POST['email'], $lang['email'], '', 'block', array('size'=>'50')));
  $form->addElement(form_makeButton('submit', '', $lang['register']));
  $form->endFieldset();
  html_form('register', $form);

  print '</div>'.NL;
}

/**
 * Print the update profile form
 *
 * @author Christopher Smith <chris@jalakai.co.uk>
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_updateprofile(){
  global $lang;
  global $conf;
  global $ID;
  global $INFO;
  global $auth;

  print p_locale_xhtml('updateprofile');

  if (empty($_POST['fullname'])) $_POST['fullname'] = $INFO['userinfo']['name'];
  if (empty($_POST['email'])) $_POST['email'] = $INFO['userinfo']['mail'];
  print '<div class="centeralign">'.NL;
  $form = new Doku_Form('dw__register', wl($ID));
  $form->startFieldset($lang['profile']);
  $form->addHidden('do', 'profile');
  $form->addHidden('save', '1');
  $form->addElement(form_makeTextField('fullname', $_SERVER['REMOTE_USER'], $lang['user'], '', 'block', array('size'=>'50', 'disabled'=>'disabled')));
  $attr = array('size'=>'50');
  if (!$auth->canDo('modName')) $attr['disabled'] = 'disabled';
  $form->addElement(form_makeTextField('fullname', $_POST['fullname'], $lang['fullname'], '', 'block', $attr));
  $attr = array('size'=>'50');
  if (!$auth->canDo('modMail')) $attr['disabled'] = 'disabled';
  $form->addElement(form_makeTextField('email', $_POST['email'], $lang['email'], '', 'block', $attr));
  $form->addElement(form_makeTag('br'));
  if ($auth->canDo('modPass')) {
    $form->addElement(form_makePasswordField('newpass', $lang['newpass'], '', 'block', array('size'=>'50')));
    $form->addElement(form_makePasswordField('passchk', $lang['passchk'], '', 'block', array('size'=>'50')));
  }
  if ($conf['profileconfirm']) {
    $form->addElement(form_makeTag('br'));
    $form->addElement(form_makePasswordField('oldpass', $lang['oldpass'], '', 'block', array('size'=>'50')));
  }
  $form->addElement(form_makeButton('submit', '', $lang['btn_save']));
  $form->addElement(form_makeButton('reset', '', $lang['btn_reset']));
  $form->endFieldset();
  html_form('updateprofile', $form);
  print '</div>'.NL;
}

/**
 * This displays the edit form (lots of logic included)
 *
 * @fixme    this is a huge lump of code and should be modularized
 * @triggers HTML_PAGE_FROMTEMPLATE
 * @triggers HTML_EDITFORM_INJECTION
 * @author   Andreas Gohr <andi@splitbrain.org>
 */
function html_edit($text=null,$include='edit'){ //FIXME: include needed?
  global $ID;
  global $REV;
  global $DATE;
  global $RANGE;
  global $PRE;
  global $SUF;
  global $INFO;
  global $SUM;
  global $lang;
  global $conf;
  global $license;

  //set summary default
  if(!$SUM){
    if($REV){
      $SUM = $lang['restored'];
    }elseif(!$INFO['exists']){
      $SUM = $lang['created'];
    }
  }

  //no text? Load it!
  if(!isset($text)){
    $pr = false; //no preview mode
    if($INFO['exists']){
      if($RANGE){
        list($PRE,$text,$SUF) = rawWikiSlices($RANGE,$ID,$REV);
      }else{
        $text = rawWiki($ID,$REV);
      }
      $check = md5($text);
      $mod = false;
    }else{
      //try to load a pagetemplate
      $data = array($ID);
      $text = trigger_event('HTML_PAGE_FROMTEMPLATE',$data,'pageTemplate',true);
      $check = md5('');
      $mod = $text!=='';
    }
  }else{
    $pr = true; //preview mode
    if (isset($_REQUEST['changecheck'])) {
      $check = $_REQUEST['changecheck'];
      $mod = md5($text)!==$check;
    } else {
      // Why? Assume default text is unmodified.
      $check = md5($text);
      $mod = false;
    }
  }

  $wr = $INFO['writable'] && !$INFO['locked'];
  if($wr){
    if ($REV) print p_locale_xhtml('editrev');
    print p_locale_xhtml($include);
  }else{
    // check pseudo action 'source'
    if(!actionOK('source')){
      msg('Command disabled: source',-1);
      return;
    }
    print p_locale_xhtml('read');
  }
  if(!$DATE) $DATE = $INFO['lastmod'];


?>
  <div style="width:99%;">

   <div class="toolbar">
      <div id="draft__status"><?php if(!empty($INFO['draft'])) echo $lang['draftdate'].' '.strftime($conf['dformat']);?></div>
      <div id="tool__bar"><?php if($wr){?><a href="<?php echo DOKU_BASE?>lib/exe/mediamanager.php?ns=<?php echo $INFO['namespace']?>"
      target="_blank"><?php echo $lang['mediaselect'] ?></a><?php }?></div>

      <?php if($wr){?>
      <script type="text/javascript" charset="utf-8"><!--//--><![CDATA[//><!--
        <?php /* sets changed to true when previewed */?>
        textChanged = <?php ($mod) ? print 'true' : print 'false' ?>;
      //--><!]]></script>
      <span id="spell__action"></span>
      <div id="spell__suggest"></div>
      <?php } ?>
   </div>
   <div id="spell__result"></div>
<?php
  $form = new Doku_Form('dw__editform');
  $form->addHidden('id', $ID);
  $form->addHidden('rev', $REV);
  $form->addHidden('date', $DATE);
  $form->addHidden('prefix', $PRE);
  $form->addHidden('suffix', $SUF);
  $form->addHidden('changecheck', $check);
  $attr = array('tabindex'=>'1');
  if (!$wr) $attr['readonly'] = 'readonly';
  $form->addElement(form_makeWikiText($text, $attr));
  $form->addElement(form_makeOpenTag('div', array('id'=>'wiki__editbar')));
  $form->addElement(form_makeOpenTag('div', array('id'=>'size__ctl')));
  $form->addElement(form_makeCloseTag('div'));
  if ($wr) {
    $form->addElement(form_makeOpenTag('div', array('class'=>'editButtons')));
    $form->addElement(form_makeButton('submit', 'save', $lang['btn_save'], array('id'=>'edbtn__save', 'accesskey'=>'s', 'tabindex'=>'4')));
    $form->addElement(form_makeButton('submit', 'preview', $lang['btn_preview'], array('id'=>'edbtn__preview', 'accesskey'=>'p', 'tabindex'=>'5')));
    $form->addElement(form_makeButton('submit', 'draftdel', $lang['btn_cancel'], array('tabindex'=>'6')));
    $form->addElement(form_makeCloseTag('div'));
    $form->addElement(form_makeOpenTag('div', array('class'=>'summary')));
    $form->addElement(form_makeTextField('summary', $SUM, $lang['summary'], 'edit__summary', 'nowrap', array('size'=>'50', 'tabindex'=>'2')));
    $elem = html_minoredit();
    if ($elem) $form->addElement($elem);
    $form->addElement(form_makeCloseTag('div'));
  }
  $form->addElement(form_makeCloseTag('div'));
  if($conf['license']){
    $form->addElement(form_makeOpenTag('div', array('class'=>'license')));
    $out  = $lang['licenseok'];
    $out .= '<a href="'.$license[$conf['license']]['url'].'" rel="license" class="urlextern"';
    if($conf['target']['external']) $out .= ' target="'.$conf['target']['external'].'"';
    $out .= '> '.$license[$conf['license']]['name'].'</a>';
    $form->addElement($out);
    $form->addElement(form_makeCloseTag('div'));
  }
  html_form('edit', $form);
  print '</div>'.NL;
}

/**
 * Adds a checkbox for minor edits for logged in users
 *
 * @author Andrea Gohr <andi@splitbrain.org>
 */
function html_minoredit(){
  global $conf;
  global $lang;
  // minor edits are for logged in users only
  if(!$conf['useacl'] || !$_SERVER['REMOTE_USER']){
    return false;
  }

  $p = array();
  $p['tabindex'] = 3;
  if(!empty($_REQUEST['minor'])) $p['checked']='checked';
  return form_makeCheckboxField('minor', '1', $lang['minoredit'], 'minoredit', 'nowrap', $p);
}

/**
 * prints some debug info
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_debug(){
  global $conf;
  global $lang;
  global $auth;
  global $INFO;

  //remove sensitive data
  $cnf = $conf;
  debug_guard($cnf);
  $nfo = $INFO;
  debug_guard($nfo);
  $ses = $_SESSION;
  debug_guard($ses);

  print '<html><body>';

  print '<p>When reporting bugs please send all the following ';
  print 'output as a mail to andi@splitbrain.org ';
  print 'The best way to do this is to save this page in your browser</p>';

  print '<b>$INFO:</b><pre>';
  print_r($nfo);
  print '</pre>';

  print '<b>$_SERVER:</b><pre>';
  print_r($_SERVER);
  print '</pre>';

  print '<b>$conf:</b><pre>';
  print_r($cnf);
  print '</pre>';

  print '<b>DOKU_BASE:</b><pre>';
  print DOKU_BASE;
  print '</pre>';

  print '<b>abs DOKU_BASE:</b><pre>';
  print DOKU_URL;
  print '</pre>';

  print '<b>rel DOKU_BASE:</b><pre>';
  print dirname($_SERVER['PHP_SELF']).'/';
  print '</pre>';

  print '<b>PHP Version:</b><pre>';
  print phpversion();
  print '</pre>';

  print '<b>locale:</b><pre>';
  print setlocale(LC_ALL,0);
  print '</pre>';

  print '<b>encoding:</b><pre>';
  print $lang['encoding'];
  print '</pre>';

  if($auth){
    print '<b>Auth backend capabilities:</b><pre>';
    print_r($auth->cando);
    print '</pre>';
  }

  print '<b>$_SESSION:</b><pre>';
  print_r($ses);
  print '</pre>';

  print '<b>Environment:</b><pre>';
  print_r($_ENV);
  print '</pre>';

  print '<b>PHP settings:</b><pre>';
  $inis = ini_get_all();
  print_r($inis);
  print '</pre>';

  print '</body></html>';
}

function html_admin(){
  global $ID;
  global $INFO;
  global $lang;
  global $conf;

  print p_locale_xhtml('admin');

  // build menu of admin functions from the plugins that handle them
  $pluginlist = plugin_list('admin');
  $menu = array();
  foreach ($pluginlist as $p) {
    if($obj =& plugin_load('admin',$p) === NULL) continue;

    // check permissions
    if($obj->forAdminOnly() && !$INFO['isadmin']) continue;

    $menu[] = array('plugin' => $p,
                    'prompt' => $obj->getMenuText($conf['lang']),
                    'sort' => $obj->getMenuSort()
                   );
  }

  usort($menu, 'p_sort_modes');

  // output the menu
  ptln('<ul>');

  foreach ($menu as $item) {
    if (!$item['prompt']) continue;
    ptln('  <li><div class="li"><a href="'.wl($ID, 'do=admin&amp;page='.$item['plugin']).'">'.$item['prompt'].'</a></div></li>');
  }

  ptln('</ul>');
}

/**
 * Form to request a new password for an existing account
 *
 * @author Benoit Chesneau <benoit@bchesneau.info>
 */
function html_resendpwd() {
  global $lang;
  global $conf;
  global $ID;

  print p_locale_xhtml('resendpwd');
  print '<div class="centeralign">'.NL;
  $form = new Doku_Form('dw__resendpwd', wl($ID));
  $form->startFieldset($lang['resendpwd']);
  $form->addHidden('do', 'resendpwd');
  $form->addHidden('save', '1');
  $form->addElement(form_makeTag('br'));
  $form->addElement(form_makeTextField('login', $_POST['login'], $lang['user'], '', 'block'));
  $form->addElement(form_makeTag('br'));
  $form->addElement(form_makeTag('br'));
  $form->addElement(form_makeButton('submit', '', $lang['btn_resendpwd']));
  $form->endFieldset();
  html_form('resendpwd', $form);
  print '</div>'.NL;
}

/**
 * Return the TOC rendered to XHTML
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 */
function html_TOC($toc){
    if(!count($toc)) return '';
    global $lang;
    $out  = '<!-- TOC START -->'.DOKU_LF;
    $out .= '<div class="toc">'.DOKU_LF;
    $out .= '<div class="tocheader toctoggle" id="toc__header">';
    $out .= $lang['toc'];
    $out .= '</div>'.DOKU_LF;
    $out .= '<div id="toc__inside">'.DOKU_LF;
    $out .= html_buildlist($toc,'toc','html_list_toc');
    $out .= '</div>'.DOKU_LF.'</div>'.DOKU_LF;
    $out .= '<!-- TOC END -->'.DOKU_LF;
    return $out;                                                                                                }

/**
 * Callback for html_buildlist
 */
function html_list_toc($item){
    if($item['hid']){
        $link = '#'.$item['hid'];
    }else{
        $link = $item['link'];
    }

    return '<span class="li"><a href="'.$link.'" class="toc">'.
           hsc($item['title']).'</a></span>';
}

/**
 * Helper function to build TOC items
 *
 * Returns an array ready to be added to a TOC array
 *
 * @param string $link  - where to link (if $hash set to '#' it's a local anchor)
 * @param string $text  - what to display in the TOC
 * @param int    $level - nesting level
 * @param string $hash  - is prepended to the given $link, set blank if you want full links
 */
function html_mktocitem($link, $text, $level, $hash='#'){
    global $conf;
    return  array( 'link'  => $hash.$link,
                   'title' => $text,
                   'type'  => 'ul',
                   'level' => $level);
}

/**
 * Output a Doku_Form object.
 * Triggers an event with the form name: HTML_{$name}FORM_OUTPUT
 *
 * @author Tom N Harris <tnharris@whoopdedo.org>
 */
function html_form($name, &$form) {
  // Safety check in case the caller forgets.
  $form->endFieldset();
  trigger_event('HTML_'.strtoupper($name).'FORM_OUTPUT', $form, 'html_form_output', false);
}

/**
 * Form print function.
 * Just calls printForm() on the data object.
 */
function html_form_output($data) {
  $data->printForm();
}

/**
 * Embed a flash object in HTML
 *
 * This will create the needed HTML to embed a flash movie in a cross browser
 * compatble way using valid XHTML
 *
 * The parameters $params, $flashvars and $atts need to be associative arrays.
 * No escaping needs to be done for them. The alternative content *has* to be
 * escaped because it is used as is. If no alternative content is given
 * $lang['noflash'] is used.
 *
 * @author Andreas Gohr <andi@splitbrain.org>
 * @link   http://latrine.dgx.cz/how-to-correctly-insert-a-flash-into-xhtml
 *
 * @param string $swf      - the SWF movie to embed
 * @param int $width       - width of the flash movie in pixels
 * @param int $height      - height of the flash movie in pixels
 * @param array $params    - additional parameters (<param>)
 * @param array $flashvars - parameters to be passed in the flashvar parameter
 * @param array $atts      - additional attributes for the <object> tag
 * @param string $alt      - alternative content (is NOT automatically escaped!)
 * @returns string         - the XHTML markup
 */
function html_flashobject($swf,$width,$height,$params=null,$flashvars=null,$atts=null,$alt=''){
    global $lang;

    $out = '';

    // prepare the object attributes
    if(is_null($atts)) $atts = array();
    $atts['width']  = (int) $width;
    $atts['height'] = (int) $height;
    if(!$atts['width'])  $atts['width']  = 425;
    if(!$atts['height']) $atts['height'] = 350;

    // add object attributes for standard compliant browsers
    $std = $atts;
    $std['type'] = 'application/x-shockwave-flash';
    $std['data'] = $swf;

    // add object attributes for IE
    $ie  = $atts;
    $ie['classid'] = 'clsid:D27CDB6E-AE6D-11cf-96B8-444553540000';

    // open object (with conditional comments)
    $out .= '<!--[if !IE]> -->'.NL;
    $out .= '<object '.buildAttributes($std).'>'.NL;
    $out .= '<!-- <![endif]-->'.NL;
    $out .= '<!--[if IE]>'.NL;
    $out .= '<object '.buildAttributes($ie).'>'.NL;
    $out .= '    <param name="movie" value="'.hsc($swf).'" />'.NL;
    $out .= '<!--><!-- -->'.NL;

    // print params
    if(is_array($params)) foreach($params as $key => $val){
        $out .= '  <param name="'.hsc($key).'" value="'.hsc($val).'" />'.NL;
    }

    // add flashvars
    if(is_array($flashvars)){
        $out .= '  <param name="FlashVars" value="'.buildURLparams($flashvars).'" />'.NL;
    }

    // alternative content
    if($alt){
        $out .= $alt.NL;
    }else{
        $out .= $lang['noflash'].NL;
    }

    // finish
    $out .= '</object>'.NL;
    $out .= '<!-- <![endif]-->'.NL;

    return $out;
}

//Setup VIM: ex: et ts=2 enc=utf-8 :
