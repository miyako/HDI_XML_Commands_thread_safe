//%attributes = {"invisible":true}
#DECLARE($refXML : Text)

$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"theXmlFile.xml"

//We try to retrieve the XML transmitted as a parameter.
$ref1:=DOM Create XML element:C865($refXML; "CreatedFromCooperativeProcess")
If (ok=1)
	//if the xml ref is correctly read do something on it. 
	DOM SET XML ELEMENT VALUE:C868($ref1; "+1!")
	DOM EXPORT TO FILE:C862($refXML; $filePath)
	
Else 
	// If the xml ref is not correctly read alert the user.
	TEXT TO DOCUMENT:C1237($filePath; Localized string("ErrorXMLRefNotTransmitted"))
	
End if 

// The xml ref should be accessible from a cooperative process, but won't be from a preemtive one. 