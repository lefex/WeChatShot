# coding=UTF-8

import sqlite3
import os
import json
import urllib2


POD_DB_NAME = 'podlib.db'
POD_NOT_PODNAME = 'notpod'

# 查找 Pod 库中的文件名
# https://github.com/rs/SDWebImage.git
# https://api.github.com/repos/rs/SDWebImage/contents/SDWebImage
# https://api.github.com/repos/BradLarson/GPUImage/framework/Source

# https://github.com/AFNetworking/AFNetworking.git
# AFNetworking/AFNetworking.h
# https://api.github.com/repos/AFNetworking/AFNetworking/contents/AFNetworking/AFNetworking.h

def query_file_name(values):
    for row in values:
        # pod 库所存放的 git 地址
        source = row[1]
        print '***************************************'
        print source
        # pod 库非 github 托管
        if 'https://github.com' not in source:
            print 'source error: ' + source
            continue

        # pod 库源文件中文件名
        file1_name = row[4]
        print file1_name
        # 如果以前已经找到了就不再找了
        if len(file1_name) > 0 and file1_name != POD_NOT_PODNAME:
            print 'have search'
            continue

        # 替换 pod 源为请求获取 github 源的 api
        source = source.replace('https://github.com', 'https://api.github.com/repos')
        # 去掉 .git
        source = source[:-4]

        # pod 源文件目录
        pod_source_dir = row[7]
        if pod_source_dir != None and len(pod_source_dir) > 0:
            pod_dirs = pod_source_dir.split('/')
            pod_temps = []
            for adir in pod_dirs:
                if ('*' not in adir) and ('.' not in adir) and ('{h,m}' not in adir):
                    pod_temps.append(adir)

            if len(pod_temps) > 0:
                result = '/'.join(pod_temps)
            else:
                result = row[0]
            source_file = result
        else:
            source_file = row[0]
        source = source + '/contents/' +  source_file
        print source
        params = '?client_id=5c3c74a2a657d5d04f95&client_secret=0853d97de7babfe1d6aae8b7dd6623f2c1fbfb48'
        source = source + params
        print source

        try:
            head = {'Authorizationt': ' fa8985c568ac1c8026a11c1c16fd89250becf42b', 'User-Agent' : 'Lefe'}
            req = urllib2.Request(source, headers=head)
            response = urllib2.urlopen(req)
            pod_json = response.read()
            if pod_json != None:
                pod_info = json.loads(pod_json)
                file_names = []
                for file in pod_info:
                    file_name = file['name']
                    ext = os.path.splitext(file_name)[1]
                    if ext == '.h' or ext == '.swift':
                        file_names.append(file_name)
                print file_names
                file_count = len(file_names)
                if file_count > 2:
                    c.execute("UPDATE podlib SET file1=?, file2=?, file3=? where name=?",
                              (file_names[0], file_names[1], file_names[2], row[0]))
                    conn.commit()
                elif file_count > 1:
                    c.execute("UPDATE podlib SET file1=?, file2=?, file3=? where name=?",
                              (file_names[0], file_names[1], '', row[0]))
                    conn.commit()
                elif file_count > 0:
                    c.execute("UPDATE podlib SET file1=?, file2=?, file3=? where name=?",
                              (file_names[0], '', '', row[0]))
                    conn.commit()

            else:
                print 'pod_json is nil'

        except Exception as err:
            # 请求错误
            c.execute("UPDATE podlib SET file1=? where name=?", (POD_NOT_PODNAME, row[0]))
            conn.commit()
            print err

# 脚本入口
if __name__ == '__main__':
    conn = sqlite3.connect(POD_DB_NAME)
    c = conn.cursor()

    cursor = c.execute("SELECT * FROM podlib WHERE star>? ORDER BY star", (100,))
    values = cursor.fetchall()
    query_file_name(values)