<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:a="http://www.egem.nl/StUF/StUF0301"
xpath-default-namespace="http://www.egem.nl/StUF/sector/bg/0310">
<xsl:output method="xml"/>
<xsl:template match="/" exclude-result-prefixes="a s">
	<Persoon>
		<BSN>
			<BSN><xsl:value-of select="//object/inp.bsn"/></BSN>
		</BSN>	
		<Persoonsgegevens>
		<Voorletters><xsl:value-of select="//object/voorletters"/></Voorletters>
		<Voornamen><xsl:value-of select="//object/voornamen"/></Voornamen>
		<Voorvoegsel><xsl:value-of select="//object/voorvoegselGeslachtsnaam"/></Voorvoegsel>
		<Geslachtsnaam><xsl:value-of select="//object/geslachtsnaam"/></Geslachtsnaam>
		<Achternaam><xsl:call-template name="create_naam">
                   <xsl:with-param name="naamgebruik" select="//object/aanduidingNaamgebruik"/>
                   <xsl:with-param name="voorvoegselGeslachtsnaam" select="//object/voorvoegselGeslachtsnaam"/>
                   <xsl:with-param name="achternaam" select="//geslachtsnaam"/>
                   <xsl:with-param name="voorvoegselGeslachtsnaamPartner" select="//object/voorvoegselGeslachtsnaamPartner"/>
                   <xsl:with-param name="AchternaamPartner" select="//object/geslachtsnaamPartner"/>
                       </xsl:call-template></Achternaam>
        <VolledigeNaam><xsl:call-template name="create_naam">
                   <xsl:with-param name="voornamen" select="//object/voornamen"/>
                   <xsl:with-param name="naamgebruik" select="//object/aanduidingNaamgebruik"/>
                   <xsl:with-param name="voorvoegselGeslachtsnaam" select="//object/voorvoegselGeslachtsnaam"/>
                   <xsl:with-param name="achternaam" select="//geslachtsnaam"/>
                   <xsl:with-param name="voorvoegselGeslachtsnaamPartner" select="//object/voorvoegselGeslachtsnaamPartner"/>
                   <xsl:with-param name="AchternaamPartner" select="//object/geslachtsnaamPartner"/>
                       </xsl:call-template></VolledigeNaam>   
        <Geboortedatum><xsl:value-of select="//object/geboortedatum"/></Geboortedatum>        
		<Geslacht><xsl:value-of select="//object/geslachtsaanduiding"/></Geslacht>
        <NederlandseNationaliteit>
				<xsl:choose>
				  <xsl:when test="//inp.heeftAlsNationaliteit/gerelateerde/omschrijving ='Nederlandse'">Ja</xsl:when>
				  <xsl:otherwise>Nee</xsl:otherwise>
					</xsl:choose>
					</NederlandseNationaliteit>
		</Persoonsgegevens>
		<Adres>
		<Straat><xsl:value-of select="//gor.openbareRuimteNaam"/></Straat>
        <Huisnummer> <xsl:call-template name="create_adres">
                                <xsl:with-param name="huisnummer" select="//aoa.huisnummer"/>
                                <xsl:with-param name="huisletter" select="//aoa.huisletter"/>
                                <xsl:with-param name="hnrtoevoeging" select="//aoa.aanduiding"/>
                                <xsl:with-param name="hnraanduiding" select="//oa.aanduiding"/>
                            </xsl:call-template></Huisnummer>
        <Gemeente>Nijmegen</Gemeente>
        <Postcode>
				<xsl:choose>
					<xsl:when test="//aoa.postcode">
			                <xsl:value-of select="//gor.openbareRuimteNaam"/>
                    </xsl:when>
                    <xsl:when test="//postcode">
			                <xsl:value-of select="//postcode"/>
                    </xsl:when>        
                </xsl:choose>            
            </Postcode>
        <Woonplaats><xsl:value-of select="//wpl.woonplaatsNaam"/></Woonplaats>
		</Adres>
		<Reisdocument>
		<Documentsoort></Documentsoort>
		<Documentnummer></Documentnummer>
		<Uitgiftedatum></Uitgiftedatum>
        <Verloopdatum></Verloopdatum>
        <Uitgever></Uitgever>
        </Reisdocument>
        
			
	</Persoon>
		
		
		
    
	</xsl:template>
	
	
	 <!-- ############################################# -->
    <!-- Aanmaken geboorte datum in formaat: DD-MM-YYYY -->
    <xsl:template name="create_geboortedatum">
        <!-- ############################################# -->
        <xsl:param name="gdatum"/>
        <xsl:value-of select="substring($gdatum,7,2)"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="substring($gdatum,5,2)"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="substring($gdatum,1,4)"/>
    </xsl:template>
    
    
    <!-- ############################################# -->
    <!-- Aanmaken Postcode in formaat: AAAA BB -->
    <xsl:template name="create_postcode">
        <!-- ############################################# -->
        <xsl:param name="pcode"/>
        <xsl:value-of select="substring($pcode,1,4)"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="substring($pcode,5,2)"/>
    </xsl:template>
    
        <xsl:template name="create_voorletters">
        <!-- ############################################# -->
        <xsl:param name="voornamen" select="' '"/>
        <xsl:param name="separator" select="' '"/>
        <xsl:for-each select="tokenize($voornamen,$separator)">
            <xsl:value-of select="substring(.,1,1)"/>
            <xsl:text>.</xsl:text>
        </xsl:for-each>
        <xsl:text/>
    </xsl:template>
    
     <!-- ############################################# -->
    <xsl:template name="create_naam">
        <!-- ############################################# -->
        <xsl:param name="voornamen"/>
        <xsl:param name="naamgebruik"/>
        <xsl:param name="voorvoegselGeslachtsnaam"/>
        <xsl:param name="achternaam"/>
        <xsl:param name="voorvoegselGeslachtsnaamPartner"/>
        <xsl:param name="AchternaamPartner"/>

        <xsl:variable name="voorletters">
            <xsl:call-template name="create_voorletters">
                <xsl:with-param name="voornamen" select="$voornamen"/>
            </xsl:call-template>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$naamgebruik = 'E' ">
                <!-- .Naam = String.Format("{0} {1} {2}", .Voorletters, .Tussenvoegsels, .Achternaam) -->
                <xsl:value-of select="concat($voorletters, $voorvoegselGeslachtsnaam,' ', $achternaam)"/>
            </xsl:when>

            <xsl:when test="$naamgebruik = 'P' ">
                <!-- .Naam = String.Format("{0} {1} {2}", .Voorletters, .TussenvoegselsPartner, .AchternaamPartner) -->
                <xsl:value-of select="concat($voorletters,$voorvoegselGeslachtsnaamPartner,$AchternaamPartner)"/>
            </xsl:when>

            <xsl:when test="$naamgebruik = 'V' ">
                <!-- .Naam = String.Format("{0} {1} {2}-{3} {4}", .Voorletters, .TussenvoegselsPartner, .AchternaamPartner, .Tussenvoegsels, .Achternaam) -->
                <xsl:value-of select="concat($voorletters,' ',$voorvoegselGeslachtsnaamPartner,$AchternaamPartner,'-',$voorvoegselGeslachtsnaam,$achternaam)"/>
            </xsl:when>

            <xsl:when test="$naamgebruik = 'N' ">
                <!-- .Naam = String.Format("{0} {1} {2}-{3} {4}", .Voorletters, .Tussenvoegsels, .Achternaam, .TussenvoegselsPartner, .AchternaamPartner) -->
                <xsl:value-of select="concat($voorletters,$voorvoegselGeslachtsnaam,$achternaam,'-',$voorvoegselGeslachtsnaamPartner,$AchternaamPartner)"/>
            </xsl:when>

        </xsl:choose>
        <!-- .Naam = Trim(.Naam).Replace("  ", " ") -->


    </xsl:template>
     

  <!-- ############################################# -->
    <xsl:template name="create_adres">
        <!-- ############################################# -->
        <xsl:param name="huisnummer"/>
        <xsl:param name="huisletter"/>
        <xsl:param name="hnrtoevoeging"/>
        <xsl:param name="hnraanduiding"/>

        
        <xsl:value-of select="$huisnummer"/>
        <xsl:value-of select="$huisletter"/>
        <xsl:value-of select="$hnrtoevoeging"/>
        <!-- aanduidingBijHuisnummer alleen toevoegen als deze een waarde heeft -->
        <xsl:choose>
            <xsl:when test="$hnraanduiding != ''">
                <xsl:text>(</xsl:text>
                <xsl:value-of select="$hnraanduiding"/>
                <xsl:text>)</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
	