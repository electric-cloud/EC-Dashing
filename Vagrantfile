# -*- mode: ruby -*-
# vi: set ft=ruby :

 $script = <<SCRIPT
    set -x
echo I am provisioning...
date > /etc/vagrant_provisioned_at
apt-get update
    echo "America/Los_Angeles" | sudo tee /etc/timezone
    ntpdate -u http://pool.ntp.org
    dpkg-reconfigure --frontend noninteractive tzdata
#    debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password commander'
#    debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password commander'
#    apt-get -y install mysql-server
#    mysqladmin -uroot -pcommander create commander
#    mysqladmin -uroot -pcommander create commander5
#    mysql -u root -pcommander -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'commander' WITH GRANT OPTION;"
#    sed -i.bak -e 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf
#    restart mysql
#    /vagrant/ElectricCommander-* --mode silent --installServer --unixServerUser vagrant \
  --unixServerGroup vagrant --installAgent --unixAgentUser vagrant --unixAgentGroup vagrant --installWeb --installRepository --installDatabase
#    export PATH=$PATH:/opt/electriccloud/electriccommander/jre/bin
#    export JAVA_HOME=/opt/electriccloud/electriccommander/jre/bin
#    cp /vagrant/mysql-connector-java.jar /opt/electriccloud/electriccommander/server/lib
#    /opt/electriccloud/electriccommander/bin/ectool setDatabaseConfiguration --databaseType mysql \
#  --databaseName commander --userName root --password commander --hostName localhost
#/etc/init.d/commanderServer restart
#    echo 'export PATH=$PATH:/opt/electriccloud/electriccommander/bin:/opt/electriccloud/electriccommander/jre/bin' > /home/vagrant/.bash_aliases

# Install Node.js
apt-get install python-software-properties python g++ make -y
add-apt-repository ppa:chris-lea/node.js -y
apt-get update
apt-get install nodejs -y

apt-get -y install curl
# Install RVM and latest ruby
curl -sSL https://get.rvm.io | bash -s stable --ruby
echo 'source /home/vagrant/.rvm/scripts/rvm' > /home/vagrant/.bash_aliases

# Following the instructions on http://shopify.github.io/dashing/
gem install dashing
gem install rest-client
gem install bundler
gem install json

mkdir /opt/dashing
mkdir /opt/dashing/dashboards

cp /vagrant/files/Gemfile /opt/dashing
cp /vagrant/files/config.ru /opt/dashing

cp /vagrant/files/dashboards/* /opt/dashing/dashboards
cp -R /vagrant/files/widgets /opt/dashing/
cp -R /vagrant/files/assets /opt/dashing/
cp -R /vagrant/files/public /opt/dashing/
cp -R /vagrant/files/jobs /opt/dashing/
cp -R /vagrant/files/lib /opt/dashing/


bundle
dashing start

SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "hashicorp/precise64"
  config.vm.provision :shell, :inline => $script

  # Private, host only networking
  config.vm.network :private_network, ip: '192.168.56.25'
  config.vm.network "forwarded_port", guest: 3030, host: 3030

  # Set the host name
  config.vm.hostname = "dashing"

  # Virtual box specific configuration options 
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

end
