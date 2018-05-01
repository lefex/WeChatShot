# coding=UTF-8

import os
import shutil

# class-dump 导出的头文件 PodsDummy_ 为集成的 pod 库
POD_PREFIX = 'PodsDummy_'
IPA_HEADER_PATH = '/Users/wangsuyan/Desktop/baidu/reverse/header/dedao_h'

def catagory_change():
    dirs = os.listdir(IPA_HEADER_PATH)
    # ../header 目录，头文件目录
    for file_name in dirs:
        # 查找以 PodsDummy_ 开通的第三方库，这部分库可能是私有库或者第三方库
        pod_name = file_name.replace('.h', '')
        dir_name = file_perfix(pod_name)
        dst = IPA_HEADER_PATH + '/' + dir_name
        if not os.path.exists(dst):
            os.mkdir(dst)
        src = IPA_HEADER_PATH + '/' + file_name
        shutil.move(src, dst)

def file_perfix(file_name):
    if file_name.startswith(POD_PREFIX):
        return 'cocoapod'
    if len(file_name) < 2:
        return file_name
    else:
        return file_name[0:2]

# 脚本入口
if __name__ == '__main__':
    catagory_change()