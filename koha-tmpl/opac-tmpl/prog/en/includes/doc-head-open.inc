<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
[% IF ( bidi ) %]<html lang="[% lang %]" xml:lang="[% lang %]" dir="[% bidi %]" xmlns="http://www.w3.org/1999/xhtml">[% ELSE %]<html lang="[% lang %]" xml:lang="[% lang %]" xmlns="http://www.w3.org/1999/xhtml">[% END %]

----------------- doc-open - add js



<script type="text/javascript" src="/opac-tmpl/prog/en/lib/jquery/jquery.js"></script>
<script type="text/javascript" language="javascript">


$(document).ready(function(){



 var site1 = '/ebchaeng.kohaaloha.com/';
 var site2 = '/ebc.kohaaloha.com/';
 var site3 = '/ebchaeng.kohaaloha.com/';

 if (location.href.match(site1) )  {
//    alert( 'chang...........!!!!!!!!!!' );

//    $('#headopacmainuserblock').load('http://' + site1+ '/calyx/ebchang/main.html');

//    $('head').load('http://' + site1+ '/calyx/ebchang/js.js');
    $('head').load('calyx/ebchang/js.js');


  }


});





</script>



<head>
<title>
