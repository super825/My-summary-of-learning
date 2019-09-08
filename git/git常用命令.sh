# 初始化本地版本库
git init

#配置签名
git config user.name super825
git config user.email 106498381@qq.com

#查看状态
git status

#查看提交日志
git log --pertty=oneline

#添加代码到暂存区
git add 文件名
git add .

#提交代码到本地版本库
git commit -m "提交说明"

#回退代码到前一个版本
git reset --hard HEAD^1

#回退到前n个版本
git reset --hard HEAD~n

#查看每次操作记录
git reflog

#还原到指定版本号
git reset --hard 版本号

#还原文件
git checkout -- 文件名

#删除文件
#手动删除文件，再执行
git add 文件名

#查看分支版本
git branch -v

#创建分支
git branch 分支名称

#切换分支
git checkout 分支名称

#合并分支
git merge 分支名称

#解决冲突
#git会提示哪个文件有冲突，这时需要编辑这个文件并解决冲突
vim 文件名
#找同事商议哪些代码要删除和保留
#修改完成后，提交代码
git add 文件名
git commit -m "reslove 文件名 conflicts"

#查看当前所有远程地址别名
git remote -v

#添加远程仓库地址
git remote add [别名] [远程地址]
#例如
git remote add origin https://github.com/super825/spring-demo.git

#推送代码到远程仓库
git push [别名] [分支名]
git push -u origin master

#克隆远程仓库
git clone [远程地址]
git clone https://github.com/super825/spring-demo.git

#拉取远程仓库代码
git pull [远程库地址别名] [远程分支名]
git pull origin master

