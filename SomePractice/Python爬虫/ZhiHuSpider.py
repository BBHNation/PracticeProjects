# coding:utf-8
# 白彬涵
# 知乎爬虫

import requests

cookie = {
    'q_c1':'f2bfedd539264b06a2bd7bbc60cc0138|1495531609000|1495531609000',
    'r_cap_id':'NWRjMDYzYjZhMTA5NDFiMmE5ZmE1YjYyNTUyY2NjNTU=|1495531609|5938276780bfa8d0ea6a74348bbd1b64e84491df',
    'cap_id':'M2FkZTgxZmIxNjVmNDhlNzkyYzY1NWNhYzRlNzdmZDM=|1495531609|290cee29fa535e432eeda4280c5ed7d7ffc8d66b',
    'd_c0':'AIDC7AI8zQuPTtBLwmp19qcODDiBb0PyTmo=|1495531609',
    '_zap':'edbfe4fa-7b43-4e09-b32f-071081e634c0',
    'l_cap_id':'MDRmZGYxMGZkMTVlNGY4ZWEyNTE4NzI1ZDZlZGU1MTg=|1495531624|6252a69c4374dfebf01904dfab64481b5afdd71c',
    'aliyungf_tc':'AQAAAJ134DimGAQAXfeLdd4pVRkRwZrm',
    'acw_tc':'AQAAAJPgVBZG4gQAXfeLdSYaDbbDPTlZ',
    '_xsrf':'9eed0e02881abcfb5771812ace54b9e4',
    'z_c0':'Mi4wQUFBQVlaVXNBQUFBZ01Mc0Fqek5DeGNBQUFCaEFsVk5ZNDFMV1FCVW5xRXREUkd6X2VWa1F1aEtIR09NOHNWbkhR|1495589757|fe80bbba6d6af7cbf01f1b88383be0bf74a68dc8',
    '__utma':'51854390.1027835645.1495531610.1495531610.1495588427.2',
    '__utmb':'51854390.0.10.1495588427',
    '__utmc':'51854390',
    '__utmz':'51854390.1495531610.1.1.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided)',
    '__utmv':'51854390.100-1|2=registration_date=20140417=1^3=entry_date=20140417=1'
}

print cookie
headers = { 'User-Agent' : 'Mozilla/4.0 (compatible; MSIE 5.5; '
                           'Windows NT)','Referer':'http://www.zhihu.com' }

response = requests.get("http://www.zhihu.com", headers=headers, cookies=cookie)

print response.content