!/bin/bash


# sudo sh -c "$(curl -fsSLhttps://raw.githubusercontent.com/dstf/debian-lab/main/add-user.sh)"


# Stop on any errors
set -e

echo "Please enter the server's username that you want to add users to:"
read serveruser
echo "Please enter the server's IP address that you want to add users to:"
read address
echo "Please enter the username to be added"
read user
echo "Please enter the public ssh key"
read pubkey

#Add user with no password and disabled prompt
#Create .ssh directory
#Create authorized_keys file
#Append public key to authorized_keys file
#Adjust ownership and permissions of the .ssh folder and authorized_keys file
ssh -t $serveruser@$address 'sudo adduser --disabled-password --gecos "" ' $user '; sudo mkdir -p /home/'$user'/.ssh ; sudo touch /home/'$user'/.ssh/authorized_keys ;' "echo $pubkey | sudo tee /home/$user/.ssh/authorized_keys ; sudo chown -R $user:$user /home/$user/.ssh; sudo chmod 700 /home/$user/.ssh; sudo chmod 600 /home/$user/.ssh/authorized_keys"

