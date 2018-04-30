# coding=UTF-8

import sqlite3
import os
import json
import urllib2


POD_DB_NAME = 'podlib.db'

# 更新 pod 库的 star 数
# star: -1 star 数为0，
def query_update_star(values):
    for row in values:
        old_star = long(row[3])
        # 只更新 star 为 0 的
        if old_star != 0:
            continue

        # pod 库的源必须是 github
        source = row[1]
        if 'https://github.com' not in source:
            print 'source error: ' + source
            continue

        # https://github.com/shareSDK/sharesdk-lib-ios.git pod 库的源
        # http://api.github.com/repos/lefex/LefexWork
        # http://api.github.com/repos/【author】/【pod name】
        source = source.replace('https://github.com', 'https://api.github.com/repos')
        source = source[:-4]
        # 需要申请 github 开发者，不然访问 github 会有限制，会报 403 异常
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
                star = long(pod_info['stargazers_count'])
                if star == 0:
                    # 防止重复更新，更新直更新 star 为 0 的 pod 库
                    star = -1
                # 更新star
                print star
                c.execute("UPDATE podlib SET star=? where name=?", (star, row[0]))
                conn.commit()

            else:
                print 'pod_json is nil'

        except Exception as err:
            # 请求错误
            c.execute("UPDATE podlib SET star=? where name=?", (-2, row[0]))
            conn.commit()
            print err

    print "*****************************  Update star finish!!!"

# 脚本入口
if __name__ == '__main__':
    conn = sqlite3.connect(POD_DB_NAME)
    c = conn.cursor()

    cursor = c.execute("SELECT * FROM podlib WHERE star=? ORDER BY name LIMIT 4000 OFFSET 0", (0,))
    values = cursor.fetchall()
    query_update_star(values)