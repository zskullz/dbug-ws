xquery version "1.0-ml";

import module namespace servers = "http://marklogic.com/resource/dbug-servers" at "dbug-servers.xqy";
import module namespace connection = "http://marklogic.com/resource/dbug-connection" at "dbug-connection.xqy";
import module namespace control = "http://marklogic.com/resource/dbug-control" at "dbug-control.xqy";
import module namespace status = "http://marklogic.com/resource/dbug-status" at "dbug-status.xqy";
import module namespace breakpoint = "http://marklogic.com/resource/dbug-breakpoint" at "dbug-breakpoint.xqy";
import module namespace data = "http://marklogic.com/resource/dbug-data" at "dbug-data.xqy";
import module namespace json="http://marklogic.com/xdmp/json" at "/MarkLogic/json/json.xqy";

let $path := xdmp:get-request-path()
let $accept := xdmp:get-request-header("Accept")

let $params := map:map()
let $map := for $field-name in xdmp:get-request-field-names()
			let $map := map:put($params, $field-name, xdmp:get-request-field($field-name))
			return ()



let $content := 
	if(xdmp:get-request-method() = "GET") then
		switch(map:get($params, "path"))
			case "/ServerList" return document { servers:getServers() }
			case "/Connect" return connection:connect(xs:unsignedLong(map:get($params, "serverID")))
			case "/Disconnect" return connection:disconnect(xs:unsignedLong(map:get($params, "serverID")))
			case "/Attach" return connection:attach(xs:unsignedLong(map:get($params, "requestID")))
			case "/Detach" return connection:detach(xs:unsignedLong(map:get($params, "requestID")))
			case "/Step" return control:step(xs:unsignedLong(map:get($params, "requestID")))
			case "/Next" return control:next(xs:unsignedLong(map:get($params, "requestID")))
			case "/Out" return control:out(xs:unsignedLong(map:get($params, "requestID")))
			case "/Continue" return control:continue(xs:unsignedLong(map:get($params, "requestID")))
			case "/Status" return status:status(xs:unsignedLong(map:get($params, "requestID")))
			case "/Stopped" return status:stopped(xs:unsignedLong(map:get($params, "serverID")))
			case "/Attached" return status:attached(xs:unsignedLong(map:get($params, "serverID")))
			case "/Connected" return status:connected()
			case "/Stack" return status:stack(xs:unsignedLong(map:get($params, "requestID")))
			case "/Breakpoints" return breakpoint:breakpoints(xs:unsignedLong(map:get($params, "requestID")))
			case "/Break" return breakpoint:break(xs:unsignedLong(map:get($params, "requestID")), xs:unsignedLong(map:get($params, "expressionID")))
			case "/Clear" return breakpoint:clear(xs:unsignedLong(map:get($params, "requestID")), xs:unsignedLong(map:get($params, "expressionID")))
			case "/Get-expressionID" return data:get-expressionID(xs:unsignedLong(map:get($params, "requestID")), xs:string(map:get($params, "uri")), xs:QName(map:get($params, "functionName")))
			case "/Get-expression" return data:get-expression(xs:unsignedLong(map:get($params, "requestID")), xs:unsignedLong(map:get($params, "expressionID")))
			case "/Get-value" return data:get-value(xs:unsignedLong(map:get($params, "requestID")), xs:string(map:get($params, "expression")))
			case "/Evaluate" return data:evaluate(xs:string(map:get($params, "expression")), map:get($params, "item"), map:get($params, "options"))
			default return document { <empty /> }
	else ()

let $response-header := xdmp:add-response-header("Access-Control-Allow-Origin", "*")

return 
	if(fn:contains($accept, "application/json")) then
		json:transform-to-json($content, json:config("full"))
	else $content