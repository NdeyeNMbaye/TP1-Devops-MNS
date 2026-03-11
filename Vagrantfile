# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # VM srv-web
  config.vm.define "srv-web" do |web|
    web.vm.box = "ubuntu/bionic64"
    web.vm.hostname = "srv-web"
    web.vm.network "private_network", ip: "192.168.56.10"
    web.vm.network "forwarded_port", guest: 8080, host: 8080

    web.vm.provider "virtualbox" do |vb|
      vb.name = "srv-web"
      vb.memory = 2048
      vb.cpus = 2
    end

    web.vm.provision "shell", inline: <<-SHELL
      echo "========================================"
      echo " Mise a jour du systeme"
      echo "========================================"
      sudo apt update -y

      echo "========================================"
      echo " Installation JDK 8, 11, 17"
      echo "========================================"
      sudo apt install -y openjdk-8-jdk openjdk-11-jdk openjdk-17-jdk wget

      echo "--- Versions Java installees ---"
      update-java-alternatives --list

      echo "========================================"
      echo " Installation Tomcat 9"
      echo "========================================"

      # Creer l'utilisateur tomcat
      sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat

      # Telecharger et extraire Tomcat 9
      cd /tmp
      wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.82/bin/apache-tomcat-9.0.82.tar.gz

      sudo mkdir -p /opt/tomcat
      sudo tar xzvf apache-tomcat-9.0.82.tar.gz -C /opt/tomcat --strip-components=1
      sudo chown -R tomcat: /opt/tomcat
      sudo sh -c 'chmod +x /opt/tomcat/bin/*.sh'

      echo "========================================"
      echo " Creation du service Tomcat (systemd)"
      echo "========================================"
      sudo bash -c 'cat > /etc/systemd/system/tomcat.service << EOF
[Unit]
Description=Apache Tomcat 9
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/bin/catalina.sh start
ExecStop=/opt/tomcat/bin/catalina.sh stop

[Install]
WantedBy=multi-user.target
EOF'

      sudo systemctl daemon-reload
      sudo systemctl start tomcat
      sudo systemctl enable tomcat

      echo "========================================"
      echo " Deploiement de l application sample.war"
      echo "========================================"
      sudo wget -q -O /opt/tomcat/webapps/sample.war \
        https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war
      sudo chown tomcat:tomcat /opt/tomcat/webapps/sample.war

      echo "========================================"
      echo " Copie du script deploy.sh"
      echo "========================================"
      sudo cp /vagrant/deploy.sh /home/vagrant/deploy.sh
      sudo chmod +x /home/vagrant/deploy.sh
      sudo chown vagrant:vagrant /home/vagrant/deploy.sh

      echo "========================================"
      echo " Provisionnement termine !"
      echo " Tomcat : http://192.168.56.10:8080"
      echo " App    : http://192.168.56.10:8080/sample"
      echo "========================================"
    SHELL
  end

end