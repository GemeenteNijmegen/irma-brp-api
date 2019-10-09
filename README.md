# this repo is merged with https://github.com/GemeenteNijmegen/irma-brp-opladen

# irma-brp-api
Api die transformeert van lokale GBA of GBA-V van T&T naar een json bericht.

/src bevat de xslt's die de transformatie verzorgen, inclusief wat logica om voorletters en achternaam goed samen te stellen.
/sample contains some sample T&T GBA-V messages as test input for the xslt.

Deze xslt's worden gebruikt in een applicatie gemaakt voor de Mulesoft ESB (https://www.mulesoft.com/platform/mule).
De applicatie zelf wordt binnenkort ook gepubliceerd, maar is alleen bruikbaar als je over een Mule Enterprise licentie beschikt.
Met wat aanpassingen is de applicatie ook geschikt te maken voor de opensource, en gratis te gebruiken, versie van Mulesoft.
