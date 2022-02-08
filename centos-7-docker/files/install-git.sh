# IUS repo setup info: https://ius.io/setup

# Remove and reinstall yum certificates to deal with weird error during image build
sudo rm -f /etc/ssl/certs/ca-bundle.crt
sudo yum reinstall -y ca-certificates

# Add the IUS and EPEL repos
sudo yum install -y https://repo.ius.io/ius-release-el7.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Remove the older version of Git that comes with OS
sudo yum remove -y git

# Install git224
sudo yum install -y git224