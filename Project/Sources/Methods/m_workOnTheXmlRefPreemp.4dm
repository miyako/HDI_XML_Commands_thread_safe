//%attributes = {"preemptive":"capable"}
C_TEXT:C284($refXML; $1)
$refXML:=$1

$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"theXmlFile.xml"

//Alert on the arriving error ;). 
ALERT:C41("The next line will create an error if you are running in a preemptive process")
//We try to retrieve the XML transmitted as a parameter.
$ref1:=DOM Create XML element:C865($refXML; "CreatedFromWorker")
If (ok=1)
	//if the xml ref is correctly read do something on it. 
	DOM SET XML ELEMENT VALUE:C868($ref1; "+1!(because your are not in compiled mode!)")
	DOM EXPORT TO FILE:C862($refXML; $filePath)
	
Else 
	// If the xml ref is not correctly read alert the user.
	TEXT TO DOCUMENT:C1237($filePath; "Error the XML ref hasn't be transmitted.")
	
End if 

// The xml ref should be accessible from a cooperative process, but won't be from a preemtive one. 