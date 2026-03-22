#!/bin/bash
if command -v docker &> /dev/null; then
	echo "已确定docker成功安装"
	docker --version
else
	echo "Docker未安装"
	if [ -f /etc/os-release ]; then
                source /etc/os-release
                if [[ "$ID" == "centos" ]]; then
                        echo "该系统为centos"
			if [ -d /root/yum_bak ]; then
				:
			else
				sudo mkdir /root/yum_bak
			if ls /etc/yum.repos.d/*.repo &> /dev/null; then
				mv /etc/yum.repos.d/*.repo /root/yum_bak
			fi
			sudo curl -o /etc/yum.repos.d/CentOS-Base.repo \
                            http://mirrors.aliyun.com/repo/Centos-7.repo
			yum makecache fast
			if [ $? -eq 0 ]; then
				:
			else
				sudo curl -o /etc/yum.repos.d/CentOS-Base.repo \
		                    http://mirrors.aliyun.com/repo/Centos-7.repo
			fi
			fi
			sudo yum install -y yum-utils device-mapper-persistent-data lvm2
                        sudo yum-config-manager --add-repo \
                            http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
                        sudo yum clean all && sudo yum makecache
                        sudo yum install -y docker-ce-24.0.9 docker-ce-cli-24.0.9 containerd.io
                        sudo systemctl start docker
                        sudo systemctl enable docker
			echo "完毕"
                        docker --version
		elif [ -f /etc/os-release ]; then
			source /etc/os-release
			if [[ "$ID" == "ubuntu" ]]; then
				echo "该系统为ubuntu"
				sudo apt-get updata
				sudo apt-get install -y ca-certificates curl gnupg lsb-relesase
				sudo install -m 0755 -d /etc/apt/keyrings
				curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
				sudo chmod a+r /etc/apt/keyrings/docker.gpg
				sudo echo \
				  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
				  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
				sudo apt-get update
				sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose
				sudo systemctl restart docker
				sudo systemctl enable docker
				echo "完毕"
				sudo docker --version
			else
				:
			fi
                else
			curl -fsSL https://get.docker.com | sh
		fi
	fi
fi
