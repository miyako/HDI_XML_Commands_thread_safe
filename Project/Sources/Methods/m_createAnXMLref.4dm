//%attributes = {}
C_TEXT:C284(refXML)
C_TEXT:C284($ref1; $XML)
$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"theXmlFile.xml"

refXML:=DOM Create XML Ref:C861("Menu")
$ref1:=DOM Create XML element:C865(refXML; "food")

$refChild1:=DOM Create XML element:C865($ref1; "name")
DOM SET XML ELEMENT VALUE:C868($refChild1; "Belgian Waffles")
$refChild2:=DOM Create XML element:C865($ref1; "price")
DOM SET XML ELEMENT VALUE:C868($refChild2; 5.95)
$refChild4:=DOM Create XML element:C865($ref1; "calories")
DOM SET XML ELEMENT VALUE:C868($refChild4; 650)
DOM EXPORT TO FILE:C862(refXML; $filePath)
DOM CLOSE XML:C722(refXML)