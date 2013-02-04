//get host from url
var pathArray = location.host.split( '.' );
var host = pathArray[0];

// delete, then load logo

//$('#libraryname').remove();
//$('#opac-main-search').prepend().load('/calyx/'+ host +'/logo.html');

$('#libraryname').load('/calyx/'+ host +'/logo.html');

// change color
$('#opac-main-search').load('/calyx/'+ host +'/logo.html');


// remove date
//$('#news i').load('/calyx/'+ host +'/logo.html');

// remove translate



// load favicon
$('link[type="image/x-icon"]').remove();  
$('<link id="favicon" type="image/x-icon" rel="shortcut icon" href="/calyx/' + host + '/favicon.ico"/>').appendTo('head');

// load header
$('#members').after('<div id="calyx-header"></div>')
$('#calyx-header').load('/calyx/'+ host +'/header.html');

// load footer
$('.yui-t1 .ft').remove();
$('#bd').after('<div id="calyx-ft" class=".ft"></div>')
$('#calyx-ft').load('/calyx/'+ host +'/footer.html');


// load sidebar
//$('#opacnav').remove();
//$('.yui-b:last').prepend('<div id="opacnav" class="container"></div>')
//$('#opacnav').load('/calyx/'+ host +'/opacnav.html');

// load sidebar
//$('#opacnav').remove();
//$('.yui-b:last').prepend('<div id="opacnav" class="container"></div>')
$('#opacnav').load('/calyx/'+ host +'/opacnav.html');

//  <div style="display: none;">DONT DELETE ME</div> | 


// load opacmain
//$('#opacmainuserblock').remove();
//$('.yui-u:first').prepend().load('/calyx/'+ host +'/main.html');

// load bottomnav
$('#menu').after('<div id="bottomnav"></div>')
$('#bottomnav').load('/calyx/'+ host +'/bottomnav.html');


