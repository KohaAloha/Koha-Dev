 <select name="item_action" id="item_action">
 [% IF ( item_action_always_add ) %] <option value="always_add" selected="selected">
 [% ELSE %] <option value="always_add">
 [% END %] Toujours ajouter les exemplaires</option>
 [% IF ( item_action_add_only_for_matches ) %] <option value="add_only_for_matches" selected="selected">
 [% ELSE %] <option value="add_only_for_matches">
 [% END %] Ajouter les exemplaires seulement si une notice biblio concordante a été trouvée</option>
 [% IF ( item_action_add_only_for_new ) %] <option value="add_only_for_new" selected="selected">
 [% ELSE %] <option value="add_only_for_new">
 [% END %] Ajouter les exemplaires seulement si aucune notice biblio concordante n'a été trouvée</option>
 [% IF ( item_action_ignore ) %] <option value="ignore" selected="selected">
 [% ELSE %] <option value="ignore">
 [% END %] Ignorer les exemplaires</option>
 </select>
