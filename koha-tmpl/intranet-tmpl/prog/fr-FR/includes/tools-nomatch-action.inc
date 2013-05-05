 <select name="nomatch_action" id="nomatch_action">
 [% IF ( nomatch_action_create_new ) %] <option value="create_new" selected="selected">
 [% ELSE %] <option value="create_new">
 [% END %] Ajouter la notice importée</option>
 [% IF ( nomatch_action_ignore ) %] <option value="ignore" selected="selected">
 [% ELSE %] <option value="ignore">
 [% END %] Ignorer les enregistrements importés (les exemplaires peuvent être traités)</option>
 </select>
