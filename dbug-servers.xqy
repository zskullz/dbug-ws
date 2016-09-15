xquery version "1.0-ml";

module namespace dbug-servers =
    "http://marklogic.com/resource/dbug-servers";

declare namespace grp="http://marklogic.com/xdmp/group";

 declare function dbug-servers:getServers()
 {
 	<servers>
 	{
 		for $server in xdmp:read-cluster-config-file("groups.xml")/grp:groups/grp:group/(grp:http-servers|grp:xdbc-servers)/*[grp:debug-allow = true()]
 		let
 			$id 		:= $server/(grp:http-server-id|grp:xdbc-server-id)/text(),
 			$database 	:= $server/grp:database/text(),
 			$name 		:= $server/(grp:http-server-name|grp:xdbc-server-name)/text(),
 			$port 		:= $server/grp:port/text(),
 			$root		:= $server/grp:root/text()
 		return (
 			<server>
 				<id>{$id}</id>
 				<database>{$database}</database>
 				<name>{$name}</name>
 				<port>{$port}</port>
 				<root>{$root}</root>
 			</server>
 		)
 	}
 	</servers>
 };