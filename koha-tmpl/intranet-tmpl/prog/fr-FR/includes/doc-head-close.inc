<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="[% IF ( IntranetFavicon ) %][% IntranetFavicon %][% ELSE %][% themelang %]/includes/favicon.ico[% END %]" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="[% interface %]/lib/jquery/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="[% interface %]/lib/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" media="print" href="[% themelang %]/css/print.css" />
[% IF ( intranetstylesheet ) %] <link rel="stylesheet" type="text/css" href="[% intranetstylesheet %]" />
[% ELSE %] <link rel="stylesheet" type="text/css" href="[% themelang %]/css/staff-global.css" />
[% END %] [% IF ( bidi ) %] <link rel="stylesheet" type="text/css" href="[% themelang %]/css/right-to-left.css" />
[% END %] [% IF ( IntranetUserCSS ) %]<style type="text/css">[% IntranetUserCSS %]</style>[% END %] <script type="text/javascript" src="[% interface %]/lib/jquery/jquery.js"></script>
<script type="text/javascript" src="[% interface %]/lib/jquery/jquery-ui.js"></script>
<script type="text/javascript" src="[% interface %]/lib/jquery/plugins/jquery.hotkeys.min.js"></script>
<script type="text/javascript" src="[% interface %]/lib/jquery/plugins/jquery.cookie.min.js"></script>
<script type="text/javascript" src="[% interface %]/lib/jquery/plugins/jquery.highlight-3.js"></script>
<script type="text/javascript" src="[% interface %]/lib/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="[% interface %]/lib/jquery/plugins/jquery.validate.min.js"></script>

[% IF ( login ) %] <link rel="stylesheet" type="text/css" href="[% themelang %]/css/login.css" />
[% END %] [% IF ( wizard ) %] <link rel="stylesheet" type="text/css" href="[% themelang %]/css/wizard.css" />
[% END %]

<!-- local colors -->
[% IF ( intranetcolorstylesheet ) %]
 <link rel="stylesheet" type="text/css" href="[% themelang %]/css/[% intranetcolorstylesheet %]" />
[% END %]

<!-- yui js --> 
<script type="text/javascript" src="[% yuipath %]/utilities/utilities.js"></script> 
<script type="text/javascript" src="[% yuipath %]/button/button-min.js"></script> 
<script type="text/javascript" src="[% yuipath %]/container/container_core-min.js"></script> 
<script type="text/javascript" src="[% yuipath %]/menu/menu-min.js"></script> 

<!-- koha core js -->
<script type="text/javascript" src="[% themelang %]/js/staff-global.js"></script>
[% INCLUDE 'validator-strings.inc' %] [% IF ( intranetuserjs ) %] <script type="text/javascript">
    //<![CDATA[
    [% intranetuserjs %]
    //]]>
    </script>
[% END %] [% IF ( virtualshelves || intranetbookbag ) %] <script type="text/javascript">
    //<![CDATA[
        var MSG_BASKET_EMPTY = _("Votre panier est vide");
        var MSG_RECORD_IN_BASKET = _("Ce document est déjà dans votre panier");
        var MSG_RECORD_ADDED = _("Document ajouté au panier");
        var MSG_NRECORDS_ADDED = _(" document(s) ajouté(s) au panier");
        var MSG_NRECORDS_IN_BASKET = _("already in your cart");
        var MSG_NO_RECORD_SELECTED = _("Aucun élément sélectionné");
        var MSG_NO_RECORD_ADDED = _("Aucun document ajouté au panier");
        var MSG_CONFIRM_DEL_BASKET = _("Êtes vous sûr de vouloir vider votre panier ?");
        var MSG_CONFIRM_DEL_RECORDS = _("Êtes vous sûr de vouloir supprimer les exemplaires sélectionnés ?");
        var MSG_IN_YOUR_CART = _("Items in your cart: ");
        var MSG_NON_RESERVES_SELECTED = _("Un ou plusieurs exemplaires sélectionnés ne peuvent être réservé.");
    //]]>
    </script>
<script type="text/javascript" src="[% themelang %]/js/basket.js"></script>
[% END %] [% IF LocalCoverImages %] <script type="text/javascript" src="[% themelang %]/js/localcovers.js"></script>
<script type="text/javascript">
//<![CDATA[
var NO_LOCAL_JACKET = _("Pas d'image de couverture disponible ");
//]]>
</script>
[% END %] 