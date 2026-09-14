//%attributes = {}
C_TEXT:C284($1)
C_TEXT:C284($0)
C_TEXT:C284($text)

$text:=$1

$text:=Replace string:C233($text; " "; "")
$text:=Replace string:C233($text; Char:C90(Tab:K15:37); "")
$text:=Replace string:C233($text; Char:C90(Carriage return:K15:38); "")
$text:=Replace string:C233($text; Char:C90(Line feed:K15:40); "")

$0:=$text
