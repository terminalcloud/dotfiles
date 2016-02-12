

local log = ngx.log
local ERR = ngx.ERR
local DBG = ngx.DBG

submap = {}
submap["node1"] = "104.197.37.212"

local function getPortFromSubdomain ( subdomain )
  local port, err = subdomain:match("-(%d+)$")
  return port
end

local function trimPortFromSubdomain (subdomain)
  local port = getPortFromSubdomain(subdomain)
  local subdomain = subdomain:gsub("-"..port.."$", "")
  return subdomain
end


ngx.log(ngx.ERR, " URI : ",ngx.var.uri);
ngx.log(ngx.ERR, " HOST : ",ngx.var.host);


-- Parse sub and main domain
vsub,vdom = ngx.var.host:match("([^.]*).(.*)");

log(ERR, " VSUB : ",vsub);
log(ERR, " VSUB : ",vsub);

log(ERR, " VDOM : ",trimmedsub);

local hnip = submap[trimPortFromSubdomain(vsub)]

log(ERR, "IP : ",hnip)

ngx.var.proxy_machine=hnip
