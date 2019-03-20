#####################################################################
# BASH CHEATSHEET (中文速查表)  -  by zev (created on 2019/03/19)
# Version: 1, Last Modified: 2019/03/20 20:19
#####################################################################

#####################################################################
# 变量
#####################################################################
declare -a                          # 查看所有数组
declare -f                          # 查看所有函数
declare -F                          # 查看所有函数,仅显示函数名
declare -i                          # 查看所有定义过的整数,包含随机数$RANDOM
declare -r                          # 查看所有只读变量
declare -x                          # 查看所有被导出成环境变量的东西
declare -p varname                  # 输出变量是怎么定义的（类型+值）
declare -A varname                  # 创建关联数组

var=value                           # 定义变量
var="value"                         # 定义变量
let var=value                       # 定义变量
export var=value                    # 定义全局变量
local var=value                     # 定义函数局部变量
unset var                           # 删除变量

echo ${#var}                        # 查看变量长度  
echo ${varname:-word}               # 如果变量不为空则返回变量,否则返回 word
echo ${varname:=word}               # 如果变量不为空则返回变量,否则赋值成 word 并返回
echo ${varname:+word}               # 如果变量不为空则返回word,否则返回 null
echo ${varname:?message}            # 如果变量不为空则返回变量,否则打印错误信息并退出
echo ${varname:offset:len}          # 取得字符串的子字符串,len支持-1倒序

echo ${variable#pattern}            # 如果变量头部匹配 pattern,则删除最小匹配部分返回剩下的
echo ${variable##pattern}           # 如果变量头部匹配 pattern,则删除最大匹配部分返回剩下的
echo ${variable%pattern}            # 如果变量尾部匹配 pattern,则删除最小匹配部分返回剩下的
echo ${variable%%pattern}           # 如果变量尾部匹配 pattern,则删除最大匹配部分返回剩下的
echo ${variable/pattern/str}        # 将变量中第一个匹配 pattern 的替换成 str,并返回
echo ${variable//pattern/str}       # 将变量中所有匹配 pattern 的地方替换成 str 并返回

arr=(valA valB valC)                # 创建数组
arr=(valA valB [5]=valC)            # 创建数组并自定义索引
arr=(["name"]=valA ["age"]=valB)    # 创建关联数组,类似hash
arr[1]=valD                         # 修改或新增元素
arr["gender"]="male"                # 修改或新增关联数组元素

echo ${arr["name"]}                 # 查看数组指定元素
echo ${arr[@]}                      # 查看所有数组元素
echo ${!arr[@]}                     # 查看数组索引
echo ${#arr[@]}                     # 查看数组元素个数
echo ${arr[@]:2}                    # 查看索引2起的后全部元素(包含2)
echo ${arr[@]:2:2}                  # 查看索引2起的2个元素(包含2)
echo ${arr[@]:(-3):2}               # 查看倒数第3个元素起的2个元素(包含倒数第3个元素)

arr=($text)                         # 按空格分隔 text 成数组,并赋值给变量
IFS=":"; arr=($text)                # 按:分隔字符串 text 成数组,并赋值给变量
text="${array[*]}"                  # 用空格链接数组并赋值给变量
text=$(IFS=/; echo "${array[*]}")   # 用斜杠链接数组并赋值给变量

echo $$                             # 查看当前 shell 的进程号
echo $?                             # 查看最近调用的后台任务进程号
echo $!                             # 查看最近一条命令的返回码

IFS=$'\n'                           # 默认分隔符为空格,可修改
`unix command`                      # 运行linux命令
uid=`uid -u zev`                    # 将zev的uid赋值给shell的uid变量
echo $(( 1+1 ))                     # 算术运算

!!                                  # 上一条命令
!^                                  # 上一条命令的第一个单词
!$                                  # 上一条命令的最后一个单词
!string                             # 最近一条包含string的命令
!^string1^string2                   # 最近一条包含string1的命令, 快速替换为string2, 相当于!!:s/string1/string2/
!#                                  # 本条命令之前所有的输入内容

#####################################################################
# 函数 
#####################################################################
# 定义一个新函数
function myfunc() {
    # $1 代表第一个参数,$N 代表第 N 个参数
    # $# 代表参数个数
    # $0 代表被调用者自身的名字
    # $@ 代表所有参数,类型是个数组,想传递所有参数给其他命令用 cmd "$@" 
    # $* 空格链接起来的所有参数,类型是字符串
    {shell commands ...}
}

myfunc                              # 调用函数 myfunc 
myfunc arg1 arg2 arg3               # 带参数的函数调用
myfunc "$@"                         # 将所有参数传递给函数
myfunc "${array[@]}"                # 将一个数组当作多个参数传递给函数
shift                               # 参数左移

unset -f myfunc                     # 删除函数
declare -f                          # 列出函数定义

#####################################################################
# 判断 只记录[[  ]],忽略test,[],因为[[  ]]是它们的超集
#####################################################################
[[ expressions ]]                   # 条件包围
statement1 && statement2            # and 操作符
statement1 || statement2            # or 操作符
!expression                         # 如果 expression 为假那返回真

-n str1                             # 判断字符串不为空（长度大于零）
-z str1                             # 判断字符串为空（长度等于零）

-a file                             # 判断文件存在,如 [ -a /tmp/abc ] && echo "exists"
-d file                             # 判断文件存在,且该文件是一个目录
-e file                             # 判断文件存在,和 -a 等价
-f file                             # 判断文件存在,且该文件是一个普通文件（非目录等）
-r file                             # 判断文件存在,且可读
-s file                             # 判断文件存在,且尺寸大于0
-w file                             # 判断文件存在,且可写
-x file                             # 判断文件存在,且执行
-N file                             # 文件上次修改过后还没有读取过
-O file                             # 文件存在且属于当前用户
-G file                             # 文件存在且匹配你的用户组
file1 -nt file2                     # 文件1 比 文件2 新
file1 -ot file2                     # 文件1 比 文件2 旧

num1 -eq num2                       # 数字判断：num1 == num2
num1 -ne num2                       # 数字判断：num1 != num2
num1 -lt num2                       # 数字判断：num1 < num2
num1 -le num2                       # 数字判断：num1 <= num2
num1 -gt num2                       # 数字判断：num1 > num2
num1 -ge num2                       # 数字判断：num1 >= num2

#####################################################################
# 分支控制 if else elif fi
#####################################################################
[[ -a /tmp ]]; echo $?              # 判断/tmp文件夹是否存在,输出是 0
[ -a /tmp ]; echo $?                # 同上等价

# 判断/etc/passwd是否存在
if [[ -e /etc/passwd ]]; then   
    echo "alright it exists ... "
else
    echo "it doesn't exist ... "
fi

# 同上,等价
[[ -e /etc/passwd ]] && echo "alright it exists" || echo "it doesn't exist"

# 判断程序存在的话就执行
[ -x /bin/ls ] && /bin/ls -l

#####################################################################
# 流程控制 while/for/case/until 
#####################################################################

# while 循环
while condition; do
    statements
done

# for 循环：上面的 while 语句等价
for i in {1..10}; do
    echo $i
done

# while经典用法,逐行读取文件
while read row; do
    echo $row
done < /etc/passwd

# 多进程并发执行示例,将不会按1到10顺序输出
# 并发执行不能保证一定成功,事实上并发越高越容易出现失败的情况,可通过linux的named pipe+shell的read实现并发消费个数控制
for i in `seq 1 10`; do
{
    `sleep $(( $RANDOM%2 ))s`
    echo $i
}&
done
wait
echo "all progresses are finished"

# for 列举某目录下面的所有文件
for f in /home/*; do
    echo $f
done

# case 判断
case expression in
    pattern1 )
        statements ;;
    pattern2 )
        statements ;;
    "" )
        statements ;;
    * )
        otherwise ;;
esac

# until 语句
until condition; do
    statements
done

#####################################################################
# bash常用指令
#####################################################################
enable                              # 显示所有bash内置指令,5.0版的bash有61个
help let                            # 查看let怎么用
type let                            # 查看let是什么类型的指令 
bg                                  # 查看待做JOB,使用ctrl+z触发
jobs                                # 同上,等价
fg [%number]                        # 返回上一个或指定某个JOB
wait                                # 等待任务完成并返回退出状态,常用于等待并发执行'{}&'子进程全部完成

##############################################################################
# References
##############################################################################
https://github.com/skywind3000/awesome-cheatsheets/blob/master/languages/bash.sh
