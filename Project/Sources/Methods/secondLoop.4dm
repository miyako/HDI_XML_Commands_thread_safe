//%attributes = {"invisible":true}
#DECLARE($referenceGraphPath : Text; $nbLoop : Integer)
var $n : Integer
var $test : Boolean

For ($n; 1; $nbLoop)
	$test:=CompareFilesXML_DOM($referenceGraphPath; $referenceGraphPath)
End for 
