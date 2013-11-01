<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select="//box[position() mod 3 = 1]"/> 
	</xsl:template>	

	<xsl:template match="box">
		<div class="row-fluid">
			<ul class="thumbnails">
				<xsl:for-each select=".|following-sibling::*[not(position() > 2)]">

	            	<xsl:call-template name="box"/>
        		</xsl:for-each> 
        	</ul>
		</div>
	</xsl:template>

	<xsl:template name="box"> 
		<li class="span4">
		    <div class="thumbnail">
		      <img alt="{@name}" style="width: 300px; height: 200px;" src="{@img}" />
		      <div class="caption">
		        <h3><xsl:value-of select="./@name"/></h3>
		        <xsl:value-of select="." disable-output-escaping="yes" />
		      </div>
		    </div>
		</li>
	</xsl:template>
</xsl:stylesheet>