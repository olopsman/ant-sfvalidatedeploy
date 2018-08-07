<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:doc="http://soap.sforce.com/2006/04/metadata">
	
	<!-- Created by Gregory GACKIERE from Salesforce.com -->
	
	<xsl:output omit-xml-declaration="yes" indent="no"  encoding="UTF-8" method="text" />
	<xsl:strip-space elements="*"/>
 
	<xsl:template match="doc:CustomObject" mode="inFile">
		<xsl:param name="folder" />
		<xsl:param name="filename" />
		<xsl:param name="objectlabel" select="doc:label" />
		<xsl:param name="curr-label" select="substring-before($filename,'.')"/>

		<xsl:for-each select="doc:fields">
			<!-- Check if there is no description -->
			<xsl:if test="not(doc:description)">
				<xsl:value-of select="substring-before($filename,'.')"/><xsl:text>,</xsl:text>
				<xsl:value-of select="$objectlabel"/><xsl:text>,</xsl:text>
				<xsl:value-of select="doc:fullName"/><xsl:text>,</xsl:text>
				<xsl:value-of select="doc:type"/>
				<xsl:text>&#xa;</xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="/">
		<xsl:for-each select="collection(iri-to-uri('ExportFolder-1/objects/?select=*.object;recurse=yes'))">
			<xsl:apply-templates mode="inFile" select=".">
				<xsl:with-param name="folder"><xsl:value-of select="tokenize(document-uri(.), '/')[last()-1]"/></xsl:with-param>
				<xsl:with-param name="filename"><xsl:value-of select="tokenize(document-uri(.), '/')[last()]"/></xsl:with-param> 
			</xsl:apply-templates>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>