<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Patrons Resident Search Box -->
<div id="header_search">
 <div id="patron_search" class="residentsearch">
 <p class="tip">Entrer le n° de carte d'adhérent ou une partie du nom&nbsp;: </p>
 <form action="/cgi-bin/koha/members/member.pl" method="post">
 <input id="searchmember" size="25" class="focus" name="member" type="text" value="[% member %]"/>
 <span class="filteraction" id="filteraction_off"> <a href="#" onclick="$('#filters').toggle();$('.filteraction').toggle();">[-]</a></span>
 <span class="filteraction" id="filteraction_on"> <a href="#" onclick="$('#filters').toggle();$('.filteraction').toggle();">[+]</a></span>


 <input value="Rechercher" class="submit" type="submit" />

 <div id="filters">
 <p><label for="searchfields">Champs de recherche:</label>
 <select name="searchfields" id="searchfields">
 <option selected="selected" value=''>Standard</option>
 <option value='email,emailpro,B_email,'>Courriel</option>
 <option value='borrowernumber'>N° d'adhérent</option>
 <option value='phone,phonepro,B_phone,altcontactphone,mobile'>Numéro de téléphone</option>
 <option value='streettype,address,address2,city,state,zipcode,country'>Street Address</option>
 </select></p>
 <p><label for="searchtype">Search type:</label>
 <select name="searchtype" id="searchtype">
 <option selected="selected" value=''>Starts with</option>
 <option value='contain'>Contains</option>
 </select></p>

 <p><label for="searchorderby">Trié par</label>
 <select name="orderby" id="searchorderby">
 <option value="">Surname, Firstname</option>
 <option value="cardnumber,0">Numéro de carte</option>
 </select></p>
 [% IF ( branchloop ) %] <p><label for="branchcode">Library: </label><select name="branchcode" id="branchcode">
 <option value="">Tous</option>[% FOREACH branchloo IN branchloop %] [% IF ( branchloo.selected ) %] <option value="[% branchloo.value %]" selected="selected">[% branchloo.branchname %]</option>[% ELSE %] <option value="[% branchloo.value %]">[% branchloo.branchname %]</option>[% END %] [% END %]</select></p>
 [% END %] [% IF ( categories ) %] <p><label for="categorycode">Catégorie&nbsp;: </label><select name="categorycode" id="categorycode">
 <option value="">Tous</option>[% FOREACH categorie IN categories %] [% IF ( categorie.selected ) %] <option value="[% categorie.categorycode %]" selected="selected">[% categorie.description %]</option>[% ELSE %] <option value="[% categorie.categorycode %]">[% categorie.description %]</option>[% END %] [% END %]</select></p>
 [% END %] </div>
</form>
 </div>

 [% INCLUDE 'patron-search-box.inc' %] [% IF ( CAN_user_catalogue ) %] <div id="catalog_search" class="residentsearch">
 <p class="tip">Entrer les termes de recherche&nbsp;:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input value="" name="q" type="text" id="search-form" title="Détermine les serveurs Z3950 que vous voulez que Koha interroge." class="form-text" size="40" />
 <input value="Valider" name="op" type="submit" id="opac-submit" class="submit" />
 </form>
 </div>[% END %] [% IF ( CAN_user_circulate ) %] <div id="checkin_search" class="residentsearch">
 <p class="tip">Scanner un code-barres pour le retour</p>
 <form method="post" action="/cgi-bin/koha/circ/returns.pl" autocomplete="off">
 <input name="barcode" id="ret_barcode" size="40" accesskey="r" />
 <input value="Valider" class="submit" type="submit" />
 </form>
 </div>
 [% END %] <ul>
 <li><a href="#patron_search">Recherche adhérents</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Prêt</a></li>[% END %] [% IF ( CAN_user_circulate ) %]<li><a href="#checkin_search">Retour</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Dans le catalogue</a></li>[% END %] </ul>
</div><!-- /header_search -->
</div><!-- /gradient -->
<script type="text/javascript">//<![CDATA[
$(document).ready(function() {
    [% IF ( advsearch ) %]$("#filteraction_on").toggle();
    [% ELSE %]$("#filters").toggle();
    $("#filteraction_off").toggle();[% END %]
});
//]]>
</script>
<!-- End Patrons Resident Search Box -->
