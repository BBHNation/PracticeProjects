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

# 使用DebugLog
httpHandler = urllib2.HTTPHandler(debuglevel=1)
httpsHandler = urllib2.HTTPSHandler(debuglevel=1)
opener = urllib2.build_opener(httpHandler, httpsHandler)
urllib2.install_opener(opener)
response = urllib2.urlopen('http://www.baidu.com')

#————————————————————————————————————————————————————————————————————————————
# URLError

requset = urllib2.Request('http://www.xxxxx.com')
try:
    urllib2.urlopen(request) # 如果不能处理，则会产生一个错误，需要错误处理
except urllib2.URLError, e:
    print e.reason


try:
    urllib2.urlopen(request)
except urllib2.HTTPError, e:
    print e.code
    print e.reason

#————————————————————————————————————————————————————————————————————————————
# Cookie使用

# 1、Opener
# 当你获取一个URL你使用一个opener(一个urllib2.OpenerDirector的实例)。在前面，
# 我们都是使用的默认的opener，也就是urlopen。它是一个特殊的opener，可以理解成opener的一个特殊实例，
# 传入的参数仅仅是url，data，timeout。
# 如果我们需要用到Cookie，只用这个opener是不能达到目的的，所以我们需要创建更一般的opener来实现对Cookie的设置。

# 2、Cookielib
# cookielib模块的主要作用是提供可存储cookie的对象，以便于与urllib2模块配合使用来访问Internet资源。
# 它们的关系：CookieJar —-派生—->FileCookieJar  —-派生—–>MozillaCookieJar和LWPCookieJar

# 首先，我们先利用CookieJar对象实现获取cookie的功能，存储到变量中，
import cookielib

#声明一个CookieJar对象实例来保存cookie
cookie = cookielib.CookieJar()
#利用urllib2库的HTTPCookieProcessor对象来创建cookie处理器
handler=urllib2.HTTPCookieProcessor(cookie)
#通过handler来构建opener
opener = urllib2.build_opener(handler)
#此处的open方法同urllib2的urlopen方法，也可以传入request
response = opener.open('http://www.baidu.com')
for item in cookie:
    print 'Name = '+item.name
    print 'Value = '+item.value

# 保存Cookie到文件中

# 设置保存cookie的文件，同级目录下的cookie.txt
filename = 'cookie.txt'
# 声明一个MozillaCookieJar对象实例来保存cookie，之后写入文件
cookie = cookielib.MozillaCookieJar(filename)
# 利用urllib2库的HTTPCookieProcessor对象来创建cookie处理器
handler = urllib2.HTTPCookieProcessor(cookie)
# 通过handler来构建opener
opener = urllib2.build_opener(handler)
# 创建一个请求，原理同urllib2的urlopen
response = opener.open("http://www.baidu.com")
# 保存cookie到文件
cookie.save(ignore_discard=True, ignore_expires=True)
# ignore_discard的意思是即使cookies将被丢弃也将它保存下来，
# ignore_expires的意思是如果在该文件中cookies已经存在，则覆盖原文件写入

#从文件中读取Cookie

#创建MozillaCookieJar实例对象
cookie = cookielib.MozillaCookieJar()
#从文件中读取cookie内容到变量
cookie.load('cookie.txt', ignore_discard=True, ignore_expires=True)
#创建请求的request
req = urllib2.Request("http://www.baidu.com")
#利用urllib2的build_opener方法创建一个opener
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookie))
response = opener.open(req)
print response.read()

#————————————————————————————————————————————————————————————————————————————
# 正则表达式

