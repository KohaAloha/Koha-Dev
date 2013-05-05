[% IF ( error ) %] <script type='text/javascript'>
// Gratuitiously copied from http://dhtmlpopups.webarticles.org/basics.php
// Determine how much the visitor had scrolled

var scrolledX, scrolledY;
if( self.pageYOffset ) {
  scrolledX = self.pageXOffset;
  scrolledY = self.pageYOffset;
} else if( document.documentElement && document.documentElement.scrollTop ) {
  scrolledX = document.documentElement.scrollLeft;
  scrolledY = document.documentElement.scrollTop;
} else if( document.body ) {
  scrolledX = document.body.scrollLeft;
  scrolledY = document.body.scrollTop;
}

// Determine the coordinates of the center of the page

var centerX, centerY;
if( self.innerHeight ) {
  centerX = self.innerWidth;
  centerY = self.innerHeight;
} else if( document.documentElement && document.documentElement.clientHeight ) {
  centerX = document.documentElement.clientWidth;
  centerY = document.documentElement.clientHeight;
} else if( document.body ) {
  centerX = document.body.clientWidth;
  centerY = document.body.clientHeight;
}

function myPopupRelocate() {
 var scrolledX, scrolledY;
 if( self.pageYOffset ) {
   scrolledX = self.pageXOffset;
   scrolledY = self.pageYOffset;
 } else if( document.documentElement && document.documentElement.scrollTop ) {
   scrolledX = document.documentElement.scrollLeft;
   scrolledY = document.documentElement.scrollTop;
 } else if( document.body ) {
   scrolledX = document.body.scrollLeft;
   scrolledY = document.body.scrollTop;
 }

 var centerX, centerY;
 if( self.innerHeight ) {
   centerX = self.innerWidth;
   centerY = self.innerHeight;
 } else if( document.documentElement && document.documentElement.clientHeight ) {
   centerX = document.documentElement.clientWidth;
   centerY = document.documentElement.clientHeight;
 } else if( document.body ) {
   centerX = document.body.clientWidth;
   centerY = document.body.clientHeight;
 }

 var leftOffset = scrolledX + (centerX - 250) / 2;
 var topOffset = scrolledY + (centerY - 200) / 2;

 document.getElementById("mypopup").style.top = topOffset + "px";
 document.getElementById("mypopup").style.left = leftOffset + "px";
}

window.onload=function(){
 myPopupRelocate();
 document.getElementById("mypopup").style.display = "block";
 document.body.onscroll = myPopupRelocate;
 window.onscroll = myPopupRelocate;
}
</script>
<div id='mypopup' name='mypopup' style='position: absolute; width: 400px; height: 131px; display: none; background: #FFC url(/intranet-tmpl/prog/img/alert-bg.gif) repeat-x left 0; border: 1px solid #bcbcbc; right: 0px; top: 500px'>
 <span id="message" style="position: absolute; top: 5px; left: 5px;">
 <strong style="color: #900;">ATTENTION :</strong>
 [% IF ( 101 ) %] La base de données a renvoyé une erreur [% IF ( card_element ) %]lors de la sauvegarde[% card_element %] [% element_id %][% ELSE %]en tentant d'enregistrer[% END %]. Merci de contacter votre administrateur système pour qu'il cherche dans les logs le détail de l'erreur. [% ELSIF ( 102 ) %] La base de données a renvoyé une erreur [% IF ( card_element ) %]pendant la suppression[% card_element %] [% element_id %][% ELSIF ( image_ids ) %][% image_ids %][% ELSE %]en tentant de supprimer[% END %]. Merci de contacter votre administrateur système pour qu'il cherche dans les logs le détail de l'erreur.[% ELSIF ( 201 ) %] Une opération imprévue a été tentée[% IF ( element_id ) %] sur [% card_element %] [% element_id %][% END %]. Merci de contacter votre administrateur système pour qu'il cherche dans les logs le détail de l'erreur.[% ELSIF ( 202 ) %] Une erreur s'est produite. Merci de contacter votre administrateur système pour qu'il cherche dans les logs le détail de l'erreur.[% ELSIF ( 203 ) %] Un code de site n'existant pas a été fourni. Merci de <a href="/cgi-bin/koha/circ/selectbranchprinter.pl">vérifier</a> que vous avez sélectionné un site. [% ELSIF ( 301 ) %] Une erreur est survenue pendant l'envoi du fichier image. Demandez à votre administrateur système de contrôler le fichier journal des erreurs pour avoir plus d'unformation. [% ELSIF ( 302 ) %] La taille de l'image dépasse 500 Ko. Redimensionnez-la et réimportez-la. [% ELSIF ( 303 ) %] Le quota d'images de la base de données permet de stocker au maximum [% image_limit %] images en même temps. Supprimez des images pour libérer de l'espace. [% ELSIF ( 401 ) %] Une erreur est survenue, les exemplaires n'ont pas été ajoutés au lot [% batch_id %]. Demandez à votre administrateur système de consulter le journal des erreurs pour avoir plus d'information. [% ELSIF ( 402 ) %] Les exemplaires n'ont pas été ajoutés parce que le site n'est pas défini.Définissez le site avant d'ajouter des exemplaires à un lot. [% ELSIF ( 403 ) %] Une erreur est survenue, les exemplaires n'ont pas été supprimés du lot [% batch_id %]. Demandez à votre administrateur système de consulter le fichier journal des erreurs pour avoir plus d'information. [% ELSIF ( 404 ) %] Une erreur est survenue, le lot [% batch_id %] n'a pas été supprimé. Demandez à votre administrateur système de consulter le fichier journal des erreurs pour avoir plus d'information. [% ELSIF ( 405 ) %] Une erreur est survenue, le lot [% batch_id %] n'a pas été complètement dédoublonné. [% ELSE %] [% END %] </span>
 <span id="close" style="position: absolute; top: 100px; left: 175px;">
 <input value="Fermer" type="submit" onclick="document.getElementById("mypopup").style.display = "none"">
 </span>
</div>
[% END %] 