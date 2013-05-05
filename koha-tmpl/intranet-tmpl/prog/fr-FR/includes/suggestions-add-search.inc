<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Suggestions Resident Search Box -->
<div id="header_search">
 <div id="suggestions_search" class="residentsearch">
 <p class="tip">Rechercher suggestions :</p>
 <form action="/cgi-bin/koha/acqui/newordersuggestion.pl" method="get">
 <input type="hidden" name="booksellerid" value="[% booksellerid %]" />
 <label for="searchtitle">Titre&nbsp;:</label> <input type="text" id="searchtitle" name="title" size="10" value="[% title %]" />
 <label for="searchauthor">Auteur&nbsp;:</label> <input type="text" id="searchauthor" name="author" size="10" value="[% author %]" />
 <label for="searchpublishercode">Editeur&nbsp;:</label> <input type="text" id="searchpublishercode" name="publishercode" size="10" value="[% publishercode %]" />
 <input value="Rechercher" type="submit" class="submit" />
 </form>
 </div>

 [% INCLUDE 'patron-search-box.inc' %] [% IF ( CAN_user_catalogue ) %] <div id="catalog_search" class="residentsearch">
 <p class="tip">Entrer les termes de recherche&nbsp;:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input value="" name="q" type="text" id="search-form" title="Détermine les serveurs Z3950 que vous voulez que Koha interroge." class="form-text" size="40" />
 <input value="Valider" type="submit" class="submit" />
 </form>
 </div>
 [% END %] <ul>
 <li><a href="#suggestions_search">Recherche suggestions</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Prêt</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Dans le catalogue</a></li>[% END %] </ul>
</div>
</div><!-- /gradient -->
<!-- End Suggestions Resident Search Box -->
