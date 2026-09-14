Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		var $vers : Text
		$vers:=Application version:C493
		Case of 
			: ($vers<"1600")  //1530 means 13R3   1501 means 15.1
				
				Form.quit:=True:C214
				OBJECT SET TITLE:C194(*; "BtnDemo"; Localized string("BtnClose"))
				OBJECT SET VISIBLE:C603(*; "TxtSorry@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "TxtInfo@"; False:C215)
				
				//check if the database run with a 64-bit version
			: (Version type:C495 ?? 64 bit version:K5:25)
				
				Form.quit:=False:C215
				
				
			Else 
				Form.quit:=True:C214
				OBJECT SET TITLE:C194(*; "BtnDemo"; Localized string("BtnClose"))
				OBJECT SET VISIBLE:C603(*; "TxtVersion@"; True:C214)
				OBJECT SET VISIBLE:C603(*; "TxtInfo@"; False:C215)
				
				
		End case 
End case 
