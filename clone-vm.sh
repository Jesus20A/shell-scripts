#!/bin/bash
#
# Clone virtual machines based on templates on a remote KVM/QEMU server hypervisor.
# autor: Jesus Salas
#
if [ ! $1 ] && [ ! $2 ]; then
    echo "ERROR!!"
    echo "Usage: clone-vm.sh <distro> <vm-name>"
    echo "Use --help for more information"
    exit 1
fi

if [ ! $2 ]; then
    if [ $1 = '--list' ]; then
    echo "Available distros: "
    echo " [+] ubuntu"
    echo " [+] debian"
    echo " [+] suse"
    exit 0
    fi

    if [ $1 = '--help' ]; then
        echo "Usage: clone-vm.sh <distro> <vm-name>"
        echo "--list to list available distros"
        echo "--help to see this message"
        exit 0
    fi
    echo "ERROR!!"
    echo "Usage: clone-vm.sh <distro> <vm-name>"
    echo "Use --help for more information"
    exit 1
fi

 case $1 in
    ubuntu) virt-clone --connect virt1 --original template-ubuntu23.04 \
            --name $2 \
            --file /home/abdias/kvm/vms/$2.qcow2 && \
            echo "Stating $2 domain..." ; virsh -c virt1 start $2
            sleep 1
	        while [ "$(virsh -c virt1 domifaddr --domain $2 --interface enp1s0 --source agent 2>/dev/null| grep 192.* | awk '{print $4}' | cut -f1 -d . )" != "192" ]; do
                clear
		        echo "Waiting for ip ."
                sleep 1
                clear
                echo "Waiting for ip .."
                sleep 1
                clear
                echo "Waiting for ip ..."
                sleep 1
                clear
                echo "Waiting for ip ...."
                sleep 1
            done
            ip=$(virsh -c virt1 domifaddr --domain $2 --interface enp1s0 --source agent | grep 192.* | awk '{print $4}')
            sleep 1
            echo "Domain $2 ip: $ip";;
    debian) virt-clone --connect virt1 --original template-debian12 \
            --name $2 \
            --file /home/abdias/kvm/vms/$2.qcow2 && \
            sleep 1
            echo "Stating $2 domain..." ; virsh -c virt1 start $2
             while [ "$(virsh -c virt1 domifaddr --domain $2 --interface enp1s0 --source agent 2>/dev/null| grep 192.* | awk '{print $4}' | cut -f1 -d . )" != "192" ]; do
                clear
                echo "Waiting for ip ."
                sleep 1
                clear
                echo "Waiting for ip .."
                sleep 1
                clear
                echo "Waiting for ip ..."
                sleep 1
                clear
                echo "Waiting for ip ...."
                sleep 1
            done
            ip=$(virsh -c virt1 domifaddr --domain $2 --interface enp1s0 --source agent | grep 192.* | awk '{print $4}')
   	    sleep 1
            echo "Domain $2 ip: $ip";;
    suse) virt-clone --connect virt1 --original template-opensuse15.5 \
            --name $2 \
            --file /home/abdias/kvm/vms/$2.qcow2 && \
            echo "Stating $2 domain..." ; virsh -c virt1 start $2
            sleep 1
            while [ "$(virsh -c virt1 domifaddr --domain $2 --interface eth0 --source agent 2>/dev/null| grep 192.* | awk '{print $4}' | cut -f1 -d . )" != "192" ]; do
                clear
		        echo "Waiting for ip ."
                sleep 1
                clear
                echo "Waiting for ip .."
                sleep 1
                clear
                echo "Waiting for ip ..."
                sleep 1
                clear
                echo "Waiting for ip ...."
                sleep 1
            done
            ip=$(virsh -c virt1 domifaddr --domain $2 --interface eth0 --source agent | grep 192.* | awk '{print $4}')
            sleep 1
            echo "Domain $2 ip: $ip";;
    *) echo "No $1 template available"
       echo "List available templates with clone-vm.sh --list"
       exit 0;;
 esac