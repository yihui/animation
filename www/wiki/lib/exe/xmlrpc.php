<?php
if(!defined('DOKU_INC')) define('DOKU_INC',dirname(__FILE__).'/../../');

// fix when '<?xml' isn't on the very first line
if(isset($HTTP_RAW_POST_DATA)) $HTTP_RAW_POST_DATA = trim($HTTP_RAW_POST_DATA);


require_once(DOKU_INC.'inc/init.php');
require_once(DOKU_INC.'inc/common.php');
require_once(DOKU_INC.'inc/auth.php');
session_write_close();  //close session

if(!$conf['xmlrpc']) {
    die('XML-RPC server not enabled.');
    // FIXME check for groups allowed
}

require_once(DOKU_INC.'inc/IXR_Library.php');


/**
 * Contains needed wrapper functions and registers all available
 * XMLRPC functions.
 */
class dokuwiki_xmlrpc_server extends IXR_IntrospectionServer {
    var $methods = array();

    /**
     * Constructor. Register methods and run Server
     */
    function dokuwiki_xmlrpc_server(){
        $this->IXR_IntrospectionServer();

        /* DokuWiki's own methods */
        $this->addCallback(
            'dokuwiki.getVersion',
            'getVersion',
            array('string'),
            'Returns the running DokuWiki version.'
        );

        /* Wiki API v2 http://www.jspwiki.org/wiki/WikiRPCInterface2 */
        $this->addCallback(
            'wiki.getRPCVersionSupported',
            'this:wiki_RPCVersion',
            array('int'),
            'Returns 2 with the supported RPC API version.'
        );
        $this->addCallback(
            'wiki.getPage',
            'this:rawPage',
            array('string','string'),
            'Get the raw Wiki text of page, latest version.'
        );
        $this->addCallback(
            'wiki.getPageVersion',
            'this:rawPage',
            array('string','string','int'),
            'Get the raw Wiki text of page.'
        );
        $this->addCallback(
            'wiki.getPageHTML',
            'this:htmlPage',
            array('string','string'),
            'Return page in rendered HTML, latest version.'
        );
        $this->addCallback(
            'wiki.getPageHTMLVersion',
            'this:htmlPage',
            array('string','string','int'),
            'Return page in rendered HTML.'
        );
        $this->addCallback(
            'wiki.getAllPages',
            'this:listPages',
            array('struct'),
            'Returns a list of all pages. The result is an array of utf8 pagenames.'
        );
        $this->addCallback(
            'wiki.getAttachments',
            'this:listAttachments',
            array('struct', 'string', 'struct'),
            'Returns a list of all media files.'
        );
        $this->addCallback(
            'wiki.getBackLinks',
            'this:listBackLinks',
            array('struct','string'),
            'Returns the pages that link to this page.'
        );
        $this->addCallback(
            'wiki.getPageInfo',
            'this:pageInfo',
            array('struct','string'),
            'Returns a struct with infos about the page.'
        );
        $this->addCallback(
            'wiki.getPageInfoVersion',
            'this:pageInfo',
            array('struct','string','int'),
            'Returns a struct with infos about the page.'
        );
        $this->addCallback(
            'wiki.getPageVersions',
            'this:pageVersions',
            array('struct','string','int'),
            'Returns the available revisions of the page.'
        );
        $this->addCallback(
            'wiki.putPage',
            'this:putPage',
            array('int', 'string', 'string', 'struct'),
            'Saves a wiki page.'
        );
        $this->addCallback(
            'wiki.listLinks',
            'this:listLinks',
            array('struct','string'),
            'Lists all links contained in a wiki page.'
        );
        $this->addCallback(
            'wiki.getRecentChanges',
            'this:getRecentChanges',
            array('struct','int'),
            'Returns a struct about all recent changes since given timestamp.'
        );
        $this->addCallback(
            'wiki.getRecentMediaChanges',
            'this:getRecentMediaChanges',
            array('struct','int'),
            'Returns a struct about all recent media changes since given timestamp.'
        );
        $this->addCallback(
            'wiki.aclCheck',
            'this:aclCheck',
            array('int', 'string'),
            'Returns the permissions of a given wiki page.'
        );
        $this->addCallback(
            'wiki.putAttachment',
            'this:putAttachment',
            array('struct', 'string', 'base64', 'struct'),
            'Upload a file to the wiki.'
        );
        $this->addCallback(
            'wiki.deleteAttachment',
            'this:deleteAttachment',
            array('int', 'string'),
            'Delete a file from the wiki.'
        );
        $this->addCallback(
            'wiki.getAttachment',
            'this:getAttachment',
            array('base64', 'string'),
            'Download a file from the wiki.'
        );
        $this->addCallback(
            'wiki.getAttachmentInfo',
            'this:getAttachmentInfo',
            array('struct', 'string'),
            'Returns a struct with infos about the attachment.'
        );

        /**
         * Trigger XMLRPC_CALLBACK_REGISTER, action plugins can use this event 
         * to extend the XMLRPC interface and register their own callbacks.
         *
         * Event data:
         *  The XMLRPC server object:
         *
         *  $event->data->addCallback() - register a callback, the second 
         *  paramter has to be of the form "plugin:<pluginname>:<plugin 
         *  method>"
         *
         *  $event->data->callbacks - an array which holds all awaylable 
         *  callbacks
         */
        trigger_event('XMLRPC_CALLBACK_REGISTER', $this);

        $this->serve();
    }

    /**
     * Return a raw wiki page
     */
    function rawPage($id,$rev=''){
        if(auth_quickaclcheck($id) < AUTH_READ){
            return new IXR_Error(1, 'You are not allowed to read this page');
        }
        $text = rawWiki($id,$rev);
        if(!$text) {
            $data = array($id);
            return trigger_event('HTML_PAGE_FROMTEMPLATE',$data,'pageTemplate',true);
        } else {
            return $text;
        }
    }
    
    /**
     * Return a media file encoded in base64
     * 
     * @author Gina Haeussge <osd@foosel.net>
     */
    function getAttachment($id){
        $id = cleanID($id);
        if (auth_quickaclcheck(getNS($id).':*') < AUTH_READ)
            return new IXR_Error(1, 'You are not allowed to read this file');
        
        $file = mediaFN($id);
        if (!@ file_exists($file))
            return new IXR_Error(1, 'The requested file does not exist');
        
        $data = io_readFile($file, false);
        $base64 = base64_encode($data);
        return $base64;
    }
    
    /**
     * Return info about a media file
     * 
     * @author Gina Haeussge <osd@foosel.net>
     */
    function getAttachmentInfo($id){
        $id = cleanID($id);
        $info = array(
            'lastModified' => 0,
            'size' => 0,
        );
        
        $file = mediaFN($id);
        if ((auth_quickaclcheck(getNS($id).':*') >= AUTH_READ) && file_exists($file)){
            $info['lastModified'] = new IXR_Date(filemtime($file));
            $info['size'] = filesize($file);
        }

        return $info;
    }

    /**
     * Return a wiki page rendered to html
     */
    function htmlPage($id,$rev=''){
        if(auth_quickaclcheck($id) < AUTH_READ){
            return new IXR_Error(1, 'You are not allowed to read this page');
        }
        return p_wiki_xhtml($id,$rev,false);
    }

    /**
     * List all pages - we use the indexer list here
     */
    function listPages(){
        global $conf;

        $list  = array();
        $pages = file($conf['indexdir'] . '/page.idx');
        $pages = array_filter($pages, 'isVisiblePage');

        foreach(array_keys($pages) as $idx) {
            if(page_exists($pages[$idx])) {
                $perm = auth_quickaclcheck($pages[$idx]);
                if($perm >= AUTH_READ) {
                    $page = array();
                    $page['id'] = trim($pages[$idx]);
                    $page['perms'] = $perm;
                    $page['size'] = @filesize(wikiFN($pages[$idx]));
                    $page['lastModified'] = new IXR_Date(@filemtime(wikiFN($pages[$idx])));
                    $list[] = $page;
                }
            }
        }

        return $list;
    }

    /**
     * List all media files.
     * 
     * Available options are 'recursive' for also including the subnamespaces
     * in the listing, and 'pattern' for filtering the returned files against
     * a regular expression matching their name.
     * 
     * @author Gina Haeussge <osd@foosel.net>
     */
    function listAttachments($ns, $options = array()) {
        global $conf;
        global $lang;

        $ns = cleanID($ns);

        if (!is_array($options))
            $options = array();

        if (!isset($options['recursive'])) $options['recursive'] = false;

        if(auth_quickaclcheck($ns.':*') >= AUTH_READ) {
            $dir = utf8_encodeFN(str_replace(':', '/', $ns));

            $data = array();
            require_once(DOKU_INC.'inc/search.php');
            search($data, $conf['mediadir'], 'search_media', array('recursive' => $options['recursive']), $dir);

            if(!count($data)) {
                return array();
            }

            $files = array();
            foreach($data as $item) {
                if (isset($options['pattern']) && !@preg_match($options['pattern'], $item['id']))
                    continue;
                $file = array();
                $file['id']       = $item['id'];
                $file['size']     = $item['size'];
                $file['lastModified'] = new IXR_Date($item['mtime']);
                $file['isimg']    = $item['isimg'];
                $file['writable'] = $item['writeable'];
                $file['perms'] = auth_quickaclcheck(getNS($item['id']).':*');
                array_push($files, $file);
            }

            return $files;

        } else {
            return new IXR_Error(1, 'You are not allowed to list media files.');
        }
    }

    /**
     * Return a list of backlinks
     */
    function listBackLinks($id){
        require_once(DOKU_INC.'inc/fulltext.php');
        return ft_backlinks($id);
    }

    /**
     * Return some basic data about a page
     */
    function pageInfo($id,$rev=''){
        if(auth_quickaclcheck($id) < AUTH_READ){
            return new IXR_Error(1, 'You are not allowed to read this page');
        }
        $file = wikiFN($id,$rev);
        $time = @filemtime($file);
        if(!$time){
            return new IXR_Error(10, 'The requested page does not exist');
        }

        $info = getRevisionInfo($id, $time, 1024);

        $data = array(
            'name'         => $id,
            'lastModified' => new IXR_Date($time),
            'author'       => (($info['user']) ? $info['user'] : $info['ip']),
            'version'      => $time
        );

        return ($data);
    }

    /**
     * Save a wiki page
     *
     * @author Michael Klier <chi@chimeric.de> 
     */
    function putPage($id, $text, $params) {
        global $TEXT;
        global $lang;
        global $conf;

        $id    = cleanID($id);
        $TEXT  = trim($text);
        $sum   = $params['sum'];
        $minor = $params['minor'];

        if(empty($id))
            return new IXR_Error(1, 'Empty page ID');

        if(!page_exists($id) && empty($TEXT)) {
            return new IXR_ERROR(1, 'Refusing to write an empty new wiki page');
        }

        if(auth_quickaclcheck($id) < AUTH_EDIT)
            return new IXR_Error(1, 'You are not allowed to edit this page');

        // Check, if page is locked
        if(checklock($id))
            return new IXR_Error(1, 'The page is currently locked');

        // SPAM check
        if(checkwordblock()) 
            return new IXR_Error(1, 'Positive wordblock check');

        // autoset summary on new pages
        if(!page_exists($id) && empty($sum)) {
            $sum = $lang['created'];
        }

        // autoset summary on deleted pages
        if(page_exists($id) && empty($TEXT) && empty($sum)) {
            $sum = $lang['deleted'];
        }

        lock($id);

        saveWikiText($id,$TEXT,$sum,$minor);

        unlock($id);

        // run the indexer if page wasn't indexed yet
        if(!@file_exists(metaFN($id, '.indexed'))) {
            // try to aquire a lock
            $lock = $conf['lockdir'].'/_indexer.lock';
            while(!@mkdir($lock,$conf['dmode'])){
                usleep(50);
                if(time()-@filemtime($lock) > 60*5){
                    // looks like a stale lock - remove it
                    @rmdir($lock);
                }else{
                    return false;
                }
            }
            if($conf['dperm']) chmod($lock, $conf['dperm']);

            require_once(DOKU_INC.'inc/indexer.php');

            // do the work
            idx_addPage($id);

            // we're finished - save and free lock
            io_saveFile(metaFN($id,'.indexed'),INDEXER_VERSION);
            @rmdir($lock);
        }

        return 0;
    }

    /**
     * Uploads a file to the wiki.
     *
     * Michael Klier <chi@chimeric.de>
     */
    function putAttachment($id, $file, $params) {
        global $conf;
        global $lang;

        $auth = auth_quickaclcheck(getNS($id).':*');
        if($auth >= AUTH_UPLOAD) {
            if(!isset($id)) {
                return new IXR_ERROR(1, 'Filename not given.');
            }

            $ftmp = $conf['tmpdir'] . '/' . $id;

            // save temporary file
            @unlink($ftmp);
            $buff = base64_decode($file);
            io_saveFile($ftmp, $buff);

            // get filename
            list($iext, $imime,$dl) = mimetype($id);
            $id = cleanID($id);
            $fn = mediaFN($id);

            // get filetype regexp
            $types = array_keys(getMimeTypes());
            $types = array_map(create_function('$q','return preg_quote($q,"/");'),$types);
            $regex = join('|',$types);

            // because a temp file was created already
            if(preg_match('/\.('.$regex.')$/i',$fn)) {
                //check for overwrite
                $overwrite = @file_exists($fn);
                if($overwrite && (!$params['ow'] || $auth < AUTH_DELETE)) {
                    return new IXR_ERROR(1, $lang['uploadexist']);
                }
                // check for valid content
                @require_once(DOKU_INC.'inc/media.php');
                $ok = media_contentcheck($ftmp, $imime);
                if($ok == -1) {
                    return new IXR_ERROR(1, sprintf($lang['uploadexist'], ".$iext"));
                } elseif($ok == -2) {
                    return new IXR_ERROR(1, $lang['uploadspam']);
                } elseif($ok == -3) {
                    return new IXR_ERROR(1, $lang['uploadxss']);
                }

                // prepare event data
                $data[0] = $ftmp;
                $data[1] = $fn;
                $data[2] = $id;
                $data[3] = $imime;
                $data[4] = $overwrite;

                // trigger event
                require_once(DOKU_INC.'inc/events.php');
                return trigger_event('MEDIA_UPLOAD_FINISH', $data, array($this, '_media_upload_action'), true);

            } else {
                return new IXR_ERROR(1, $lang['uploadwrong']);
            }
        } else {
            return new IXR_ERROR(1, "You don't have permissions to upload files.");
        }
    }
    
    /**
     * Deletes a file from the wiki.
     * 
     * @author Gina Haeussge <osd@foosel.net>
     */
    function deleteAttachment($id){
        $auth = auth_quickaclcheck(getNS($id).':*');
        if($auth < AUTH_DELETE) return new IXR_ERROR(1, "You don't have permissions to delete files.");
        global $conf;
        global $lang;
    
        // check for references if needed
        $mediareferences = array();
        if($conf['refcheck']){
            require_once(DOKU_INC.'inc/fulltext.php');
            $mediareferences = ft_mediause($id,$conf['refshow']);
        }
    
        if(!count($mediareferences)){
            $file = mediaFN($id);
            if(@unlink($file)){
                require_once(DOKU_INC.'inc/changelog.php');
                addMediaLogEntry(time(), $id, DOKU_CHANGE_TYPE_DELETE);
                io_sweepNS($id,'mediadir');
                return 0;
            }
            //something went wrong
               return new IXR_ERROR(1, 'Could not delete file');
        } else {
            return new IXR_ERROR(1, 'File is still referenced');
        }
    }

    /**
     * Moves the temporary file to its final destination.
     *
     * Michael Klier <chi@chimeric.de>
     */
    function _media_upload_action($data) {
        global $conf;

        if(is_array($data) && count($data)===5) {
            io_createNamespace($data[2], 'media');
            if(rename($data[0], $data[1])) {
                chmod($data[1], $conf['fmode']);
                media_notify($data[2], $data[1], $data[3]);
                // add a log entry to the media changelog
                require_once(DOKU_INC.'inc/changelog.php');
                if ($data[4]) {
                    addMediaLogEntry(time(), $data[2], DOKU_CHANGE_TYPE_EDIT);
                } else {
                    addMediaLogEntry(time(), $data[2], DOKU_CHANGE_TYPE_CREATE);
                }
                return $data[2];
            } else {
                return new IXR_ERROR(1, 'Upload failed.');
            }
        } else {
            return new IXR_ERROR(1, 'Upload failed.');
        }
    }

    /**
    * Returns the permissions of a given wiki page
    */
    function aclCheck($id) {
        return auth_quickaclcheck($id);
    }

    /**
     * Lists all links contained in a wiki page
     *
     * @author Michael Klier <chi@chimeric.de>
     */
    function listLinks($id) {
        if(auth_quickaclcheck($id) < AUTH_READ){
            return new IXR_Error(1, 'You are not allowed to read this page');
        }
        $links = array();

        // resolve page instructions
        $ins   = p_cached_instructions(wikiFN(cleanID($id)));

        // instantiate new Renderer - needed for interwiki links
        include(DOKU_INC.'inc/parser/xhtml.php');
        $Renderer = new Doku_Renderer_xhtml();
        $Renderer->interwiki = getInterwiki();

        // parse parse instructions
        foreach($ins as $in) {
            $link = array();
            switch($in[0]) {
                case 'internallink':
                    $link['type'] = 'local';
                    $link['page'] = $in[1][0];
                    $link['href'] = wl($in[1][0]);
                    array_push($links,$link);
                    break;
                case 'externallink':
                    $link['type'] = 'extern';
                    $link['page'] = $in[1][0];
                    $link['href'] = $in[1][0];
                    array_push($links,$link);
                    break;    
                case 'interwikilink':
                    $url = $Renderer->_resolveInterWiki($in[1][2],$in[1][3]);
                    $link['type'] = 'extern';
                    $link['page'] = $url;
                    $link['href'] = $url;
                    array_push($links,$link);
                    break;
            }
        }

        return ($links);
    }

    /**
     * Returns a list of recent changes since give timestamp
     *
     * @author Michael Hamann <michael@content-space.de>
     * @author Michael Klier <chi@chimeric.de>
     */
    function getRecentChanges($timestamp) {
        if(strlen($timestamp) != 10)
            return new IXR_Error(20, 'The provided value is not a valid timestamp');

        require_once(DOKU_INC.'inc/changelog.php');
        require_once(DOKU_INC.'inc/pageutils.php');

        $recents = getRecentsSince($timestamp);

        $changes = array();

        foreach ($recents as $recent) {
            $change = array();
            $change['name']         = $recent['id'];
            $change['lastModified'] = new IXR_Date($recent['date']);
            $change['author']       = $recent['user'];
            $change['version']      = $recent['date'];
            $change['perms']        = $recent['perms'];
            $change['size']         = @filesize(wikiFN($recent['id']));
            array_push($changes, $change);
        }

        if (!empty($changes)) {
            return $changes;
        } else {
            // in case we still have nothing at this point
            return new IXR_Error(30, 'There are no changes in the specified timeframe');
        } 
    }

    /**
     * Returns a list of recent media changes since give timestamp
     *
     * @author Michael Hamann <michael@content-space.de>
     * @author Michael Klier <chi@chimeric.de>
     */
    function getRecentMediaChanges($timestamp) {
        if(strlen($timestamp) != 10)
            return new IXR_Error(20, 'The provided value is not a valid timestamp');

        require_once(DOKU_INC.'inc/changelog.php');
        require_once(DOKU_INC.'inc/pageutils.php');

        $recents = getRecentsSince($timestamp, null, '', RECENTS_MEDIA_CHANGES);

        $changes = array();

        foreach ($recents as $recent) {
            $change = array();
            $change['name']         = $recent['id'];
            $change['lastModified'] = new IXR_Date($recent['date']);
            $change['author']       = $recent['user'];
            $change['version']      = $recent['date'];
            $change['perms']        = $recent['perms'];
            $change['size']         = @filesize(wikiFN($recent['id']));
            array_push($changes, $change);
        }

        if (!empty($changes)) {
            return $changes;
        } else {
            // in case we still have nothing at this point
            return new IXR_Error(30, 'There are no changes in the specified timeframe');
        } 
    }

    /**
     * Returns a list of available revisions of a given wiki page
     *
     * @author Michael Klier <chi@chimeric.de>
     */
    function pageVersions($id, $first) {
        global $conf;

        $versions = array();

        if(empty($id))
            return new IXR_Error(1, 'Empty page ID');

        require_once(DOKU_INC.'inc/changelog.php');

        $revisions = getRevisions($id, $first, $conf['recent']+1);

        if(count($revisions)==0 && $first!=0) {
            $first=0;
            $revisions = getRevisions($id, $first, $conf['recent']+1);
        }

        if(count($revisions)>0 && $first==0) {
            array_unshift($revisions, '');  // include current revision
            array_pop($revisions);          // remove extra log entry
        }

        $hasNext = false;
        if(count($revisions)>$conf['recent']) {
            $hasNext = true;
            array_pop($revisions); // remove extra log entry
        }

        if(!empty($revisions)) {
            foreach($revisions as $rev) {
                $file = wikiFN($id,$rev);
                $time = @filemtime($file);
                // we check if the page actually exists, if this is not the
                // case this can lead to less pages being returned than
                // specified via $conf['recent']
                if($time){
                    $info = getRevisionInfo($id, $time, 1024);
                    if(!empty($info)) {
                        $data['user'] = $info['user'];
                        $data['ip']   = $info['ip'];
                        $data['type'] = $info['type'];
                        $data['sum']  = $info['sum'];
                        $data['modified'] = new IXR_Date($info['date']);
                        $data['version'] = $info['date'];
                        array_push($versions, $data);
                    }
                }
            }
            return $versions;
        } else {
            return array(); 
        }
    }

    /**
     * The version of Wiki RPC API supported
     */
    function wiki_RPCVersion(){
        return 2;
    }
}

$server = new dokuwiki_xmlrpc_server();

// vim:ts=4:sw=4:et:enc=utf-8:
