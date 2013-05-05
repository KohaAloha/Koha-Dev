<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Cities Resident Search Box -->
<div id="header_search">
 <div id="city_search" class="residentsearch">
 <p class="tip">Recherche commune</p>
 <form action="[% script_name %]" method="post">
 <input type="text" name="city_name" value="[% searchfield %]" size="40" />
 <input type="submit" name="submit" value="OK" class="submit" />
 </form>
 </div>

 [% INCLUDE 'patron-search-box.inc' %] [% IF ( CAN_user_catalogue ) %] <div id="catalog_search" class="residentsearch">
 <p class="tip">Entrer les termes de recherche&nbsp;:</p>
 <form action="/cgi-bin/koha/catalogue/search.pl"  method="get" id="cat-search-block">
 <input value="" name="q" type="text" id="search-form" title="Détermine les serveurs Z3950 que vous voulez que Koha interroge." class="form-text" size="40" />
 <input value="Valider" type="submit" class="submit" />
 </form>
 </div>[% END %] <ul>
 <li><a href="#city_search">Recherche commune</a></li>
 [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Prêt</a></li>[% END %] [% IF ( CAN_user_catalogue ) %]<li><a href="#catalog_search">Dans le catalogue</a></li>[% END %] </ul> 
</div>
</div>
<!-- End Cities Resident Search Box -->
