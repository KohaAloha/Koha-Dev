

<!DOCTYPE stylesheet [<!ENTITY nbsp "&#160;" >]>

<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha-community.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">

<xsl:import href="UNIMARCslimUtils.xsl"/>
<xsl:output method = "html" indent="yes" omit-xml-declaration = "yes" encoding="UTF-8"/>
<xsl:template match="/">
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="marc:record">
 <xsl:variable name="leader" select="marc:leader"/>
 <xsl:variable name="leader6" select="substring($leader,7,1)"/>
 <xsl:variable name="leader7" select="substring($leader,8,1)"/>
 <xsl:variable name="biblionumber" select="marc:datafield[@tag=090]/marc:subfield[@code='a']"/>
 <xsl:variable name="DisplayOPACiconsXSLT" select="marc:sysprefs/marc:syspref[@name='DisplayOPACiconsXSLT']"/>
 <xsl:variable name="OPACURLOpenInNewWindow" select="marc:sysprefs/marc:syspref[@name='OPACURLOpenInNewWindow']"/>
 <xsl:variable name="URLLinkText" select="marc:sysprefs/marc:syspref[@name='URLLinkText']"/>

 <xsl:if test="marc:datafield[@tag=200]">
 <xsl:for-each select="marc:datafield[@tag=200]">
 <h1 class="title">
 <xsl:call-template name="addClassRtl" />
 <xsl:for-each select="marc:subfield">
 <xsl:choose>
 <xsl:when test="@code='a'">
 <xsl:variable name="title" select="."/>
 <xsl:variable name="ntitle"
               select="translate($title, '&#x0088;&#x0089;&#x0098;&#x009C;','')"/>
 <xsl:value-of select="$ntitle" />
 </xsl:when>
 <xsl:when test="@code='b'">
 <xsl:text> [</xsl:text>
 <xsl:value-of select="."/>
 <xsl:text>]</xsl:text>
 </xsl:when>
 <xsl:when test="@code='d'">
 <xsl:text> = </xsl:text>
 <xsl:value-of select="."/>
 </xsl:when>
 <xsl:when test="@code='e'">
 <xsl:text> : </xsl:text>
 <xsl:value-of select="."/>
 </xsl:when>
 <xsl:when test="@code='f'">
 <xsl:text> / </xsl:text>
 <xsl:value-of select="."/>
 </xsl:when>
 <xsl:when test="@code='g'">
 <xsl:text> ; </xsl:text>
 <xsl:value-of select="."/>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>, </xsl:text>
 <xsl:value-of select="."/>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </h1>
 </xsl:for-each>
 </xsl:if>

 <xsl:call-template name="tag_title">
 <xsl:with-param name="tag">454</xsl:with-param>
 <xsl:with-param name="label">Traduction de</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_title">
 <xsl:with-param name="tag">461</xsl:with-param>
 <xsl:with-param name="label">Niveau de l'ensemble</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_title">
 <xsl:with-param name="tag">464</xsl:with-param>
 <xsl:with-param name="label">Niveau de dépouillement</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">700</xsl:with-param>
 <xsl:with-param name="label">Auteur principal</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">710</xsl:with-param>
 <xsl:with-param name="label">Auteur principal collectivité</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">701</xsl:with-param>
 <xsl:with-param name="label">Co-auteur</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">702</xsl:with-param>
 <xsl:with-param name="label">Auteur secondaire&nbsp;: </xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">711</xsl:with-param>
 <xsl:with-param name="label">Co-auteur collectivité</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_7xx">
 <xsl:with-param name="tag">712</xsl:with-param>
 <xsl:with-param name="label">Auteur secondaire collectivité</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_title">
 <xsl:with-param name="tag">500</xsl:with-param>
 <xsl:with-param name="label">Titre uniforme</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_title">
 <xsl:with-param name="tag">503</xsl:with-param>
 <xsl:with-param name="label">Titre uniforme</xsl:with-param>
 </xsl:call-template>

 <xsl:if test="marc:datafield[@tag=101]">
 <span class="results_summary">
 <span class="label">Langue&nbsp;:</span>
 <xsl:for-each select="marc:datafield[@tag=101]">
 <xsl:for-each select="marc:subfield">
 <xsl:choose>
 <xsl:when test="@code='b'">de texte intermédiaire, </xsl:when>
 <xsl:when test="@code='c'">d'ouvrage original, </xsl:when>
 <xsl:when test="@code='d'">de résumé, </xsl:when>
 <xsl:when test="@code='e'">de page de contenus, </xsl:when>
 <xsl:when test="@code='f'">de page de titre, </xsl:when>
 <xsl:when test="@code='g'">de titre propre, </xsl:when>
 <xsl:when test="@code='h'">de libretto, </xsl:when>
 <xsl:when test="@code='i'">de matériel d'accompagnement, </xsl:when>
 <xsl:when test="@code='j'">de sous-titre, </xsl:when>
 </xsl:choose>
 <xsl:value-of select="text()"/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text>.</xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> ; </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=102]">
 <span class="results_summary">
 <span class="label">Pays : </span>
 <xsl:for-each select="marc:datafield[@tag=102]">
 <xsl:for-each select="marc:subfield">
 <xsl:value-of select="text()"/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text>.</xsl:text>
 </xsl:when>
 <xsl:otherwise><xsl:text>, </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:call-template name="tag_comma">
 <xsl:with-param name="tag">205</xsl:with-param>
 <xsl:with-param name="label">Mention d'édition</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_210" />

 <xsl:call-template name="tag_215" />

 <xsl:if test="marc:datafield[@tag=010]/marc:subfield[@code='a']">
 <span class="results_summary"><span class="label">ISBN&nbsp;: </span>
 <xsl:for-each select="marc:datafield[@tag=010]">
 <xsl:variable name="isbn" select="marc:subfield[@code='a']"/>
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text>.</xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text> ; </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=011]">
 <span class="results_summary">
 <span class="label">ISSN&nbsp;: </span>
 <xsl:for-each select="marc:datafield[@tag=011]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text>.</xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>; </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:call-template name="tag_title">
 <xsl:with-param name="tag">225</xsl:with-param>
 <xsl:with-param name="label">Collections</xsl:with-param>
 </xsl:call-template>

 <xsl:if test="marc:datafield[@tag=676]">
 <span class="results_summary">
 <span class="label">Dewey: </span>
 <xsl:for-each select="marc:datafield[@tag=676]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:if test="marc:subfield[@code='v']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='v']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='z']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='z']"/>
 </xsl:if>
 <xsl:if test="not (position()=last())">
 <xsl:text> ; </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=686]">
 <span class="results_summary">
 <span class="label">Classification&nbsp;: </span>
 <xsl:for-each select="marc:datafield[@tag=686]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:if test="marc:subfield[@code='b']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='b']"/>
 </xsl:if>
 <xsl:if test="marc:subfield[@code='c']">
 <xsl:text>, </xsl:text>
 <xsl:value-of select="marc:subfield[@code='c']"/>
 </xsl:if>
 <xsl:if test="not (position()=last())"><xsl:text> ; </xsl:text></xsl:if>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=327]">
 <span class="results_summary">
 <span class="label">Note de contenu : </span>
 <xsl:for-each select="marc:datafield[@tag=327]">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">abcdjpvxyz</xsl:with-param>
 <xsl:with-param name="subdivCodes">jpxyz</xsl:with-param>
 <xsl:with-param name="subdivDelimiter">-- </xsl:with-param>
 </xsl:call-template>
 </xsl:with-param>
 </xsl:call-template>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=330]">
 <span class="results_summary">
 <span class="label">Résumé : </span>
 <xsl:for-each select="marc:datafield[@tag=330]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose>
 <xsl:when test="position()=last()">
 <xsl:text>.</xsl:text>
 </xsl:when>
 <xsl:otherwise>
 <xsl:text>; </xsl:text>
 </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=317]">
 <span class="results_summary">
 <span class="label">Note de provenance&nbsp;: </span>
 <xsl:for-each select="marc:datafield[@tag=317]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=320]">
 <span class="results_summary">
 <span class="label">Bibliographie: </span>
 <xsl:for-each select="marc:datafield[@tag=320]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=328]">
 <span class="results_summary">
 <span class="label">Thèse&nbsp;: </span>
 <xsl:for-each select="marc:datafield[@tag=328]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=333]">
 <span class="results_summary">
 <span class="label">Public: </span>
 <xsl:for-each select="marc:datafield[@tag=333]">
 <xsl:value-of select="marc:subfield[@code='a']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:if test="marc:datafield[@tag=955]">
 <span class="results_summary">
 <span class="label">Etat de collection SUDOC&nbsp;: </span>
 <xsl:for-each select="marc:datafield[@tag=955]">
 <xsl:value-of select="marc:subfield[@code='9']"/>: <xsl:value-of select="marc:subfield[@code='r']"/>
 <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">600</xsl:with-param>
 <xsl:with-param name="label">Sujet - Nom de personne</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">601</xsl:with-param>
 <xsl:with-param name="label">Suject - Auteur collectivité</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">602</xsl:with-param>
 <xsl:with-param name="label">Sujet - Famille</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">604</xsl:with-param>
 <xsl:with-param name="label">Sujet - Auteur/titre</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">606</xsl:with-param>
 <xsl:with-param name="label">Sujet - Nom d'actualité</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">607</xsl:with-param>
 <xsl:with-param name="label">Sujet - Nom géographique</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">608</xsl:with-param>
 <xsl:with-param name="label">Sujet - Forme</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">610</xsl:with-param>
 <xsl:with-param name="label">Sujet</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">615</xsl:with-param>
 <xsl:with-param name="label">Sujet Catégorie</xsl:with-param>
 </xsl:call-template>

 <xsl:call-template name="tag_subject">
 <xsl:with-param name="tag">616</xsl:with-param>
 <xsl:with-param name="label">Marque commerciale</xsl:with-param>
 </xsl:call-template>

 <xsl:if test="marc:datafield[@tag=856]">
 <span class="results_summary">
 <span class="label">Ressource en ligne</span>
 <xsl:for-each select="marc:datafield[@tag=856]">
 <a>
 <xsl:attribute name="href">
 <xsl:value-of select="marc:subfield[@code='u']"/>
 </xsl:attribute>
 <xsl:if test="$OPACURLOpenInNewWindow='1'">
 <xsl:attribute name="target">_blank</xsl:attribute>
 </xsl:if>
 <xsl:choose>
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
 <xsl:choose>
 <xsl:when test="position()=last()"></xsl:when>
 <xsl:otherwise> | </xsl:otherwise>
 </xsl:choose>
 </xsl:for-each>
 </span>
 </xsl:if>

 <!-- 780 -->
 <xsl:if test="marc:datafield[@tag=780]">
 <xsl:for-each select="marc:datafield[@tag=780]">
 <span class="results_summary">
 <xsl:choose>
 <xsl:when test="@ind2=0">
 <span class="label">Continu :</span>
 </xsl:when>
 <xsl:when test="@ind2=1">
 <span class="label">En partie continué :</span>
 </xsl:when>
 <xsl:when test="@ind2=2">
 <span class="label">Remplace :</span>
 </xsl:when>
 <xsl:when test="@ind2=3">
 <span class="label">Remplace en partie :</span>
 </xsl:when>
 <xsl:when test="@ind2=4">
 <span class="label">Fusion de ... et ...</span>
 </xsl:when>
 <xsl:when test="@ind2=5">
 <span class="label">Absorbé :</span>
 </xsl:when>
 <xsl:when test="@ind2=6">
 <span class="label">Absorbé en partie :</span>
 </xsl:when>
 <xsl:when test="@ind2=7">
 <span class="label">Séparé de:</span>
 </xsl:when>
 </xsl:choose>
 <xsl:variable name="f780">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="translate($f780, '()', '')"/></xsl:attribute>
 <xsl:value-of select="translate($f780, '()', '')"/>
 </a>
 </span>

 <xsl:choose>
 <xsl:when test="@ind1=0">
 <span class="results_summary"><xsl:value-of select="marc:subfield[@code='n']"/></span>
 </xsl:when>
 </xsl:choose>

 </xsl:for-each>
 </xsl:if>

 <!-- 785 -->
 <xsl:if test="marc:datafield[@tag=785]">
 <xsl:for-each select="marc:datafield[@tag=785]">
 <span class="results_summary">
 <xsl:choose>
 <xsl:when test="@ind2=0">
 <span class="label">Devient :</span>
 </xsl:when>
 <xsl:when test="@ind2=1">
 <span class="label">En partie continué par : </span>
 </xsl:when>
 <xsl:when test="@ind2=2">
 <span class="label">Remplacé par&nbsp;:</span>
 </xsl:when>
 <xsl:when test="@ind2=3">
 <span class="label">Remplacé en partie par :</span>
 </xsl:when>
 <xsl:when test="@ind2=4">
 <span class="label">Absorbé par :</span>
 </xsl:when>
 <xsl:when test="@ind2=5">
 <span class="label">Absorbé en partie par :</span>
 </xsl:when>
 <xsl:when test="@ind2=6">
 <span class="label">Séparé en ... et ... :</span>
 </xsl:when>
 <xsl:when test="@ind2=7">
 <span class="label">Fusionné avec ... pour former ...</span>
 </xsl:when>
 <xsl:when test="@ind2=8">
 <span class="label">Redevient :</span>
 </xsl:when>

 </xsl:choose>
 <xsl:variable name="f785">
 <xsl:call-template name="subfieldSelect">
 <xsl:with-param name="codes">a_t</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>

 <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="translate($f785, '()', '')"/></xsl:attribute>
 <xsl:value-of select="translate($f785, '()', '')"/>
 </a>

 </span>
 </xsl:for-each>
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

 <xsl:template name="part">
 <xsl:variable name="partNumber">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">n</xsl:with-param>
 <xsl:with-param name="anyCodes">n</xsl:with-param>
 <xsl:with-param name="afterCodes">fghkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:variable name="partName">
 <xsl:call-template name="specialSubfieldSelect">
 <xsl:with-param name="axis">p</xsl:with-param>
 <xsl:with-param name="anyCodes">p</xsl:with-param>
 <xsl:with-param name="afterCodes">fghkdlmor</xsl:with-param>
 </xsl:call-template>
 </xsl:variable>
 <xsl:if test="string-length(normalize-space($partNumber))">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$partNumber"/>
 </xsl:call-template>
 </xsl:if>
 <xsl:if test="string-length(normalize-space($partName))">
 <xsl:call-template name="chopPunctuation">
 <xsl:with-param name="chopString" select="$partName"/>
 </xsl:call-template>
 </xsl:if>
 </xsl:template>

 <xsl:template name="specialSubfieldSelect">
 <xsl:param name="anyCodes"/>
 <xsl:param name="axis"/>
 <xsl:param name="beforeCodes"/>
 <xsl:param name="afterCodes"/>
 <xsl:variable name="str">
 <xsl:for-each select="marc:subfield">
 <xsl:if test="contains($anyCodes, @code)      or (contains($beforeCodes,@code) and following-sibling::marc:subfield[@code=$axis])      or (contains($afterCodes,@code) and preceding-sibling::marc:subfield[@code=$axis])">
 <xsl:value-of select="text()"/>
 <xsl:text> </xsl:text>
 </xsl:if>
 </xsl:for-each>
 </xsl:variable>
 <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
 </xsl:template>

</xsl:stylesheet>
