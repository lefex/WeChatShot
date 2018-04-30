# coding=UTF-8

import urllib2


# 获取star数 http://api.github.com/repos/lefex/LefexWork
#          http://api.github.com/repos/hutuyingxiong/ZUKStreamingKit
# https://github.com/shareSDK/sharesdk-lib-ios.git
# stargazers_count
# 使用默认的opener请求数据（Get）

# 测试获取 star
def request_test():
    head = {'Authorizationt': ' fa8985c568ac1c8026a11c1c16fd89250becf42b', 'User-Agent': 'Lefe'}
    url = 'https://api.github.com/repos/malkouz/SwiftTransition'
    params = '?client_id=5c3c74a2a657d5d04f95&client_secret=0853d97de7babfe1d6aae8b7dd6623f2c1fbfb48'
    url = url + params
    print url
    req = urllib2.Request(url, headers=head)
    response = urllib2.urlopen(req)
    print response.read()

# 脚本入口
if __name__ == '__main__':
    request_test()