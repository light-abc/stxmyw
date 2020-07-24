#!/bin/bash
#mysql=
#使用说明，用来提示输入参数
usage() {
    echo "Usage: sh restart-mysql.sh [start|stop|restart|status]"
    exit 1
}
 
#检查程序是否在运行
is_exist(){
  pid=`ps -ef|grep mysql |grep -v grep|awk '{print $2}'|sed -n '3,16p'`
  #如果不存在返回1，存在返回0     
  if [ -z "${pid}" ]; then
   return 1
  else
    return 0
  fi
}
 
#启动方法
start(){
  is_exist
  if [ $? -eq 0 ]; then
    echo "mysql is already running. pid=${pid}"
  else
    systemctl start mysqld
  fi
}
 
#停止方法
stop(){
  is_exist
  if [ $? -eq "0" ]; then
    kill -9 $pid
  else
    echo "mysql is not running"
  fi  
}
 
#运行状态
status(){
  is_exist
  if [ $? -eq "0" ]; then
    echo "mysql is running. Pid is ${pid}"
  else
    echo "mysql is NOT running."
  fi
}
 
#重启
restart(){
  stop
  sleep 5
  start
}
 
#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
  "start")
    start
    ;;
  "stop")
    stop
    ;;
  "status")
    status
    ;;
  "restart")
    restart
    ;;
  *)
    usage
    ;;
esac
