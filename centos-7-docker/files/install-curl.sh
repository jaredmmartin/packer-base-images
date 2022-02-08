# Install the city-fan repo that contains the most recent builds for curl
sudo rpm -Uvh http://www.city-fan.org/ftp/contrib/yum-repo/rhel7/x86_64/city-fan.org-release-2-1.rhel7.noarch.rpm

# Install yum utilities
sudo yum install -y yum-utils

# Disable the city-fan repo unless it is specifically enabled for a command
sudo yum-config-manager --disable city-fan.org

# Install curl and dependencies
sudo yum --enablerepo=city-fan.org install -y libcurl libcurl-devel