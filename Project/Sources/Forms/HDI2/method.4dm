
Case of 
	: (Form event code:C388=On Load:K2:1)
		initHDI
		
		//check if the database run in compiled mode
		If (Is compiled mode:C492=True:C214)
			
			//check if the database run with a 64-bit version
			If (Version type:C495 ?? 64 bit version:K5:25)
				OBJECT SET VISIBLE:C603(*; "errMode"; False:C215)
				OBJECT SET VISIBLE:C603(*; "errRect"; False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*; "errMode"; True:C214)
				OBJECT SET VISIBLE:C603(*; "errRect"; True:C214)
			End if 
			
		Else 
			OBJECT SET VISIBLE:C603(*; "errMode"; True:C214)
			OBJECT SET VISIBLE:C603(*; "errRect"; True:C214)
		End if 
		
		rb1:=1
		progressBar:=1
		nbWorker:=4
		nbLoop:=1
		nbFileToCompare:=5
		
		m_createAnXMLref
		
		$filePath:=Get 4D folder:C485(Current resources folder:K5:16)+"theXmlFile.xml"
		
		refXML:=DOM Parse XML source:C719($filePath)
		
		SET TIMER:C645(30)
		
	: (Form event code:C388=On Timer:K2:25)
		
		DOM EXPORT TO VAR:C863(refXML; varXml)
		
End case 