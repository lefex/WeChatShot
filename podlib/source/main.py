# coding=UTF-8

import os
import pod_db

# class-dump 导出头文件所在的目录
IPA_HEADER_PATH = '/Users/wangsuyan/Desktop/baidu/reverse/header/xmly'
# class-dump 导出的头文件 PodsDummy_ 为集成的 pod 库
POD_PREFIX = 'PodsDummy_'

class Source:
    def __init__(self, name, star, source):
        self.star = star
        self.name = name
        self.source = source

    def description(self):
        return '- [%s](%s) - (%s)'%(self.name, self.source, str(self.star))

def pod_find_lib():
    dirs = os.listdir(IPA_HEADER_PATH)
    # ../header 目录，头文件目录
    pods = []
    for file_name in dirs:
        # 查找以 PodsDummy_ 开通的第三方库，这部分库可能是私有库或者第三方库
        if file_name.startswith(POD_PREFIX):
            pod_name = file_name.replace(POD_PREFIX, '')
        else:
            pod_name = file_name

        pod_name = pod_name.replace('.h', '')
        pod_dict = pod_db.pod_query_name(pod_name)

        if pod_dict != None:
            isFind = False
            for source in pods:
                if source.name == pod_dict['name']:
                    isFind = True
                    continue
            if not isFind:
                aSource = Source(pod_dict['name'], pod_dict['star'], pod_dict['source'])
                pods.append(aSource)

    sort_pods = sorted(pods, key=lambda source: source.star, reverse=True)
    for pod in sort_pods:
        print pod.description()


# 脚本入口
if __name__ == '__main__':
    pod_find_lib()