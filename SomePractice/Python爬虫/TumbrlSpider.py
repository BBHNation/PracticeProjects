# coding:utf-8
import urllib
import urllib2
import json
import time
import re
import os
import requests

def getHtml(username):
    '根据接口从服务器读取整个页面'
    # overview_url='http://'+username+'.tumblr.com/api/read/json?start=0&num=200'
    # print overview_url
    # sp_req=urllib2.Request(overview_url)
    # sp_req.add_header('User-Agent','Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6')
    # data=urllib2.urlopen(sp_req).read()
    # print data
    # return data
    f=open('/Users/MRWhite/Desktop/hi.txt','r')
    return f.read()


def getResourceUrl(htmlStr):
    '获取所有的视频网址'
    videoList=[]
    imageList=[]
    data=json.loads(htmlStr[22:-1])
    for i in range(0,len(data["posts"])):
        if data["posts"][i]["type"]=="video":
            pass
            videoSourceCode = data["posts"][i]["video-player-500"]
            videoList.append(videoSourceCode)
        elif data["posts"][i]["type"]=="photo":
            image=data["posts"][i]["photo-url-500"]
            imageList.append(image)
            if data["posts"][i]["photos"]!= None:
                for j in range(0,len(data["posts"][i]["photos"])):
                    imageList.append(data["posts"][i]["photos"][j]["photo-url-1280"])
    print "视频列表加载完成！"
    print "图片列表加载完成！"
    return (videoList,imageList)    #返回视频、图片两个列表

def saveUrl(saveContentList):
    '保存网址到txt或者数据库'
    resourceDir="./source"
    if not os.path.exists(resourceDir):
        os.makedirs(resourceDir)
        print "资源目录创建完成！"
    f=open("./source/video.txt",'w')
    f2=open("./source/image.txt","w")
    (video, image) = saveContentList
    for videoItem in video:
        f.write(videoItem+"\n")
    for imageItem in image:
        f2.write(imageItem+"\n")
    f.close()
    f2.close()
    print "文件输出完毕，任务结束！"

def parse2Html():
    '将网址拼凑为网页'
    pass

def save2Local(localTxt):
    '将内容保存到本地'
    f = open(localTxt,'r')
    arr = f.readlines()

    for i in range(0,len(arr)):
        fileUrl = "./source/images/" + "%d"%i + ".png"
        url = arr[i][:-1]
        img = requests.get(url)
        if img.status_code == 200:
            open(fileUrl,'wb').write(img.content)

if __name__ == '__main__':
    f=getHtml('lolilegs')
    c=getResourceUrl(f)
    saveUrl(c)

    save2Local("/Users/MRWhite/Desktop/image.txt")