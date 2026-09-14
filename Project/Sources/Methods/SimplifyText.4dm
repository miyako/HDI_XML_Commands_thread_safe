//%attributes = {}
C_TEXT:C284($1)

C_TEXT:C284($text)
C_TEXT:C284($result)

C_LONGINT:C283($p)
C_TEXT:C284($paquet)

If (Count parameters:C259=0)
	$text:="   M 120 258.6666666666667   l 80 0   l 0 23.333333333333332   s 0 6 -6 6    l -68 0   s -6 0 -6 -6   l 0 -23.333333333333332   z   "
Else 
	$text:=$1
End if 


If ($text#"")
	
	$text:=$text+" "
	
	While (Position:C15("  "; $text)>0)
		$text:=Replace string:C233($text; "  "; " ")
	End while 
	
	While ($text[[1]]=" ")
		$text:=Substring:C12($text; 2)
	End while 
	
	While ($text#"")
		$p:=Position:C15(" "; $text)
		$paquet:=Substring:C12($text; 1; $p-1)
		$text:=Substring:C12($text; $p+1)
		
		$p:=Position:C15("."; $paquet)
		If ($p<=0)
			$result:=$result+$paquet+" "
		Else 
			$result:=$result+Substring:C12($paquet; 1; $p+4)+" "  // quatre chiffres après la "virgule" (le "point")
		End if 
		
	End while 
	
	$result:=Substring:C12($result; 1; Length:C16($result)-1)
	
End if 

$0:=$result