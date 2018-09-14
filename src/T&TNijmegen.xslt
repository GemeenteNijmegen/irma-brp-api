<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="xml"/>
    <xsl:template exclude-result-prefixes="xs S gban ns2" match="/" xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:gban="https://data-test.nijmegen.nl/GbaNaw/" xmlns:ns2="http://www.competent.nl/gbav/v1" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xs="http://www.w3.org/2001/XMLSchema">
        <!--<soapenv:Envelope xmlns:gban="https://data-test.nijmegen.nl/GbaNaw/" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">-->
            
            <xsl:variable name="rootPersoon" select="/S:Envelope/S:Body/ns2:gbavAntwoord/resultaten/persoon"/>
                     
                    <Persoon>
                                              
                        <BSN>
							<BSN><xsl:value-of select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0120']/waarde/text()"/></BSN>
						</BSN>
						<Persoonsgegevens>
							<Voorletters>
                            <xsl:call-template name="create_voorletters">
                                <xsl:with-param name="voornamen" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0210']/waarde/text()"/>
                            </xsl:call-template>
                        </Voorletters>
							<Voornamen><xsl:value-of select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0210']/waarde/text()"/></Voornamen>
							<Voorvoegsel><xsl:value-of select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0230']/waarde/text()"/></Voorvoegsel>
							<Geslachtsnaam><xsl:value-of select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0240']/waarde/text()"/></Geslachtsnaam>
							<xsl:choose>
                            <xsl:when test="$rootPersoon/categorieen/categorie[nummer='05']">
                                <!-- cat05 bestaat, dus for-each om actuele partner te achterhalen --> <xsl:for-each select="$rootPersoon/categorieen/categorie[nummer='05']">
                                    <xsl:variable name="showCurrent" select="current()/text()"> </xsl:variable>
                                    <xsl:if test="current()/rubrieken/rubriek[nummer='0610']/waarde/text()"> 
                                        
                                        <Achternaam>
                                            <xsl:call-template name="create_naam">
                                                <xsl:with-param name="naamgebruik" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='6110']/waarde/text()"/>
                                                <xsl:with-param name="voorvoegselGeslachtsnaam" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0230']/waarde/text()"/>
                                                <xsl:with-param name="achternaam" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0240']/waarde/text()"/>
                                                <xsl:with-param name="voorvoegselGeslachtsnaamPartner" select="current()/rubrieken/rubriek[nummer='0230']/waarde/text()"/>
                                                <xsl:with-param name="AchternaamPartner" select="current()/rubrieken/rubriek[nummer='0240']/waarde/text()"/>
                                            </xsl:call-template>
                                        </Achternaam>
                                        
                                        <Naam>
                                            <xsl:call-template name="create_naam">
                                                <xsl:with-param name="voornamen" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0210']/waarde/text()"/>
                                                <xsl:with-param name="naamgebruik" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='6110']/waarde/text()"/>
                                                <xsl:with-param name="voorvoegselGeslachtsnaam" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0230']/waarde/text()"/>
                                                <xsl:with-param name="achternaam" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0240']/waarde/text()"/>
                                                <xsl:with-param name="voorvoegselGeslachtsnaamPartner" select="current()/rubrieken/rubriek[nummer='0230']/waarde/text()"/>
                                                <xsl:with-param name="AchternaamPartner" select="current()/rubrieken/rubriek[nummer='0240']/waarde/text()"/>
                                            </xsl:call-template>
                                        </Naam>
                                
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:when> 
                            
                            <xsl:otherwise>
                                <!-- geen (ex)partner, meteen <naam> vullen dus maar -->
								<Achternaam>
										<xsl:call-template name="create_naam">
											<xsl:with-param name="naamgebruik" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='6110']/waarde/text()"/>
											<xsl:with-param name="voorvoegselGeslachtsnaam" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0230']/waarde/text()"/>
											<xsl:with-param name="achternaam" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0240']/waarde/text()"/>
											<xsl:with-param name="voorvoegselGeslachtsnaamPartner" select="leeg"/>
											<xsl:with-param name="AchternaamPartner" select="leeg"/>
										</xsl:call-template>
									</Achternaam>                    	
                                <Naam>
                                    <xsl:call-template name="create_naam">
                                        <xsl:with-param name="voornamen" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0210']/waarde/text()"/>
                                        <xsl:with-param name="naamgebruik" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='6110']/waarde/text()"/>
                                        <xsl:with-param name="voorvoegselGeslachtsnaam" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0230']/waarde/text()"/>
                                        <xsl:with-param name="achternaam" select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0240']/waarde/text()"/>
                                        <xsl:with-param name="voorvoegselGeslachtsnaamPartner" select="leeg"/>
                                        <xsl:with-param name="AchternaamPartner" select="leeg"/>
                                    </xsl:call-template>
                                </Naam>                    			
                            </xsl:otherwise>
                        </xsl:choose> 
							<Geboortedatum><xsl:value-of select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0310']/waarde"/></Geboortedatum>        
							<Geslacht><xsl:value-of select="$rootPersoon/categorieen/categorie[nummer='01']/rubrieken/rubriek[nummer='0410']/waarde"/></Geslacht>
							<NederlandseNationaliteit>
									<xsl:choose>
									  <xsl:when test="$rootPersoon/categorieen/categorie[nummer='04']/rubrieken/rubriek[nummer='0510']/waarde ='0001'">Ja</xsl:when>
									  <xsl:otherwise>Nee</xsl:otherwise>
										</xsl:choose>
										</NederlandseNationaliteit>
						</Persoonsgegevens>
						<Adres>
								<Straat><xsl:value-of select="$rootPersoon/categorieen/categorie[nummer='08']/rubrieken/rubriek[nummer='1115']/waarde/text()"/></Straat>
								<Huisnummer> 
                            <xsl:call-template name="create_adres">
                                <xsl:with-param name="huisnummer" select="$rootPersoon/categorieen/categorie[nummer='08']/rubrieken/rubriek[nummer='1120']/waarde/text()"/>
                                <xsl:with-param name="huisletter" select="$rootPersoon/categorieen/categorie[nummer='08']/rubrieken/rubriek[nummer='1130']/waarde/text()"/>
                                <xsl:with-param name="hnrtoevoeging" select="$rootPersoon/categorieen/categorie[nummer='08']/rubrieken/rubriek[nummer='1140']/waarde/text()"/>
                                <xsl:with-param name="hnraanduiding" select="$rootPersoon/categorieen/categorie[nummer='08']/rubrieken/rubriek[nummer='1150']/waarde/text()"/>
                            </xsl:call-template>
                       </Huisnummer>
								<Gemeente><xsl:value-of select="$rootPersoon/categorieen/categorie[nummer='08']/rubrieken/rubriek[nummer='0910']/omschrijving/text()"/></Gemeente>
								<Postcode>
                            <xsl:call-template name="create_postcode">
                                <xsl:with-param name="pcode" select="$rootPersoon/categorieen/categorie[nummer='08']/rubrieken/rubriek[nummer='1160']/waarde/text()"/>
                            </xsl:call-template>
                        </Postcode>
						<Woonplaats><xsl:value-of select="$rootPersoon/categorieen/categorie[nummer='08']/rubrieken/rubriek[nummer='1170']/omschrijving/text()"/></Woonplaats>
						</Adres>						
									
						<Reisdocument>
							<xsl:for-each select="$rootPersoon/categorieen/categorie[nummer='12']">
    
							<xsl:if test="not(./rubrieken/rubriek[nummer='3560']/omschrijving)"> 

							<Documentsoort><xsl:value-of select="./rubrieken/rubriek[nummer='3510']/omschrijving/text()"/></Documentsoort>
							<Documentnummer><xsl:value-of select="./rubrieken/rubriek[nummer='3520']/waarde/text()"/></Documentnummer>
							<Uitgiftedatum><xsl:value-of select="./rubrieken/rubriek[nummer='3530']/waarde/text()"/></Uitgiftedatum>
							<Verloopdatum><xsl:value-of select="./rubrieken/rubriek[nummer='3550']/waarde/text()"/></Verloopdatum>
							</xsl:if>
							</xsl:for-each>
						</Reisdocument>
						<ageLimits>
							<over12></over12>
							<over16></over16>
							<over18></over18>
							<over21></over21>
							<over65></over65>
						</ageLimits>						
												
												
							
                    </Persoon>
        <!--</soapenv:Envelope>-->
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

    <!-- ############################################# -->
    <xsl:template name="create_adres">
        <!-- ############################################# -->
        <xsl:param name="straatnaam"/>
        <xsl:param name="huisnummer"/>
        <xsl:param name="huisletter"/>
        <xsl:param name="hnrtoevoeging"/>
        <xsl:param name="hnraanduiding"/>

        <xsl:value-of select="$straatnaam"/>
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


    <!-- ############################################# -->
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
                <xsl:value-of select="concat($voorletters, $voorvoegselGeslachtsnaam, $achternaam)"/>
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

</xsl:stylesheet>