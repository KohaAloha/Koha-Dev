//get host from url
var pathArray = location.host.split( '.' );
var host = pathArray[0];

// load opacmain


$('#opacmainuserblock').remove();
$('.yui-u:first').prepend().load('/calyx/'+ host +'/main.html');

// delete, then load logo

$('#libraryname').remove();
$('#opac-main-search').prepend().load('/calyx/'+ host +'/logo.html');


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

