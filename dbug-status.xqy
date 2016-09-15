xquery version "1.0-ml";

module namespace dbug-status =
    "http://marklogic.com/resource/dbug-status";

declare namespace xdb = "http://marklogic.com/xdmp/debug";

declare function dbug-status:status($requestId as xs:unsignedLong)
as document-node()*
{
	document { dbg:status($requestId) }
};

declare function dbug-status:stopped($sID as xs:unsignedLong)
as document-node()*
{
	document { <requests>
	{
	for $requestID in dbg:stopped($sID)
	return (
	  <requestID>{$requestID}</requestID>
	  )
	}
	</requests> }
};

declare function dbug-status:attached($sID as xs:unsignedLong)
as document-node()*
{
	document { <requests>
	{
	for $requestID in dbg:attached($sID)
	return (
	  <requestID>{$requestID}</requestID>
	  )
	}
	</requests> }
};

declare function dbug-status:connected()
as document-node()*
{
	document { <attachedServers>
	{
	for $serverID in dbg:connected()
	return (
	  <serverID>{$serverID}</serverID>
	  )
	}
	</attachedServers> }
};

declare function dbug-status:stack($requestID as xs:unsignedLong)
as document-node()*
{
	 dbug-status:checkStopped($requestID),
	 document { dbg:stack($requestID) }
};

declare function dbug-status:checkStopped($requestID as xs:unsignedLong)
{
	xdmp:sleep(200),
	if(dbug-status:status($requestID)/xdb:request/xdb:request-status/text() != "stopped")
	then dbug-status:checkStopped($requestID)
	else ()
};