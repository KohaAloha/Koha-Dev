 <select name="overlay_action" id="overlay_action">
 [% IF ( overlay_action_replace ) %] <option value="replace"  selected="selected">
 [% ELSE %] <option value="replace">
 [% END %] Remplace la notice existante avec une notice entrante</option>
 [% IF ( overlay_action_create_new ) %] <option value="create_new" selected="selected">
 [% ELSE %] <option value="create_new">
 [% END %] Ajouter la notice importée</option>
 [% IF ( overlay_action_ignore ) %] <option value="ignore" selected="selected">
 [% ELSE %] <option value="ignore">
 [% END %] Ignorer les enregistrements importés (les exemplaires peuvent être traités)</option>
 </select>
