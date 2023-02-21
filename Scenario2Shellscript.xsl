<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    version="3.0"  
    >
    
    <xsl:output method="text" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    
    <!-- 
        quick helper script that converts Oxygen .scenario file into tentative Bash shell scripts for Saxon
    -->
    
    <xsl:param name="pdu"/>
    
    <xsl:variable name="bashprefix" select="'#!/bin/bash'"/>
    
    <xsl:template match="/">
        <xsl:for-each select=".//scenario">
            <xsl:result-document href="{concat(replace(field[@name='name'],' ', '_'),'.sh')}">
            <xsl:value-of select="$bashprefix"/>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>pdu=SOMEFOLDER&#xa;</xsl:text><!-- hardcoded, not pretty but effective -->
            <xsl:text>currentFileUrl=$1&#xa;</xsl:text>
            <xsl:text>pd=$pdu&#xa;</xsl:text>
                <xsl:value-of select="concat('java -jar saxon9he.jar -xsl:',
                    field[@name='inputXSLURL']/String,
                    ' -s:',
                    field[@name='inputXMLURL']/String,
                    ' -o:',
                    field[@name='outputResource']/String,
                    ''
                    )"/>
                <xsl:if test="//field[@name='cascadingStylesheets']/String-array/String">
                    <xsl:for-each select="//field[@name='cascadingStylesheets']/String-array/String">
                        <xsl:value-of select="concat(' -xsl:',
                            ./data()
                            )"/>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="//field[@name='useConfigFile']/Boolean='true'">
                    <xsl:value-of select="concat(' -config:',
                        //field[@name='configSystemID']/string/data()
                        )"/>
                </xsl:if>
                <xsl:for-each select="//xsltParams/list/transformationParameter">
                    <xsl:value-of select="concat(//paramDescriptor/field[@name='localName']/String/data(),
                        '=&quot;',
                        //field[@name='value']/String/data(),
                        '&quot;'
                        )"/>
                </xsl:for-each>
            <xsl:text>&#xa;&#xa;</xsl:text>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
