-- generate amazon v4 authorization signature
-- https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html
-- Author: jeffry L. paragasu@gmail.com
-- Licence: MIT


--local resty_sha256 = require 'resty.sha256'
--local hmac   = require 'resty.hmac'
local myApp = require( "myapp" )  
local crypto  =  require("crypto")
local common = require( myApp.utilsfld .. "common" )
local json = require( "json" )
--local str  = require 'resty.string'
local aws_key, aws_secret, aws_region, aws_service, aws_host, aws_request
local iso_date, iso_tz, cont_type, req_method, req_path, req_body, req_querystr

local _M = {
  _VERSION = '0.1.0'
}

local mt = { __index = _M }

-- init new aws auth
function _M.new(self, config)
  aws_key     = config.aws_key
  aws_secret  = config.aws_secret
  aws_region  = config.aws_region
  aws_service = config.aws_service
  aws_request = config.aws_request
  aws_host    = config.aws_host
  cont_type   = config.content_type   or "application/x-www-form-urlencoded" 
  req_method  = config.request_method or "POST"
  req_path    = config.request_path   or "/"
  req_querystr= config.request_querystr or ''
  req_body    = config.request_body
  -- set default time
  self:set_iso_date(os.time())
  return setmetatable(_M, mt)
end

function _M.str_to_hex(self,s)
    local i
    local cs  = ''
    for i = 1, string.len(s) do
      cs = cs .. string.format('%x',string.byte(s,i,i))
    end
    return cs
end

-- generate sha256 from the given string
function _M.get_sha256_digest(self, s)
  --local h = resty_sha256:new()
  --h:update(s)
  --return str.to_hex(h:final())
    print ("*******************")
    print ("*******************")
      print ("*******************")
        print ("*******************")
          print ("*******************")
            print ("aaaa*******************")
            
           

    

    local sr =crypto.digest( crypto.sha256, s )  -- will hash and convert to hext
    print (sr)
    --return self:str_to_hex(s)
    return sr
end

-- required for testing
function _M.set_iso_date(self, microtime)
  local mt = microtime
  mt = os.time({year=2015, month=08, day=30, hour=08, min=36,  sec=00})     --'2015-08-30T12:36:00Z')
  iso_date = os.date('!%Y%m%d', mt)
  iso_tz   = os.date('!%Y%m%dT%H%M%SZ', mt)
  print (iso_date)
end

-- get signing key
-- https://docs.aws.amazon.com/general/latest/gr/sigv4-calculate-signature.html
function _M.get_signing_key(self)
  local  k_date    = crypto.hmac(crypto.sha256,'AWS4' .. aws_secret, iso_date,true)    -- true for binary
  local  k_region  = crypto.hmac(crypto.sha256,k_date, aws_region,true)
  local  k_service = crypto.hmac(crypto.sha256,k_region, aws_service,true)
  local  k_signing = self:str_to_hex(crypto.hmac(crypto.sha256,k_service, aws_request,true))


  print ("*******************")
    print ("*******************")
      print ("*******************")
        print ("*******************")
          print ("****signingkey start********")
            print ("*******************")

  print (k_signing)
    print ("*******************")
    print ("*******************")
      print ("*******signing key end ******")
        print ("*******************")
          print ("*******************")
            print ("*******************")
  return k_signing

end
-- create canonical headers
-- header must be sorted asc  and lowercase for the names
function _M.get_canonical_header(self)
  local h = {
   -- 'content-type:' .. cont_type,
    'host:' .. aws_host,
    'x-amz-date:' .. iso_tz
  }
  return table.concat(h, '\n')
end


function _M.get_signed_request_body(self)
  local params = req_body
  if type(req_body) == 'table' then
    --table.sort(params)    -- do we need to sort ?
    params = json.encode(params)
  end
  local digest = self:get_sha256_digest(params or '')
  return string.lower(digest) -- hash must be in lowercase hex string
end

-- get canonical request
-- https://docs.aws.amazon.com/general/latest/gr/sigv4-create-canonical-request.html
function _M.get_canonical_request(self)
  --local signed_header = 'content-type;host;x-amz-date'
  local signed_header = 'host;x-amz-date'
  local canonical_header = self:get_canonical_header()
  local signed_body = self:get_signed_request_body()
  local param  = {
    req_method,
    req_path,
    req_querystr , -- canonical querystr
    canonical_header,
    '',   -- required
    signed_header,
    signed_body
  }
  local canonical_request = table.concat(param, '\n')
    print ("***************CANICAL*************")
  print ("***************CANICAL*************")
  print ("***************CANICAL*************")
  print (canonical_request)
  print ("***************CANICAL*************")
  print ("***************CANICAL*************")
  print ("***************CANICAL*************")
  return self:get_sha256_digest(canonical_request)
end
-- get string
function _M.get_string_to_sign(self)
  local param = { iso_date, aws_region, aws_service, aws_request }
  local cred  = table.concat(param, '/')
  local req   = self:get_canonical_request()
  print ("***************HASHED CANICAL*************")
  print ("***************HASHED CANICAL*************")
  print ("***************HASHED CANICAL*************")
  print ("***************HASHED CANICAL*************")
  print (table.concat({ 'AWS4-HMAC-SHA256', iso_tz, cred, req}, '\n'))
  print ("***************HASHED CANICAL*************")
  print ("***************HASHED CANICAL*************")
  print ("***************HASHED CANICAL*************")
  return table.concat({ 'AWS4-HMAC-SHA256', iso_tz, cred, req}, '\n')
end
-- generate signature
function _M.get_signature(self)
  local  signing_key = self:get_signing_key()
  local  string_to_sign = self:get_string_to_sign()
  --return self:str_to_hex(crypto.hmac(crypto.sha256,signing_key, string_to_sign))
  local signat =  crypto.hmac(crypto.sha256,signing_key, string_to_sign)   -- will convert to hext
  print ("***************signature*************")
print ("***************signature*************")
print ("***************signature*************")
print ("***************signature*************")
print ("***************signature*************")
print (signat)
  print ("***************signature*************")
print ("***************signature*************")
print ("***************signature*************")
print ("***************signature*************")
print ("***************signature*************")

  return signat   -- will convert to hext
 --return signing_key
end

-- get authorization string
-- x-amz-content-sha256 required by s3
function _M.get_authorization_header(self)
  local  param = { aws_key, iso_date, aws_region, aws_service, aws_request }
  local header = {
    'AWS4-HMAC-SHA256 Credential=' .. table.concat(param, '/'),
    --'SignedHeaders=content-type;host;x-amz-date',
    'SignedHeaders=host;x-amz-date',
    'Signature=' .. self:get_signature()

  }
  return table.concat(header, ', ')
end

-- get the current timestamp in iso8601 basic format
function _M.get_amz_date_header()
  return iso_tz
end


return _M
