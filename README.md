# OxygenScenarios2Bash

Transform .scenario file to Bash scripts that call Saxon

Suppose you have a bunch of Oxygen XSL transformation scenarios that you need to run in some order, and you want to automate that. Most of them are simple input-XSL-output, some with a few `xsl:param` declarations. 

1. In Oxygen, select the Transformation scenarios you want to transform
2. right-click to "export selected scenarios", select a file.
3. transform the resulting .scenario file using the `Scenario2Shellscript.xsl` provided here
4. check and adapt the bash commands that are spit out in single `.sh` files
5. build your larger and probably more complex bash scripts from there. 

YMMV. 
