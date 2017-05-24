# coding:utf-8
import requests
cookie = {
    'tmgioct':'5924f106ae8b990673229170',
    'rxx':'2mfhp6i9ug8.qa2zot2&v=1',
    'anon_id':'DKXJSRPWRRRBPMZTAEGPFICKTEQSTLYX',
    'pfl':'YmZlNGM4ZmNmZmQ1NzBmNjg2ZGExMjQ0MmUyMjkyZjgwZmQ3ZGM2OWM3ODM5NTk4Mjc4MmZkMjBmMjU5M2ViMiw1a3N3eG02dzUzYzZuN3JtYmt2OGUzNnNrZHc4azNyMywxNDk1NTkzMjQ4',
    'language':'%2Czh_CN',
    'logged_in':'1',
    'pfp':'39G1dzIhG1hcWvzqoBWjpvaRKch3mfCl0FLkunGI',
    'pfs':'ckIYwaBp8uwZ6XvrNop1xIC4E0s',
    'pfe':'1503369255',
    'pfu':'235732646',
    '_ga':'GA1.2.1216238084.1495593226',
    '_gid':'GA1.2.1680558932.1495593259',
    '_utma':'189990958.1216238084.1495593226.1495593226.1495593226.1',
    '__utmb':'189990958.0.10.1495593226',
    '__utmc':'189990958',
    '__utmz':'189990958.1495593226.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)',
    'yx':'5nf6usupv9f89%26o%3D3%26f%3D3o',
    'nts':'false',
    'devicePixelRatio':'2',
    'documentWidth':'1008'
}
header = {
    'User-Agent' : 'Mozilla/4.0 (compatible; MSIE 5.5; ''Windows NT)',
    'Referer':'http://www.tumblr.com'
}
url = "http://www.tumblr.com"
print url,cookie,header
response = requests.get(url,headers=header,cookies=cookie)
print response.content