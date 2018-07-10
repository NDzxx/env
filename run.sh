#!/bin/bash
if [ ${UID} == 0 ]; then
    echo "0. 基础软件包"
    echo "1. 扩展软件包"
    echo "2. Nodejs"
    echo "3. Python(pip)"
    echo "4. Golang"
    echo "5. Java"
    echo "6. MySQL"
    echo "第一次执行请安装基础软件包，然后选择其他操作。"
    read -p "选择你要安装的开发环境（输入前面的数字）：" i
    case "$i" in
        0)
        echo "========================================================================"
        echo "刷新软件列表"
        echo "========================================================================"
        apt-get update
        echo "1. curl"
        echo "2. ca-certificates"
        echo "3. wget"
        echo "4. pwgen"
        echo "5. build-essential"
        read -p "选择操作（推荐直接回车安装全部）：" i
        case "$i" in
            1)
            apt-get install -y curl
            echo "========================================================================"
            echo "curl安装完成！！"
            echo "========================================================================"
            ;;
            2)
            apt-get install -y  ca-certificates
            echo "========================================================================"
            echo "ca-certificates安装完成！！"
            echo "========================================================================"
            ;;
            3)
            apt-get install  -y wget
            echo "========================================================================"
            echo "wget安装完成！！"
            echo "========================================================================"
            ;;
            4)
            apt-get install  -y pwgen
            echo "========================================================================"
            echo "pwgen安装完成！！"
            echo "========================================================================"
            ;;
            5)
             apt-get install -y build-essential
            echo "========================================================================"
            echo "build-essential安装完成！！"
            echo "========================================================================"
            ;;
            *)
            apt-get install  -y curl ca-certificates wget pwgen build-essential
            echo "========================================================================"
            echo "基础软件包已全部安装完成！！"
            echo "========================================================================"
        esac
        ;;
        1)
        echo "1. virtualenv + codeintel"
        read -p "选择操作：" i
        case "$i" in
            1)
            pip install -U virtualenv
            virtualenv --python=python2 $HOME/.c9/python2
            source $HOME/.c9/python2/bin/activate
            $workspace="/workspace"
            virtualenv --python=python2 $workspace/.c9/python2
            source $workspace/.c9/python2/bin/activate
            apt-get install -y python-dev
            mkdir /tmp/codeintel
            pip install --download /tmp/codeintel codeintel==0.9.3
            cd /tmp/codeintel && tar xf CodeIntel-0.9.3.tar.gz
            mv CodeIntel-0.9.3/SilverCity CodeIntel-0.9.3/silvercity
            tar czf CodeIntel-0.9.3.tar.gz CodeIntel-0.9.3
            pip install -U --no-index --find-links=/tmp/codeintel codeintel
            # rm -rf /tmp/codeintel
            echo "========================================================================"
            echo "virtualenv + codeintel安装完成！！(CTRL+R重启Cloud9)"
            echo "========================================================================"
            ;;
            *)
            echo "请选择你要安装的扩展软件"
        esac
        ;;
        2)
        apt-get update
		apt-get install -y python-software-properties software-properties-common
		add-apt-repository ppa:chris-lea/node.js
		apt-get update
		apt-get install nodejs
		apt install nodejs-legacy
		apt install npm
		npm install -g cnpm --registry=https://registry.npm.taobao.org  
        node -v
		cnpm -v
        echo "========================================================================"
        echo "Nodejs安装完成！！"
        echo "========================================================================"
        ;;
	3)
    	apt-get install -y python
    	wget https://bootstrap.pypa.io/get-pip.py
    	python get-pip.py
    	rm get-pip.py
    	python --version
    	echo "========================================================================"
        echo "Python(pip)安装完成！！"
        echo "========================================================================"
    	;;
    	4)
    	apt-get install build-essential
    	wget https://dl.google.com/go/go1.10.linux-amd64.tar.gz
		tar zxvf go1.10.linux-amd64.tar.gz -C /usr/local
        echo "export GOROOT=/usr/local/go" >> /etc/profile
        echo "export PATH=$PATH:$GOROOT/bin" >> /etc/profile
        echo "export GOPATH=/$(whoami)/go1.10" >> /etc/profile
        source /etc/profile
        echo "========================================================================"
        echo "Golang安装完成！！"
        echo "========================================================================"
    	;;
    	5)
    	apt-get install -y python-software-properties software-properties-common
    	add-apt-repository -y ppa:webupd8team/java && sudo apt-get update
        apt-get install -y oracle-java8-installer
        java -version
        echo "========================================================================"
        echo "Java安装完成！！"
        echo "========================================================================"
    	;;
    	6)
        apt-get -y install mysql-server-5.6 && \
        rm -rf /var/lib/apt/lists/* && \
        rm /etc/mysql/conf.d/mysqld_safe_syslog.cnf && \
        mv $(pwd)/mysql/my.cnf /etc/mysql/conf.d/my.cnf && \
        mv $(pwd)/mysql/mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf && \
        if [ ! -f /usr/share/mysql/my-default.cnf ] ; then cp /etc/mysql/my.cnf /usr/share/mysql/my-default.cnf; fi && \
        mysql_install_db > /dev/null 2>&1 && \
        touch /var/lib/mysql/.EMPTY_DB
        # chmod +x $(pwd)/mysql/*.sh && \
        # cd $(pwd)/mysql && ./run.sh
        echo "========================================================================"
        echo "你现在可以连接MySQL服务了："
        echo ""
        echo "mysql -u<root> -p<yourpassword> -h<host> -P<port>"
        echo ""
        echo "MySQL的'root'用户只允许本地连接。"
        echo "========================================================================"
    	;;
        *)
        echo "选一个正确的数字～～"
    esac
else
    echo "没有权限（是不是少了sudo？）～～"
fi
