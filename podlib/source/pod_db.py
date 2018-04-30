# coding=UTF-8

import sqlite3
import os
import json

# Pod repo 路径
POD_REPO_PATH = '../Specs'
# 数据库名称
POD_DB_NAME = 'podlib.db'

conn = sqlite3.connect(POD_DB_NAME)
c = conn.cursor()

# 创建表
def pod_create_table():
    c.execute("CREATE TABLE IF NOT EXISTS podlib(name TEXT PRIMARY KEY NOT NULL, source TEXT, summary TEXT, star INT, file1 TEXT, file2 TEXT,file3 TEXT)")
    conn.commit()

def pod_create_index():
    c.execute(
        "CREATE INDEX podlib_name ON podlib(name);")
    c.execute(
        "CREATE INDEX podlib_file1 ON podlib(file1);")
    c.execute(
        "CREATE INDEX podlib_file2 ON podlib(file2);")
    c.execute(
        "CREATE INDEX podlib_file3 ON podlib(file3);")
    conn.commit()

# 根据 pod 名字获取 pod 库
def pod_query_name(name):
    cursor = c.execute("SELECT * FROM podlib WHERE name=? OR file1=? OR file2=? OR file3=?", (name,name,name,name,))
    values = cursor.fetchone()
    if values == None:
        return None

    result = dict()
    result['name'] = values[0]
    result['source'] = values[1]
    result['summary'] = values[2]
    result['star'] = values[3]

    return result

# 更新 pod rep 到数据库中
def pod_update_podlib():
    # 查找所有的 pod 库

    dirs = os.listdir(POD_REPO_PATH)
    # ../Specs 根目录
    for compent in dirs:
        second_path = os.path.join(POD_REPO_PATH, compent)
        # ../Specs/0 一级目录
        second_dirs = os.listdir(second_path)
        for second_compent in second_dirs:
            third_path = os.path.join(second_path, second_compent)
            # ../Specs/0/0 二级目录
            third_dirs = os.listdir(third_path)
            for third_compent in third_dirs:
                four_path = os.path.join(third_path, third_compent)
                # ../Specs/0/0/0 三级目录
                four_dirs = os.listdir(four_path)
                for four_compent in four_dirs:
                    try:
                        # 解析podspec.json 文件并插入到数据库中
                        json_dict = parse_podreps(four_path + '/' + four_compent)
                        source_url = json_dict['source']['git']
                        c.execute("INSERT INTO podlib VALUES (?,?,?,?,?,?,?)", (four_compent, source_url, json_dict['summary'],0,'','',''))
                        conn.commit()
                    except Exception as err:
                        print err
    print "*****************************  Insert sqlit finish!!!"

# 更新 pod rep 到数据库中
def pod_update_source_dir():
    # 查找所有的 pod 库

    dirs = os.listdir(POD_REPO_PATH)
    # ../Specs 根目录
    for compent in dirs:
        second_path = os.path.join(POD_REPO_PATH, compent)
        # ../Specs/0 一级目录
        second_dirs = os.listdir(second_path)
        for second_compent in second_dirs:
            third_path = os.path.join(second_path, second_compent)
            # ../Specs/0/0 二级目录
            third_dirs = os.listdir(third_path)
            for third_compent in third_dirs:
                four_path = os.path.join(third_path, third_compent)
                # ../Specs/0/0/0 三级目录
                four_dirs = os.listdir(four_path)
                for four_compent in four_dirs:
                    try:
                        # 解析podspec.json 文件并插入到数据库中
                        json_dict = parse_podreps(four_path + '/' + four_compent)
                        if json_dict.has_key('source_files'):
                            source_dir = json_dict['source_files']
                        else:
                            if json_dict.has_key('subspecs'):
                                pod_subspecs =  json_dict['subspecs']

                                for subspec in pod_subspecs:
                                    if subspec.has_key('source_files'):
                                        source_dir = subspec['source_files']
                                        break
                                    if subspec.has_key('public_header_files'):
                                        source_dir = subspec['public_header_files']
                                        break
                            else:
                                source_dir = ''

                        if type(source_dir) == list:
                            source_dir = source_dir[0]

                        print source_dir
                        c.execute("UPDATE podlib SET source_file=? where name=?", (source_dir, four_compent))
                        conn.commit()
                    except Exception as err:
                        print('Error happen')
                        print err

# 解析 podspec.json 文件
def parse_podreps(file_path):
    # ../Specs/9/9/9/SwiftTransition/1.0/SwiftTransition.podspec.json
    compents = os.path.split(file_path)
    first_name = compents[len(compents) - 1]
    dirs = os.listdir(file_path)
    json_file_path = file_path + '/' + dirs[len(dirs)-1] + '/' + first_name + '.podspec.json'
    with open(json_file_path) as f:
        js = json.load(f)
        return js

# 脚本入口
if __name__ == '__main__':
    #pod_create_table()
    #pod_update_source_dir()
    pod_create_index()