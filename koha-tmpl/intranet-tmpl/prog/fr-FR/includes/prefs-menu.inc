<div id="menu">
<ul>
[% IF ( acquisitions ) %]<li class="active">[% ELSE %]<li>[% END %]<a title="Acquisitions" href="/cgi-bin/koha/admin/preferences.pl?tab=acquisitions">Acquisitions</a></li>
[% IF ( admin ) %]<li class="active">[% ELSE %]<li>[% END %]<a title="Administration" href="/cgi-bin/koha/admin/preferences.pl?tab=admin">Administration</a></li>
[% IF ( authorities ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=authorities" title="Contrôle des autorités">Autorités</a></li>
[% IF ( cataloguing ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=cataloguing" title="Catalogage">Catalogage</a></li>
[% IF ( circulation ) %]<li class="active">[% ELSE %]<li>[% END %]<a title="Circulation" href="/cgi-bin/koha/admin/preferences.pl?tab=circulation">Circulation</a></li>
[% IF ( creators ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=creators" title="Créateurs">Créateurs</a></li>
[% IF ( enhanced_content ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=enhanced_content" title="Paramétrage des contenus enrichis">Contenu enrichi</a></li>
[% IF ( i18n_l10n ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=i18n_l10n" title="Internationalisation et localisation">International</a></li>
[% IF ( local_use ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/systempreferences.pl">Local use</a></li>
[% IF ( logs ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=logs" title="Logs">Logs</a></li>
[% IF ( opac ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=opac" title="Catalogue Public en Ligne (OPAC)">OPAC</a></li>
[% IF ( patrons ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=patrons" title="Adhérents">Adhérents</a></li>
[% IF ( searching ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=searching" title="Recherche">Recherche</a></li>
[% IF ( serials ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=serials" title="Périodiques">Périodiques</a></li>
[% IF ( staff_client ) %]<li class="active">[% ELSE %]<li>[% END %]<a title="Staff client" href="/cgi-bin/koha/admin/preferences.pl?tab=staff_client">Staff client</a></li>
[% IF ( web_services ) %]<li class="active">[% ELSE %]<li>[% END %]<a href="/cgi-bin/koha/admin/preferences.pl?tab=web_services" title="Web Services">Web Services</a></li>
</ul>
</div>
