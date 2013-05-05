</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="generator" content="Koha [% Version %]" /> <!-- leave this for stats -->
<link rel="shortcut icon" href="[% IF ( OpacFavicon ) %][% OpacFavicon %][% ELSE %][% themelang %]/includes/favicon.ico[% END %]" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="[% themelang %]/lib/jquery/jquery-ui.css" />
[% SET opaclayoutstylesheet='opac.css' UNLESS opaclayoutstylesheet %] [% IF (opaclayoutstylesheet.match('^https?:|^\/')) %]<link rel="stylesheet" type="text/css" href="[% opaclayoutstylesheet %]" />
[% ELSE %] <link rel="stylesheet" type="text/css" href="[% themelang %]/css/[% opaclayoutstylesheet %]" />
[% END %] [% IF ( opaccolorstylesheet ) %] [% IF (opaccolorstylesheet.match('^https?:|^\/')) %] <link rel="stylesheet" type="text/css" href="[% opaccolorstylesheet %]" />
 [% ELSE %] <link rel="stylesheet" type="text/css" href="[% themelang %]/css/[% opaccolorstylesheet %]" />
 [% END %] [% END %] [% IF ( opac_css_override ) %] <link rel="stylesheet" type="text/css" href="[% themelang %]/css/[% opac_css_override %]" />
[% END %] <link rel="stylesheet" type="text/css" media="print" href="[% themelang %]/css/print.css" />
[% IF persona %] <link rel="stylesheet" type="text/css" href="[% themelang %]/css/persona-buttons.css" />
[% END %] [% IF ( OPACMobileUserCSS ) %]<style type="text/css" media="screen and (max-width:700px)">[% OPACMobileUserCSS %]</style>[% END %] [% IF ( bidi ) %]<link rel="stylesheet" type="text/css" href="[% themelang %]/css/right-to-left.css" />
[% END %] [% IF ( OPACUserCSS ) %]<style type="text/css">[% OPACUserCSS %]</style>[% END %]
<!-- yui js --> 
<script type="text/javascript" src="[% yuipath %]/utilities/utilities.js"></script> 
<script type="text/javascript" src="[% yuipath %]/container/container-min.js"></script> 
<script type="text/javascript" src="[% yuipath %]/menu/menu-min.js"></script> 
<script type="text/javascript" src="[% themelang %]/lib/jquery/jquery.js"></script>
<script type="text/javascript" src="[% themelang %]/lib/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="[% themelang %]/lib/jquery/plugins/jquery.hoverIntent.minified.js"></script>
<script type="text/javascript" src="[% themelang %]/js/script.js"></script>
[% IF ( OPACAmazonCoverImages ) %] <script type="text/javascript" language="javascript">//<![CDATA[
		var NO_AMAZON_IMAGE = _("Pas d'image disponible");
	//]]>
</script>
<script type="text/javascript" language="javascript" src="[% themelang %]/js/amazonimages.js"></script>
[% END %] [% IF ( SyndeticsCoverImages ) %]<script type="text/javascript">//<![CDATA[
        var NO_AMAZON_IMAGE = _("Pas d'image disponible");
    //]]>
</script>
<script type="text/javascript" src="[% themelang %]/js/amazonimages.js"></script> [% END %] [% IF ( opacbookbag ) %]<script type="text/javascript" src="[% themelang %]/js/basket.js">
[% ELSIF ( virtualshelves ) %]<script type="text/javascript" src="[% themelang %]/js/basket.js">
[% ELSE %]<script type="text/javascript"> var readCookie;[% END %]
</script>

<script type="text/javascript">
	//<![CDATA[
	var MSG_CONFIRM_AGAIN = _("Warning: Cannot be undone. Please confirm once again")
    var MSG_DELETE_SEARCH_HISTORY = _("Etes-vous sûr de vouloir supprimer votre historique de recherche ?");
    [% IF ( opacbookbag ) %]var MSG_BASKET_EMPTY = _("Votre panier est actuellement vide");
    var MSG_RECORD_IN_BASKET = _("Ce document est déjà dans mon panier");
    var MSG_RECORD_ADDED = _("Ce document a été ajouté à mon panier");
    var MSG_RECORD_REMOVED = _("Ce document a été enlevé à mon panier");
    var MSG_NRECORDS_ADDED = _(" document(s) ajouté(s) à mon panier");
    var MSG_NRECORDS_IN_BASKET = _("Déjà dans mon panier");
    var MSG_NO_RECORD_SELECTED = _("Aucun document sélectionné");
    var MSG_NO_RECORD_ADDED = _("Aucun document ajouté dans votre panier");
    var MSG_CONFIRM_DEL_BASKET = _("Etes-vous sûr de vouloir vider votre panier ?");
    var MSG_CONFIRM_DEL_RECORDS = _("Etes-vous sûr de vouloir enlever les documents sélectionnés ?");
    var MSG_ITEM_IN_CART = _("Dans mon panier");
    var MSG_IN_YOUR_CART = _("Items in your cart: ");
    var MSG_ITEM_NOT_IN_CART = _("Ajouter à mon panier");
    $("#cartDetails").ready(function(){ $("#cmspan").html("<a href=\"#\" id=\"cartmenulink\"><span id=\"carticon\"></span> "+_("Panier")+"<span id=\"basketcount\"><\/span><\/a>"); }); [% ELSE %][% IF ( virtualshelves ) %]
    var MSG_NO_RECORD_SELECTED = _("Aucun document sélectionné");[% END %][% END %]
    [% IF ( opacuserlogin ) %][% IF ( TagsEnabled ) %]var MSG_TAGS_DISABLED = _("Désolé, les tags ne sont pas disponibles sur ce système.");
    var MSG_TAG_ALL_BAD = _("Note : votre tag contenait uniquement du texte interdit. Il n'a PAS été ajouté.");
    var MSG_ILLEGAL_PARAMETER = _("Erreur ! paramètre illégal");
    var MSG_TAG_SCRUBBED = _("Note&nbsp;: votre tag contenait du texte qui a été supprimé. Le tag a été ajouté ");
    var MSG_ADD_TAG_FAILED = _("Erreur ! l'opération d'ajout a échoué");
    var MSG_ADD_TAG_FAILED_NOTE = _("Note : Vous ne pouvez taguer qu'une seule fois un exemplaire avec un terme donné. Allez dans Mes tags afin de voir vos tags.");
    var MSG_DELETE_TAG_FAILED = _("Erreur ! Vous ne pouvez pas supprimer le tag");
    var MSG_DELETE_TAG_FAILED_NOTE = _("Note&nbsp;: vous ne pouvez supprimer que vos propres tags.")
    var MSG_LOGIN_REQUIRED = _("Vous devez être connecté pour ajouter des tags.");
    var MSG_TAGS_ADDED = _("Tags ajoutés : ");
    var MSG_TAGS_DELETED = _("Tags ajoutés : ");
    var MSG_TAGS_ERRORS = _("Erreurs&nbsp;: ");
    var MSG_MULTI_ADD_TAG_FAILED = _("Impossible d'ajouter des tags.");
    var MSG_NO_TAG_SPECIFIED = _("Aucun tag déclaré.");[% END %][% END %]
	[% IF ( OPACAmazonCoverImages ) %]$(window).load(function() {
		 	verify_images();
		 });[% END %]
	[% IF ( SyndeticsCoverImages ) %]$(window).load(function() {
            verify_images();
         });[% END %]
	[% IF ( opacuserjs ) %][% opacuserjs %][% END %]
	//]]>
[% IF ( opacbookbag ) %]</script><script type="text/javascript" src="[% themelang %]/js/basket.js">
[% ELSIF ( virtualshelves ) %]</script><script type="text/javascript" src="[% themelang %]/js/basket.js">
[% ELSE %]</script><script type="text/javascript">var readCookie;[% END %]</script>
[% IF ( opacuserlogin ) %][% IF ( TagsEnabled ) %]<script type="text/javascript" src="[% themelang %]/js/tags.js"></script>[% END %][% ELSE %][% END %] [% IF ( GoogleJackets ) %] <script type="text/javascript" src="[% themelang %]/js/google-jackets.js"></script>
<script type="text/javascript">
	//<![CDATA[
	var NO_GOOGLE_JACKET = _("Pas d'image disponible");
	//]]>
</script>
[% END %] [% IF OpenLibraryCovers %]<script type="text/javascript" src="[% themelang %]/js/openlibrary.js"></script>
<script type="text/javascript">
//<![CDATA[
var NO_OL_JACKET = _("Pas d'image disponible");
//]]>
</script>
[% END %] [% IF OPACLocalCoverImages %]<script type="text/javascript" src="[% themelang %]/js/localcovers.js"></script>
<script type="text/javascript">
//<![CDATA[
var NO_LOCAL_JACKET = _("Pas d'image disponible");
//]]>
</script>
[% END %] [% IF ( BakerTaylorEnabled ) %]<script type="text/javascript" src="[% themelang %]/js/bakertaylorimages.js"></script>
<script type="text/javascript">
	//<![CDATA[
	var NO_BAKERTAYLOR_IMAGE = _("Pas d'image disponible");
	$(window).load(function(){
		bt_verify_images();
	});
	//]]>
</script>[% END %] <link rel="unapi-server" type="application/xml" title="unAPI" href="[% OPACBaseURL %]/cgi-bin/koha/unapi" />
[% IF ( GoogleIndicTransliteration ) %] <script type="text/javascript" src="http://www.google.com/jsapi"></script>
 <script type="text/javascript" src="[% themelang %]/js/googleindictransliteration.js"></script>
[% END %] 