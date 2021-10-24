



#Install software source manager

    apt-get update
    apt-get install software-properties-common

#Add mirror with openjdk-8-jdk

    apt-add-repository 'deb http://security.debian.org/debian-security stretch/updates main'
    apt-get update

#Install openjdk 8

    apt-get install openjdk-8-jdk

update-java-alternatives --list
sudo update-alternatives --config java
