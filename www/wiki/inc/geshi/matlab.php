<?php
/*************************************************************************************
 * matlab.php
 * -----------
 * Author: Florian Knorn (floz@gmx.de)
 * Copyright: (c) 2004 Florian Knorn (http://www.florian-knorn.com)
 * Release Version: 1\.0\.8
 * Date Started: 2005/02/09
 *
 * Matlab M-file language file for GeSHi.
 *
 * CHANGES
 * -------
 * 2006-03-25 (1.0.7.22)
 *   - support for the transpose operator
 *   - many keywords added
 *   - links to the matlab documentation at mathworks
 *      by: Olivier Verdier (olivier.verdier@free.fr)
 * 2005/05/07 (1.0.0)
 *   -  First Release
 *
 *
 *************************************************************************************
 *
 *     This file is part of GeSHi.
 *
 *   GeSHi is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   GeSHi is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with GeSHi; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 ************************************************************************************/

$language_data = array (
    'LANG_NAME' => 'Matlab M',
    'COMMENT_SINGLE' => array(1 => '%'),
    'COMMENT_MULTI' => array(),
    //Matlab Strings
    'COMMENT_REGEXP' => array(2 => "/(?<!\\w)('[^\\n\\r']*?')/"),
    'CASE_KEYWORDS' => GESHI_CAPS_NO_CHANGE,
    'QUOTEMARKS' => array(),
    'ESCAPE_CHAR' => '',
    'KEYWORDS' => array(
        1 => array(
            'break', 'case', 'catch', 'continue', 'elseif', 'else', 'end', 'for',
            'function', 'global', 'if', 'otherwise', 'persistent', 'return',
            'switch', 'try', 'while'
            ),
        2 => array(
            'all','any','exist','find','is','isa','logical','mislocked',

            'builtin','eval','evalc','evalin','feval','function','global',
            'nargchk','persistent','script','break','case','catch','else',
            'elseif','end','error','for','if','otherwise','return','switch',
            'try','warning','while','input','keyboard','menu','pause','class',
            'double','inferiorto','inline','int8','int16','int32','isa',
            'loadobj','saveobj','single','superiorto','uint8','int16','uint32',
            'dbclear','dbcont','dbdown','dbmex','dbquit','dbstack','dbstatus',
            'dbstep','dbstop','dbtype','dbup','blkdiag','eye','linspace',
            'logspace','ones','rand','randn','zeros','ans','computer','eps',
            'flops','i','Inf','inputname','j','NaN','nargin','nargout','pi',
            'realmax','realmin','varargin','varargout','calendar','clock',
            'cputime','date','datenum','datestr','datevec','eomday','etime',
            'now','tic','toc','weekday','cat','diag','fliplr','flipud','repmat',
            'reshape','rot90','tril','triu','compan','gallery','hadamard',
            'hankel','hilb','invhilb','magic','pascal','toeplitz','wilkinson',
            'abs','acos','acosh','acot','acoth','acsc','acsch','angle','asec',
            'asech','asin','asinh','atan','atanh','atan2','ceil','complex',
            'conj','cos','cosh','cot','coth','csc','csch','exp','fix','floor',
            'gcd','imag','lcm','log','log2','log10','mod','nchoosek','real',
            'rem','round','sec','sech','sign','sin','sinh','sqrt','tan','tanh',
            'airy','besselh','besseli','besselk','besselj','Bessely','beta',
            'betainc','betaln','ellipj','ellipke','erf','erfc','erfcx','erfiny',
            'expint','factorial','gamma','gammainc','gammaln','legendre','pow2',
            'rat','rats','cart2pol','cart2sph','pol2cart','sph2cart','abs',
            'eval','real','strings','deblank','findstr','lower','strcat',
            'strcmp','strcmpi','strjust','strmatch','strncmp','strrep','strtok',
            'strvcat','symvar','texlabel','upper','char','int2str','mat2str',
            'num2str','sprintf','sscanf','str2double','str2num','bin2dec',
            'dec2bin','dec2hex','hex2dec','hex2num','fclose','fopen','fread',
            'fwrite','fgetl','fgets','fprintf','fscanf','feof','ferror',
            'frewind','fseek','ftell','sprintf','sscanf','dlmread','dlmwrite',
            'hdf','imfinfo','imread','imwrite','textread','wk1read','wk1write',
            'bitand','bitcmp','bitor','bitmax','bitset','bitshift','bitget',
            'bitxor','fieldnames','getfield','rmfield','setfield','struct',
            'struct2cell','class','isa','cell','cellfun','cellstr',
            'cell2struct','celldisp','cellplot','num2cell','cat','flipdim',
            'ind2sub','ipermute','ndgrid','ndims','permute','reshape',
            'shiftdim','squeeze','sub2ind','cond','condeig','det','norm','null',
            'orth','rank','rcond','rref','rrefmovie','subspace','trace','chol',
            'inv','lscov','lu','nnls','pinv','qr','balance','cdf2rdf','eig',
            'gsvd','hess','poly','qz','rsf2csf','schur','svd','expm','funm',
            'logm','sqrtm','qrdelete','qrinsert','bar','barh','hist','hold',
            'loglog','pie','plot','polar','semilogx','semilogy','subplot',
            'bar3','bar3h','comet3','cylinder','fill3','plot3','quiver3',
            'slice','sphere','stem3','waterfall','clabel','datetick','grid',
            'gtext','legend','plotyy','title','xlabel','ylabel','zlabel',
            'contour','contourc','contourf','hidden','meshc','mesh','peaks',
            'surf','surface','surfc','surfl','trimesh','trisurf','coneplot',
            'contourslice','isocaps','isonormals','isosurface','reducepatch',
            'reducevolume','shrinkfaces','smooth3','stream2','stream3',
            'streamline','surf2patch','subvolume','griddata','meshgrid','area',
            'box','comet','compass','errorbar','ezcontour','ezcontourf',
            'ezmesh','ezmeshc','ezplot','ezplot3','ezpolar','ezsurf','ezsurfc',
            'feather','fill','fplot','pareto','pie3','plotmatrix','pcolor',
            'rose','quiver','ribbon','stairs','scatter','scatter3','stem',
            'convhull','delaunay','dsearch','inpolygon','polyarea','tsearch',
            'voronoi','camdolly','camlookat','camorbit','campan','campos',
            'camproj','camroll','camtarget','camup','camva','camzoom','daspect',
            'pbaspect','view','viewmtx','xlim','ylim','zlim','camlight',
            'diffuse','lighting','lightingangle','material','specular',
            'brighten','bwcontr','caxis','colorbar','colorcube','colordef',
            'colormap','graymon','hsv2rgb','rgb2hsv','rgbplot','shading',
            'spinmap','surfnorm','whitebg','autumn','bone','contrast','cool',
            'copper','flag','gray','hot','hsv','jet','lines','prism','spring',
            'summer','winter','orient','print','printopt','saveas','copyobj',
            'findobj','gcbo','gco','get','rotate','ishandle','set','axes',
            'figure','image','light','line','patch','rectangle','surface',
            'text Create','uicontext Create','capture','clc','clf','clg',
            'close','gcf','newplot','refresh','saveas','axis','cla','gca',
            'propedit','reset','rotate3d','selectmoveresize','shg','ginput',
            'zoom','dragrect','drawnow','rbbox','dialog','errordlg','helpdlg',
            'inputdlg','listdlg','msgbox','pagedlg','printdlg','questdlg',
            'uigetfile','uiputfile','uisetcolor','uisetfont','warndlg','menu',
            'menuedit','uicontextmenu','uicontrol','uimenu','dragrect',
            'findfigs','gcbo','rbbox','selectmoveresize','textwrap','uiresume',
            'uiwait Used','waitbar','waitforbuttonpress','convhull','cumprod',
            'cumsum','cumtrapz','delaunay','dsearch','factor','inpolygon','max',
            'mean','median','min','perms','polyarea','primes','prod','sort',
            'sortrows','std','sum','trapz','tsearch','var','voronoi','del2',
            'diff','gradient','corrcoef','cov','conv','conv2','deconv','filter',
            'filter2','abs','angle','cplxpair','fft','fft2','fftshift','ifft',
            'ifft2','ifftn','ifftshift','nextpow2','unwrap','cross','intersect',
            'ismember','setdiff','setxor','union','unique','conv','deconv',
            'poly','polyder','polyeig','polyfit','polyval','polyvalm','residue',
            'roots','griddata','interp1','interp2','interp3','interpft',
            'interpn','meshgrid','ndgrid','spline','dblquad','fmin','fmins',
            'fzero','ode45,','ode113,','ode15s,','ode23s,','ode23t,','ode23tb',
            'odefile','odeget','odeset','quad,','vectorize','spdiags','speye',
            'sprand','sprandn','sprandsym','find','full','sparse','spconvert',
            'nnz','nonzeros','nzmax','spalloc','spfun','spones','colmmd',
            'colperm','dmperm','randperm','symmmd','symrcm','condest','normest',
            'bicg','bicgstab','cgs','cholinc','cholupdate','gmres','luinc',
            'pcg','qmr','qr','qrdelete','qrinsert','qrupdate','eigs','svds',
            'spparms','lin2mu','mu2lin','sound','soundsc','auread','auwrite',
            'wavread','wavwrite',
            //'[Keywords 6]',
            'addpath','doc','docopt','help','helpdesk','helpwin','lasterr',
            'lastwarn','lookfor','partialpath','path','pathtool','profile',
            'profreport','rmpath','type','ver','version','web','what',
            'whatsnew','which','clear','disp','length','load','mlock',
            'munlock','openvar','pack','save','saveas','size','who','whos',
            'workspace','clc','echo','format','home','more','cd','copyfile',
            'delete','diary','dir','edit','fileparts','fullfile','inmem','ls',
            'matlabroot','mkdir','open','pwd','tempdir','tempname','matlabrc',
            'quit'
            )
        ),
    'SYMBOLS' => array(
        '...'
        ),
    'CASE_SENSITIVE' => array(
        GESHI_COMMENTS => false,
        1 => false,
        2 => false,
        //3 => false,
        //4 => false,
        ),
    'STYLES' => array(
        'KEYWORDS' => array(
            1 => 'color: #0000FF;',
            2 => 'color: #0000FF;'
            ),
        'COMMENTS' => array(
            1 => 'color: #228B22;',
            2 => 'color:#A020F0;'
            ),
        'ESCAPE_CHAR' => array(
            0 => ''
            ),
        'BRACKETS' => array(
            0 => 'color: #080;'
            ),
        'STRINGS' => array(
            //0 => 'color: #A020F0;'
            ),
        'NUMBERS' => array(
            0 => 'color: #33f;'
            ),
        'METHODS' => array(
            1 => '',
            2 => ''
            ),
        'SYMBOLS' => array(
            0 => 'color: #080;'
            ),
        'REGEXPS' => array(
            ),
        'SCRIPT' => array(
            0 => ''
            )
        ),
    'URLS' => array(
        1 => '',
        2 => 'http://www.mathworks.com/access/helpdesk/help/techdoc/ref/{FNAMEL}.html',
        3 => '',
        4 => ''
        ),
    'OOLANG' => true,
    'OBJECT_SPLITTERS' => array(
        1 => '.',
        2 => '::'
        ),
    'REGEXPS' => array(
        ),
    'STRICT_MODE_APPLIES' => GESHI_NEVER,
    'SCRIPT_DELIMITERS' => array(
        ),
    'HIGHLIGHT_STRICT_BLOCK' => array(
        )
);

?>
