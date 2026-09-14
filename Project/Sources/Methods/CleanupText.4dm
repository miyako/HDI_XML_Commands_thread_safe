//%attributes = {"invisible":true}
#DECLARE($input : Text)->$result : Text

var $text : Text
$text:=$input

$text:=Replace string:C233($text; " "; "")
$text:=Replace string:C233($text; Char:C90(Tab:K15:37); "")
$text:=Replace string:C233($text; Char:C90(Carriage return:K15:38); "")
$text:=Replace string:C233($text; Char:C90(Line feed:K15:40); "")

$result:=$text
