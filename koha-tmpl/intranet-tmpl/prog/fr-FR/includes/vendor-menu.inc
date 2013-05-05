[% IF ( booksellerid ) %] <div id="menu">
 <ul>
 [% IF ( CAN_user_acquisition_order_manage ) %]<li><a href="/cgi-bin/koha/acqui/booksellers.pl?booksellerid=[% booksellerid %]">Paniers de commande</a></li>[% END %] [% IF ( CAN_user_acquisition_group_manage ) %]<li><a href="/cgi-bin/koha/acqui/basketgroup.pl?booksellerid=[% booksellerid %]">Bordereaux de commande</a></li>[% END %] [% IF ( CAN_user_acquisition_contracts_manage ) %]<li><a href="/cgi-bin/koha/admin/aqcontract.pl?booksellerid=[% booksellerid %]">Contrats</a></li>[% END %] <li><a href="/cgi-bin/koha/acqui/invoices.pl?supplierid=[% booksellerid %]&amp;op=do_search">Invoices</a></li>
 [% IF ( CAN_user_acquisition_order_manage ) %][% IF ( basketno ) %] <li><a href="/cgi-bin/koha/acqui/uncertainprice.pl?booksellerid=[% booksellerid %]&amp;basketno=[% basketno %]&amp;owner=1">Prix indéterminés</a></li>
 [% ELSE %] <li><a href="/cgi-bin/koha/acqui/uncertainprice.pl?booksellerid=[% booksellerid %]&amp;owner=1">Prix indéterminés</a></li>
 [% END %] [% END %] </ul>
</div>
[% END %] 