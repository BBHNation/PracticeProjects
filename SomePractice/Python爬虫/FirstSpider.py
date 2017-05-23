# coding:utf-8
import urllib
import urllib2

response = urllib2.urlopen("http://www.baidu.com")
# print response.read()
# urlopen(url, data, timeout)
# 第一个参数url即为URL，第二个参数data是访问URL时要传送的数据，第三个timeout是设置超时时间。
# 第二三个参数是可以不传送的，data默认为空None，timeout默认为 socket._GLOBAL_DEFAULT_TIMEOUT
# 上面的方法可以这样写
request = urllib2.Request("http://www.baidu.com")
# 这里加入对request的一些配置
response = urllib2.urlopen(request)
print response.read()


#_________________________________________________________________
# 一般添加账号密码的方式如下。
values = {"username":"1016903103@qq.com","password":"XXXX"}
data = urllib.urlencode(values)
url = "https://passport.csdn.net/account/login?from=http://my.csdn.net/my/mycsdn"
request = urllib2.Request(url,data)
response = urllib2.urlopen(request)
print response.read()


#_________________________________________________________________
# 设置Header
url = 'http://www.server.com/login'
values = {'username': 'cqc', 'password': 'XXXX'}
headers = { 'User-Agent' : 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)','Referer':'http://www.zhihu.com/articles' }
# Referer是反防止盗取链接
data = urllib.urlencode(values)
request = urllib2.Request(url, data, headers)
response = urllib2.urlopen(request, timeout=10) # 设置超时
page = response.read()

# User-Agent : 有些服务器或 Proxy 会通过该值来判断是否是浏览器发出的请求
# Content-Type : 在使用 REST 接口时，服务器会检查该值，用来确定 HTTP Body 中的内容该怎样解析。
# application/xml ： 在 XML RPC，如 RESTful/SOAP 调用时使用
# application/json ： 在 JSON RPC 调用时使用
# application/x-www-form-urlencoded ： 浏览器提交 Web 表单时使用
# 在使用服务器提供的 RESTful 或 SOAP 服务时， Content-Type 设置错误会导致服务器拒绝服务

#_________________________________________________________________
# 设置Proxy(代理)
# 使用代理服务器，分布式发送请求，不会因为同一个IP请求过多而被禁止

enable_proxy = True
proxy_handler = urllib2.ProxyHandler({"http" : 'http://some-proxy.com:8080'})
null_proxy_handler = urllib2.ProxyHandler({})
if enable_proxy:
    opener = urllib2.build_opener(proxy_handler)
else:
    opener = urllib2.build_opener(null_proxy_handler)
urllib2.install_opener(opener)

# http协议有六种请求方法，get,head,put,delete,post,options，我们有时候需要用到PUT方式或者DELETE方式请求
url = "http://www.baidu.com"
request = urllib2.Request(url, data=data)
request.get_method = lambda: 'PUT' # or 'DELETE'
response = urllib2.urlopen(request)


