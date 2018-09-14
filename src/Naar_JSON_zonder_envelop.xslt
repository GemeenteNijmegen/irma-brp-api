<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/" xmlns:gban="https://data-test.nijmegen.nl/GbaNaw/" xmlns:ns2="http://www.competent.nl/gbav/v1" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">





<xsl:for-each select="//Persoon/*">
    "<xsl:value-of select="name()"/>":"<xsl:value-of select="current()"/>"<xsl:choose>
    <xsl:when test="position() != last()">,</xsl:when>
  </xsl:choose>
</xsl:for-each>

</xsl:template>     
</xsl:stylesheet>