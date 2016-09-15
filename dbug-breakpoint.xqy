xquery version "1.0-ml";

module namespace dbug-breakpoint =
    "http://marklogic.com/resource/dbug-breakpoint";

declare function dbug-breakpoint:breakpoints($requestID as xs:unsignedLong) as document-node()
{
	document { <breakpoints>
	{
		for $breakpoint in dbg:breakpoints($requestID)
		return (
		  <expressionID>{$breakpoint}</expressionID>
		  )
	}
	</breakpoints> }	
};

declare function dbug-breakpoint:break($requestID as xs:unsignedLong, $expressionID as xs:unsignedLong?) as document-node()
{
	try {
		dbg:break($requestID, $expressionID),
		document { <success>{fn:true()}</success> }
	}
	catch *
	{
		document { <success>{fn:false()}</success> }
	}
};

declare function dbug-breakpoint:clear($requestID as xs:unsignedLong, $expressionID as xs:unsignedLong) as document-node()
{
	try {
		dbg:clear($requestID, $expressionID),
		document { <success>{fn:true()}</success> }
	}
	catch *
	{
		document { <success>{fn:false()}</success> }
	}
};

