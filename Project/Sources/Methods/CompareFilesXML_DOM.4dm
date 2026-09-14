//%attributes = {}
C_TEXT:C284($1; $2)
C_TEXT:C284($path1; $path2)

$path1:=$1
$path2:=$2

C_TEXT:C284($domRef1; $domRef2)
C_BOOLEAN:C305($error)




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


$0:=Not:C34($error)