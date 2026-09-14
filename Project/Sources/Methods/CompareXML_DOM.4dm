//%attributes = {}
C_TEXT:C284($1; $2)
C_TEXT:C284($domRef1; $domRef2)
$domRef1:=$1
$domRef2:=$2

C_LONGINT:C283($source; $i; $j; $n1; $n2)
C_LONGINT:C283($nbAttributes1; $nbAttributes2)

C_BOOLEAN:C305($error)

C_POINTER:C301($ptrA; $ptrB)

C_BOOLEAN:C305($c1; $c2)

C_TEXT:C284($name1; $name2)
C_TEXT:C284($value1; $value2)
C_TEXT:C284($text1; $text2)

ARRAY LONGINT:C221($_childTypes1; 0)
ARRAY TEXT:C222($_nodeRefs1; 0)

ARRAY LONGINT:C221($_childTypes2; 0)
ARRAY TEXT:C222($_nodeRefs2; 0)

DOM GET XML CHILD NODES:C1081($domRef1; $_childTypes1; $_nodeRefs1)
DOM GET XML CHILD NODES:C1081($domRef2; $_childTypes2; $_nodeRefs2)


For ($source; 1; 2)
	
	If ($source=1)
		$ptrA:=->$_childTypes1
		$ptrB:=->$_nodeRefs1
	Else 
		$ptrA:=->$_childTypes2
		$ptrB:=->$_nodeRefs2
	End if 
	
	$n1:=Size of array:C274($ptrA->)
	For ($i; $n1; 1; -1)
		
		$c1:=($ptrA->{$i}=XML comment:K45:8)
		$c2:=(($ptrA->{$i}=XML DATA:K45:12) & (CleanupText($ptrB->{$i})=""))
		
		If ($c1 | $c2)
			DELETE FROM ARRAY:C228($ptrA->; $i; 1)
			DELETE FROM ARRAY:C228($ptrB->; $i; 1)
		End if 
		
	End for 
	
End for 


$n1:=Size of array:C274($_childTypes1)
$n2:=Size of array:C274($_childTypes2)
If ($n1=$n2)
	
	For ($i; 1; $n1)
		
		Case of 
				
			: ($_childTypes1{$i}=XML ELEMENT:K45:20)
				If ($_childTypes2{$i}=XML ELEMENT:K45:20)
					
					$nbAttributes1:=DOM Count XML attributes:C727($_nodeRefs1{$i})
					$nbAttributes2:=DOM Count XML attributes:C727($_nodeRefs2{$i})
					
					If ($nbAttributes1=$nbAttributes2)
						For ($j; 1; $nbAttributes1)
							DOM GET XML ATTRIBUTE BY INDEX:C729($_nodeRefs1{$i}; $j; $name1; $value1)
							DOM GET XML ATTRIBUTE BY INDEX:C729($_nodeRefs2{$i}; $j; $name2; $value2)
							If ($name1#$name2)
								$error:=True:C214
								$j:=$nbAttributes1  // exit loop
							Else 
								If ($value1#$value2)
									$value1:=SimplifyText($value1)
									$value2:=SimplifyText($value2)
									If ($value1#$value2)
										$error:=True:C214
										$j:=$nbAttributes1  // exit loop
									End if 
								End if 
							End if 
						End for 
						If (Not:C34($error))
							$error:=Not:C34(CompareXML_DOM($_nodeRefs1{$i}; $_nodeRefs2{$i}))  // *** recursive call
						End if 
					Else 
						$error:=True:C214
					End if 
				Else 
					$error:=True:C214
				End if 
				
				
			: ($_childTypes1{$i}=XML DATA:K45:12)
				If ($_childTypes2{$i}=XML DATA:K45:12)
					
					If ($_nodeRefs1{$i}#$_nodeRefs2{$i})
						
						$text1:=Replace string:C233($_nodeRefs1{$i}; ","; ".")
						$text2:=Replace string:C233($_nodeRefs2{$i}; ","; ".")
						If ($text1#$text2)  // toujours différent ?
							$error:=True:C214
						End if 
					End if 
					
				Else 
					$error:=True:C214
				End if 
				
			Else 
				
				
		End case 
		
		
		If ($error)
			$i:=$n1  // exit loop
		End if 
		
	End for 
Else 
	$error:=True:C214
End if 

$0:=Not:C34($error)