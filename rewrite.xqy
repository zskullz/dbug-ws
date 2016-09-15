xquery version "1.0-ml";

let $url := xdmp:get-request-url()
let $path := xdmp:get-request-path()

return "router.xqy?path=" || $path || "&amp;" || fn:substring-after($url, "?")