xquery version "1.0-ml";

module namespace dbug-control =
    "http://marklogic.com/resource/dbug-control";

import module namespace status = "http://marklogic.com/resource/dbug-status" at "dbug-status.xqy";

declare function dbug-control:step($requestID as xs:unsignedLong)
as document-node()*
{
	 status:checkStopped($requestID),
	 dbg:step($requestID),
	 status:checkStopped($requestID),
	 document { dbg:stack($requestID) }
};

declare function dbug-control:next($requestID as xs:unsignedLong)
as document-node()*
{
	 status:checkStopped($requestID),
	 dbg:next($requestID),
	 status:checkStopped($requestID),
	 document { dbg:stack($requestID) }
};

declare function dbug-control:out($requestID as xs:unsignedLong)
as document-node()*
{
	 status:checkStopped($requestID),
	 dbg:out($requestID),
	 status:checkStopped($requestID),
	 document { dbg:stack($requestID) }
};

declare function dbug-control:continue($requestID as xs:unsignedLong)
as document-node()*
{
	 status:checkStopped($requestID),
	 dbg:continue($requestID),
	 status:checkStopped($requestID),
	 document { dbg:stack($requestID) }
};