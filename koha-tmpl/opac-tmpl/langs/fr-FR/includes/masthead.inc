<div id="header-wrapper"><div id="members">
 [% IF ( opacuserlogin ) %] <ul>
[% UNLESS ( loggedinusername ) %] <li><a href="/cgi-bin/koha/opac-user.pl">Me connecter</a></li>[% END %] [% IF ( loggedinusername ) %]<li><span class="members">Bienvenue, <a href="/cgi-bin/koha/opac-user.pl"><span class="loggedinusername">[% FOREACH USER_INF IN USER_INFO %][% USER_INF.title %] [% USER_INF.firstname %] [% USER_INF.surname %][% END %]</span></a></span></li>

 [% END %] [% IF ( ShowOpacRecentSearchLink ) %]<li><a href="/cgi-bin/koha/opac-search-history.pl" title="Voir mon historique de recherche">Mon historique de recherche</a> [<a href="/cgi-bin/koha/opac-search-history.pl?action=delete" class="logout" title="Supprimer votre historique de recherche" onclick="return confirm(MSG_DELETE_SEARCH_HISTORY);">x</a>]</li>
 [% END %] [% IF ( loggedinusername ) %]<li>[% IF persona %]<a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1" onclick='navigator.id.logout();'>[% ELSE %]<a class="logout" id="logout" href="/cgi-bin/koha/opac-main.pl?logout.x=1">[% END %]Log Out</a></li>[% END %] </ul> 
 [% END %] </div>
 [% IF ( opacheader ) %] [% opacheader %] [% END %] <div id="opac-main-search" class="yui-g">
 [% IF ( opacsmallimage ) %] <h1 id="libraryname" style="background-image: url('[% opacsmallimage %]');">
 [% ELSE %] <h1 id="libraryname">
 [% END %]<a href="/cgi-bin/koha/opac-main.pl">[% IF ( LibraryName ) %][% LibraryName %][% ELSE %]Catalogue en-ligne Koha[% END %]</a></h1>

<div id="fluid">

[% IF ( OpacPublic ) %] <div id="fluid-offset">
[% UNLESS ( advsearch ) %]<form name="searchform" method="get" action="/cgi-bin/koha/opac-search.pl" id="searchform">
 <label for="masthead_search" class="left"> Chercher [% UNLESS ( OpacAddMastheadLibraryPulldown ) %] [% IF ( mylibraryfirst ) %] (dans [% mylibraryfirst %] uniquement)[% END %] [% END %] </label>

 <select name="idx" id="masthead_search" class="left">
 [% IF ( ms_kw ) %] <option selected="selected" value="">Tous les mots</option>
 [% ELSE %] <option value="">Tous les mots</option>
 [% END %] [% IF ( ms_ti ) %]<option selected="selected" value="ti">Titre</option>
 [% ELSE %] <option value="ti">Titre</option>
 [% END %] [% IF ( ms_au ) %]<option selected="selected" value="au">Auteur</option>
 [% ELSE %] <option value="au">Auteur</option>
 [% END %] [% IF ( ms_su ) %]<option selected="selected" value="su">Sujet</option>
 [% ELSE %] <option value="su">Sujet</option>
 [% END %] [% IF ( ms_nb ) %]<option selected="selected" value="nb">ISBN</option>
 [% ELSE %] <option value="nb">ISBN</option>
 [% END %] [% IF ( ms_se ) %]<option selected="selected" value="se">Collections</option>
 [% ELSE %] <option value="se">Collections</option>
 [% END %] [% IF ( numbersphr ) %] [% IF ( ms_callnum ) %] <option selected="selected" value="callnum,phr">Cote</option>
 [% ELSE %] <option value="callnum,phr">Cote</option>
 [% END %] [% ELSE %] [% IF ( ms_callnum ) %] <option selected="selected" value="callnum">Cote</option>
 [% ELSE %] <option value="callnum">Cote</option>
 [% END %] [% END %]</select>
[% IF ( ms_value ) %] <input type="text" title="Type search term" id = "transl1" name="q" value="[% ms_value |html %]" class="left" style="width: 35%; font-size: 111%;"/><div id="translControl"></div>
[% ELSE %] <input type="text" title="Type search term" id = "transl1" name="q" class="left" style="width: 35%; font-size: 111%;"/><div id="translControl"></div>
[% END %] [% IF ( OpacAddMastheadLibraryPulldown ) %]<select name="branch_group_limit" id="select_library" class="left">
 <option value="">Tous sites</option>
 <optgroup label="Libraries">
 [% FOREACH BranchesLoo IN BranchesLoop %] [% IF ( BranchesLoo.selected ) %]<option selected="selected" value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>
 [% ELSE %]<option value="branch:[% BranchesLoo.value %]">[% BranchesLoo.branchname %]</option>[% END %] [% END %]</optgroup>
 [% IF BranchCategoriesLoop %] <optgroup label="Groups">
 [% FOREACH bc IN BranchCategoriesLoop %] [% IF ( bc.selected ) %]<option selected="selected" value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
 [% ELSE %] <option value="multibranchlimit-[% bc.categorycode %]">[% bc.categoryname %]</option>
 [% END %] [% END %]</optgroup>
 [% END %] </select>
 [% ELSE %] [% IF ( opac_limit_override ) %] [% IF ( opac_search_limit ) %] <input name="limit" value="[% opac_search_limit %]" type="hidden" />
 [% END %] [% ELSE %] [% IF ( mylibraryfirst ) %] <input name="limit" value="branch:[% mylibraryfirst %]" type="hidden" />
 [% END %] [% END %] [% END %] <input value="Aller" type="submit" id="searchsubmit" class="left" />
[% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %] [% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink">Listes</a>[% END %] </form>
[% ELSE %] <div style="width:80%;*margin-bottom:-30px;">
[% IF ( virtualshelves ) %]<a href="/cgi-bin/koha/opac-shelves.pl" id="listsmenulink">Listes</a>[% END %][% IF ( opacbookbag ) %]<span id="cmspan"></span>[% END %] </div>
[% END %] <div id="moresearches">
<a href="/cgi-bin/koha/opac-search.pl">Recherche avancée</a>
[% IF ( OpacBrowser ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-browser.pl">Parcourir par hiérarchie</a>[% END %] [% IF ( OpacAuthorities ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-authorities-home.pl">Authority search</a>[% END %] [% IF ( opacuserlogin && reviewson && OpacShowRecentComments ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-showreviews.pl">Commentaires récents</a>[% END %] [% IF ( TagsEnabled ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags.pl">Nuage de Tags</a>[% END %] [% IF ( OpacCloud ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-tags_subject.pl">Nuage de sujets</a>[% END %] [% IF ( OpacTopissue ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-topissues.pl">Les plus populaires</a>[% END %] [% IF ( suggestion ) %] [% IF ( AnonSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Suggestions d'achat</a>
 [% ELSIF ( OPACViewOthersSuggestions ) %]<span class="pipe"> | </span><a href="/cgi-bin/koha/opac-suggestions.pl">Suggestions d'achat</a>
 [% END %] [% END %]</div>
 </div>
</div>

[% END %] <!-- OpacPublic --> 

[% IF ( opacbookbag ) %]<div id="cartDetails">Votre panier est vide.</div>[% END %] [% IF ( virtualshelves ) %]<div id="listsmenu" class="yuimenu" style="display: none">
 <div class="bd">
 <h4>Mes listes publiques</h4>
 [% IF ( pubshelves ) %] <ul class="first-of-type">
 [% FOREACH pubshelvesloo IN pubshelvesloop %] <li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% pubshelvesloo.shelfnumber %]&amp;sortfield=[% pubshelvesloo.sortfield %]">[% pubshelvesloo.shelfname |html %]</a></li>
 [% END %] <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=publicshelves">[Voir tout]</a></li>
 </ul>
 [% ELSE %] Pas de liste publique [% END %] [% IF ( opacuserlogin ) %] <h4>Mes listes</h4>
 [% IF ( loggedinusername ) %] [% IF ( barshelves ) %]<ul class="first-of-type">
 [% FOREACH barshelvesloo IN barshelvesloop %] <li class="yuimenuitem"><a href="/cgi-bin/koha/opac-shelves.pl?viewshelf=[% barshelvesloo.shelfnumber %]&amp;sortfield=[% barshelvesloo.sortfield %]">[% barshelvesloo.shelfname |html %]</a></li>
 [% END %] <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[Voir tout]</a></li>
 </ul>
 [% ELSE %] <ul class="first-of-type">
 <li>Pas de liste privée</li>
 <li class="yuimenuitem"><a class="yuimenuitemlabel" href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">[Ajouter une liste]</a></li></ul>
 [% END %] [% ELSE %]<ul class="first-of-type"><li><a href="/cgi-bin/koha/opac-user.pl">Identifiez-vous pour créer vos listes personnelles</a></li></ul>
 [% END %] [% END %]</div>
</div><!-- /listmenu /virtualshelves -->
[% END %]
<div id="listsDetails"></div>
</div>
</div>
<div id="breadcrumbs" class="yui-g">
[% IF ( searchdesc ) %]<p>[% IF ( total ) %]<strong>Votre a retournée [% total |html %] résultats.</strong> [% IF ( related ) %] (recherches apparentées : [% FOREACH relate IN related %][% relate.related_search %][% END %]). [% END %] <a href="[% OPACBaseURL %]/cgi-bin/koha/opac-search.pl?[% query_cgi |html |url %][% limit_cgi |html | url %]&amp;count=[% countrss |html %]&amp;sort_by=acqdate_dsc&amp;format=rss2" class="rsssearchlink"><img alt="S'abonner à cette recherche" src="/opac-tmpl/prog/images/feed-icon-16x16.png" title="S'abonner à cette recherche" class="rsssearchicon" /></a>
[% ELSE %] <strong>Pas de réponse !</strong>
<p>
 [% IF ( searchdesc ) %] Pas de réponse trouvée dans le catalogue [% LibraryName %].<a href="[% OPACBaseURL %]/cgi-bin/koha/opac-search.pl?[% query_cgi | html | url %][% limit_cgi | html | url %]&amp;format=rss2" class="rsssearchlink"><img alt="S'abonner à cette recherche" src="/opac-tmpl/prog/images/feed-icon-16x16.png" title="S'abonner à cette recherche" class="rsssearchicon" border="0" /></a>
 [% ELSE %] Vous n'avez précisé aucun critère de recherche. [% END %] </p>
[% IF ( OPACNoResultsFound ) %] <div id="noresultsfound">
[% OPACNoResultsFound %] </div>
[% END %] </div>
[% END %]</p>[% END %]</div>
