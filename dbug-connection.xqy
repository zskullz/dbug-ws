xquery version "1.0-ml";

module namespace dbug-connection =
    "http://marklogic.com/resource/dbug-connection";

declare function dbug-connection:connect($db as xs:unsignedLong)
as document-node()*
{
	try {
		dbg:connect($db),
		document { <success>{fn:true()}</success> }
	}
	catch err:FOER0000
	{
		document { <error>Invalid ID</error> }
	}
	catch *
	{
		document { <error>Failed to connect</error> }
	}
};

declare function dbug-connection:disconnect($db as xs:unsignedLong)
as document-node()*
{
	try {
		dbg:disconnect($db),
		document { <success>{fn:true()}</success> }
	}
	catch err:FOER0000
	{
		document { <error>Invalid ID</error> }
	}
	catch *
	{
		document { <error>Failed to connect</error> }
	}
};

declare function dbug-connection:attach($requestID as xs:unsignedLong)
as document-node()*
{
	try {
		dbg:attach($requestID),
		document { <success>{fn:true()}</success> }
	}
	catch *
	{
		document { <success>{fn:false()}</success> }
	}
};

declare function dbug-connection:detach($requestID as xs:unsignedLong)
as document-node()*
{
	try {
		dbg:detach($requestID),
		document { <success>{fn:true()}</success> }
	}
	catch *
	{
		document { <success>{fn:false()}</success> }
	}
};