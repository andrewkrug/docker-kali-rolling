#!/bin/bash

# Install dependencies (debbootstrap)
sudo apt-get install debootstrap curl

# Fetch the latest Kali debootstrap script from git
curl "http://git.kali.org/gitweb/?p=packages/debootstrap.git;a=blob_plain;f=scripts/kali;h=50d7ef5b4e9e905cc6da8655416cdf3ef559911e;hb=refs/heads/kali/master" > kali-debootstrap &&\
sudo debootstrap kali-rolling ./kali-root http://repo.kali.org/kali ./kali-debootstrap &&\
sudo tar -C kali-root -c . | sudo docker import - andrewkrug/kali-linux-docker &&\
sudo rm -rf ./kali-root &&\
TAG=rolling
echo "Tagging kali with $TAG" &&\
sudo docker tag andrewkrug/kali-linux-docker:latest andrewkrug/kali-linux-docker:$TAG &&\
echo "Build OK" || echo "Build failed!"
