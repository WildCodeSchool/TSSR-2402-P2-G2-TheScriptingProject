
```bash
#----------------------------------------------#
#-------- Fonction Menu Principal--------------#
#----------------------------------------------#

# Fonction menu principal
Menu_Principal()
{
    while true ; do
        # Effacer l'écran
        clear
        # Demande de premier choix ACTION / INFORMAITON ou QUITTER
	    echo "=================================================="
	    echo '                Menu Principal                    '
	    echo "=================================================="	
        echo "Bonjour, voici les choix possibles :"
        echo " "
        echo "[1] Menu ACTION sur Utilisateur ou POSTE DISTANT"
        echo "[2] Menu INFORMATION sur Utilisateur ou POSTE DISTANT"
        echo " "    
        echo "[X] Arreter le script "
        echo " "
        read -p "Veuillez faire un choix en donnant le numéro souhaité : " choixMenuPrincipal
        case $choixMenuPrincipal in
            1) 
            # Envoie vers MENU ACTION
                echo " "    
                echo "Vous avez choisit ACTION" && sleep 2s
                echo "ACTION a été chosit" >> event.log        
                Menu_Action 
                ;;
            2) 
            # Envoie vers MENU INFORMAITON
                echo " "    
                echo "Vous avez choisit INFORMATION" && sleep 2s
                echo "INFORMATION a été chosit" >> event.log                     
                Menu_Information 
                ;;
            X)
            # Arrêt script 
                echo " "    
                echo "J'espère que j'ai pu vous aider, à bientôt" && sleep 2s
                echo "Demande de sortie" >> event.log        
                exit 0 
                ;;
            *)
            # Erreur de commande   
                echo " "    
                echo "Commande inconnu, Veuillez recommencer" 
                echo " "    
                read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
                echo "erreur de commande" >> event.log
                ;;        
        esac
    done
}

# Fonction menu Action
Menu_Action() 
{
    while true; do
        # Effacer l'écran
        clear
	# Demande choix ACTION UTILISATEUR / ACTION POSTE DISTANT / retour menu principal
        echo "=================================================="
	    echo '                 Menu "Action"                    '
	    echo "=================================================="	
        echo "Voici les choix possibles :"
        echo " "
        echo "[1] ACTION sur UTILISATEUR "
        echo "[2] ACTION POSTE DISTANT "
	echo " "    
        echo "[X] Retour menu principal "
        echo " "    
        read -p "Veuillez faire un choix en donnant le numéro souhaité : " choixMenuAction
        case $choixMenuAction in
            1)
                echo " "    
                echo "Vous avez choisit ACTION UTILISATEUR" && sleep 2s
                echo "ACTION USER chosit" >> event.log
                Menu_Action_Utilisateur
                ;;
            2)
                echo " "    
                echo "Vous avez choisit ACTION POSTE DISTANT"  && sleep 2s
                echo "ACTION POSTE DISTANT chosit" >> event.log 
                Menu_Action_Ordinateur
                ;;
            X)
                echo " "    
                echo "Retour au menu principal"  && sleep 2s
                echo "retour menu principal" >> event.log
                return
                ;;        
            *)
                echo " "    
                echo "Commande inconnu, Veuillez recommencer" 
                echo " "    
                read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
                echo "erreur de commande" >> event.log
                ;;
        esac
    done
}

# Fonction menu Information
Menu_Information() 
{
    while true; do
        # Effacer l'écran
        clear
	# Demande choix INFORMATION UTILISATEUR / ACTION POSTE DISTANT / retour menu principal
        echo "=================================================="
	    echo '            Menu "INFORMATION"                    '
	    echo "=================================================="	
        echo "Voici les choix possibles :"
        echo " "
        echo "[1] INFORMATION sur UTILISATEUR"
        echo "[2] INFORMATION POSTE DISTANT"
        echo " "    
        echo "[X] Retour menu principal "
        echo " "    
        read -p "Veuillez faire un choix en donnant le numéro souhaité: " choixMenuInformation
        case $choixMenuInformation in
            1) 
                echo " "    
                echo "Vous avez choisit INFORMATION utilsiateur" && sleep 2s
                echo "ACTION INFORMATION user chosit" >> event.log
                Menu_Information_Utilsateur
                ;;
            2)
                echo " "    
                echo "Vous avez choisit INFORMATION POSTE DISTANT" && sleep 2s
                echo "ACTION INFORMATION computer chosit" >> event.log
                Menu_Information_Ordinateur
                ;;
            X)
                echo " "    
                echo "Retour au menu principal"  && sleep 2s
                echo "Retour menu principal" >> event.log
                return
                ;;        
            *)
                echo " "    
                echo "Commande inconnu, Veuillez recommencer" 
                echo " "    
                read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
                echo "erreur de commande" >> event.log
                ;;
        esac
    done
}

#----------------------------------------------#
#-------- Fonction Menu Action   --------------#
#----------------------------------------------#


# Fonction menu Action Utilisateur
Menu_Action_Utilisateur() 
{
    while true; do
        # Effacer l'écran
        clear
        #Demande choix ACTION UTILISATEUR / retour menu précédent / retour menu principal
        echo "=================================================="
        echo '             Menu "Action utilisateur"           '
        echo "=================================================="
        echo "Voici les choix possibles :"
        echo ""
        echo "[1] Création de compte utilisateur local"
        echo "[2] Changement de mot de passe"
        echo "[3] Suppression de compte utilisateur local"
        echo "[4] Désactivation de compte utilisateur local"
        echo "[5] Ajout à un groupe d'administration"
        echo "[6] Ajout à un groupe local"
        echo "[7] Sortie d'un groupe local"
        echo ""
        echo "[0]. Retour au menu précédent"
        echo "[X]. Retour au menu principal"
        echo ""
        # Demande du choix action
        read -p "Veuillez faire votre choix action en donnant le numéro souhaité:" choixMenuActionUser    
        # Traitement de l'action choisie
        case $choixMenuActionUser in
            1)        
                echo " "    
                echo "Vous avez choisit création de compte utilsiateur" && sleep 2s
                echo "Création utilisateur chosit" >> event.log
                créer_utilisateur
                ;;
            2)
                echo " "    
                echo "Vous avez choisit changement de mot de passe" && sleep 2s
                echo "changement de mot de passe chosit" >> event.log
                changer_mdp
                ;;
            3)
                echo " "    
                echo "Vous avez choisit suppression de compte utilisateur" && sleep 2s
                echo "Suppression de compte utilisateur chosit" >> event.log
                supprimer_utilisateur
                ;;
            4)
                echo " "    
                echo "Vous avez choisit désactivation de compte utilisateur" && sleep 2s
                echo "Désactivation de compte utilisateur chosit" >> event.log
                désactiver_utilisateur
                ;;
            5)
                echo " "    
                echo "Vous avez choisit ajjout à groupe d'administration" && sleep 2s
                echo "Ajjout à groupe d'administration chosit" >> event.log
                ajouter_groupe_admin
                ;;
            6)
                echo " "    
                echo "Vous avez choisit ajjout à groupe local" && sleep 2s
                echo "Ajjout à groupe loScal chosit" >> event.log
                ajout_utilisateur_groupe
                ;;
            7)
                echo " "    
                echo "Vous avez choisit Sortie d'un groupe local" && sleep 2s
                echo "Sortie d'un groupe local chosit" >> event.log
                supprimer_utilisateur_groupe
                ;;
            8)    
                echo " "    
                echo "Retour au menu précédent" && sleep 2s
                echo "retour menu précédent choisit" >> event.log
                return
                ;;
            0)
                echo " "    
                echo "Retour au menu précédent" && sleep 2s
                echo "retour menu précédent choisit" >> event.log
                return
                ;;
            X)
                echo " "    
                echo "Retour au menu principal" && sleep 2s
                echo "retour menu principal choisit" >> event.log
                Menu_Principal
                ;;
            *)
                echo "Option invalide. Veuillez choisir une option valide."
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
        esac
    done
}

# Fonction pour afficher le menu Ordinateur
Menu_Action_Ordinateur() 
{
    while true; do
        # Effacer l'écran1
        clear
        # Demande choix INFORMATION UTILISATEUR / ACTION POSTE DISTANT / retour menu principal
        echo "=================================================="
        echo '        Menu "Action Machine Distante"            '
        echo "=================================================="
        echo "Voici les choix possibles :"
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
        echo "[0]  Retour au menu précédent"
        echo "[X]  Retour au menu principal"
        echo ""
         # Demande du choix action
        read -p "Veuillez faire votre choix action en donnant le numéro souhaité:" choixMenuActionOrdinateur    
        # Traitement de l'action choisie
        case $choixMenuActionOrdinateur in   
            1)
                echo " "    
                echo "Vous avez choisit l'arrêt de la machine distante" && sleep 2s
                echo "Arrêt choisit" >> event.log
                shutdown
                ;;
            
            2)
                echo " "    
                echo "Vous avez choisit le rédemarrage de la machine distante" && sleep 2s
                echo "Redémarrage choisit" >> event.log
                reboot
                ;;
            
            3)
                echo " "    
                echo "Vous avez choisit le vérrouillage de la machine distante" && sleep 2s
                echo "Vérrouillage machine distante choisit" >> event.log
                lock
                ;;
            
            4)
                echo " "    
                echo "Vous avez choisit la mise à jour de la machine distante" && sleep 2s
                echo "Mise à jour choisit" >> event.log
                update
                ;;
            
            5)
                echo " "    
                echo "Vous avez choisit de créér un répertoire sur la machine distante" && sleep 2s
                echo "Création de répertoire choisit" >> event.log
                create_directory
                ;;
                        
            6)
                echo " "    
                echo "Vous avez choisit de supprimer un répertoire sur la machine distante" && sleep 2s
                echo "Suppression de répertoire choisit" >> event.log
                remove_directory
                ;;

            7)
                echo " "    
                echo "Vous avez choisit Prise de main à distance sur la machine distante" && sleep 2s
                echo "Prise de main à distance choisit" >> event.log
                remote_control
                ;;
            
            8)
                echo " "    
                echo "Vous avez choisit Activation du pare-feu sur la machine distante" && sleep 2s
                echo "Activation du pare-feu choisit" >> event.log
                firewall_on	
                ;;
            
            9)
                echo " "    
                echo "Vous avez choisit Désactivation du pare-feu sur la machine distante" && sleep 2s
                echo "Désactivation du pare-feu choisit" >> event.log
                firewall_off
                ;;	
                
            10)
                echo " "    
                echo "Vous avez choisit Règles du parefeu sur la machine distante" && sleep 2s
                echo "Règles du parefeu choisit" >> event.log
                firewall_rules
                ;;	
                
            11)
                echo " "    
                echo "Vous avez choisit Installation d'un logiciel sur la machine distante" && sleep 2s
                echo "Installation d'un logiciel choisit" >> event.log
                install_app
                ;;	
            
            12)
                echo " "    
                echo "Vous avez choisit Prise de main à distance sur la machine distante" && sleep 2s
                echo "Prise de main à distance choisit" >> event.log
                uninstall_app
                ;;
            
            13)
                echo " "    
                echo "Vous avez choisit Désinstallation d'un logiciel sur la machine distante" && sleep 2s
                echo "Désinstallation d'un logiciel choisit" >> event.log
                remote_script
                ;;
            0)
                echo " "    
                echo "Retour au menu précédent" && sleep 2s
                echo "retour menu précédent choisit" >> event.log
                return
                ;;
            X)
                echo " "    
                echo "Retour au menu principal" && sleep 2s
                echo "retour menu principal choisit" >> event.log
                Menu_Principal
                ;;
            *)
                echo "Option invalide. Veuillez choisir une option valide."
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
        esac	
    done
}

#----------------------------------------------#
#-------- Fonction Menu Information------------#
#----------------------------------------------#

# Fonction menu Information Utilisateur
Menu_Information_Utilsateur ()
{
    while true; do
        # Effacer l'écran
        clear
        #Demande choix INFOMRATION UTILISATEUR / retour menu précédent / retour menu principal
        echo "=================================================="
        echo '         Menu "Information utilisateur"           '
        echo "=================================================="
        echo "Voici les choix possibles :"
        echo ""
        echo "[1] Date dernière connexion utilisateur"
        echo "[2] Date dernière modificaiton mot de passe utilisateur"
        echo "[3] Liste des session utilisateurs ouvertes"
        echo "[4] Droits/permission sur un dossier"
        echo "[5] Droits/permission sur un fichier"
        echo ""
        echo "[0]. Retour au menu précédent"
        echo "[X]. Retour au menu principal"
        echo ""
        # Demande du choix action
        read -p "Veuillez faire votre choix action en donnant le numéro souhaité:" choixMenuInformationUser    
        # Traitement de l'action choisie
        case $choixMenuInformationUser in
            1)        
                echo " "    
                echo "Vous avez choisit Date dernière connexion utilisateur" && sleep 2s
                echo "Date dernière connexion utilisateur chosit" >> event.log
                
                ;;
            2)        
                echo " "    
                echo "Vous avez choisit Date dernière modificaiton mot de passe utilisateur" && sleep 2s
                echo "Date dernière modificaiton mot de passe utilisateur chosit" >> event.log
                
                ;;
            3)        
                echo " "    
                echo "Vous avez choisit Liste des session utilisateurs ouvertes" && sleep 2s
                echo "Liste des session utilisateurs ouvertes chosit" >> event.log
                
                ;;
            4)        
                echo " "    
                echo "Vous avez choisit Droits/permission sur un dossier" && sleep 2s
                echo "Droits/permission sur un dossier chosit" >> event.log
                
                ;;
            5)        
                echo " "    
                echo "Vous avez choisit Droits/permission sur un fichier" && sleep 2s
                echo "Droits/permission sur un fichier chosit" >> event.log
                
                ;;                
            0)
                echo " "    
                echo "Retour au menu précédent" && sleep 2s
                echo "retour menu précédent choisit" >> event.log
                return
                ;;
            X)
                echo " "    
                echo "Retour au menu principal" && sleep 2s
                echo "retour menu principal choisit" >> event.log
                Menu_Principal
                ;;
            *)
                echo "Option invalide. Veuillez choisir une option valide."
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
        esac
    done
}


# Fonction menu Information ordinateur
Menu_Information_Ordinateur ()
{

    while true; do
        # Effacer l'écran
        clear
        #Demande choix INFOMRATION UTILISATEUR / retour menu précédent / retour menu principal
        echo "=================================================="
        echo '         Menu "Information utilisateur"           '
        echo "=================================================="
        echo "Voici les choix possibles :"
        echo ""
        echo "[1] Version de l'OS"
        echo "[2] Nombre d'interface"
        echo "[3] Adresse IP de chaque interface"
        echo "[4] Adresse MAC de chaque interface"
        echo "[5] Liste des application/paquets installées"
        echo "[6] Information CPU"
        echo "[7] Mémoire RAM totale"
        echo "[8] Utilisation de la RAM"
        echo "[9] Utilisation du disque"
        echo "[10] Utilisation du processeur"
        echo "[11] Liste des ports ouverts"
        echo "[12] Staut du pare-feu"
        echo ""
        echo "[0]. Retour au menu précédent"
        echo "[X]. Retour au menu principal"
        echo ""
        # Demande du choix action
        read -p "Veuillez faire votre choix action en donnant le numéro souhaité:" choixMenuInformationOrdinateur    
        # Traitement de l'action choisie
        case $choixMenuInformationOrdinateur in
            1)        
                echo " "    
                echo "Vous avez choisit version de l'OS" && sleep 2s
                echo "Information version de l'OS chosit" >> event.log
                
                ;;
            2)        
                echo " "    
                echo "Vous avez choisit Nombre d'interface" && sleep 2s
                echo "Information Nombre d'interface chosit" >> event.log
                
                ;;
            3)        
                echo " "    
                echo "Vous avez choisit Adresse IP de chaque interface" && sleep 2s
                echo "Information Adresse IP de chaque interface chosit" >> event.log
                
                ;;
            4)        
                echo " "    
                echo "Vous avez choisit Adresse MAC de chaque interface" && sleep 2s
                echo "Information Adresse MAC de chaque interface chosit" >> event.log
                
                ;;
            5)        
                echo " "    
                echo "Vous avez choisit Liste des application/paquets installées" && sleep 2s
                echo "Information Liste des application/paquets installées chosit" >> event.log
                
                ;;               
            6)        
                echo " "    
                echo "Vous avez choisit Information CPU" && sleep 2s
                echo "Information CPU chosit" >> event.log
                
                ;;                               
            7)        
                echo " "    
                echo "Vous avez choisit Mémoire RAM totale" && sleep 2s
                echo "Information Mémoire RAM totale chosit" >> event.log
                
                ;;                               
            8)        
                echo " "    
                echo "Vous avez choisit Utilisation de la RAM" && sleep 2s
                echo "Information Utilisation de la RAM chosit" >> event.log
                
                ;;               
            9)        
                echo " "    
                echo "Vous avez choisit Utilisation du disque" && sleep 2s
                echo "Information Utilisation du disque chosit" >> event.log
                
                ;;               
            10)        
                echo " "    
                echo "Vous avez choisit Utilisation du processeur" && sleep 2s
                echo "Information Utilisation du processeur chosit" >> event.log
                
                ;;               
            11)        
                echo " "    
                echo "Vous avez choisit Liste des ports ouverts" && sleep 2s
                echo "Information Liste des ports ouverts chosit" >> event.log
                
                ;;                                                                                          
            12)        
                echo " "    
                echo "Vous avez choisit Staut du pare-feu" && sleep 2s
                echo "Information Staut du pare-feu chosit" >> event.log
                
                ;;                                                                                                          
            0)
                echo " "    
                echo "Retour au menu précédent" && sleep 2s
                echo "retour menu précédent choisit" >> event.log
                return
                ;;
            X)
                echo " "    
                echo "Retour au menu principal" && sleep 2s
                echo "retour menu principal choisit" >> event.log
                Menu_Principal
                ;;
            *)
                echo "Option invalide. Veuillez choisir une option valide."
                read -p "Appuyez sur Entrée pour continuer..."
                ;;
        esac
    done
}

#----------------------------------------------#
#--------Fonction Action Utilisateur-----------#
#----------------------------------------------#


#----------------------------------------------#
#--------Fonction Action Ordinateur------------#
#----------------------------------------------#

#Fonction arrêt
shutdown()
{
read -p "Confirmez-vous l'arrêt de la machine distante ? [O pour valider] " conf_shutdown

if [ $conf_shutdown = O ]
	
then
		clear
		echo " [1] Arrêt instantané de la machine"
		echo " [2] Arrêt planifié de la machine avec message d'avertissement" 
		echo " [3] Arrêt planifié de la machine sans message d'avertissement"
		echo " [*] Revenir au menu précédent"
		
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
		echo " [1] Redémarrage instantané de la machine"
		echo " [2] Redémarrage planifié de la machine avec message d'avertissement" 
		echo " [3] Redémarrage planifié de la machine sans message d'avertissement"
		echo " [*] Revenir au menu précédent"
		
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
else
	echo "Mauvais choix - Retour au menu précédent"
	sleep 1s
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
	sleep 1s
	clear
	return
fi
}

#Fonction Màj du système
update()
{
read -p "Confirmez-vous la mise-à-jour du système de la machine distante ? [O pour valider] " conf_update

if [ $conf_update = O ]
then
	clear
	ssh $nom_distant@$ip_distante sudo -S apt update && sudo -S apt upgrade -y
	echo "La mise-à-jour du système de la machine distante a été effectuée"
	sleep 2s
	return
else
	clear
	echo "Mauvais choix - Retour au menu précédent"
	sleep 1s
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
            sleep 1s
            return
        fi

        read -p "Quel est le chemin de destination de votre dossier (Si pas de chemin indiqué, chemin courant utilisé) : " path_directory

        if ssh $nom_distant@$ip_distante [ -z "$path_directory" ]
        then
    		if ssh $nom_distant@$ip_distante "[ -d \"$name_directory\" ]"
    		then
        		echo "Le dossier existe déja"
        		echo "Retour au menu précédent"
        		sleep 1s
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
        		echo "Le dossier existe déjà"
        		echo "Retour au menu précédent"
        		sleep 1s
        		return
    		else
        		echo "Le dossier n'existe pas"
        		ssh $nom_distant@$ip_distante mkdir -p "$path_directory/$name_directory"
        		echo "Le dossier $name_directory a été créé à l'emplacement $path_directory"
        		sleep 2s
    		fi
	fi


    else
        echo "Opération annulée - Retour au menu précédent"
        sleep 1s
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
                sleep 1s
                clear
                return
            fi
        else
            echo "Le dossier $path_directory_2/$name_directory_2 n'existe pas - Retour au menu précédent"
            sleep 2s
            clear
            return
        fi
    fi
}

#Fonction prise en main à distance
remote_control()
{
	echo "Cette action vous sortira de ce script et vous donnera accès à la commande de la machine distante $nom_distant@$ip_distante"
	read -p "Confirmez-vous ? [O pour valider] : " conf_remote
	
		if [ $conf_remote = O ]
		then
			echo "Accès à la commande de la machine distante :"
			sleep 2s
			ssh $nom_distant@$ip_distante	
		else
			echo "Opération annulée - Retour au menu précédent"
			sleep 1s
			return		
		fi	
}

#Fonction activation Firewall
firewall_on()
{
	read -p "Confirmez-vous l'activation du pare-feu sur la machine distante ? [O pour valider ] : " conf_fw_on
	
	if [ $conf_fw_on = O ]
	then 
		ssh $nom_distant@$ip_distante sudo -S ufw enable
		ssh $nom_distant@$ip_distante sudo -S ufw status | cat
		echo "Le pare-feu de la machine distante a été activé"
		sleep 2s
		return
	else
		echo "Opération annulée - Retour au menu précédent"
		sleep 1s
		return	
	fi	
}

#Fonction désactivation Firewall
firewall_off()

{
	read -p "Confirmez-vous la désactivation du pare-feu sur la machine distante ? [O pour valider ] : " conf_fw_off
	
	if [ $conf_fw_off = O ]
	then 
		ssh $nom_distant@$ip_distante sudo -S ufw disable
		ssh $nom_distant@$ip_distante sudo -S ufw status | cat
		echo "Le pare-feu de la machine distante a été désactivé"
		sleep 2s
		return
	else
		echo "Opération annulée - Retour au menu précédent"
		sleep 1s
		return	
	fi	
}

#Fonction règles Firewall
firewall_rules()
{
	read -p "Confirmez-vous l'accès à la modification des régles du pare-feu ? [O Pour valider] : " conf_fw_rules
	
	if [ $conf_fw_rules = O ]	 
	then
		clear
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
				
			1) 
			echo "Affichage de l'état actuel des règles du pare-feu"
			ssh $nom_distant@$ip_distante sudo -S ufw status verbose
			;;
			
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
			
			4)
			echo "Activation de la journalisation"
			sleep 2s
			ssh $nom_distant@$ip_distante sudo -S ufw logging on
			echo "Journalisation activée"
			sleep 2s
			;;
			
			5)
			echo "Désactivation de la journalisation"
			sleep 2s
			ssh $nom_distant@$ip_distante sudo -S ufw logging off
			echo "Journalisation désactivée"
			sleep 2s
			;;
			
			6)
			echo "Réinitialisation du pare-feu"
			echo "ATTENTION, cette commande peut compromettre la connexion à distance"
			read -p "Souhaitez-vous tout de même continuer ? [O pour valider] : " conf_reset_fw
			
				if [ $conf_reset_fw = O ]
				
				then 	
					sleep 1s
					$nom_distant@$ip_distante sudo -S ufw reset
					echo "Le pare-feu a été réinitialisé"
					sleep 2s
					return
				else
					echo "Opération annulée - Retour au menu précédent"
					sleep 1s
				fi
					;;
				
				
			*) 
			echo "Retour au menu précédent"
			sleep 1s
			return
			;;
		esac
		done
	fi	
}

#Fonction installation d'une appllication
install_app()

{

	read -p "Confirmez-vous l'accès à l'installation de logiciels ? [O Pour valider] : " conf_install
	if [ $conf_install = O ]	 
	then
		clear
		echo " [1] Installation via APT"
		echo " [2] Installation via SNAP"
		echo " [*] Revenir au menu précédent"
		
		while true
		do
		read -p "Faites votre choix parmi la sélection ci-dessus : " conf_message_install
		case $conf_message_install in
		
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
			
			*)	
			echo "Retour au menu précédent"
			sleep 1s
			return
			;;
		esac
		done
fi

}

#Fonction suppression d'une appllication
uninstall_app()

{
read -p "Confirmez-vous l'accès à la désinstallation de logiciels ? [O Pour valider] : " conf_uninstall
	if [ $conf_uninstall = O ]	 
	then
		clear
		echo " [1] Désinstallation via APT"
		echo " [2] Désinstallation via SNAP"
		echo " [*] Revenir au menu précédent"
		
		while true
		do
		read -p "Faites votre choix parmi la sélection ci-dessus : " conf_message_uninstall
		case $conf_message_uninstall in
		
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
			
			*)	
			echo "Retour au menu précédent"
			sleep 1s
			return
			;;
		esac
		done
fi
}

#Fonction lancement d'un script
remote_script()

{
	read -p "Confirmez-vous l'éxécution d'un script sur la machine distante ? [O pour valider ] : " conf_script
	
	if [ $conf_script = O ]	 
	then
		read -p "Quel est le nom du script ? : " name_script
		read -p "Quel est le chemin du script ? : " path_script
		echo "Le script $name_script va être éxécuté"
		sleep 1s
		ssh $nom_distant@$ip_distante cd $path_script
		ssh $nom_distant@$ip_distante chmod +x $name_script
		read -p "Si besoin, indiquez les arguments du script : " arg_script
		ssh $nom_distant@$ip_distante ./$name_script $arg_script
		sleep 4s
		return
	
	else
		echo "Opération annulée - Retour au menu précédent"
		sleep 1s
		return
	fi	

}

#----------------------------------------------#
#-----Fonction Information Utilisateur---------#
#----------------------------------------------#


#----------------------------------------------#
#-----Fonction Information Ordinateur----------#
#----------------------------------------------#




# Début enregistrement evennement
echo "<Date>-<Heure>-<Utilisateur>-********StartScript********" >> event.log  



#appel foncton MENU1 
Menu_Principal

# Fin enregistrement evennement
echo "<Date>-<Heure>-<Utilisateur>-********EndScript********" >> event.log  
# Fin de script
exit 0

````
