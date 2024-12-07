#!/bin/sh
set -ex

# [TODO: 最初に設定] 環境変数
GIT_REPOSITORY_DIR="$HOME/webapp"
SYSTEMCTL_APP="isu-ruby"
MYSQL_SLOW_LOG="/var/log/mysql/mysql-slow.log"
NGINX_ACCESS_LOG="/var/log/nginx/access.log"
APP_PROF="$GIT_REPOSITORY_DIR/ruby/tmp"

cp -r ${GIT_REPOSITORY_DIR}/etc/nginx/* /etc/nginx
cp -r ${GIT_REPOSITORY_DIR}/etc/mysql/* /etc/mysql

sudo truncate -s 0 "${MYSQL_SLOW_LOG}"
sudo truncate -s 0 "${NGINX_ACCESS_LOG}"
if [ -d $APP_PROF ]; then
  rm -r ${APP_PROF}
fi

sudo systemctl restart ${SYSTEMCTL_APP}
sudo systemctl restart nginx
sudo systemctl restart mysql
