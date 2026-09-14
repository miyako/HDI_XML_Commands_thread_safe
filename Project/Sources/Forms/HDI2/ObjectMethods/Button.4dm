C_LONGINT:C283($nbElement)


If (rb1=1)
	//CALL WORKER("processCoop";m_workOnTheXmlRefCoop;refXML)
	
	CALL WORKER:C1389("processCoop"; "m_workOnTheXmlRefCoop"; refXML)
	
Else 
	CALL WORKER:C1389("processPreemp"; "m_workOnTheXmlRefPreemp"; refXML)
End if 