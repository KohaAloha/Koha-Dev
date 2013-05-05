[% IF ( opacuserlogin ) %][% IF ( loggedinusername ) %] <div id="menu">
<ul>
 [% IF ( userview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-user.pl">Mon compte</a></li>
 [% IF ( OPACFinesTab ) %] [% IF ( accountview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-account.pl">Mes amendes</a></li>
 [% END %] [% IF ( userupdateview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-memberentry.pl">Mes informations personnelles</a></li>
 [% IF ( TagsEnabled ) %] [% IF ( tagsview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-tags.pl?mine=1">Mes tags</a></li>
 [% END %] [% IF ( OpacPasswordChange ) %] [% IF ( passwdview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-passwd.pl">Modifier mon mot de passe</a></li>
 [% END %] [% IF ( ShowOpacRecentSearchLink ) %] [% IF ( searchhistoryview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-search-history.pl">Historique de recherche</a></li>
 [% END %] [% IF ( opacreadinghistory ) %] [% IF ( readingrecview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-readingrecord.pl">Mon historique de lecture</a></li>
 [% IF ( OPACPrivacy ) %] [% IF ( privacyview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-privacy.pl">ma vie privée</a></li>
 [% END %] [% END %] [% IF ( suggestion ) %] [% UNLESS ( AnonSuggestions ) %] [% IF ( suggestionsview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-suggestions.pl">Mes suggestions d'achat</a></li>
 [% END %] [% END %] [% IF ( EnhancedMessagingPreferences ) %] [% IF ( messagingview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-messaging.pl">Mes notifications</a></li>
 [% END %] [% IF ( virtualshelves ) %] [% IF ( listsview ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/opac-shelves.pl?display=privateshelves">Mes listes</a></li>
 [% END %] </ul>
</div>
[% END %][% ELSE %][% END %] 