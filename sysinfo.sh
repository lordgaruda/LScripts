#!/bin/bash

echo "RAM Information:"
free -h | grep Mem

echo -e "\nRAM Type:"
dmidecode -t memory | grep -i "Type:"

echo -e "\nSSD Information:"
if lsblk -d -o name,rota,size,model | grep -i "nvme"; then
    lsblk -d -o name,rota,size,model | grep -i "nvme"
elif lsblk -d -o name,rota,size,model | grep -i "sda"; then
    lsblk -d -o name,rota,size,model | grep -i "sda"
else
    echo "Unable to detect SSD type."
fi

echo -e "\nLaptop Model and Serial Number:"
dmidecode -t system | grep -i "Product Name:"
dmidecode -t system | grep -i "Serial Number:"

echo -e "\nProcessor Information:"

lscpu | grep -i "Model name" | awk -F: '{print $2}'

