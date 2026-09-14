//%attributes = {"invisible":true}
If (Get database localization:C1009(Current localization:K5:22)="ja")
	$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("SAMPLES-ja.json").getText(); Is collection:K8:32)
Else 
	$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("SAMPLES-en.json").getText(); Is collection:K8:32)
End if 

ARRAY TEXT:C222(TabControl; 0)
ARRAY TEXT:C222(TextTabControl; 0)
COLLECTION TO ARRAY:C1562($json; TabControl; "Title"; TextTabControl; "Text")

//ALL RECORDS([SAMPLES])
//ORDER BY([SAMPLES]; [SAMPLES]SampleSort)
//SELECTION TO ARRAY([SAMPLES]Title; TabControl)
//SELECTION TO ARRAY([SAMPLES]Text; TextTabControl)
//UNLOAD RECORD([SAMPLES])

TabControl:=0
Var1:=TextTabControl{1}
Var2:=TextTabControl{2}