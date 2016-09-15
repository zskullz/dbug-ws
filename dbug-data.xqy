xquery version "1.0-ml";

module namespace dbug-data =
    "http://marklogic.com/resource/dbug-data";

declare function dbug-data:get-expressionID($requestID as xs:unsignedLong, $uri as xs:string, $functionName as xs:QName) as document-node()
{
	document {
		<expressionID>
		{
			dbg:function($requestID, $uri, $functionName)
		}
		</expressionID>
	}
};

declare function dbug-data:get-expression($requestID as xs:unsignedLong, $expressionID as xs:unsignedLong) as document-node()
{
	document
	{
		dbg:expr($requestID, $expressionID)
	}
};

declare function dbug-data:get-value($requestID as xs:unsignedLong, $expr as xs:string) as document-node()
{
	document
	{
		<expressionValue>
		{
			dbg:value($requestID, $expr)
		}
		</expressionValue>
	}
};

declare function dbug-data:evaluate($expr as xs:string, $vars as item()*, $options as node()?) as document-node()
{
	document {
		<expressionID>
		{ 
			dbg:eval($expr, $vars, $options)
		}
		</expressionID>
	}
};