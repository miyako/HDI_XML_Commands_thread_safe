//%attributes = {}
C_TEXT:C284($referenceGraphPath)
C_LONGINT:C283($n; $nbLoop)
C_BOOLEAN:C305($test)

$referenceGraphPath:=$1
$nbLoop:=$2

For ($n; 1; $nbLoop)
	$test:=CompareFilesXML_DOM($referenceGraphPath; $referenceGraphPath)
End for 
