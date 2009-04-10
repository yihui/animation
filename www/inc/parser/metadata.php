<?php
/**
 * Renderer for metadata
 *
 * @author Esther Brunner <wikidesign@gmail.com>
 */
if(!defined('DOKU_INC')) die('meh.');

if ( !defined('DOKU_LF') ) {
    // Some whitespace to help View > Source
    define ('DOKU_LF',"\n");
}

if ( !defined('DOKU_TAB') ) {
    // Some whitespace to help View > Source
    define ('DOKU_TAB',"\t");
}

require_once DOKU_INC . 'inc/parser/renderer.php';

/**
 * The Renderer
 */
class Doku_Renderer_metadata extends Doku_Renderer {

  var $doc  = '';
  var $meta = array();
  var $persistent = array();

  var $headers = array();
  var $capture = true;
  var $store   = '';

  function getFormat(){
    return 'metadata';
  }

  function document_start(){
    // reset metadata to persistent values
    $this->meta = $this->persistent;
  }

  function document_end(){
    // store internal info in metadata (notoc,nocache)
    $this->meta['internal'] = $this->info;

    if (!$this->meta['description']['abstract']){
      // cut off too long abstracts
      $this->doc = trim($this->doc);
      if (strlen($this->doc) > 500)
        $this->doc = utf8_substr($this->doc, 0, 500).'…';
      $this->meta['description']['abstract'] = $this->doc;
    }
  }

  function toc_additem($id, $text, $level) {
    global $conf;

    //only add items within configured levels
    if($level >= $conf['toptoclevel'] && $level <= $conf['maxtoclevel']){
      // the TOC is one of our standard ul list arrays ;-)
      $this->meta['description']['tableofcontents'][] = array(
        'hid'   => $id,
        'title' => $text,
        'type'  => 'ul',
        'level' => $level-$conf['toptoclevel']+1
      );
    }

  }

  function header($text, $level, $pos) {

    if (!$this->meta['title']) $this->meta['title'] = $text;

    // add the header to the TOC
    $hid = $this->_headerToLink($text,'true');
    $this->toc_additem($hid, $text, $level);

    // add to summary
    if ($this->capture && ($level > 1)) $this->doc .= DOKU_LF.$text.DOKU_LF;
  }

  function section_open($level){}
  function section_close(){}

  function cdata($text){
    if ($this->capture) $this->doc .= $text;
  }

  function p_open(){
    if ($this->capture) $this->doc .= DOKU_LF;
  }

  function p_close(){
    if ($this->capture){
      if (strlen($this->doc) > 250) $this->capture = false;
      else $this->doc .= DOKU_LF;
    }
  }

  function linebreak(){
    if ($this->capture) $this->doc .= DOKU_LF;
  }

  function hr(){
    if ($this->capture){
      if (strlen($this->doc) > 250) $this->capture = false;
      else $this->doc .= DOKU_LF.'----------'.DOKU_LF;
    }
  }

  function strong_open(){}
  function strong_close(){}

  function emphasis_open(){}
  function emphasis_close(){}

  function underline_open(){}
  function underline_close(){}

  function monospace_open(){}
  function monospace_close(){}

  function subscript_open(){}
  function subscript_close(){}

  function superscript_open(){}
  function superscript_close(){}

  function deleted_open(){}
  function deleted_close(){}

  /**
   * Callback for footnote start syntax
   *
   * All following content will go to the footnote instead of
   * the document. To achieve this the previous rendered content
   * is moved to $store and $doc is cleared
   *
   * @author Andreas Gohr <andi@splitbrain.org>
   */
  function footnote_open() {
    if ($this->capture){
      // move current content to store and record footnote
      $this->store = $this->doc;
      $this->doc   = '';
    }
  }

  /**
   * Callback for footnote end syntax
   *
   * All rendered content is moved to the $footnotes array and the old
   * content is restored from $store again
   *
   * @author Andreas Gohr
   */
  function footnote_close() {
    if ($this->capture){
      // restore old content
      $this->doc = $this->store;
      $this->store = '';
    }
  }

  function listu_open(){
    if ($this->capture) $this->doc .= DOKU_LF;
  }

  function listu_close(){
    if ($this->capture && (strlen($this->doc) > 250)) $this->capture = false;
  }

  function listo_open(){
    if ($this->capture) $this->doc .= DOKU_LF;
  }

  function listo_close(){
    if ($this->capture && (strlen($this->doc) > 250)) $this->capture = false;
  }

  function listitem_open($level){
    if ($this->capture) $this->doc .= str_repeat(DOKU_TAB, $level).'* ';
  }

  function listitem_close(){
    if ($this->capture) $this->doc .= DOKU_LF;
  }

  function listcontent_open(){}
  function listcontent_close(){}

  function unformatted($text){
    if ($this->capture) $this->doc .= $text;
  }

  function php($text){}

  function phpblock($text){}

  function html($text){}

  function htmlblock($text){}

  function preformatted($text){
    if ($this->capture) $this->doc .= $text;
  }

  function file($text){
    if ($this->capture){
      $this->doc .= DOKU_LF.$text;
      if (strlen($this->doc) > 250) $this->capture = false;
      else $this->doc .= DOKU_LF;
    }
  }

  function quote_open(){
    if ($this->capture) $this->doc .= DOKU_LF.DOKU_TAB.'"';
  }

  function quote_close(){
    if ($this->capture){
      $this->doc .= '"';
      if (strlen($this->doc) > 250) $this->capture = false;
      else $this->doc .= DOKU_LF;
    }
  }

  function code($text, $language = NULL){
    if ($this->capture){
      $this->doc .= DOKU_LF.$text;
      if (strlen($this->doc) > 250) $this->capture = false;
      else $this->doc .= DOKU_LF;
    }
  }

  function acronym($acronym){
    if ($this->capture) $this->doc .= $acronym;
  }

  function smiley($smiley){
    if ($this->capture) $this->doc .= $smiley;
  }

  function entity($entity){
    if ($this->capture) $this->doc .= $entity;
  }

  function multiplyentity($x, $y){
    if ($this->capture) $this->doc .= $x.'×'.$y;
  }

  function singlequoteopening(){
    global $lang;
    if ($this->capture) $this->doc .= $lang['singlequoteopening'];
  }

  function singlequoteclosing(){
    global $lang;
    if ($this->capture) $this->doc .= $lang['singlequoteclosing'];
  }

  function apostrophe() {
    global $lang;
    if ($this->capture) $this->doc .= $lang['apostrophe'];
  }

  function doublequoteopening(){
    global $lang;
    if ($this->capture) $this->doc .= $lang['doublequoteopening'];
  }

  function doublequoteclosing(){
    global $lang;
    if ($this->capture) $this->doc .= $lang['doublequoteclosing'];
  }

  function camelcaselink($link) {
    $this->internallink($link, $link);
  }

  function locallink($hash, $name = NULL){}

  /**
   * keep track of internal links in $this->meta['relation']['references']
   */
  function internallink($id, $name = NULL){
    global $ID;

    $default = $this->_simpleTitle($id);

    // first resolve and clean up the $id
    resolve_pageid(getNS($ID), $id, $exists);
    list($page, $hash) = split('#', $id, 2);

    // set metadata
    $this->meta['relation']['references'][$page] = $exists;
    // $data = array('relation' => array('isreferencedby' => array($ID => true)));
    // p_set_metadata($id, $data);

    // add link title to summary
    if ($this->capture){
      $name = $this->_getLinkTitle($name, $default, $id);
      $this->doc .= $name;
    }
  }

  function externallink($url, $name = NULL){
    if ($this->capture){
      if ($name) $this->doc .= $name;
      else $this->doc .= '<'.$url.'>';
    }
  }

  function interwikilink($match, $name = NULL, $wikiName, $wikiUri){
    if ($this->capture){
      list($wikiUri, $hash) = explode('#', $wikiUri, 2);
      $name = $this->_getLinkTitle($name, $wikiName.'>'.$wikiUri);
      $this->doc .= $name;
    }
  }

  function windowssharelink($url, $name = NULL){
    if ($this->capture){
      if ($name) $this->doc .= $name;
      else $this->doc .= '<'.$url.'>';
    }
  }

  function emaillink($address, $name = NULL){
    if ($this->capture){
      if ($name) $this->doc .= $name;
      else $this->doc .= '<'.$address.'>';
    }
  }

  function internalmedia($src, $title=NULL, $align=NULL, $width=NULL,
                         $height=NULL, $cache=NULL, $linking=NULL){
    if ($this->capture && $title) $this->doc .= '['.$title.']';
  }

  function externalmedia($src, $title=NULL, $align=NULL, $width=NULL,
                         $height=NULL, $cache=NULL, $linking=NULL){
    if ($this->capture && $title) $this->doc .= '['.$title.']';
  }

  function rss($url,$params) {
    $this->meta['relation']['haspart'][$url] = true;

    $this->meta['date']['valid']['age'] =
            isset($this->meta['date']['valid']['age']) ?
                min($this->meta['date']['valid']['age'],$params['refresh']) :
                $params['refresh'];
  }

  function table_open($maxcols = NULL, $numrows = NULL){}
  function table_close(){}

  function tablerow_open(){}
  function tablerow_close(){}

  function tableheader_open($colspan = 1, $align = NULL){}
  function tableheader_close(){}

  function tablecell_open($colspan = 1, $align = NULL){}
  function tablecell_close(){}

  //----------------------------------------------------------
  // Utils

  /**
   * Removes any Namespace from the given name but keeps
   * casing and special chars
   *
   * @author Andreas Gohr <andi@splitbrain.org>
   */
  function _simpleTitle($name){
    global $conf;

    if(is_array($name)) return '';

    if($conf['useslash']){
        $nssep = '[:;/]';
    }else{
        $nssep = '[:;]';
    }
    $name = preg_replace('!.*'.$nssep.'!','',$name);
    //if there is a hash we use the anchor name only
    $name = preg_replace('!.*#!','',$name);
    return $name;
  }

  /**
   * Creates a linkid from a headline
   *
   * @param string  $title   The headline title
   * @param boolean $create  Create a new unique ID?
   * @author Andreas Gohr <andi@splitbrain.org>
   */
  function _headerToLink($title, $create=false) {
    $title = str_replace(':','',cleanID($title));
    $title = ltrim($title,'0123456789._-');
    if(empty($title)) $title='section';

    if($create){
      // make sure tiles are unique
      $num = '';
      while(in_array($title.$num,$this->headers)){
        ($num) ? $num++ : $num = 1;
      }
      $title = $title.$num;
      $this->headers[] = $title;
    }

    return $title;
  }

  /**
   * Construct a title and handle images in titles
   *
   * @author Harry Fuecks <hfuecks@gmail.com>
   */
  function _getLinkTitle($title, $default, $id=NULL) {
    global $conf;

    $isImage = false;
    if (is_null($title)){
      if (useHeading('content') && $id){
        $heading = p_get_first_heading($id,false);
        if ($heading) return $heading;
      }
      return $default;
    } else if (is_string($title)){
      return $title;
    } else if (is_array($title)){
      return '['.$title.']';
    }
  }

}

//Setup VIM: ex: et ts=4 enc=utf-8 :
