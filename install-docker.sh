# In WSL2 bash (open the Ubuntu app that was installed):

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/myuser/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

sudo apt update && sudo apt install -y build-essential gcc
sudo apt update && sudo apt install -y xdg-utils

brew install gcc
brew install drud/ddev/ddev

# Remove previously installed versions, if needed
# sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update && sudo apt install -y ca-certificates curl gnupg lsb-release
# echoing to priveleged file: https://stackoverflow.com/a/550808
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io

# https://docs.docker.com/engine/install/linux-postinstall
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# Not needed if you installed it using PowerShell, I think
mkcert -install

# https://docs.docker.com/engine/install/linux-postinstall/#configuring-remote-access-with-daemonjson
echo -e '{\n  "hosts": ["unix:///var/run/docker.sock", "tcp://127.0.0.1:2375"]\n}' | sudo tee -a daemon.json > /dev/null
sudo service docker restart

# To verify it's working:
sudo apt install -y net-tools
sudo netstat -lntp | grep dockerd

# https://askubuntu.com/a/1356147
echo -e "\n# Start the Docker service\n"
echo "wsl.exe -u root service docker status > /dev/null || wsl.exe -u root service docker start > /dev/null" > ~/.bashrc
