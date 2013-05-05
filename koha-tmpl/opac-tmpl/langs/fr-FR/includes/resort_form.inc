<option value="relevance">Pertinence</option>
<optgroup label="Popularité">
[% IF ( sort_by == "popularity_dsc" ) %] <option value="popularity_dsc" selected="selected">Popularité (plus au moins)</option>[% ELSE %] <option value="popularity_dsc">Popularité (plus au moins)</option>
[% END %] [% IF ( sort_by == "popularity_asc" ) %]<option value="popularity_asc" selected="selected">Popularité (moins au plus)</option>[% ELSE %] <option value="popularity_asc">Popularité (moins au plus)</option>
[% END %] </optgroup>
<optgroup label="Auteur">
[% IF ( sort_by == "author_az" || sort_by == "author_asc" ) %] <option value="author_az" selected="selected">Auteur (A-Z)</option>
[% ELSE %] <option value="author_az">Auteur (A-Z)</option>
[% END %] [% IF ( sort_by == "author_za" || sort_by == "author_dsc" ) %]<option value="author_za" selected="selected">Auteur (Z-A)</option>
[% ELSE %] <option value="author_za">Auteur (Z-A)</option>
[% END %] </optgroup>
<optgroup label="Cote">
[% IF ( sort_by == "call_number_asc" ) %] <option value="call_number_asc" selected="selected">Cote (0-9 puis A-Z)</option>
[% ELSE %] <option value="call_number_asc">Cote (0-9 puis A-Z)</option>
[% END %] [% IF ( sort_by == "call_number_dsc" ) %]<option value="call_number_dsc" selected="selected">Cote (Z-A puis 9-0)</option>
[% ELSE %] <option value="call_number_dsc">Cote (Z-A puis 9-0)</option>
[% END %] </optgroup>
<optgroup label="Dates">
[% IF ( sort_by == "pubdate_dsc" ) %] <option value="pubdate_dsc" selected="selected">Date de publication/copyright&nbsp;: décroissant</option>
[% ELSE %] <option value="pubdate_dsc">Date de publication/copyright&nbsp;: décroissant</option>
[% END %] [% IF ( sort_by == "pubdate_asc" ) %]<option value="pubdate_asc" selected="selected">Date de publication/copyright&nbsp;: croissant</option>
[% ELSE %] <option value="pubdate_asc">Date de publication/copyright&nbsp;: croissant</option>
[% END %] [% IF ( sort_by == "acqdate_dsc" ) %]<option value="acqdate_dsc" selected="selected">Date d'acquisition&nbsp;: décroissante</option>
[% ELSE %] <option value="acqdate_dsc">Date d'acquisition&nbsp;: décroissante</option>
[% END %] [% IF ( sort_by == "acqdate_asc" ) %]<option value="acqdate_asc" selected="selected">Date d'acquisition&nbsp;: croissante</option>
[% ELSE %] <option value="acqdate_asc">Date d'acquisition&nbsp;: croissante</option>
[% END %] </optgroup>
<optgroup label="Titre">
[% IF ( sort_by == "title_az" || sort_by == "title_asc" ) %] <option value="title_az" selected="selected">Titre (A-Z)</option>
[% ELSE %] <option value="title_az">Titre (A-Z)</option>
[% END %] [% IF ( sort_by == "title_za" || sort_by == "title_dsc" ) %]<option value="title_za" selected="selected">Titre (Z-A)</option>
[% ELSE %] <option value="title_za">Titre (Z-A)</option>
[% END %] </optgroup>

