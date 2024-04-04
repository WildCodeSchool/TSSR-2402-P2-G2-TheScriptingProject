#!/bin/bash

# Fonction pour afficher le menu
show_menu_computer() 
{
# Effacer l'écran
    
# Affichage Menu Action
    echo "=================================================="
    echo '         Menu "Action Machine Distante"           '
    echo "=================================================="
    echo ""
    echo "Machine distante : $nom_distant@$ip_distante"
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
 
# Fonction "Arrêt"
shutdown()
{
# Demande de confrmation
read -p "Confirmez-vous l'arrêt de la machine distante ? [O pour valider] " conf_shutdown
# Si confirmation OK, affichage du sous-menu de la fonction "Arrêt"
if [ $conf_shutdown = O ]
	
then
		echo " [1] Arrêt instantané de la machine"
		echo " [2] Arrêt planifié de la machine avec message d'avertissement" 
		echo " [3] Arrêt planifié de la machine sans message d'avertissement"
		echo " [*] Revenir au menu précédent"
# Demande de choix pour le sous-menu de la fonction "Arrêt"		
		while true
		do
		read -p "Faites votre choix parmi la sélection ci-dessus : " conf_message_s
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
			ssh $nom_distant@$ip_distante notify-send "Extinction_prévue_à_$timer_s1 Pensez_à_sauvegarder_votre_travail"
			echo "Message d'avertissement envoyé"
			sleep 1s
			ssh $nom_distant@$ip_distante sudo -S shutdown $timer_s1
			echo "Arrêt planifié pour $timer_s1"
			sleep 3s
			return
			;;
			
			3) 
			echo "Arrêt planifié en cours"
			read -p "Indiquer l'heure de l'arrêt [hh:mm] " timer_s2
			ssh $nom_distant@$ip_distante sudo -S shutdown $timer_s2
			sleep 3s
			return
			;;
			
			*) 
			echo "Retour au menu précédent"
			sleep 1s
			return
			;;
		esac
		done
# Si confirmation NOK, sortie de la fonction "Arrêt"			
else
	echo "Opération annulée - Retour au menu précédent"
	sleep 2s
	
return
fi	
}

# Fonction "Redémarrage"
reboot()
{
# Demande de confrmation
read -p "Confirmez-vous l'arrêt de la machine distante ? [O pour valider] " conf_reboot
# Si confirmation OK, affichage du sous-menu de la fonction "Redémarrage"
if [ $conf_reboot = O ]
	
then
		
		echo " [1] Redémarrage instantané de la machine"
		echo " [2] Redémarrage planifié de la machine avec message d'avertissement" 
		echo " [3] Redémarrage planifié de la machine sans message d'avertissement"
		echo " [*] Revenir au menu précédent"
# Demande de choix pour le sous-menu de la fonction "Redémarrage"		
		while true
		do
		read -p "Choisissez comment vous souhaitez procéder : " conf_message_r
		case $conf_message_r in
				
			1) 
			echo "Redémarrage instantanné en cours"
			ssh $nom_distant@$ip_distante sudo -S shutdown -r now
			return
			;;
			
			2) 
			echo "Redémarrage planifié en cours"
			sleep 1s
			read -p "Indiquer l'heure du redémarrage [hh:mm] " timer_r1
			ssh $nom_distant@$ip_distante notify-send "Redémarrage_prévu_pour_$timer_r1 Pensez_à_sauvegarder_votre_travail"
			echo "Message d'avertissement envoyé"
			sleep 1s
			ssh $nom_distant@$ip_distante sudo -S shutdown -r $timer_r1
			sleep 3s
			return
			;;
			
			3) 
			echo "Redémarrage planifié en cours"
			read -p "Indiquer l'heure de l'arrêt [hh:mm] " timer_r2
			ssh $nom_distant@$ip_distante sudo -S shutdown -r $timer_r2
			sleep 3s
			return
			;;
			
			*) 
			echo "Retour au menu précédent"
			sleep 1s
			return
			;;
		esac
		done
# Si confirmation NOK, sortie de la fonction "Redémarrage"			
else
	echo "Opération annulée - Retour au menu précédent"
	sleep 1s
	
return
fi	
}

# Fonction "Vérouillage"
lock()
{
# Demande de confrmation
read -p "Confirmez-vous le vérouillage de la session de la machine distante ? [O pour valider] " conf_lock
# Si confirmation OK, exécution de la commande "Vérouillage"
if [ $conf_lock = O ]	
then
	ssh $nom_distant@$ip_distante sudo -S skill -KILL -u $nom_distant
	echo "La session de la machine distante a été vérouillée"
	sleep 2s
	
	return
# Si confirmation NOK, sortie de la fonction "Vérouillage"	
else
	echo "Opération annulée - Retour au menu précédent"
	sleep 1s
	
	return
fi
}

# Fonction MàJ
update()
{
# Demande de confrmation
read -p "Confirmez-vous la mise-à-jour du système de la machine distante ? [O pour valider] " conf_update
# Si confirmation OK, exécution de la commande "MàJ"
if [ $conf_update = O ]
then	
	ssh $nom_distant@$ip_distante sudo -S apt update && sudo -S apt upgrade -y
	echo "La mise-à-jour du système de la machine distante a été effectuée"
	sleep 2s
	return
# Si confirmation NOK, sortie de la fonction "MàJ"	
else
	echo "Opération annulée - Retour au menu précédent"
	sleep 1s
	return
fi
}

# Fonction "Création Dossier"
create_directory() 
{
# Demande de confrmation
    read -p "Confirmez-vous la création d'un dossier ? [O pour valider] " conf_create_directory
# Si confirmation OK, exécution de la commande "Création Dossier"
    if [ $conf_create_directory = O ]
    then
        
# Demande du nom du dossier à créer        
        read -p "Quel est le nom du dossier à créer ? " name_directory
# Si aucun nom rentré, sortie de la fonction "Création Dossier"
        if [ -z $name_directory ]
        then
            echo "Vous n'avez pas indiqué de nom de dossier, retour au menu précédent"
            sleep 1s
            return
        fi
# Demande du chemin de destination du dossier à créer
        read -p "Quel est le chemin de destination de votre dossier (Si pas de chemin indiqué, chemin courant utilisé) : " path_directory

        if ssh $nom_distant@$ip_distante [ -z "$path_directory" ]
        then
# Si le dossier existe à l'emplacement actuel, sortie de la fonction "Création Dossier"       
    		if ssh $nom_distant@$ip_distante "[ -d \"$name_directory\" ]"
    		then
        		echo "Le dossier existe déja"
        		echo "Retour au menu précédent"
        		sleep 1s
        		return
# Si le dossier n'existe pas, et que le chemin n'est pas spécifié, création du dossier à l'emplacement actuel
    		else
        		echo "Le dossier n'existe pas."
        		ssh $nom_distant@$ip_distante mkdir "$name_directory"
        		echo "Le dossier $name_directory sera créé à l'emplacement actuel"
        		sleep 2s
    		fi
	else
# Si le dossier existe dans l'emplacement spécifié, sortie de la fonction "Création Dossier"	
    		if ssh $nom_distant@$ip_distante "[ -d \"$path_directory/$name_directory\" ]"
    		then
        		echo "Le dossier existe déjà"
        		echo "Retour au menu précédent"
        		sleep 1s
        		return
# Si le dossier n'existe pas, et que le chemin est spécifié, création du dossier à cet emplacement
    		else
        		echo "Le dossier n'existe pas"
        		ssh $nom_distant@$ip_distante mkdir -p "$path_directory/$name_directory"
        		echo "Le dossier $name_directory a été créé à l'emplacement $path_directory"
        		sleep 2s
    		fi
	fi
# Si confirmation NOK, sortie de la fonction "Création Dossier"
    else
        echo "Opération annulée - Retour au menu précédent"
        sleep 1s
        
        return
    fi
}

# Fonction "Suppression Dossier"
remove_directory() 
{
# Demande de confrmation
    read -p "Confirmez-vous la suppression d'un dossier ? [O pour valider] " conf_remove_directory
# Si confirmation OK, exécution de la commande "Suppression Dossier"
    if [ $conf_remove_directory = O ]
    then
        
# Demande du nom du dossier à supprimer
        read -p "Quel est le nom du dossier à supprimer ? " name_directory_2
# Si aucun nom rentré, sortie de la fonction "Suppression Dossier"
        if [ -z "$name_directory_2" ]
        then
            echo "Vous n'avez pas indiqué de nom de dossier, retour au menu précédent"
            return
        fi
# Demande du chemin de destination du dossier à supprimer
        read -p "Quel est le chemin de votre dossier : " path_directory_2
# Si le dossier existe à l'emplacement spécifié, demande de confirmation de la suppression du dossier
        if ssh $nom_distant@$ip_distante [ -d "$path_directory_2/$name_directory_2" ]
        then
            read -p " Le dossier suivant $path_directory_2/$name_directory_2 sera supprimé, confirmez-vous ? [O pour valider] " conf_remove_directory_2
# Si confirmation OK, éxécution de la commande de suppression de dossier
            if [ $conf_remove_directory_2 = O ]
            then
                ssh $nom_distant@$ip_distante sudo -S rm -r "$path_directory_2/$name_directory_2"
                echo "Le dossier suivant $path_directory_2/$name_directory_2 a été supprimé"
                sleep 2s
                return
# Si confirmation NOK, sortie de la fonction "Suppression Dossier"
            else
                echo "Opération annulée - Retour au menu précédent"
                sleep 1s
                
                return
            fi
# Si le dossier n'existe pas à l'emplacement spécifié, sortie de la fonction "Suppression Dossier"
        else
            echo "Le dossier $path_directory_2/$name_directory_2 n'existe pas - Retour au menu précédent"
            sleep 2s
            
            return
        fi
    fi
}
# Fonction "Prise de main à distance"
remote_control()
# Demande de confirmation + Avertissement concernant la sortie du script dès l'éxécution de cette fonction
{
	echo "ATTENTION : Cette commande vous sortira momentanément du script"
	read -p "Confirmez-vous ? [O pour valider] : " conf_remote
# Si confirmation OK, exécution de la commande "Prise de main à distance" + Sortie du script
		if [ $conf_remote = O ]
		then
			echo "Accès à la commande de la machine distante :"
			sleep 2s
			ssh $nom_distant@$ip_distante
# Si confirmation NOK, sortie de la fonction "Prise de main à distance"
		else
			echo "Opération annulée - Retour au menu précédent"
			sleep 1s
			return		
		fi	
}

# Fonction "Activation du pare-feu"
firewall_on()
# Demande de confirmation + Avertissement
{
	echo "ATTENTION : Cette commande peut impacter l'éxécution du script"
	read -p "Confirmez-vous l'activation du pare-feu sur la machine distante ? [O pour valider ] : " conf_fw_on
# Si confirmation OK, éxécution de la commande "Activation du pare-feu"	
	if [ $conf_fw_on = O ]
	then 
		ssh $nom_distant@$ip_distante sudo -S ufw enable
		ssh $nom_distant@$ip_distante sudo -S ufw status | cat
		echo "Le pare-feu de la machine distante a été activé"
		sleep 2s
		return
# Si confirmation NOK, sortie de la fonction "Activation du pare-feu"
	else
		echo "Opération annulée - Retour au menu précédent"
		sleep 1s
		return	
	fi	
}

# Fonction "Désactivation du pare-feu"
firewall_off()
# Demande de confirmation + Avertissement
{
	echo "ATTENTION : Cette commande peut impacter la vulnérabilité de la machine distante"
	read -p "Confirmez-vous la désactivation du pare-feu sur la machine distante ? [O pour valider ] : " conf_fw_off
# Si confirmation OK, éxécution de la commande "Désactivation du pare-feu	
	if [ $conf_fw_off = O ]
	then 
		ssh $nom_distant@$ip_distante sudo -S ufw disable
		ssh $nom_distant@$ip_distante sudo -S ufw status | cat
		echo "Le pare-feu de la machine distante a été désactivé"
		sleep 2s
		return
# Si confirmation NOK, sortie de la fonction "Désactivation du pare-feu"
	else
		echo "Opération annulée - Retour au menu précédent"
		sleep 1s
		return	
	fi	
}

# Fonction "Règles du pare-feu"
firewall_rules()
# Demande de confirmation + Avertissement
{
	echo "ATTENTION : Les commandes suivantes sont reservées à un public averti"
	read -p "Confirmez-vous l'accès à la modification des régles du pare-feu ? [O Pour valider] : " conf_fw_rules
# Si confirmation OK, affichage du sous-menu de la fonction "Règles du pare-feu
	if [ $conf_fw_rules = O ]	 
	then
		
		echo " [1] Affichage de l'état actuel des règles du pare-feu"
		echo " [2] Ouverture d'un port (UDP et TCP)"
		echo " [3] Fermeture d'un port (UDP et TCP)"
		echo " [4] Activer la journalisation"
		echo " [5] Désactiver la journalisation"
		echo " [6] Réinitialiser le pare-feu"
		echo " [*] Revenir au menu précédent"
		
		while true
		do
		read -p "Faites votre choix parmi la sélection ci-dessus : " conf_message_fw
		case $conf_message_fw in
# Affichage de l'état actuel du pare-feu				
			1) 
			echo "Affichage de l'état actuel des règles du pare-feu"
			ssh $nom_distant@$ip_distante sudo -S ufw status verbose
			sleep 2s
			
			;;
# Exécution de la commande d'ouverture de port			
			2) 
			echo "Ouverture d'un port"
			sleep 2s
			read -p "Indiquer le n° du port à ouvrir : " port_1
			echo "Ouverture du port $port_1"
			sleep 2s
			ssh $nom_distant@$ip_distante sudo -S ufw allow $port_1
			echo "$port_1 ouvert"
			sleep 2s
			
			;;
# Exécution de la commande de fermeture de port				
			3) 
			echo "Fermeture d'un port"
			sleep 2s
			read -p "Indiquer le n° du port à fermer : " port_2
			echo "Fermeture du port $port_2"
			sleep 2s
			ssh $nom_distant@$ip_distante sudo -S ufw allow $port_2
			echo "$port_2 fermé"
			sleep 2s
			
			;;
# Exécution de la commande d'activation de la journalisation	
			4)
			echo "Activation de la journalisation"
			sleep 2s
			ssh $nom_distant@$ip_distante sudo -S ufw logging on
			sleep 2s
			
			;;
# Exécution de la commande de désactivation de la journalisation	
			5)
			echo "Désactivation de la journalisation"
			sleep 2s
			ssh $nom_distant@$ip_distante sudo -S ufw logging off
			sleep 2s
			
			;;
# Exécution de la commande de réinitialisation du pare-feu + Avertissement
			6)
			echo "Réinitialisation du pare-feu"
			echo "ATTENTION, cette commande peut compromettre la connexion à distance"
			read -p "Souhaitez-vous tout de même continuer ? [O pour valider] : " conf_reset_fw
# Si confirlation OK, exécution de la commande de réinitialisation du pare-feu 
				if [ $conf_reset_fw = O ]
				
				then 	
					sleep 1s
					$nom_distant@$ip_distante sudo -S ufw reset
					echo "Le pare-feu a été réinitialisé"
					sleep 2s
					
					return
# Si confirmation NOK, sortie de la fonction "Règles du pare-feu"
				else
					echo "Opération annulée - Retour au menu précédent"
					sleep 1s
					
				fi
					;;
				
# Si autre/mauvais choix, sortie de la fonction "Règles du pare-feu"		
			*) 
			echo "Retour au menu précédent"
			sleep 1s
			return
			;;
		esac
		done
	fi	
}
# Fonction "Installation Application"
install_app()

{
# Demande de confirmation
	read -p "Confirmez-vous l'accès à l'installation de logiciels ? [O Pour valider] : " conf_install
# Si confirmation OK, affichage du sous-menu de la fonction "Installation Application"
	if [ $conf_install = O ]	 
	then
	
		
		echo " [1] Installation via APT"
		echo " [2] Installation via SNAP"
		echo " [*] Revenir au menu précédent"
		
		while true
		do
		read -p "Faites votre choix parmi la sélection ci-dessus : " conf_message_install
		case $conf_message_install in
# Exécution de la commande "Installation via APT"		
			1)
			read -p "Quel logiciel souhaitez-vous installer via APT : " apt_install
			echo "Vous avez choisi d'installer le logiciel $apt_install"
			sleep 1s
			ssh $nom_distant@$ip_distante sudo -S apt install $apt_install
			sleep 1s
			echo "Le logiciel $apt_install a été installé"
			sleep 2s
			return
			;;		
# Exécution de la commande "Installation via SNAP"
			2)
			read -p "Quel logiciel souhaitez-vous installer via SNAP : " snap_install
			echo "Vous avez choisi d'installer le logiciel $snap_install"
			sleep 1s
			ssh $nom_distant@$ip_distante sudo -S snap install $snap_install
			sleep 1s
			echo "Le logiciel $snap_install a été installé"
			sleep 2s
			return	
			;;
# Si autre/mauvais choix, sortie de la fonction "Installation Application"
			*)	
			echo "Retour au menu précédent"
			sleep 1s
			return
			;;
		esac
		done
fi

}
# Fonction "Désinstallation Application"
uninstall_app()
# Demande de confirmation
{
read -p "Confirmez-vous l'accès à la désinstallation de logiciels ? [O Pour valider] : " conf_uninstall
# Si confirmation OK, affichage du sous-menu de la fonction "Installation Application"
	if [ $conf_uninstall = O ]	 
	then
		
		echo " [1] Désinstallation via APT"
		echo " [2] Désinstallation via SNAP"
		echo " [*] Revenir au menu précédent"

		while true
		do
		read -p "Faites votre choix parmi la sélection ci-dessus : " conf_message_uninstall
		case $conf_message_uninstall in
# Exécution de la commande "Installation via APT"
			1)
			read -p "Quel logiciel souhaitez-vous désinstaller via APT : " apt_uninstall
			echo "Vous avez choisi de désinstaller le logiciel $apt_uninstall"
			sleep 1s
			ssh $nom_distant@$ip_distante sudo -S apt remove $apt_uninstall
			sleep 1s
			echo "Le logiciel $apt_uninstall a été désinstallé"
			sleep 2s
			return	
			;;		
# Exécution de la commande "Installation via SNAP"
			2)
			read -p "Quel logiciel souhaitez-vous désinstaller via SNAP : " snap_uninstall
			echo "Vous avez choisi de désinstaller le logiciel $snap_uninstall"
			sleep 1s
			ssh $nom_distant@$ip_distante sudo -S snap install $snap_uninstall
			sleep 1s
			echo "Le logiciel $snap_uninstall a été désinstallé"
			sleep 2s
			return	
			;;		
# Si autre/mauvais choix, sortie de la fonction "Désinstallation Application"	
			*)	
			echo "Retour au menu précédent"
			sleep 1s
			return
			;;
		esac
		done
fi
}
# Fonction "Script à distance"
remote_script()
# Demande de confirmation
{
	read -p "Confirmez-vous l'éxécution d'un script sur la machine distante ? [O pour valider ] : " conf_script
# Si confirmation OK, éxécution de la commande "Script à distance""	
	if [ $conf_script = O ]	 
	then
# Demande du nom et du chemin du script à éxécuter	
		read -p "Quel est le nom du script ? : " name_script
		read -p "Quel est le chemin du script ? : " path_script
# Vérification de l'existence du script à l'emplacement spécifié		
			if ssh $nom_distant@$ip_distante test -e "$path_script/$name_script"
			then
# Si le script existe, il va être exécuté		
				echo "Le script $name_script existe."
				echo "Le script $name_script va être éxécuté"
				sleep 1s
# Changement des permissions du script pour le rendre exécutable				
				ssh $nom_distant@$ip_distante chmod +x "$path_script/$name_script"
# Ajout des arguments du script si besoin
				read -p "Si besoin, indiquez les arguments du script : " arg_script
				ssh $nom_distant@$ip_distante "$path_script/$name_script" $arg_script
				read -p "Appuyez sur Entrée pour continuer ..."
				sleep 1s
			else 
# Si le script n'existe pas, sortie de la fonction "Script à distance"
				echo "Le script $name_script n'existe pas dans le répertoire spécifié."
    				echo "Opération annulée - Retour au menu précédent."
    				sleep 2s
    				return
    			fi	
# Si confirmation NOK, sortie de la fonction "Script à distance"	
	else
		echo "Opération annulée - Retour au menu précédent"
		sleep 1s
		return
	fi	

}



# Affichage du menu "Informations Machine Distante"
    echo "=================================================="
    echo "        Informations Machine Distante             "
    echo "=================================================="
	echo ""
# Demande du nom d'utilisateur de la machine distante
	read -p "Veuillez entrer le nom d'utilisateur de la machine distante : " nom_distant
# Demande de l'adresse IP de la machine distante
	read -p "Veuillez entrer l'adresse IP de la machine distante : " ip_distante
	echo ""
	
while true
do
# Affiche le sous-menu
    show_menu_computer
# Demande du choix
    read -p "Faites votre choix parmi la sélection ci-dessus : " choix
    case $choix in
# Exécution de la fonction "Arrêt"
    1)
    	shutdown
    ;;
# Exécution de la fonction "Redémarrage"
    2)
    	reboot
    ;;
# Exécution de la fonction "Vérouillage"
    3)
    	lock
    ;;
# Exécution de la fonction "MàJ"
    4)
    	update
    ;;
# Exécution de la fonction "Création Dossier" 
    5)
    	create_directory
    ;;
# Exécution de la fonction "Suppression Dossier"
    6)
    	remove_directory
    ;;
# Exécution de la fonction "Prise de main à distance"
    7)
    	remote_control
    ;;
# Exécution de la fonction "Activation du pare-feu"
    8)
    	firewall_on	
    ;;
# Exécution de la fonction "Désactivation du pare-feu"
    9)
    	firewall_off
    ;;	
# Exécution de la fonction "Règles du pare-feu"
    10)
    	firewall_rules
    ;;	
# Exécution de la fonction "Redémarrage"
    11)
    	install_app
    ;;	
 # Exécution de la fonction "Installation Application"
    12)
    	uninstall_app
    ;;
# Exécution de la fonction "Désinstallation Application"
    13)
    	remote_script
    ;;	
# Retour au menu précédent
    X)
    	echo "Retour au menu précédent"
    	exit 0
    ;;
# Si mauvais choix, redemander de choisir à nouveau
    *)
	echo "Veuillez recommencer" 
	echo ""
	read -p "Appuyez sur Entrée pour continuer ..." && sleep 1s
    	
    				
    esac	
done    	
