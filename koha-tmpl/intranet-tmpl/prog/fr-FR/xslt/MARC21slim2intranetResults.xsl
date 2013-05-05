
<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
<!DOCTYPE stylesheet [<!ENTITY nbsp "&#160;" >]>
<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">
 <xsl:import href="MARC21slimUtils.xsl"/>
 <xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>
 <xsl:key name="item-by-status" match="items:item" use="items:status"/>
 <xsl:key name="item-by-status-and-branch" match="items:item" use="concat(items:status, ' ', items:homebranch)"/>

 <xsl:template match="/">
 <xsl:apply-templates/>
 </xsl:template>
 <xsl:template match="marc:record">

 <!-- Option: Display Alternate Graphic Representation (MARC 880) -->
 <xsl:variable name="display880" select="boolean(marc:datafield[@tag=880])"/>

 <xsl:variable name="hidelostitems" select="marc:sysprefs/marc:syspref[@name='hidelostitems']"/>
 <xsl:variable name="URLLinkText" select="marc:sysprefs/marc:syspref[@name='URLLinkText']"/>
 <xsl:variable name="Show856uAsImage" select="marc:sysprefs/marc:syspref[@name='Display856uAsImage']"/>
 <xsl:variable name="AlternateHoldingsField" select="substring(marc:sysprefs/marc:syspref[@name='AlternateHoldingsField'], 1, 3)"/>
 <xsl:variable name="AlternateHoldingsSubfields" select="substring(marc:sysprefs/marc:syspref[@name='AlternateHoldingsField'], 4)"/>
 <xsl:variable name="AlternateHoldingsSeparator" select="marc:sysprefs/marc:syspref[@name='AlternateHoldingsSeparator']"/>
 <xsl:variable name="UseAuthoritiesForTracings" select="marc:sysprefs/marc:syspref[@name='UseAuthoritiesForTracings']"/>
 <xsl:variable name="DisplayIconsXSLT" select="marc:sysprefs/marc:syspref[@name='DisplayIconsXSLT']"/>
 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="leader19" select="substring($leader,20,1)"/>
 <xsl:variable name="biblionumber" select="marc:datafield[@tag=999]/marc:subfield[@code='c']"/>
 <xsl:variable name="controlField008" select="marc:controlfield[@tag=008]"/>
 <xsl:variable name="typeOf008">
 <xsl:choose>
 <xsl:when test="$leader19='a'">ST</xsl:when>
 <xsl:when test="$leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='a' or $leader7='c' or $leader7='d' or $leader7='m'">BK</xsl:when>
 <xsl:when test="$leader7='b' or $leader7='i' or $leader7='s'">CR</xsl:when>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="$leader6='t'">BK</xsl:when>
 <xsl:when test="$leader6='o' or $leader6='p'">MX</xsl:when>
 <xsl:when test="$leader6='m'">CF</xsl:when>
 <xsl:when test="$leader6='e' or $leader6='f'">MP</xsl:when>
 <xsl:when test="$leader6='g' or $leader6='k' or $leader6='r'">VM</xsl:when>
 <xsl:when test="$leader6='i' or $leader6='j'">MU</xsl:when>
 <xsl:when test="$leader6='c' or $leader6='d'">PR</xsl:when>
 </xsl:choose>
 </xsl:variable>
 <xsl:variable name="controlField008-23" select="substring($controlField008,24,1)"/>
 <xsl:variable name="controlField008-21" select="substring($controlField008,22,1)"/>
 <xsl:variable name="controlField008-22" select="substring($controlField008,23,1)"/>
 <xsl:variable name="controlField008-24" select="substring($controlField008,25,4)"/>
 <xsl:variable name="controlField008-26" select="substring($controlField008,27,1)"/>
 <xsl:variable name="controlField008-29" select="substring($controlField008,30,1)"/>
 <xsl:variable name="controlField008-34" select="substring($controlField008,35,1)"/>
 <xsl:variable name="controlField008-33" select="substring($controlField008,34,1)"/>
 <xsl:variable name="controlField008-30-31" select="substring($controlField008,31,2)"/>

 <xsl:variable name="physicalDescription">
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='a']">
 numérique reformaté</xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='b']">
 microfilm numérisé </xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='d']">
 autre numérisation </xsl:if>

 <xsl:variable name="check008-23">
 <xsl:if test="$typeOf008='BK' or $typeOf008='MU' or $typeOf008='CR' or $typeOf008='MX'">
 <xsl:value-of select="true()"></xsl:value-of>
 </xsl:if>
 </xsl:variable>
 <xsl:variable name="check008-29">
 <xsl:if test="$typeOf008='MP' or $typeOf008='VM'">
 <xsl:value-of select="true()"></xsl:value-of>
 </xsl:if>
 </xsl:variable>
 <xsl:choose>
 <xsl:when test="($check008-23 and $controlField008-23='f') or ($check008-29 and $controlField008-29='f')">
 braille </xsl:when>
 <xsl:when test="($controlField008-23=' ' and ($leader6='c' or $leader6='d')) or (($typeOf008='BK' or $typeOf008='CR') and ($controlField008-23=' ' or $controlField008='r'))">
 print
 </xsl:when>
 <xsl:when test="$leader6 = 'm' or ($check008-23 and $controlField008-23='s') or ($check008-29 and $controlField008-29='s')">
 electronic
 </xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='b') or ($check008-29 and $controlField008-29='b')">
 microfiche</xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='a') or ($check008-29 and $controlField008-29='a')">
 microfilm</xsl:when>
 </xsl:choose>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='b']">
 fim fixe en cartouche </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='j']">
 disque magnétique</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='m']">
 disque magnéto-optique</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='r']">
 available online
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='a']">
 bande (cartouche) </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='f']">
 cassette audio</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='h']">
 bande (sur bobine)</xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='o'][substring(text(),2,1)='o']">
 kit </xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='d']">
 atlas
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='g']">
 diagramme </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='j']">
 carte</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='q']">
 modèle </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='k']">
 profile
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='r']">
 image de télédétection</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='s']">
 section </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='y']">
 vue</xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='a']">
 aperture card
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='e']">
 microfiche</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='f']">
 cassette microfiche</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='b']">
 cartouche microforme</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='c']">
 cassette microfiche</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='d']">
 microfilm en rouleau </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='g']">
 micro opaque</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='c']">
 fim fixe en cartouche</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='f']">
 Videocassette</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='r']">
 bobine de film</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='c']">
 collage </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='f']">
 photomechanical print
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='g']">
 photonegative
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='h']">
 photoprint
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='j']">
 print
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='l']">
 dessin technique</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='d']">
 film fixe en bande</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='c']">
 film fixe en cartouche</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='o']">
 film fixe en bobine</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='f']">
 autre type de bobine de film</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='t']">
 transparent</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='r'][substring(text(),2,1)='r']">
 image de télédétection</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='e']">
 cylindre</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='q']">
 rouleau</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='g']">
 cartouche audio</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='s']">
 cassette audio</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='t']">
 bande-son (sur bobine) </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='i']">
 piste sonore </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='w']">
 enregistrement sur bande</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='c']">
 braille </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='b']">
 combinaison de données </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='a']">
 lune </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='d']">
 tactile, sans système d'écriture </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='c']">
 braille </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='a']">
 impression normale</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='d']">
 reliure à feuillets mobiles</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='c']">
 cartouche vidéo</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='f']">
 vidéocassette</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='r']">
 bobine vidéo</xsl:if>
<!--
 <xsl:for-each select="marc:datafield[@tag=856]/marc:subfield[@code='q'][string-length(.)>1]">
 <xsl:value-of select="."></xsl:value-of>
 </xsl:for-each>
 <xsl:for-each select="marc:datafield[@tag=300]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abce</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
-->
 </xsl:variable>

 <!-- Title Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">245</xsl:with-param>
 <xsl:with-param name="codes">abhfgknps</xsl:with-param>
 <xsl:with-param name="bibno"><xsl:value-of  select="$biblionumber"/></xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <a><xsl:attribute name="href">/cgi-bin/koha/catalogue/detail.pl?biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute><xsl:attribute name="class">titre</xsl:attribute>

 <xsl:if test="marc:datafield[@tag=245]">
 <xsl:for-each select="marc:datafield[@tag=245]">
 <xsl:variable name="title">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='h']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">h</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">fgknps</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:variable name="titleChop">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="$title"/>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:value-of select="$titleChop"/>
 </xsl:for-each>
 </xsl:if>
 </a>

 <!-- Author Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">100,110,111,700,710,711</xsl:with-param>
 <xsl:with-param name="codes">abc</xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:choose>
 <xsl:when test="marc:datafield[@tag=100] or marc:datafield[@tag=110] or marc:datafield[@tag=111] or marc:datafield[@tag=700] or marc:datafield[@tag=710] or marc:datafield[@tag=711]">
 <p class="author">par <xsl:for-each select="marc:datafield[(@tag=100 or @tag=700) and @ind1!='z']">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9] and $UseAuthoritiesForTracings='1'">
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=au:"<xsl:value-of select="marc:subfield[@code='a']"/>"</xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="nameABCDQ"/></a>
 <xsl:choose>
 <xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[(@tag=110 or @tag=710) and @ind1!='z']">
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9] and $UseAuthoritiesForTracings='1'">
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=au:"<xsl:value-of select="marc:subfield[@code='a']"/>"</xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="nameABCDN"/></a>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text> </xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[(@tag=111 or @tag=711) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='n']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">n</xsl:with-param> </xsl:call-template>
 <xsl:text> </xsl:text>
 </xsl:when>
 </xsl:choose>
 <a>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code=9] and $UseAuthoritiesForTracings='1'">
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=an:<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href">/cgi-bin/koha/catalogue/search.pl?q=au:"<xsl:value-of select="marc:subfield[@code='a']"/>"</xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:call-template name="nameACDEQ"/></a>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>

 </xsl:for-each>
 </p>
 </xsl:when>
 </xsl:choose>

<xsl:if test="$DisplayIconsXSLT!='0'">
 <span class="results_summary">
 <xsl:if test="$typeOf008!=''">
 <span class="label">Type&nbsp;:</span>
 <xsl:choose>
 <xsl:when test="$leader19='a'"><img src="/intranet-tmpl/prog/img/famfamfam/silk/book_link.png" alt="book" title="book" class="materialtype"/> Groupe</xsl:when>
 <xsl:when test="$leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='c' or $leader7='d' or $leader7='m'"><img src="/intranet-tmpl/prog/img/famfamfam/silk/book.png" alt="book" title="book" class="materialtype"/> Livre</xsl:when>
 <xsl:when test="$leader7='i' or $leader7='s'"><img alt="périodique" src="/intranet-tmpl/prog/img/famfamfam/silk/newspaper.png" title="périodique" class="materialtype" /> Ressources continue</xsl:when>
 <xsl:when test="$leader7='a' or $leader7='b'"><img src="/intranet-tmpl/prog/img/famfamfam/silk/book_open.png" alt="article" title="article" class="materialtype"/> Article</xsl:when>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="$leader6='t'"><img src="/intranet-tmpl/prog/img/famfamfam/silk/book.png" alt="book" title="book" class="materialtype"/> Livre</xsl:when>
 <xsl:when test="$leader6='o'"><img src="/intranet-tmpl/prog/img/famfamfam/silk/report_disk.png" alt="kit" title="kit" class="materialtype"/> Kit</xsl:when>
 <xsl:when test="$leader6='p'"><img src="/intranet-tmpl/prog/img/famfamfam/silk/report_disk.png" alt="mixed materials" title="mixed materials" class="materialtype"/>Matériaux composites</xsl:when>
 <xsl:when test="$leader6='m'"><img src="/intranet-tmpl/prog/img/famfamfam/silk/computer_link.png" alt="computer file" title="computer file" class="materialtype"/> Fichiers informatiques</xsl:when>
 <xsl:when test="$leader6='e' or $leader6='f'"><img alt="carte" src="/intranet-tmpl/prog/img/famfamfam/silk/map.png" title="carte" class="materialtype" /> Carte</xsl:when>
 <xsl:when test="$leader6='g' or $leader6='k' or $leader6='r'"><img src="/intranet-tmpl/prog/img/famfamfam/silk/film.png" alt="visual material" title="visual material" class="materialtype"/> Matériels visuels</xsl:when>
 <xsl:when test="$leader6='c' or $leader6='d'"><img alt="partition" src="/intranet-tmpl/prog/img/famfamfam/silk/music.png" title="partition" class="materialtype" /> Partition</xsl:when>
 <xsl:when test="$leader6='i'"><img alt="son" src="/intranet-tmpl/prog/img/famfamfam/silk/sound.png" title="son" class="materialtype" /> Sound</xsl:when>
 <xsl:when test="$leader6='j'"><img alt="Musique" src="/intranet-tmpl/prog/img/famfamfam/silk/sound.png" title="Musique" class="materialtype" /> Music</xsl:when>
 </xsl:choose>
 </xsl:if>

 <xsl:if test="string-length(normalize-space($physicalDescription))">
 <span class="label">; Format :</span><xsl:copy-of select="$physicalDescription"></xsl:copy-of>
 </xsl:if>

 <xsl:if test="$controlField008-21 or $controlField008-22 or $controlField008-24 or $controlField008-26 or $controlField008-29 or $controlField008-34 or $controlField008-33 or $controlField008-30-31 or $controlField008-33">

 <xsl:if test="$typeOf008='CR'">
 <xsl:if test="$controlField008-21 and $controlField008-21 !='|' and $controlField008-21 !=' '">
 <span class="label">Type de ressource continue</span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-21='l'">
 Feuillets mobiles</xsl:when>
 <xsl:when test="$controlField008-21='m'">
 series </xsl:when>
 <xsl:when test="$controlField008-21='n'">
 journal</xsl:when>
 <xsl:when test="$controlField008-21='p'">
 periodical
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='BK' or $typeOf008='CR'">
 <xsl:if test="contains($controlField008-24,'abcdefghijklmnopqrstvwxyz')">
 <span class="label">; Nature des contenus:</span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="contains($controlField008-24,'a')">
 résumé ou sommaire</xsl:when>
 <xsl:when test="contains($controlField008-24,'b')">
 bibliographie </xsl:when>
 <xsl:when test="contains($controlField008-24,'c')">
 catalogue </xsl:when>
 <xsl:when test="contains($controlField008-24,'d')">
 dictionnaire</xsl:when>
 <xsl:when test="contains($controlField008-24,'e')">
 encyclopedia
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'f')">
 livre de poche</xsl:when>
 <xsl:when test="contains($controlField008-24,'g')">
 articles juridiques</xsl:when>
 <xsl:when test="contains($controlField008-24,'i')">
 index</xsl:when>
 <xsl:when test="contains($controlField008-24,'k')">
 discography
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'l')">
 législation</xsl:when>
 <xsl:when test="contains($controlField008-24,'m')">
 thèses </xsl:when>
 <xsl:when test="contains($controlField008-24,'n')">
 enquête bibliographique</xsl:when>
 <xsl:when test="contains($controlField008-24,'o')">
 commentaire</xsl:when>
 <xsl:when test="contains($controlField008-24,'p')">
 programmed text
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'q')">
 filmographie </xsl:when>
 <xsl:when test="contains($controlField008-24,'r')">
 répertoire </xsl:when>
 <xsl:when test="contains($controlField008-24,'s')">
 statistiques</xsl:when>
 <xsl:when test="contains($controlField008-24,'v')">
 cas de droit et notes de cas</xsl:when>
 <xsl:when test="contains($controlField008-24,'w')">
 rapports de lois et recueils</xsl:when>
 <xsl:when test="contains($controlField008-24,'z')">
 traité</xsl:when>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="$controlField008-29='1'">
 actes de congrès</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='CF'">
 <xsl:if test="$controlField008-26='a' or $controlField008-26='e' or $controlField008-26='f' or $controlField008-26='g'">
 <span class="label">; Type de fichier informatique : </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-26='a'">
 données numériques </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='BK'">
 <xsl:if test="(substring($controlField008,25,1)='j') or (substring($controlField008,25,1)='1') or ($controlField008-34='a' or $controlField008-34='b' or $controlField008-34='c' or $controlField008-34='d')">
 <span class="label">; Nature des contenus:</span>
 </xsl:if>
 <xsl:if test="substring($controlField008,25,1)='j'">
 patent
 </xsl:if>
 <xsl:if test="substring($controlField008,31,1)='1'">
 mélanges</xsl:if>

 <xsl:if test="$controlField008-33 and $controlField008-33!='|' and $controlField008-33!='u' and $controlField008-33!=' '">
 <span class="label">; forme littéraire: </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-33='0'">
 documentaire</xsl:when>
 <xsl:when test="$controlField008-33='1'">
 fiction</xsl:when>
 <xsl:when test="$controlField008-33='e'">
 essai </xsl:when>
 <xsl:when test="$controlField008-33='d'">
 drama
 </xsl:when>
 <xsl:when test="$controlField008-33='c'">
 bande dessinée</xsl:when>
 <xsl:when test="$controlField008-33='l'">
 fiction</xsl:when>
 <xsl:when test="$controlField008-33='h'">
 humour, satire</xsl:when>
 <xsl:when test="$controlField008-33='i'">
 lettre</xsl:when>
 <xsl:when test="$controlField008-33='f'">
 roman</xsl:when>
 <xsl:when test="$controlField008-33='j'">
 nouvelle</xsl:when>
 <xsl:when test="$controlField008-33='s'">
 discours</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='MU' and $controlField008-30-31 and $controlField008-30-31!='||' and $controlField008-30-31!='  '">
 <span class="label">; forme littéraire: </span> <!-- Literary text for sound recordings -->
 <xsl:if test="contains($controlField008-30-31,'b')">
 biographie </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'c')">
 actes de congrès</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'d')">
 drama
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'e')">
 essai </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'f')">
 fiction</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'o')">
 conte populaire</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'h')">
 Historique</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'k')">
 humour, satire</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'m')">
 mémoire </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'p')">
 poetry
 </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'r')">
 répétition</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'g')">
 rapports </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'s')">
 son</xsl:if>
 <xsl:if test="contains($controlField008-30-31,'l')">
 discours</xsl:if>
 </xsl:if>
 <xsl:if test="$typeOf008='VM'">
 <span class="label">Type de matériel visuel:</span>
 <xsl:choose>
 <xsl:when test="$controlField008-33='a'">
 art original
 </xsl:when>
 <xsl:when test="$controlField008-33='b'">
 kit </xsl:when>
 <xsl:when test="$controlField008-33='c'">
 art reproduction
 </xsl:when>
 <xsl:when test="$controlField008-33='d'">
 diorama </xsl:when>
 <xsl:when test="$controlField008-33='f'">
 film fixe en bande</xsl:when>
 <xsl:when test="$controlField008-33='g'">
 articles juridiques</xsl:when>
 <xsl:when test="$controlField008-33='i'">
 picture
 </xsl:when>
 <xsl:when test="$controlField008-33='k'">
 graphique</xsl:when>
 <xsl:when test="$controlField008-33='l'">
 dessin technique</xsl:when>
 <xsl:when test="$controlField008-33='m'">
 film </xsl:when>
 <xsl:when test="$controlField008-33='n'">
 graphique </xsl:when>
 <xsl:when test="$controlField008-33='o'">
 carte flash</xsl:when>
 <xsl:when test="$controlField008-33='p'">
 diapositives microscopes</xsl:when>
 <xsl:when test="$controlField008-33='q' or marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2
,1)='q']">
 modèle </xsl:when>
 <xsl:when test="$controlField008-33='r'">
 realia</xsl:when>
 <xsl:when test="$controlField008-33='s'">
 diapositive</xsl:when>
 <xsl:when test="$controlField008-33='t'">
 transparent</xsl:when>
 <xsl:when test="$controlField008-33='v'">
 enregistrement vidéo</xsl:when>
 <xsl:when test="$controlField008-33='w'">
 jouet</xsl:when>
 </xsl:choose>
 </xsl:if>
 </xsl:if>

 <xsl:if test="($typeOf008='BK' or $typeOf008='CF' or $typeOf008='MU' or $typeOf008='VM') and ($controlField008-22='a' or $controlField008-22='b' or $controlField008-22='c' or $controlField008-22='d' or $controlField008-22='e' or $controlField008-22='g' or $controlField008-22='j' or $controlField008-22='f')">
 <span class="label">; Public: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-22='a'">
 Préscolaire ; </xsl:when>
 <xsl:when test="$controlField008-22='b'">
 Primaire ; </xsl:when>
 <xsl:when test="$controlField008-22='c'">
 Pré-adolescent ; </xsl:when>
 <xsl:when test="$controlField008-22='d'">
 Adolescent;</xsl:when>
 <xsl:when test="$controlField008-22='e'">
 Adulte;</xsl:when>
 <xsl:when test="$controlField008-22='g'">
 Général; </xsl:when>
 <xsl:when test="$controlField008-22='j'">
 Jeunesse;</xsl:when>
 <xsl:when test="$controlField008-22='f'">
 Specialized;
 </xsl:when>
 </xsl:choose>
 </xsl:if>
<xsl:text> </xsl:text> <!-- added blank space to fix font display problem, see Bug 3671 -->
 </span>
</xsl:if> <!-- DisplayIconsXSLT -->

 <!-- Publisher Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">260</xsl:with-param>
 <xsl:with-param name="codes">abcg</xsl:with-param>
 <xsl:with-param name="class">results_summary</xsl:with-param>
 <xsl:with-param name="label">Editeur&nbsp;: </xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=260]">
 <span class="results_summary publisher"><span class="label">Editeur&nbsp;: </span>
 <xsl:for-each select="marc:datafield[@tag=260]">
 <xsl:if test="marc:subfield[@code='a']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:text> </xsl:text>
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">cg</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text></xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=300]">
 <span class="results_summary description"><span class="label">Description: </span>
 <xsl:for-each select="marc:datafield[@tag=300]">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abceg</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=020]">
 <span class="results_summary isbn"><span class="label">ISBN&nbsp;: </span>
 <xsl:for-each select="marc:datafield[@tag=020]">
 <xsl:variable name="isbn" select="marc:subfield[@code='a']"/>
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=022]">
 <span class="results_summary issn"><span class="label">ISSN&nbsp;: </span>
 <xsl:for-each select="marc:datafield[@tag=022]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=250]">
 <span class="results_summary">
 <span class="label">Edition&nbsp;:</span>
 <xsl:for-each select="marc:datafield[@tag=250]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=773]">
 <xsl:for-each select="marc:datafield[@tag=773]">
 <xsl:if test="marc:subfield[@code='t']">
 <span class="results_summary">
 <span class="label">Source: </span>
 <xsl:value-of select="marc:subfield[@code='t']"/>
 </span>
 </xsl:if>
 </xsl:for-each>
 </xsl:if>

 <!-- Other Title Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">246</xsl:with-param>
 <xsl:with-param name="codes">ab</xsl:with-param>
 <xsl:with-param name="class">results_summary</xsl:with-param>
 <xsl:with-param name="label">Autre titre&nbsp;: </xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=246]">
 <span class="results_summary">
 <span class="label">Autre titre: </span>
 <xsl:for-each select="marc:datafield[@tag=246]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=856]">
 <span class="results_summary">
 <span class="label">Accès en ligne:</span>
 <xsl:for-each select="marc:datafield[@tag=856]">
 <xsl:variable name="SubqText"><xsl:value-of select="marc:subfield[@code='q']"/></xsl:variable>
 <a><xsl:attribute name="href"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute>
 <xsl:choose>
 <xsl:when test="($Show856uAsImage='Results' or $Show856uAsImage='Both') and (substring($SubqText,1,6)='image/' or $SubqText='img' or $SubqText='bmp' or $SubqText='cod' or $SubqText='gif' or $SubqText='ief' or $SubqText='jpe' or $SubqText='jpeg' or $SubqText='jpg' or $SubqText='jfif' or $SubqText='png' or $SubqText='svg' or $SubqText='tif' or $SubqText='tiff' or $SubqText='ras' or $SubqText='cmx' or $SubqText='ico' or $SubqText='pnm' or $SubqText='pbm' or $SubqText='pgm' or $SubqText='ppm' or $SubqText='rgb' or $SubqText='xbm' or $SubqText='xpm' or $SubqText='xwd')">
 <xsl:element name="img"><xsl:attribute name="src"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute><xsl:attribute name="alt"><xsl:value-of select="marc:subfield[@code='y']"/></xsl:attribute><xsl:attribute name="height">100</xsl:attribute></xsl:element><xsl:text></xsl:text>
 </xsl:when>
 <xsl:when test="marc:subfield[@code='y' or @code='3' or @code='z']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">y3z</xsl:with-param>
 </xsl:call-template>
 </xsl:when>
 <xsl:when test="not(marc:subfield[@code='y']) and not(marc:subfield[@code='3']) and not(marc:subfield[@code='z'])">
 <xsl:choose>
 <xsl:when test="$URLLinkText!=''">
 <xsl:value-of select="$URLLinkText"/>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>Cliquez ici pour l'accès en ligne</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 </xsl:choose>
 </a>
 <xsl:choose>
 <xsl:when test="position()=last()"><xsl:text> </xsl:text></xsl:when>
 <xsl:otherwise> | </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 </xsl:template>

 <xsl:template name="nameABCDQ">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">aq</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 <xsl:with-param name="punctuation">
 <xsl:text>:,;/ </xsl:text>
 </xsl:with-param>
 </xsl:call-template>
 <xsl:call-template name="termsOfAddress"/>
 </xsl:template>

 <xsl:template name="nameABCDN">
 <xsl:for-each select="marc:subfield[@code='a']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."/>
 </xsl:call-template>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='b']">
 <xsl:value-of select="."/>
 </xsl:for-each>
 <xsl:if test="marc:subfield[@code='c'] or marc:subfield[@code='d'] or marc:subfield[@code='n']">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">cdn</xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="nameACDEQ">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">acdeq</xsl:with-param>
 </xsl:call-template>
 </xsl:template>

 <xsl:template name="termsOfAddress">
 <xsl:if test="marc:subfield[@code='b' or @code='c']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">bc</xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="nameDate">
 <xsl:for-each select="marc:subfield[@code='d']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="."/>
 </xsl:call-template>
 </xsl:for-each>
 </xsl:template>

 <xsl:template name="role">
 <xsl:for-each select="marc:subfield[@code='e']">
 <xsl:value-of select="."/>
 </xsl:for-each>
 <xsl:for-each select="marc:subfield[@code='4']">
 <xsl:value-of select="."/>
 </xsl:for-each>
 </xsl:template>

 <xsl:template name="specialSubfieldSelect">
 <xsl:param name="anyCodes"/>
 <xsl:param name="axis"/>
 <xsl:param name="beforeCodes"/>
 <xsl:param name="afterCodes"/>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="contains($anyCodes, @code) or (contains($beforeCodes,@code) and following-sibling::marc:subfield[@code=$axis]) or (contains($afterCodes,@code) and preceding-sibling::marc:subfield[@code=$axis])">
 <xsl:value-of select="text()"/>
 <xsl:text> </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
 </xsl:template>

 <xsl:template name="subtitle">
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:subfield[@code='b']"/>

 <!--<xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">b</xsl:with-param>
 </xsl:call-template>-->
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="chopBrackets">
 <xsl:param name="chopString"></xsl:param>
 <xsl:variable name="string">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$chopString"></xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:if test="substring($string, 1,1)='['">
 <xsl:value-of select="substring($string,2, string-length($string)-2)"></xsl:value-of>
 </xsl:if>
 <xsl:if test="substring($string, 1,1)!='['">
 <xsl:value-of select="$string"></xsl:value-of>
 </xsl:if>
 </xsl:template>

</xsl:stylesheet>
