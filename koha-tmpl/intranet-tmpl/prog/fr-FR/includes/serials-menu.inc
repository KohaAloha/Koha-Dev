[% IF ( subscriptionid ) %] <ul>
<li><a href="serials-collection.pl?subscriptionid=[% subscriptionid %]">Etat de collection</a></li>
 [% UNLESS closed %] [% IF ( routing && CAN_user_serials_routing ) %] [% IF ( hasRouting ) %] <li><a href="/cgi-bin/koha/serials/routing.pl?subscriptionid=[% subscriptionid %]">Modifier la liste de circulation</a></li>
 [% ELSE %] <li><a href="/cgi-bin/koha/serials/routing.pl?subscriptionid=[% subscriptionid %]&amp;op=new">Créer une liste de circulation</a></li>
 [% END %] [% END %] [% END %] </ul>
[% END %] <ul>
 [% IF ( CAN_user_serials_claim_serials ) %] <li><a href="/cgi-bin/koha/serials/claims.pl">Réclamations</a></li>
 [% END %] [% IF ( CAN_user_serials_check_expiration ) %] <li><a href="/cgi-bin/koha/serials/checkexpiration.pl">Vérification des dates d'expiration</a></li>
 [% END %] </ul>
