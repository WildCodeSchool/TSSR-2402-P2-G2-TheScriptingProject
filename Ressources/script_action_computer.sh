#!/bin/bash

# Fonction pour afficher le menu
show_menu_computer() 
{
    # Effacer l'écran
    clear
    # Affichage actions
    echo "=================================================="
    echo '        Menu "Action Machine Distante" :          '
    echo "=================================================="
    echo ""
    echo " Machine distante : $nom_distant@$ip_distante"
    echo ""
    echo "[1]  Arrêt"
    echo "[2]  Redémarrage"
    echo "[3]  Vérouillage"
    echo "[4]  MàJ du système"
    echo "[5]  Création de repertoire"
    echo "[6]  Suppression de repertoire"
    echo "[7]  Prise de main à distance"
    echo "[8]  Activation du pare-feu"
    echo "[9]  Désactivation du pare-feu"
    echo "[10] Règles du parefeu"
    echo "[11] Installation d'un logiciel"
    echo "[12] Désinstallation d'un logiciel"
    echo "[13] Exécution d'un script sur la machine distante"
    echo ""
    echo "[X]  Retour au menu précédent"
    echo ""
 }
 
#Fonction arrêt
shutdown()
{
read -p "Confirmez-vous l'arrêt de la machine distante ? [O pour valider] " conf_shutdown

if [ $conf_shutdown = O ]
	
then
		clear
		echo " [1] Arrêt instantané de la machine "
		echo " [2] Arrêt planifié de la machine avec message d'avertissement " 
		echo " [3] Arrêt planifié de la machine sans message d'avertissement "
		echo " [*] Revenir au menu précédent "
		
		while true
		do
		read -p "Choisissez comment vous souhaitez procéder : " conf_message_s
		case $conf_message_s in
				
			1) 
			echo "Arrêt instantanné en cours"
			ssh $nom_distant@$ip_distante sudo -S shutdown
			return
			;;
			
			2) 
			echo "Arrêt planifié en cours"
			sleep 1s
			read -p "Indiquer l'heure de l'arrêt [hh:mm] " timer_s1
			ssh $nom_distant@$ip_distante notify-send "Arrêt_prévu_à_$timer_s1"
			echo "Message d'avertissement envoyé"
			sleep 2s
			ssh $nom_distant@$ip_distante sudo -S shutdown $timer_s1
			echo "Arrêt planifié pour $timer_s1"
			sleep 3s
			return
			;;
			
			3) 
			echo "Arrêt planifié en cours"
			read -p "Indiquer l'heure de l'arrêt [hh:mm] " timer_s2
			ssh $nom_distant@$ip_distante sudo -S shutdown $timer_s2
			sleep 2s
			return
			;;
			
			*) 
			echo "Retour au menu précédent"
			sleep 1s
			return
			;;
		esac
		done	
else
	echo "Mauvais choix - Retour au menu précédent"
	sleep 2s
	clear
return
fi	
}

#Fonction redémarrage
reboot()
{
read -p "Confirmez-vous l'arrêt de la machine distante ? [O pour valider] " conf_reboot

if [ $conf_reboot = O ]
	
then
		clear
		echo " [1] Redémarrage instantané de la machine "
		echo " [2] Redémarrage planifié de la machine avec message d'avertissement " 
		echo " [3] Redémarrage planifié de la machine sans message d'avertissement "
		echo " [*] Revenir au menu précédent "
		
		while true
		do
		read -p "Choisissez comment vous souhaitez procéder : " conf_message_r
		case $conf_message_r in
				
			1) 
			echo "Redémarrage instantanné en cours"
			sudo shutdown -S -r now
			return
			;;
			
			2) 
			echo "Redémarrage planifié en cours"
			sleep 1s
			read -p "Indiquer l'heure du redémarrage [hh:mm] " timer_s2
			notify-send "Redémarrage_prévu_pour_$timer_s2"
			echo "Message d'avertissement envoyé"
			sleep 2s
			sudo shutdown -S -r $timer_s2
			sleep 3s
			return
			;;
			
			3) 
			echo "Redémarrage planifié en cours"
			read -p "Indiquer l'heure de l'arrêt [hh:mm] " timer_s2
			sudo shutdown -S -r $timer_s2
			sleep 2s
			return
			;;
			
			*) 
			echo "Retour au menu précédent"
			sleep 1s
			return
			;;
		esac
		done	
else
	echo "Mauvais choix - Retour au menu précédent"
	sleep 2s
	clear
return
fi	
}

#Fonction vérouillage
lock()
{
read -p "Confirmez-vous le vérouillage de la session de la machine distante ? [O pour valider] " conf_lock

if [ $conf_lock = O ]	
then
	ssh $nom_distant@$ip_distante sudo -S skill -KILL -u $nom_distant
	echo "La session de la machine distante a été vérouillée"
	sleep 2s
	clear
	return
else
	echo "Mauvais choix - Retour au menu précédent"
	sleep 2s
	clear
	return
fi
}

#Fonction Màj
update()
{
read -p "Confirmez-vous la mise-à-jour du système de la machine distante ? [O pour valider] " conf_update

if [ $conf_update = O ]
then
	clear
	ssh $nom_distant@$ip_distante sudo apt update && sudo apt upgrade -y
	echo "La mise-à-jour du système de la machine distante a été effectuée"
	sleep 2s
	return
else
	clear
	echo "Mauvais choix - Retour au menu précédent"
	sleep 2s
	return
fi
}

#Fonction "Création de dossier"
create_directory() 
{

    read -p "Confirmez-vous la création d'un dossier ? [O pour valider] " conf_create_directory

    if [ $conf_create_directory = O ]
    then
        clear
        read -p "Quel est le nom du dossier à créer ? " name_directory

        if [ -z $name_directory ]
        then
            echo "Vous n'avez pas indiqué de nom de dossier, retour au menu précédent"
            return
        fi

        read -p "Quel est le chemin de destination de votre dossier (Si pas de chemin indiqué, chemin courant utilisé) : " path_directory

        if ssh $nom_distant@$ip_distante [ -z "$path_directory" ]
        then
    		if ssh $nom_distant@$ip_distante "[ -d \"$name_directory\" ]"
    		then
        		echo "Le dossier existe déjà."
        		echo "Retour au menu précédent"
        		sleep 2s
        		return
    		else
        		echo "Le dossier n'existe pas."
        		ssh $nom_distant@$ip_distante mkdir "$name_directory"
        		echo "Le dossier $name_directory sera créé à l'emplacement actuel"
        		sleep 2s
    		fi
	else
    		if ssh $nom_distant@$ip_distante "[ -d \"$path_directory/$name_directory\" ]"
    		then
        		echo "Le dossier existe déjà."
        		echo "Retour au menu précédent"
        		sleep 2s
        		return
    		else
        		echo "Le dossier n'existe pas."
        		ssh $nom_distant@$ip_distante mkdir -p "$path_directory/$name_directory"
        		echo "Le dossier $name_directory a été créé à l'emplacement $path_directory"
        		sleep 2s
    		fi
	fi


    else
        echo "Opération annulée - Retour au menu précédent"
        sleep 2s
        clear
        return
    fi
}

#Fonction "Suppréssion de dossier"
remove_directory() 
{

    read -p "Confirmez-vous la suppression d'un dossier ? [O pour valider] " conf_remove_directory

    if [ $conf_remove_directory = O ]
    then
        clear
        read -p "Quel est le nom du dossier à supprimer ? " name_directory_2

        if [ -z "$name_directory_2" ]
        then
            echo "Vous n'avez pas indiqué de nom de dossier, retour au menu précédent"
            return
        fi

        read -p "Quel est le chemin de votre dossier : " path_directory_2

        if ssh $nom_distant@$ip_distante [ -d "$path_directory_2/$name_directory_2" ]
        then
            read -p " Le dossier suivant $path_directory_2/$name_directory_2 sera supprimé, confirmez-vous ? [O pour valider] " conf_remove_directory_2
            if [ $conf_remove_directory_2 = O ]
            then
                ssh $nom_distant@$ip_distante sudo -S rm -r "$path_directory_2/$name_directory_2"
                echo "Le dossier suivant $path_directory_2/$name_directory_2 a été supprimé"
                sleep 2s
                return
            else
                echo "Opération annulée - Retour au menu précédent"
                sleep 2s
                clear
                return
            fi
        else
            echo "Le dossier $path_directory_2/$name_directory_2 n'existe pas - Retour au menu précédent."
            sleep 2s
            clear
            return
        fi
    fi
}

remote_control()
{
	echo "Cette action vous sortira de ce script et vous donnera accès à la commande de la machine distante $nom_distant@$ip_distante"
	read -p "Confirmez-vous ? [O pour valider] : " conf_remote
	
		if [ $conf_remote = O ]
		then
			echo "Accès à la commande de la machine distante : "
			sleep 2s
			ssh $nom_distant@$ip_distante	
		else
			echo "Opération annulée - Retour au menu précédent"
			sleep 2s
			return		
		fi	
}

firewall_on()
{
	read -p "Confirmez-vous l'activation du pare-feu sur la machine distante ? [O pour valider ] : " conf_fw_on
	
	if [ $conf_fw_on = O ]
	then 
		ssh $nom_distant@$ip_distante sudo -S ufw enable
		ssh $nom_distant@$ip_distante sudo -S ufw status | cat
		echo "Le pare-feu de la machine distante a été activé"
		sleep 3s
		return
	else
		echo "Opération annulée - Retour au menu précédent"
		sleep 2s
		return	
	fi	
}

firewall_off()

{
	read -p "Confirmez-vous la désactivation du pare-feu sur la machine distante ? [O pour valider ] : " conf_fw_off
	
	if [ $conf_fw_off = O ]
	then 
		ssh $nom_distant@$ip_distante sudo -S ufw disable
		ssh $nom_distant@$ip_distante sudo -S ufw status | cat
		echo "Le pare-feu de la machine distante a été désactivé"
		sleep 3s
		return
	else
		echo "Opération annulée - Retour au menu précédent"
		sleep 2s
		return	
	fi	
}


#Demande d'infos sur la machine distante
    echo "=================================================="
    echo "        Informations Machine Distante             "
    echo "=================================================="
	echo ""
	read -p "Veuillez entrer le nom de la machine distante : " nom_distant
	read -p "Veuillez entrer l'adresse IP de la machine distante : " ip_distante
	
while true
do
    # Affiche le menu
    show_menu_computer
    # Demande du choix action
    read -p "Faites votre choix parmi la sélection ci-dessus : " choix

    # Traitement de l'action choisie
    case $choix in
    1)
    	shutdown
    ;;
    
    2)
    	reboot
    ;;
    
    3)
    	lock
    ;;
    
    4)
    	update
    ;;
    
    5)
    	create_directory
    ;;
    			
    6)
    	remove_directory
    ;;
    
    7)
    	remote_control
    ;;
    
    8)
    	firewall_on	
    ;;
    
    9)
    	firewall_off
    			
    esac	
done    	
