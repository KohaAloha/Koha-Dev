[% IF ( opacfacets ) %] [% IF ( facets_loop ) %]<div id="search-facets">
<h4>Affinez votre recherche</h4>
<ul>
 <li id="availability_facet">Disponibilité<ul><li>[% IF ( available ) %]Montrer seulement <strong>en rayon</strong> exemplaires. <a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi_not_availablity %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html%][% END %]">Montrer tous les documents</a>[% ELSE %]Limiter aux <a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html%][% END %]&amp;limit=available">exemplaires disponibles.</a>[% END %]</li></ul>
 [% IF ( related ) %] <li>(Recherches apparentées&nbsp;: [% FOREACH relate IN related %][% relate.related_search %][% END %])</li>[% END %] </li>
 
[% FOREACH facets_loo IN facets_loop %] <li id="[% facets_loo.type_id %]">
[% IF ( facets_loo.type_label_Authors ) %]Authors[% END %]
[% IF ( facets_loo.type_label_Titles ) %]Titles[% END %]
[% IF ( facets_loo.type_label_Topics ) %]Topics[% END %]
[% IF ( facets_loo.type_label_Places ) %]Places[% END %]
[% IF ( facets_loo.type_label_Series ) %]Series[% END %]
[% IF ( facets_loo.type_label_ItemTypes ) %]Item types[% END %]
[% UNLESS ( singleBranchMode ) %]
[% IF ( facets_loo.type_label_Libraries ) %]Libraries[% END %]
[% END %]
[% IF ( facets_loo.type_label_Location ) %]Locations[% END %]
<ul>
 [% FOREACH facet IN facets_loo.facets %]<li><a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html %][% END %]&amp;limit=[% facet.type_link_value %]:[% facet.facet_link_value %]" title="[% facet.facet_title_value |html %]">[% facet.facet_label_value %]</a> [% IF ( displayFacetCount ) %]([% facet.facet_count %])[% END %]</li>[% END %][% IF ( facets_loo.expandable ) %] <li class="showmore"><a href="/cgi-bin/koha/opac-search.pl?[% query_cgi |html %][% limit_cgi |html %][% IF ( sort_by ) %]&amp;sort_by=[% sort_by |html %][% END %][% IF ( offset ) %]&amp;offset=[% offset %][% END %]&amp;expand=[% facets_loo.expand %]#[% facets_loo.type_id %]">En voir plus</a></li>
[% END %] </ul></li>
[% END %] </ul>
</div>
[% IF ( OPACResultsSidebar ) %] <div id="opacresultssidebar">
[% OPACResultsSidebar %] </div>
[% END %] [% END %] [% END %] 