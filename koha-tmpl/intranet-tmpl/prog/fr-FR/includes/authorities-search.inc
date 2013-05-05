<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1>
<!-- Begin Authorities Resident Search Box -->
<script type="text/javascript">
//<![CDATA[
    $(document).ready(function() {
        var searchType = '[% marclist %]';
        if (searchType) {
            if ('mainentry' == searchType) {
                $("#header_search").tabs( "option", "selected", 0 );
            } else if ('match' == searchType) {
                $("#header_search").tabs( "option", "selected", 1 );
            } else if ('all' == searchType) {
                $("#header_search").tabs( "option", "selected", 2 );
            }
        }
    });
//]]>
</script>
<div id="header_search" class="residentsearch">
 <div id="main_heading" class="residentsearch">
 <p class="tip">Enter authorized heading:</p>
 <form action="/cgi-bin/koha/authorities/authorities-home.pl" method="get">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <select name="authtypecode">
 [% IF (marcflavour == 'UNIMARC' ) %]<option value="">All authority types</option>[% END %] [% FOREACH authtypesloo IN authtypesloop %] [% IF ( authtypesloo.selected ) %] <option value="[% authtypesloo.value %]" selected="selected">[% authtypesloo.authtypetext %]</option>
 [% ELSE %] <option value="[% authtypesloo.value %]">[% authtypesloo.authtypetext %]</option>
 [% END %] [% END %] </select>
 <input type="hidden" name="marclist" value="mainentry" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator">
 [% IF ( operator == 'contains' ) %] <option value="contains" selected="selected">contient</option>
 [% ELSE %] <option value="contains">contient</option>
 [% END %] [% IF ( operator == 'start' ) %] <option value="start" selected="selected">Commence par</option>
 [% ELSE %] <option value="start">Commence par</option>
 [% END %] [% IF ( operator == 'is' ) %] <option value="is" selected="selected">est exactement</option>
 [% ELSE %] <option value="is">est exactement</option>
 [% END %] </select>
 <input id="value_mainentry" type="text" name="value" value="[% value %]" />
 <select name="orderby">
 [% IF ( orderby == 'HeadingAsc' ) %] <option value="HeadingAsc" selected="selected">Vedette A-Z</option>
 [% ELSE %] <option value="HeadingAsc">Vedette A-Z</option>
 [% END %] [% IF ( orderby == 'HeadingDsc' ) %] <option value="HeadingDsc" selected="selected">Vedette Z-A</option>
 [% ELSE %] <option value="HeadingDsc">Vedette Z-A</option>
 [% END %] [% IF ( orderby == '' && op ) %] <option value="" selected="selected">Aucun</option>
 [% ELSE %] <option value="">Aucun</option>
 [% END %] </select>
 <input value="Valider" type="submit" class="submit" />
 </form>
 </div>
 <div id="matchheading_search" class="residentsearch">
 <p class="tip">Enter any heading:</p>
 <form action="/cgi-bin/koha/authorities/authorities-home.pl" method="get">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <select  name="authtypecode">
 [% IF (marcflavour == 'UNIMARC' ) %]<option value="">All authority types</option>[% END %] [% FOREACH authtypesloo IN authtypesloop %] [% IF ( authtypesloo.selected ) %] <option value="[% authtypesloo.value %]" selected="selected">[% authtypesloo.authtypetext %]</option>
 [% ELSE %] <option value="[% authtypesloo.value %]">[% authtypesloo.authtypetext %]</option>
 [% END %] [% END %] </select>
 <input type="hidden" name="marclist" value="match" />
 <select name="operator">
 [% IF ( operator == 'contains' ) %] <option value="contains" selected="selected">contient</option>
 [% ELSE %] <option value="contains">contient</option>
 [% END %] [% IF ( operator == 'start' ) %] <option value="start" selected="selected">Commence par</option>
 [% ELSE %] <option value="start">Commence par</option>
 [% END %] [% IF ( operator == 'is' ) %] <option value="is" selected="selected">est exactement</option>
 [% ELSE %] <option value="is">est exactement</option>
 [% END %] </select>
 <input id="value_matchheading" type="text" name="value" value="[% value %]" />
 <select name="orderby">
 [% IF ( orderby == 'HeadingAsc' ) %] <option value="HeadingAsc" selected="selected">Vedette A-Z</option>
 [% ELSE %] <option value="HeadingAsc">Vedette A-Z</option>
 [% END %] [% IF ( orderby == 'HeadingDsc' ) %] <option value="HeadingDsc" selected="selected">Vedette Z-A</option>
 [% ELSE %] <option value="HeadingDsc">Vedette Z-A</option>
 [% END %] [% IF ( orderby == '' && op ) %] <option value="" selected="selected">Aucun</option>
 [% ELSE %] <option value="">Aucun</option>
 [% END %] </select>
 <input value="Valider" type="submit" class="submit" />
 </form>
 </div>
 <div id="all_headings" class="residentsearch">
 <p class="tip">Chercher dans toute l'autorité&nbsp;:</p>
 <form action="/cgi-bin/koha/authorities/authorities-home.pl" method="get">
 <input type="hidden" name="op" value="do_search" />
 <input type="hidden" name="type" value="intranet" />
 <select name="authtypecode">
 [% IF (marcflavour == 'UNIMARC' ) %]<option value="">All authority types</option>[% END %] [% FOREACH authtypesloo IN authtypesloop %] [% IF ( authtypesloo.selected ) %] <option value="[% authtypesloo.value %]" selected="selected">[% authtypesloo.authtypetext %]</option>
 [% ELSE %] <option value="[% authtypesloo.value %]">[% authtypesloo.authtypetext %]</option>
 [% END %] [% END %] </select>
 <input type="hidden" name="marclist" value="all" />
 <input type="hidden" name="and_or" value="and" />
 <input type="hidden" name="excluding" value="" />
 <select name="operator">
 [% IF ( operator == 'contains' ) %] <option value="contains" selected="selected">contient</option>
 [% ELSE %] <option value="contains">contient</option>
 [% END %] [% IF ( operator == 'start' ) %] <option value="start" selected="selected">Commence par</option>
 [% ELSE %] <option value="start">Commence par</option>
 [% END %] [% IF ( operator == 'is' ) %] <option value="is" selected="selected">est exactement</option>
 [% ELSE %] <option value="is">est exactement</option>
 [% END %] </select>
 <input id="value_anywhere" type="text" name="value" value="[% value %]" />
 <select name="orderby">
 [% IF ( orderby == 'HeadingAsc' ) %] <option value="HeadingAsc" selected="selected">Vedette A-Z</option>
 [% ELSE %] <option value="HeadingAsc">Vedette A-Z</option>
 [% END %] [% IF ( orderby == 'HeadingDsc' ) %] <option value="HeadingDsc" selected="selected">Vedette Z-A</option>
 [% ELSE %] <option value="HeadingDsc">Vedette Z-A</option>
 [% END %] [% IF ( orderby == '' && op ) %] <option value="" selected="selected">Aucun</option>
 [% ELSE %] <option value="">Aucun</option>
 [% END %] </select>
 <input value="Valider" type="submit" class="submit" />
 </form>
 </div>
 <ul>
 <li><a href="#main_heading">Recherche vedette</a></li>
 <li><a href="#matchheading_search">Rechercher toutes les Vedettes</a></li>
 <li><a href="#all_headings">Keyword search</a></li>
 </ul>
</div><!-- /header_search -->
</div><!-- /gradient -->
<!-- End Authorities Resident Search Box -->
