#!/bin/bash
#
#   1 - Validates if the HOST CHASSIs is virtualized
#   2 - Validates which brand has the virtualizator/CHASSIs
#
#   Version:   3.0
#   Revision:  3.0
#   Mantainer: Xaeioux
#   License:   GPL
#===============================================================================
CHASSI=$(systemd-detect-virt)
PHYSICAL=$(dmidecode -s CHASSIs-type)

if [ "$CHASSI" == "none" ]; then
	if [ "$PHYSICAL" == "Notebook" ]; then
		echo -e $PAPAYA "Chassis....................:" $RSTCOLOR $PHYSICAL $RED"MAQUINA INAPROPRIADA" $RSTCOLOR;
	else
		echo -e $PAPAYA "Chassis....................:" $RSTCOLOR $PHYSICAL $YELLOW"MAQUINA FISICA" $RSTCOLOR;
	fi
else
	if [ "$CHASSI" == "qemu" ]; then
		echo -e $PAPAYA "Chassis....................:" $RSTCOLOR $CHASSI $GREEN"(vm PROXMOX)" $RSTCOLOR;
	elif [ "$CHASSI" == "vmware" ]; then
		echo -e $PAPAYA "Chassis....................:" $RSTCOLOR $CHASSI $RED"(vm VMWARE)" $RSTCOLOR;
	elif [ "$CHASSI" == "xen" ]; then
		echo -e $PAPAYA "Chassis....................:" $RSTCOLOR $CHASSI $RED"(vm XenServer/Citrix)" $RSTCOLOR;
	elif [ "$CHASSI" == "microsoft" ]; then
		echo -e $PAPAYA "Chassis....................:" $RSTCOLOR $CHASSI $RED"(vm Microsoft)" $RSTCOLOR;
	elif [ "$CHASSI" == "lxc" ]; then
		echo -e $PAPAYA "Chassis....................:" $RSTCOLOR $CHASSI $RED"(container PROXMOX) PODE TER COMPETICAO" $RSTCOLOR;
	elif [ "$CHASSI" == "docker" ]; then
		echo -e $PAPAYA "Chassis....................:" $RSTCOLOR $CHASSI $RED"(container DOCKER) PODE TER COMPETICAO" $RSTCOLOR;
	else
		echo -e $PAPAYA "Chassis....................:" $RSTCOLOR $CHASSI"(vm Bochs VALIDAR)" $RSTCOLOR;
	fi
fi
echo -e $RSTCOLOR
