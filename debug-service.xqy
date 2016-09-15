xquery version "1.0-ml";
module namespace dbug =
    "http://marklogic.com/resource/dbug";

import module namespace servers = "http://marklogic.com/resource/dbug-servers" at "dbug-servers.xqy";
import module namespace connection = "http://marklogic.com/resource/dbug-connection" at "dbug-connection.xqy";
import module namespace control = "http://marklogic.com/resource/dbug-control" at "dbug-control.xqy";
import module namespace status = "http://marklogic.com/resource/dbug-status" at "dbug-status.xqy";
import module namespace breakpoint = "http://marklogic.com/resource/dbug-breakpoint" at "dbug-breakpoint.xqy";
import module namespace data = "http://marklogic.com/resource/dbug-data" at "dbug-data.xqy";

declare function dbug:get(
    $context as map:map,
    $params  as map:map
)
{
    let $content := switch (map:keys($params)[map:count($params)])
                    case "ServerList" return document { servers:getServers() }
                    case "Connect" return connection:connect(xs:unsignedLong(map:get($params, "db")))
                    case "Disconnect" return connection:disconnect(xs:unsignedLong(map:get($params, "db")))
                    case "Attach" return connection:attach(xs:unsignedLong(map:get($params, "requestID")))
                    case "Detach" return connection:detach(xs:unsignedLong(map:get($params, "requestID")))
                    case "Step" return control:step(xs:unsignedLong(map:get($params, "requestID")))
                    case "Next" return control:next(xs:unsignedLong(map:get($params, "requestID")))
                    case "Out" return control:out(xs:unsignedLong(map:get($params, "requestID")))
                    case "Continue" return control:continue(xs:unsignedLong(map:get($params, "requestID")))
                    case "Status" return status:status(xs:unsignedLong(map:get($params, "requestID")))
                    case "Stopped" return status:stopped(xs:unsignedLong(map:get($params, "serverID")))
                    case "Attached" return status:attached(xs:unsignedLong(map:get($params, "serverID")))
                    case "Connected" return status:connected()
                    case "Stack" return status:stack(xs:unsignedLong(map:get($params, "requestID")))
                    case "Breakpoints" return breakpoint:breakpoints(xs:unsignedLong(map:get($params, "requestID")))
                    case "Break" return breakpoint:break(xs:unsignedLong(map:get($params, "requestID")), xs:unsignedLong(map:get($params, "expressionID")))
                    case "Clear" return breakpoint:clear(xs:unsignedLong(map:get($params, "requestID")), xs:unsignedLong(map:get($params, "expressionID")))
                    case "Get-expressionID" return data:get-expressionID(xs:unsignedLong(map:get($params, "requestID")), xs:string(map:get($params, "uri")), xs:QName(map:get($params, "functionName")))
                    case "Get-expression" return data:get-expression(xs:unsignedLong(map:get($params, "requestID")), xs:unsignedLong(map:get($params, "expressionID")))
                    case "Get-value" return data:get-value(xs:unsignedLong(map:get($params, "requestID")), xs:string(map:get($params, "expression")))
                    case "Evaluate" return data:evaluate(xs:string(map:get($params, "expression")), map:get($params, "item"), map:get($params, "options"))
                    default return document { <empty /> }
    return 
        if(fn:index-of(map:get($context, "accept-types"), "application/xml") > 0) then
            $content
        else if(fn:index-of(map:get($context, "accept-types"), "application/json") > 0) then
            xdmp:to-json($content)
        else ()
};

declare function dbug:put(
    $context as map:map,
    $params  as map:map,
    $input   as document-node()*
) as document-node()?
{
    xdmp:log("put!")
};

declare function dbug:post(
    $context as map:map,
    $params  as map:map,
    $input   as document-node()*
) as document-node()*
{
    xdmp:log("post!")
};

declare function dbug:delete(
    $context as map:map,
    $params  as map:map
) as document-node()?
{
    xdmp:log("delete!")
};