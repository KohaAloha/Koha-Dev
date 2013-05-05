
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
 <xsl:variable name="DisplayOPACiconsXSLT" select="marc:sysprefs/marc:syspref[@name='DisplayOPACiconsXSLT']"/>
 <xsl:variable name="OPACURLOpenInNewWindow" select="marc:sysprefs/marc:syspref[@name='OPACURLOpenInNewWindow']"/>
 <xsl:variable name="URLLinkText" select="marc:sysprefs/marc:syspref[@name='URLLinkText']"/>
 <xsl:variable name="Show856uAsImage" select="marc:sysprefs/marc:syspref[@name='OPACDisplay856uAsImage']"/>
 <xsl:variable name="AlternateHoldingsField" select="substring(marc:sysprefs/marc:syspref[@name='AlternateHoldingsField'], 1, 3)"/>
 <xsl:variable name="AlternateHoldingsSubfields" select="substring(marc:sysprefs/marc:syspref[@name='AlternateHoldingsField'], 4)"/>
 <xsl:variable name="AlternateHoldingsSeparator" select="marc:sysprefs/marc:syspref[@name='AlternateHoldingsSeparator']"/>
 <xsl:variable name="OPACItemLocation" select="marc:sysprefs/marc:syspref[@name='OPACItemLocation']"/>
 <xsl:variable name="singleBranchMode" select="marc:sysprefs/marc:syspref[@name='singleBranchMode']"/>
 <xsl:variable name="OPACTrackClicks" select="marc:sysprefs/marc:syspref[@name='TrackClicks']"/>
 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="leader19" select="substring($leader,20,1)"/>
 <xsl:variable name="biblionumber" select="marc:datafield[@tag=999]/marc:subfield[@code='c']"/>
 <xsl:variable name="isbn" select="marc:datafield[@tag=020]/marc:subfield[@code='a']"/>
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
 digitale reformatée </xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='b']">
 microfilm </xsl:if>
 <xsl:if test="$typeOf008='CF' and marc:controlfield[@tag=007][substring(.,12,1)='d']">
 Autre support analogique numérisé </xsl:if>

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
 imprimé </xsl:when>
 <xsl:when test="$leader6 = 'm' or ($check008-23 and $controlField008-23='s') or ($check008-29 and $controlField008-29='s')">
 électronique </xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='b') or ($check008-29 and $controlField008-29='b')">
 micro-fiche </xsl:when>
 <xsl:when test="($check008-23 and $controlField008-23='a') or ($check008-29 and $controlField008-29='a')">
 microfilm </xsl:when>
 </xsl:choose>
<!--
 <xsl:if test="marc:datafield[@tag=130]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=130]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=240]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=240]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=242]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=242]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=245]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=245]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=246]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=246]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=730]/marc:subfield[@code='h']">
 <xsl:call-template name="chopBrackets">
 <xsl:with-param name="chopString">
 <xsl:value-of select="marc:datafield[@tag=730]/marc:subfield[@code='h']"></xsl:value-of>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 <xsl:for-each select="marc:datafield[@tag=256]/marc:subfield[@code='a']">
 <xsl:value-of select="."></xsl:value-of>
 </xsl:for-each>
 <xsl:for-each select="marc:controlfield[@tag=007][substring(text(),1,1)='c']">
 <xsl:choose>
 <xsl:when test="substring(text(),14,1)='a'">
 access
 </xsl:when>
 <xsl:when test="substring(text(),14,1)='p'">
 preservation
 </xsl:when>
 <xsl:when test="substring(text(),14,1)='r'">
 replacement
 </xsl:when>
 </xsl:choose>
 </xsl:for-each>
-->
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='b']">
 Cartouche </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='c']">
 <img alt="disque optique" src="/opac-tmpl/lib/famfamfam/silk/cd.png" title="disque optique" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='j']">
 disque magnétique </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='m']">
 disque magnéto-optique </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='o']">
 <img alt="disque optique" src="/opac-tmpl/lib/famfamfam/silk/cd.png" title="disque optique" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='r']">
 disponible en-ligne <img alt="distant" src="/opac-tmpl/lib/famfamfam/silk/drive_web.png" title="distant" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='a']">
 cartouche </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='f']">
 cassette audio </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='c'][substring(text(),2,1)='h']">
 bande réelle </xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='a']">
 <img alt="Globe céleste" src="/opac-tmpl/lib/famfamfam/silk/world.png" title="Globe céleste" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='e']">
 <img alt="Globe lunaire/terrestre" src="/opac-tmpl/lib/famfamfam/silk/world.png" title="Globe lunaire/terrestre" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='b']">
 <img alt="globe planétaire ou lunaire" src="/opac-tmpl/lib/famfamfam/silk/world.png" title="globe planétaire ou lunaire" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='d'][substring(text(),2,1)='c']">
 <img alt="globe terrestre" src="/opac-tmpl/lib/famfamfam/silk/world.png" title="globe terrestre" class="format" />
 </xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='o'][substring(text(),2,1)='o']">
 kit </xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='d']">
 atlas</xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='g']">
 diagramme </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='j']">
 carte </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='q']">
 modèle </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='k']">
 profil </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='r']">
 image distante </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='s']">
 section </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2,1)='y']">
 vue </xsl:if>

 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='a']">
 Carte d'accès </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='e']">
 micro-fiche </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='f']">
 cassette micro-fiche </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='b']">
 cartouche microfilm </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='c']">
 cassette microfilm </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='d']">
 microfilm réel </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='h'][substring(text(),2,1)='g']">
 microopaque </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='c']">
 Cartouche film </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='f']">
 Cassette film </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='m'][substring(text(),2,1)='r']">
 film réel </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='n']">
 <img alt="graphique" src="/opac-tmpl/lib/famfamfam/silk/chart_curve.png" title="graphique" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='c']">
 collage </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='d']">
 <img alt="dessin" src="/opac-tmpl/lib/famfamfam/silk/pencil.png" title="dessin" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='o']">
 <img alt="carte flash" src="/opac-tmpl/lib/famfamfam/silk/note.png" title="carte flash" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='e']">
 <img alt="peinture" src="/opac-tmpl/lib/famfamfam/silk/paintbrush.png" title="peinture" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='f']">
 reproduction photomécanique </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='g']">
 négatif photo </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='h']">
 impression photo </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='i']">
 <img alt="image" src="/opac-tmpl/lib/famfamfam/silk/picture.png" title="image" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='j']">
 imprimé </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='k'][substring(text(),2,1)='l']">
 dessin technique </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='q'][substring(text(),2,1)='q']">
 <img alt="musique annotée" src="/opac-tmpl/lib/famfamfam/silk/script.png" title="musique annotée" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='d']">
 fimslim </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='c']">
 filmstrip cartridge </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='o']">
 filmstrip roll </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='f']">
 autre support filmographique </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='s']">
 <img alt="diapositive" src="/opac-tmpl/lib/famfamfam/silk/pictures.png" title="diapositive" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='g'][substring(text(),2,1)='t']">
 transparent </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='r'][substring(text(),2,1)='r']">
 image distante </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='e']">
 cylindre </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='q']">
 rouleau </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='g']">
 cartouche son </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='s']">
 cassette son </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='d']">
 <img alt="disque son" src="/opac-tmpl/lib/famfamfam/silk/cd.png" title="disque son" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='t']">
 bande sonore réel </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='i']">
 bande originale de film </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='s'][substring(text(),2,1)='w']">
 enregistrement </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='c']">
 braille </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='b']">
 combinaison </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='a']">
 lune </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='f'][substring(text(),2,1)='d']">
 tactile, sans clavier </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='c']">
 braille </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='b']">
 <img alt="gros caractères" src="/opac-tmpl/lib/famfamfam/silk/magnifier.png" title="gros caractères" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='a']">
 impression normale </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='t'][substring(text(),2,1)='d']">
 texte dans classeur </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='c']">
 cartouche vidéo </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='f']">
 Vidéocassette </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='d']">
 <img alt="vidéo disque" src="/opac-tmpl/lib/famfamfam/silk/dvd.png" title="vidéo disque" class="format" />
 </xsl:if>
 <xsl:if test="marc:controlfield[@tag=007][substring(text(),1,1)='v'][substring(text(),2,1)='r']">
 vidéoreel </xsl:if>
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

 <a><xsl:attribute name="href">/cgi-bin/koha/opac-detail.pl?biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute><xsl:attribute name="class">titres</xsl:attribute>

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
 <p>

 <!-- Author Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">100,110,111,700,710,711</xsl:with-param>
 <xsl:with-param name="codes">abc</xsl:with-param>
 </xsl:call-template>
 </xsl:if>

 <xsl:choose>
 <xsl:when test="marc:datafield[@tag=100] or marc:datafield[@tag=110] or marc:datafield[@tag=111] or marc:datafield[@tag=700] or marc:datafield[@tag=710] or marc:datafield[@tag=711]">

 par <span class="author">
 <xsl:for-each select="marc:datafield[(@tag=100 or @tag=700) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:call-template name="nameABCDQ"/>. </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="nameABCDQ"/>; </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[(@tag=110 or @tag=710) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="position()=1">
 <xsl:text> -- </xsl:text>
 </xsl:when>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:call-template name="nameABCDN"/> 
 </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="nameABCDN"/>; </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>

 <xsl:for-each select="marc:datafield[(@tag=111 or @tag=711) and @ind1!='z']">
 <xsl:choose>
 <xsl:when test="position()=1">
 <xsl:text> -- </xsl:text>
 </xsl:when>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="marc:subfield[@code='n']">
 <xsl:text> </xsl:text>
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">n</xsl:with-param> 
 </xsl:call-template>
 <xsl:text> </xsl:text>
 </xsl:when>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:call-template name="nameACDEQ"/>. </xsl:when>
 <xsl:otherwise>
 <xsl:call-template name="nameACDEQ"/>; </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:when>
 </xsl:choose>
 </p>

 <xsl:if test="marc:datafield[@tag=250]">
 <span class="results_summary">
 <span class="label">Edition: </span>
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

<xsl:if test="$DisplayOPACiconsXSLT!='0'">
 <span class="results_summary">
 <xsl:if test="$typeOf008!=''">
 <span class="label">Type : </span>
 <xsl:choose>
 <xsl:when test="$leader19='a'"><img alt="livre" src="/opac-tmpl/lib/famfamfam/silk/book_link.png" title="livre" class="materialtype" /> Groupe</xsl:when>
 <xsl:when test="$leader6='a'">
 <xsl:choose>
 <xsl:when test="$leader7='c' or $leader7='d' or $leader7='m'"><img alt="livre" src="/opac-tmpl/lib/famfamfam/silk/book.png" title="livre" class="materialtype" /> Livre</xsl:when>
 <xsl:when test="$leader7='i' or $leader7='s'"><img alt="périodique" src="/opac-tmpl/lib/famfamfam/silk/newspaper.png" title="périodique" class="materialtype" /> Ressource continue</xsl:when>
 <xsl:when test="$leader7='a' or $leader7='b'"><img src="/opac-tmpl/lib/famfamfam/silk/book_open.png" alt="article" title="article" class="materialtype"/> Article</xsl:when>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="$leader6='t'"><img alt="livre" src="/opac-tmpl/lib/famfamfam/silk/book.png" title="livre" class="materialtype" /> Livre</xsl:when>
 <xsl:when test="$leader6='o'"><img src="/opac-tmpl/lib/famfamfam/silk/report_disk.png" alt="kit" title="kit" class="materialtype"/> kit</xsl:when>
 <xsl:when test="$leader6='p'"><img alt="mélange" src="/opac-tmpl/lib/famfamfam/silk/report_disk.png" title="mélange" class="materialtype" />Matériel mixte</xsl:when>
 <xsl:when test="$leader6='m'"><img alt="Fichier informatique" src="/opac-tmpl/lib/famfamfam/silk/computer_link.png" title="Fichier informatique" class="materialtype" /> Fichier informatique</xsl:when>
 <xsl:when test="$leader6='e' or $leader6='f'"><img alt="carte" src="/opac-tmpl/lib/famfamfam/silk/map.png" title="carte" class="materialtype" /> Carte</xsl:when>
 <xsl:when test="$leader6='g' or $leader6='k' or $leader6='r'"><img alt="matériel visuel" src="/opac-tmpl/lib/famfamfam/silk/film.png" title="matériel visuel" class="materialtype" /> Matériel visuel</xsl:when>
 <xsl:when test="$leader6='c' or $leader6='d'"><img alt="partition" src="/opac-tmpl/lib/famfamfam/silk/music.png" title="partition" class="materialtype" /> Partition</xsl:when>
 <xsl:when test="$leader6='i'"><img alt="son" src="/opac-tmpl/lib/famfamfam/silk/sound.png" title="son" class="materialtype" /> Son</xsl:when>
 <xsl:when test="$leader6='j'"><img alt="musique" src="/opac-tmpl/lib/famfamfam/silk/sound.png" title="musique" class="materialtype" /> Musique</xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="string-length(normalize-space($physicalDescription))">
 <span class="label">; Format: </span><xsl:copy-of select="$physicalDescription"></xsl:copy-of>
 </xsl:if>

 <xsl:if test="$controlField008-21 or $controlField008-22 or $controlField008-24 or $controlField008-26 or $controlField008-29 or $controlField008-34 or $controlField008-33 or $controlField008-30-31 or $controlField008-33">

 <xsl:if test="$typeOf008='CR'">
 <xsl:if test="$controlField008-21 and $controlField008-21 !='|' and $controlField008-21 !=' '">
 <span class="label">; type de ressource continue : </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-21='d'">
 <img alt="base de données" src="/opac-tmpl/lib/famfamfam/silk/database.png" title="base de données" class="format" />
 </xsl:when>
 <xsl:when test="$controlField008-21='l'">
 feuillets mobiles </xsl:when>
 <xsl:when test="$controlField008-21='m'">
 collection </xsl:when>
 <xsl:when test="$controlField008-21='n'">
 Journal </xsl:when>
 <xsl:when test="$controlField008-21='p'">
 périodique </xsl:when>
 <xsl:when test="$controlField008-21='w'">
 <img alt="Site web" src="/opac-tmpl/lib/famfamfam/silk/world_link.png" title="Site web" class="format" />
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='BK' or $typeOf008='CR'">
 <xsl:if test="contains($controlField008-24,'abcdefghijklmnopqrstvwxyz')">
 <span class="label">; nature du contenu : </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="contains($controlField008-24,'a')">
 résumé ou sommaire </xsl:when>
 <xsl:when test="contains($controlField008-24,'b')">
 bibliographie <img alt="bibliographie" src="/opac-tmpl/lib/famfamfam/silk/text_list_bullets.png" title="bibliographie" class="natureofcontents" />
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'c')">
 catalogue </xsl:when>
 <xsl:when test="contains($controlField008-24,'d')">
 dictionnaire </xsl:when>
 <xsl:when test="contains($controlField008-24,'e')">
 encyclopédie </xsl:when>
 <xsl:when test="contains($controlField008-24,'f')">
 manuscrit </xsl:when>
 <xsl:when test="contains($controlField008-24,'g')">
 loi/règlement </xsl:when>
 <xsl:when test="contains($controlField008-24,'i')">
 index </xsl:when>
 <xsl:when test="contains($controlField008-24,'k')">
 discographie </xsl:when>
 <xsl:when test="contains($controlField008-24,'l')">
 Législation </xsl:when>
 <xsl:when test="contains($controlField008-24,'m')">
 thèses </xsl:when>
 <xsl:when test="contains($controlField008-24,'n')">
 étude littéraire </xsl:when>
 <xsl:when test="contains($controlField008-24,'o')">
 commentaire </xsl:when>
 <xsl:when test="contains($controlField008-24,'p')">
 texte programmé </xsl:when>
 <xsl:when test="contains($controlField008-24,'q')">
 filmographie </xsl:when>
 <xsl:when test="contains($controlField008-24,'r')">
 répertoire </xsl:when>
 <xsl:when test="contains($controlField008-24,'s')">
 statistiques </xsl:when>
 <xsl:when test="contains($controlField008-24,'t')">
 <img alt="rapport technique" src="/opac-tmpl/lib/famfamfam/silk/report.png" title="rapport technique" class="natureofcontents" />
 </xsl:when>
 <xsl:when test="contains($controlField008-24,'v')">
 jugement </xsl:when>
 <xsl:when test="contains($controlField008-24,'w')">
 loi ou digeste </xsl:when>
 <xsl:when test="contains($controlField008-24,'z')">
 traité </xsl:when>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="$controlField008-29='1'">
 Publication de conférence </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='CF'">
 <xsl:if test="$controlField008-26='a' or $controlField008-26='e' or $controlField008-26='f' or $controlField008-26='g'">
 <span class="label">; type de fichier informatique : </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-26='a'">
 donnée numérique </xsl:when>
 <xsl:when test="$controlField008-26='e'">
 <img alt="base de données" src="/opac-tmpl/lib/famfamfam/silk/database.png" title="base de données" class="format" />
 </xsl:when>
 <xsl:when test="$controlField008-26='f'">
 <img alt="fonte" src="/opac-tmpl/lib/famfamfam/silk/font.png" title="fonte" class="format" />
 </xsl:when>
 <xsl:when test="$controlField008-26='g'">
 <img alt="jeu" src="/opac-tmpl/lib/famfamfam/silk/controller.png" title="jeu" class="format" />
 </xsl:when>
 </xsl:choose>
 </xsl:if>
 <xsl:if test="$typeOf008='BK'">
 <xsl:if test="(substring($controlField008,25,1)='j') or (substring($controlField008,25,1)='1') or ($controlField008-34='a' or $controlField008-34='b' or $controlField008-34='c' or $controlField008-34='d')">
 <span class="label">; nature du contenu : </span>
 </xsl:if>
 <xsl:if test="substring($controlField008,25,1)='j'">
 brevet </xsl:if>
 <xsl:if test="substring($controlField008,31,1)='1'">
 mélanges </xsl:if>
 <xsl:if test="$controlField008-34='a' or $controlField008-34='b' or $controlField008-34='c' or $controlField008-34='d'">
 <img alt="Biographie" src="/opac-tmpl/lib/famfamfam/silk/user.png" title="Biographie" class="natureofcontents" />
 </xsl:if>

 <xsl:if test="$controlField008-33 and $controlField008-33!='|' and $controlField008-33!='u' and $controlField008-33!=' '">
 <span class="label">; forme littéraire : </span>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="$controlField008-33='0'">
 non-fiction </xsl:when>
 <xsl:when test="$controlField008-33='1'">
 fiction </xsl:when> 
 <xsl:when test="$controlField008-33='e'">
 essai </xsl:when>
 <xsl:when test="$controlField008-33='d'">
 drame </xsl:when>
 <xsl:when test="$controlField008-33='c'">
 bande dessinée </xsl:when>
 <xsl:when test="$controlField008-33='l'">
 fiction </xsl:when>
 <xsl:when test="$controlField008-33='h'">
 humour, satire </xsl:when>
 <xsl:when test="$controlField008-33='i'">
 lettre </xsl:when>
 <xsl:when test="$controlField008-33='f'">
 nouvelle </xsl:when>
 <xsl:when test="$controlField008-33='j'">
 nouvelle </xsl:when>
 <xsl:when test="$controlField008-33='s'">
 discours </xsl:when>
 </xsl:choose>
 </xsl:if> 
 <xsl:if test="$typeOf008='MU' and $controlField008-30-31 and $controlField008-30-31!='||' and $controlField008-30-31!='  '">
 <span class="label">; forme littéraire : </span> <!-- Literary text for sound recordings -->
 <xsl:if test="contains($controlField008-30-31,'b')">
 Biographie </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'c')">
 Publication de conférence </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'d')">
 drame </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'e')">
 essai </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'f')">
 fiction </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'o')">
 conte/légende </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'h')">
 histoire </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'k')">
 humour, satire </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'m')">
 mémoire </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'p')">
 poésie </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'r')">
 rehearsal </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'g')">
 rapporter </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'s')">
 son </xsl:if>
 <xsl:if test="contains($controlField008-30-31,'l')">
 discours </xsl:if>
 </xsl:if>
 <xsl:if test="$typeOf008='VM'">
 <span class="label">; Type de matériel visuel : </span>
 <xsl:choose>
 <xsl:when test="$controlField008-33='a'">
 art original </xsl:when>
 <xsl:when test="$controlField008-33='b'">
 kit </xsl:when>
 <xsl:when test="$controlField008-33='c'">
 reproduction d'art </xsl:when>
 <xsl:when test="$controlField008-33='d'">
 diorama </xsl:when>
 <xsl:when test="$controlField008-33='f'">
 bande de film </xsl:when>
 <xsl:when test="$controlField008-33='g'">
 loi/règlement </xsl:when>
 <xsl:when test="$controlField008-33='i'">
 image </xsl:when>
 <xsl:when test="$controlField008-33='k'">
 graphique </xsl:when>
 <xsl:when test="$controlField008-33='l'">
 dessin technique </xsl:when>
 <xsl:when test="$controlField008-33='m'">
 film </xsl:when>
 <xsl:when test="$controlField008-33='n'">
 graphique </xsl:when>
 <xsl:when test="$controlField008-33='o'">
 carte flash </xsl:when>
 <xsl:when test="$controlField008-33='p'">
 support microscope </xsl:when>
 <xsl:when test="$controlField008-33='q' or marc:controlfield[@tag=007][substring(text(),1,1)='a'][substring(text(),2
,1)='q']">
 modèle </xsl:when>
 <xsl:when test="$controlField008-33='r'">
 realia </xsl:when>
 <xsl:when test="$controlField008-33='s'">
 diapositive </xsl:when>
 <xsl:when test="$controlField008-33='t'">
 transparent </xsl:when>
 <xsl:when test="$controlField008-33='v'">
 enregistrement vidéo </xsl:when>
 <xsl:when test="$controlField008-33='w'">
 jouet </xsl:when>
 </xsl:choose>
 </xsl:if>
 </xsl:if> 

 <xsl:if test="($typeOf008='BK' or $typeOf008='CF' or $typeOf008='MU' or $typeOf008='VM') and ($controlField008-22='a' or $controlField008-22='b' or $controlField008-22='c' or $controlField008-22='d' or $controlField008-22='e' or $controlField008-22='g' or $controlField008-22='j' or $controlField008-22='f')">
 <span class="label">; Public: </span>
 <xsl:choose>
 <xsl:when test="$controlField008-22='a'">
 Préscolaire; </xsl:when>
 <xsl:when test="$controlField008-22='b'">
 Primaire; </xsl:when>
 <xsl:when test="$controlField008-22='c'">
 Pré-adolescent; </xsl:when>
 <xsl:when test="$controlField008-22='d'">
 Adolescent; </xsl:when>
 <xsl:when test="$controlField008-22='e'">
 Adulte; </xsl:when>
 <xsl:when test="$controlField008-22='g'">
 General; </xsl:when>
 <xsl:when test="$controlField008-22='j'">
 jeunesse ; </xsl:when>
 <xsl:when test="$controlField008-22='f'">
 Specialisé; </xsl:when>
 </xsl:choose>
 </xsl:if>
<xsl:text> </xsl:text> <!-- added blank space to fix font display problem, see Bug 3671 -->
 </span>
</xsl:if>

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

 <!-- Other Title Statement: Alternate Graphic Representation (MARC 880) -->
 <xsl:if test="$display880">
 <xsl:call-template name="m880Select">
 <xsl:with-param name="basetags">246</xsl:with-param>
 <xsl:with-param name="codes">ab</xsl:with-param>
 <xsl:with-param name="class">results_summary</xsl:with-param>
 <xsl:with-param name="label">Autre titre : </xsl:with-param>
 </xsl:call-template>
 </xsl:if>
 
 <xsl:if test="marc:datafield[@tag=246]">
 <span class="results_summary">
 <span class="label">Autre titre : </span>
 <xsl:for-each select="marc:datafield[@tag=246]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">ab</xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=242]">
 <span class="results_summary">
 <span class="label">Titre traduit : </span>
 <xsl:for-each select="marc:datafield[@tag=242]">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abh</xsl:with-param>
 </xsl:call-template>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 <xsl:if test="marc:datafield[@tag=856]">
 <span class="results_summary">
 <span class="label">Ressource en ligne&nbsp;: </span>
 <xsl:for-each select="marc:datafield[@tag=856]">
 <xsl:variable name="SubqText"><xsl:value-of select="marc:subfield[@code='q']"/></xsl:variable>
 <xsl:if test="$OPACURLOpenInNewWindow='0'">
 <a>
 <xsl:choose>
 <xsl:when test="$OPACTrackClicks='track'">
 <xsl:attribute name="href">/cgi-bin/koha/tracklinks.pl?uri=<xsl:value-of select="marc:subfield[@code='u']"/>;biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute>
 </xsl:when>
 <xsl:when test="$OPACTrackClicks='anonymous'">
 <xsl:attribute name="href">/cgi-bin/koha/tracklinks.pl?uri=<xsl:value-of select="marc:subfield[@code='u']"/>;biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
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
 <xsl:text>Accès en ligne</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 </xsl:choose>
 </a>
 </xsl:if>
 <xsl:if test="$OPACURLOpenInNewWindow='1'">
 <a target='_blank'>
 <xsl:choose>
 <xsl:when test="$OPACTrackClicks='track'">
 <xsl:attribute name="href">/cgi-bin/koha/tracklinks.pl?uri=<xsl:value-of select="marc:subfield[@code='u']"/>;biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute>
 </xsl:when>
 <xsl:when test="$OPACTrackClicks='anonymous'">
 <xsl:attribute name="href">/cgi-bin/koha/tracklinks.pl?uri=<xsl:value-of select="marc:subfield[@code='u']"/>;biblionumber=<xsl:value-of select="$biblionumber"/></xsl:attribute>
 </xsl:when>
 <xsl:otherwise>
 <xsl:attribute name="href"><xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute>
 </xsl:otherwise>
 </xsl:choose>
 <xsl:choose>
 <xsl:when test="($Show856uAsImage='Results' or $Show856uAsImage='Both') and ($SubqText='img' or $SubqText='bmp' or $SubqText='cod' or $SubqText='gif' or $SubqText='ief' or $SubqText='jpe' or $SubqText='jpeg' or $SubqText='jpg' or $SubqText='jfif' or $SubqText='png' or $SubqText='svg' or $SubqText='tif' or $SubqText='tiff' or $SubqText='ras' or $SubqText='cmx' or $SubqText='ico' or $SubqText='pnm' or $SubqText='pbm' or $SubqText='pgm' or $SubqText='ppm' or $SubqText='rgb' or $SubqText='xbm' or $SubqText='xpm' or $SubqText='xwd')">
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
 <xsl:text>Accès en ligne</xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 </xsl:choose>
 </a>
 </xsl:if>
 <xsl:choose>
 <xsl:when test="position()=last()"><xsl:text> </xsl:text></xsl:when>
 <xsl:otherwise> | </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>
 <span class="results_summary availability">
 <span class="label">Disponibilité: </span>
 <xsl:choose>
 <xsl:when test="count(key('item-by-status', 'available'))=0 and count(key('item-by-status', 'reference'))=0">
 <xsl:choose>
 <xsl:when test="string-length($AlternateHoldingsField)=3 and marc:datafield[@tag=$AlternateHoldingsField]">
 <xsl:variable name="AlternateHoldingsCount" select="count(marc:datafield[@tag=$AlternateHoldingsField])"/>
 <xsl:for-each select="marc:datafield[@tag=$AlternateHoldingsField][1]">
 <xsl:call-template select="marc:datafield[@tag=$AlternateHoldingsField]" name="subfieldSelect">
 <xsl:with-param name="codes"><xsl:value-of select="$AlternateHoldingsSubfields"/></xsl:with-param>
 <xsl:with-param name="delimeter"><xsl:value-of select="$AlternateHoldingsSeparator"/></xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 (<xsl:value-of select="$AlternateHoldingsCount"/>) </xsl:when>
 <xsl:otherwise>Pas d'exemplaires disponible </xsl:otherwise>
 </xsl:choose>
 </xsl:when>
 <xsl:when test="count(key('item-by-status', 'available'))>0">
 <span class="available">
 <b><xsl:text>Exemplaires disponibles au prêt : </xsl:text></b>
 <xsl:variable name="available_items"
                           select="key('item-by-status', 'available')"/>
 <xsl:choose>
 <xsl:when test="$singleBranchMode=1">
 <xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text>)</xsl:text>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:when>
 <xsl:otherwise>
 <xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:value-of select="items:homebranch"/>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber and $OPACItemLocation='callnum'"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text>)</xsl:text>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </xsl:otherwise>
 </xsl:choose>

 </span>
 </xsl:when>
 </xsl:choose>

 <xsl:choose>
 <xsl:when test="count(key('item-by-status', 'reference'))>0">
 <span class="available">
 <b><xsl:text>Exemplaires disponibles sur place&nbsp;: </xsl:text></b>
 <xsl:variable name="reference_items" select="key('item-by-status', 'reference')"/>
 <xsl:for-each select="$reference_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:value-of select="items:homebranch"/>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> [<xsl:value-of select="items:itemcallnumber"/>]</xsl:if>
 <xsl:text> (</xsl:text>
 <xsl:value-of select="count(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch)))"/>
 <xsl:text> )</xsl:text>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:when>
 </xsl:choose>

 <xsl:choose> <xsl:when test="count(key('item-by-status', 'available'))>0">
 <xsl:choose><xsl:when test="count(key('item-by-status', 'reference'))>0">
 <br/>
 </xsl:when></xsl:choose>
 </xsl:when> </xsl:choose>

 <xsl:if test="count(key('item-by-status', 'Checked out'))>0">
 <span class="unavailable">
 <xsl:text>En prêt (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Checked out'))"/>
 <xsl:text>). </xsl:text>
 </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Withdrawn'))>0">
 <span class="unavailable">
 <xsl:text>Retiré (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Withdrawn'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="$hidelostitems='0' and count(key('item-by-status', 'Lost'))>0">
 <span class="unavailable">
 <xsl:text>Perdu (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Lost'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Damaged'))>0">
 <span class="unavailable">
 <xsl:text>Damaged (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Damaged'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'On order'))>0">
 <span class="unavailable">
 <xsl:text>En commande (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'On order'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'In transit'))>0">
 <span class="unavailable">
 <xsl:text>En transit (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'In transit'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 <xsl:if test="count(key('item-by-status', 'Waiting'))>0">
 <span class="unavailable">
 <xsl:text>Réservé (</xsl:text>
 <xsl:value-of select="count(key('item-by-status', 'Waiting'))"/>
 <xsl:text>). </xsl:text> </span>
 </xsl:if>
 </span>
 <xsl:choose>
 <xsl:when test="($OPACItemLocation='location' or $OPACItemLocation='ccode') and (count(key('item-by-status', 'available'))!=0 or count(key('item-by-status', 'reference'))!=0)">
 <span class="results_summary" id="location">
 <span class="label">Location(s): </span>
 <xsl:choose>
 <xsl:when test="count(key('item-by-status', 'available'))>0">
 <span class="available">
 <xsl:variable name="available_items" select="key('item-by-status', 'available')"/>
 <xsl:for-each select="$available_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:choose>
 <xsl:when test="$OPACItemLocation='location'"><b><xsl:value-of select="concat(items:location,' ')"/></b></xsl:when>
 <xsl:when test="$OPACItemLocation='ccode'"><b><xsl:value-of select="concat(items:ccode,' ')"/></b></xsl:when>
 </xsl:choose>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> <xsl:value-of select="items:itemcallnumber"/></xsl:if>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:when>
 <xsl:when test="count(key('item-by-status', 'reference'))>0">
 <span class="available">
 <xsl:variable name="reference_items" select="key('item-by-status', 'reference')"/>
 <xsl:for-each select="$reference_items[generate-id() = generate-id(key('item-by-status-and-branch', concat(items:status, ' ', items:homebranch))[1])]">
 <xsl:choose>
 <xsl:when test="$OPACItemLocation='location'"><b><xsl:value-of select="concat(items:location,' ')"/></b></xsl:when>
 <xsl:when test="$OPACItemLocation='ccode'"><b><xsl:value-of select="concat(items:ccode,' ')"/></b></xsl:when>
 </xsl:choose>
 <xsl:if test="items:itemcallnumber != '' and items:itemcallnumber"> <xsl:value-of select="items:itemcallnumber"/></xsl:if>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>, </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:when>
 </xsl:choose>
 </span>
 </xsl:when>
 </xsl:choose>
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
