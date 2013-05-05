<select class="advsearch" name="idx">
 <option value="kw">Tous les mots</option>
 <option value="au">Auteur</option>
 <option value="au,phr">&nbsp;&nbsp;&nbsp;&nbsp; Auteur (expression)</option>
 <option value="cpn">&nbsp;&nbsp;&nbsp;&nbsp; Auteur collectivité</option>
 <option value="cfn">&nbsp;&nbsp;&nbsp;&nbsp; Nom de congrès</option>
 <option value="cpn,phr">&nbsp;&nbsp;&nbsp;&nbsp; Collectivité auteur (expression)</option>
 <option value="cfn,phr">&nbsp;&nbsp;&nbsp;&nbsp; Nom de congrès (expression)</option>
 <option value="pn"> &nbsp;&nbsp;&nbsp;&nbsp; Nom de personne</option>
 <option value="pn,phr">&nbsp;&nbsp;&nbsp;&nbsp; Nom de personne (expression)</option>
 <option value="ti">Titre</option>
 <option value="ti,phr">&nbsp;&nbsp;&nbsp;&nbsp;Titre (expression)</option>
 <option value="se">&nbsp;&nbsp;&nbsp;&nbsp; Titre de collection</option>
 <option value="su">Sujet</option>
 <option value="su,phr">&nbsp;&nbsp;&nbsp;&nbsp; Sujet (expression)</option>
 [% IF ( expanded_options ) %] <option value="su-br">&nbsp;&nbsp;&nbsp;&nbsp; Subject and broader terms</option>
 <option value="su-na">&nbsp;&nbsp;&nbsp;&nbsp; Subject and narrower terms</option>
 <option value="su-rl">&nbsp;&nbsp;&nbsp;&nbsp; Subject and related terms</option>
 [% END %] <option value="bc">Code à barres</option>
 <option value="location">Etagère</option>
 [% IF (numbersphr) %] <option value="sn,phr">Standard number</option>
 [% ELSE %] <option value="sn">Standard number</option>
 [% END %] <option value="nb">&nbsp;&nbsp;&nbsp;&nbsp; ISBN</option>
 <option value="ns">&nbsp;&nbsp;&nbsp;&nbsp; ISSN</option>
 [% IF (numbersphr) %] <option value="callnum,phr">&nbsp;&nbsp;&nbsp;&nbsp; Cote</option>
 [% ELSE %] <option value="callnum">&nbsp;&nbsp;&nbsp;&nbsp; Cote</option>
 [% END %] <option value="ln,rtrn">Language</option>
 <option value="nt">Notes</option>
 [% IF (marcflavour != 'UNIMARC' ) %] <option value="curriculum">Curriculum</option>
 [% END %] <option value="pb">Editeur</option>
 <option value="pl">Lieu de publication</option>
 <option value="yr">Date de publication (aaaa)</option>
 <option value="acqdate">Date d'acquisition (aaaa-mm-jj)</option>
</select>
