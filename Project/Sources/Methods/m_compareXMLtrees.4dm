//%attributes = {"invisible":true}
#DECLARE($winRef : Integer; $preemptif : Boolean; $nbWorker : Integer; $nbLoop : Integer; $nbFileToCompare : Integer)

var $folderPath; $workerName; $message; $referenceGraphPath : Text
var $startComparaison; $endComparaison : Time
var $totalTime; $n; $i : Integer
var $running : Boolean

$startComparaison:=Milliseconds:C459

$message:=""
$folderPath:=Get 4D folder:C485(Current resources folder:K5:16)+"FilesXML"+Folder separator:K24:12

ARRAY TEXT:C222($myXMLDoc; 0)
DOCUMENT LIST:C474($folderPath; $myXMLDoc)

$n:=$nbFileToCompare
//Size of array($myXMLDoc)

ARRAY LONGINT:C221(_psID; $nbWorker)
For ($i; 1; $n)
	
	$referenceGraphPath:=$folderPath+$myXMLDoc{$i}
	$workerName:="Worker"+String:C10($i%$nbWorker)
	
	If ($preemptif)
		CALL WORKER:C1389($workerName; "secondLoopPreem"; $referenceGraphPath; $nbLoop)
	Else 
		CALL WORKER:C1389($workerName; "secondLoopCoop"; $referenceGraphPath; $nbLoop)
	End if 
	
	_psID{($i%$nbWorker)+1}:=Process number:C372($workerName)
	
	
End for 


Repeat 
	//bing the method in order to see if it's still running.
	$running:=True:C214
	For ($i; 0; $nbWorker)
		If (Process state:C330(_psID{$i})=Waiting for user event:K13:9)
			$running:=False:C215
		Else 
			DELAY PROCESS:C323(Current process:C322; 6)
		End if 
	End for 
	
Until ($running=False:C215)

For ($i; 0; $nbWorker)
	KILL WORKER:C1390(_psID{$i})
End for 

$endComparaison:=Milliseconds:C459
$totalTime:=$endComparaison-$startComparaison
$message:=Localized string("MsgTimeElapsedPrefix")+String:C10($totalTime)+Localized string("MsgTimeElapsedSuffix")

CALL FORM:C1391($winRef; "m_updateVar"; $message)
