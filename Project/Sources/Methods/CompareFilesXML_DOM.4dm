//%attributes = {"invisible":true}
#DECLARE($path1 : Text; $path2 : Text)->$result : Boolean

var $domRef1; $domRef2 : Text
var $error : Boolean




$domRef1:=DOM Parse XML source:C719($path1; True:C214)
If (ok=1)
	$domRef2:=DOM Parse XML source:C719($path2; True:C214)
	If (ok=1)
		
		$error:=Not:C34(CompareXML_DOM($domRef1; $domRef2))
		
		
		DOM CLOSE XML:C722($domRef1)
		DOM CLOSE XML:C722($domRef2)
		
	Else 
		$error:=True:C214
	End if 
Else 
	$error:=True:C214
End if 


$result:=Not:C34($error)