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
        echo " "
        echo "Machine distante : $nom_distant@$ip_distante"
        echo " "
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
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-ACTION a été chosit"  >>  /var/log/log_evt.log        
                Menu_Action 
                ;;
            2) 
            # Envoie vers MENU INFORMAITON
                echo " "    
                echo "Vous avez choisit INFORMATION" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-INFORMATION a été chosit" >>  /var/log/log_evt.log                     
                Menu_Information 
                ;;
            X)
            # Arrêt script 
                echo " "    
                echo "J'espère que j'ai pu vous aider, à bientôt" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Sortie de Script" >>  /var/log/log_evt.log        
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-********EndScript********" >>  /var/log/log_evt.log    
                exit 0 
                ;;
            *)
            # Erreur de commande   
                echo " "    
                echo "Commande inconnu, Veuillez recommencer" 
                echo " "    
                read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>  /var/log/log_evt.log
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
        echo " "
        echo "Machine distante : $nom_distant@$ip_distante"
        echo " "
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
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-ACTION Utilisateur chosit" >>  /var/log/log_evt.log
                Menu_Action_Utilisateur
                ;;
            2)
                echo " "    
                echo "Vous avez choisit ACTION POSTE DISTANT"  && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-ACTION Poste distant chosit" >>  /var/log/log_evt.log 
                Menu_Action_Ordinateur
                ;;
            X)
                echo " "    
                echo "Retour au menu principal"  && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>  /var/log/log_evt.log
                return
                ;;        
            *)
                echo " "    
                echo "Commande inconnu, Veuillez recommencer" 
                echo " "    
                read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>  /var/log/log_evt.log
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
        echo " "
        echo "Machine distante : $nom_distant@$ip_distante"
        echo " "
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
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-ACTION Information utlisateur chosit" >>  /var/log/log_evt.log
                Menu_Information_Utilsateur
                ;;
            2)
                echo " "    
                echo "Vous avez choisit INFORMATION POSTE DISTANT" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-ACTION INFORMATION poste distant chosit" >>  /var/log/log_evt.log
                Menu_Information_Ordinateur
                ;;
            X)
                echo " "    
                echo "Retour au menu principal"  && sleep 2s
                 echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>  /var/log/log_evt.log
                return
                ;;        
            *)
                echo " "    
                echo "Commande inconnu, Veuillez recommencer" 
                echo " "    
                read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>  /var/log/log_evt.log
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
        echo " "
        echo "Machine distante : $nom_distant@$ip_distante"
        echo " "
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
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Création utilisateur chosit" >>  /var/log/log_evt.log
                créer_utilisateur
                ;;
            2)
                echo " "    
                echo "Vous avez choisit changement de mot de passe" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-changement de mot de passe chosit" >>  /var/log/log_evt.log
                changer_mdp
                ;;
            3)
                echo " "    
                echo "Vous avez choisit suppression de compte utilisateur" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Suppression de compte utilisateur chosit" >>  /var/log/log_evt.log
                supprimer_utilisateur
                ;;
            4)
                echo " "    
                echo "Vous avez choisit désactivation de compte utilisateur" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Désactivation de compte utilisateur chosit" >>  /var/log/log_evt.log
                désactiver_utilisateur
                ;;
            5)
                echo " "    
                echo "Vous avez choisit ajjout à groupe d'administration" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Ajjout à groupe d'administration chosit" >>  /var/log/log_evt.log
                ajouter_groupe_admin
                ;;
            6)
                echo " "    
                echo "Vous avez choisit ajjout à groupe local" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Ajjout à groupe loScal chosit" >>  /var/log/log_evt.log
                ajout_utilisateur_groupe
                ;;
            7)
                echo " "    
                echo "Vous avez choisit Sortie d'un groupe local" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Sortie d'un groupe local chosit" >>  /var/log/log_evt.log
                supprimer_utilisateur_groupe
                ;;
            0)
                echo " "    
                echo "Retour au menu précédent" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-retour au menu précédent choisit" >>  /var/log/log_evt.log
                return
                ;;
            X)
                echo " "    
                echo "Retour au menu principal" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>  /var/log/log_evt.log
                Menu_Principal
                ;;
            *)
                echo " "    
                echo "Commande inconnu, Veuillez recommencer" 
                echo " "    
                read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>  /var/log/log_evt.log
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
        echo " "
        echo "Machine distante : $nom_distant@$ip_distante"
        echo " "
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
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Arrêt choisit" >>  /var/log/log_evt.log
                shutdown
                ;;
            
            2)
                echo " "    
                echo "Vous avez choisit le rédemarrage de la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Redémarrage choisit" >>  /var/log/log_evt.log
                reboot
                ;;
            
            3)
                echo " "    
                echo "Vous avez choisit le vérrouillage de la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Vérrouillage machine distante choisit" >>  /var/log/log_evt.log
                lock
                ;;
            
            4)
                echo " "    
                echo "Vous avez choisit la mise à jour de la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Mise à jour choisit" >>  /var/log/log_evt.log
                update
                ;;
            
            5)
                echo " "    
                echo "Vous avez choisit de créér un répertoire sur la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Création de répertoire choisit" >>  /var/log/log_evt.log
                create_directory
                ;;
                        
            6)
                echo " "    
                echo "Vous avez choisit de supprimer un répertoire sur la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Suppression de répertoire choisit" >>  /var/log/log_evt.log
                remove_directory
                ;;

            7)
                echo " "    
                echo "Vous avez choisit Prise de main à distance sur la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Prise de main à distance choisit" >>  /var/log/log_evt.log
                remote_control
                ;;
            
            8)
                echo " "    
                echo "Vous avez choisit Activation du pare-feu sur la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Activation du pare-feu choisit" >>  /var/log/log_evt.log
                firewall_on	
                ;;
            
            9)
                echo " "    
                echo "Vous avez choisit Désactivation du pare-feu sur la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Désactivation du pare-feu choisit" >>  /var/log/log_evt.log
                firewall_off
                ;;	
                
            10)
                echo " "    
                echo "Vous avez choisit Règles du parefeu sur la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Modificaiton règles du parefeu choisit" >>  /var/log/log_evt.log
                firewall_rules
                ;;	
                
            11)
                echo " "    
                echo "Vous avez choisit Installation d'un logiciel sur la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Installation d'un logiciel choisit" >>  /var/log/log_evt.log
                install_app
                ;;	
            
            12)
                echo " "    
                echo "Vous avez choisit Désinstallation d'un logiciel sur la machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Désinstallation d'un logiciel choisit" >>  /var/log/log_evt.log
                uninstall_app
                ;;
            
            13)
                echo " "    
                echo "Vous avez choisit Lancement d'un script depuis machine distante" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Lancement d'un script choisit" >>  /var/log/log_evt.log
                remote_script
                ;;
            0)
                echo " "    
                echo "Retour au menu précédent" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-retour au menu précédent choisit" >>  /var/log/log_evt.log
                return
                ;;
            X)
                echo " "    
                echo "Retour au menu principal" && sleep 2s
                 echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>  /var/log/log_evt.log
                Menu_Principal
                ;;
            *)
                echo " "    
                echo "Commande inconnu, Veuillez recommencer" 
                echo " "    
                read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>  /var/log/log_evt.log
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
        echo " "
        echo "Machine distante : $nom_distant@$ip_distante"
        echo " "
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
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Date dernière connexion utilisateur chosit" >>  /var/log/log_evt.log
                
                ;;
            2)        
                echo " "    
                echo "Vous avez choisit Date dernière modificaiton mot de passe utilisateur" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Date dernière modificaiton mot de passe utilisateur chosit" >>  /var/log/log_evt.log
                
                ;;
            3)        
                echo " "    
                echo "Vous avez choisit Liste des session utilisateurs ouvertes" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Liste des session utilisateurs ouvertes chosit" >>  /var/log/log_evt.log
                
                ;;
            4)        
                echo " "    
                echo "Vous avez choisit Droits/permission sur un dossier" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Droits/permission sur un dossier chosit" >>  /var/log/log_evt.log
                
                ;;
            5)        
                echo " "    
                echo "Vous avez choisit Droits/permission sur un fichier" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Droits/permission sur un fichier chosit" >>  /var/log/log_evt.log
                
                ;;                
            0)
                echo " "    
                echo "Retour au menu précédent" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-retour au menu précédent choisit" >>  /var/log/log_evt.log
                return
                ;;
            X)
                echo " "    
                echo "Retour au menu principal" && sleep 2s
                 echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>  /var/log/log_evt.log
                Menu_Principal
                ;;
            *)
                echo " "    
                echo "Commande inconnu, Veuillez recommencer" 
                echo " "    
                read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>  /var/log/log_evt.log
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
        echo " "
        echo "Machine distante : $nom_distant@$ip_distante"
        echo " "
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
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information version de l'OS chosit" >>  /var/log/log_evt.log
                
                ;;
            2)        
                echo " "    
                echo "Vous avez choisit Nombre d'interface" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Nombre d'interface chosit" >>  /var/log/log_evt.log
                
                ;;
            3)        
                echo " "    
                echo "Vous avez choisit Adresse IP de chaque interface" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Adresse IP de chaque interface chosit" >>  /var/log/log_evt.log
                
                ;;
            4)        
                echo " "    
                echo "Vous avez choisit Adresse MAC de chaque interface" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Adresse MAC de chaque interface chosit" >>  /var/log/log_evt.log
                
                ;;
            5)        
                echo " "    
                echo "Vous avez choisit Liste des application/paquets installées" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Liste des application/paquets installées chosit" >>  /var/log/log_evt.log
                
                ;;               
            6)        
                echo " "    
                echo "Vous avez choisit Information CPU" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information CPU chosit" >>  /var/log/log_evt.log
                
                ;;                               
            7)        
                echo " "    
                echo "Vous avez choisit Mémoire RAM totale" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Mémoire RAM totale chosit" >>  /var/log/log_evt.log
                
                ;;                               
            8)        
                echo " "    
                echo "Vous avez choisit Utilisation de la RAM" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Utilisation de la RAM chosit" >>  /var/log/log_evt.log
                
                ;;               
            9)        
                echo " "    
                echo "Vous avez choisit Utilisation du disque" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Utilisation du disque chosit" >>  /var/log/log_evt.log
                
                ;;               
            10)        
                echo " "    
                echo "Vous avez choisit Utilisation du processeur" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Utilisation du processeur chosit" >>  /var/log/log_evt.log
                
                ;;               
            11)        
                echo " "    
                echo "Vous avez choisit Liste des ports ouverts" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Liste des ports ouverts chosit" >>  /var/log/log_evt.log
                
                ;;                                                                                          
            12)        
                echo " "    
                echo "Vous avez choisit Staut du pare-feu" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Staut du pare-feu chosit" >>  /var/log/log_evt.log
                
                ;;                                                                                                          
            0)
                echo " "    
                echo "Retour au menu précédent" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-retour au menu précédent choisit" >>  /var/log/log_evt.log
                return
                ;;
            X)
                echo " "    
                echo "Retour au menu principal" && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>  /var/log/log_evt.log
                Menu_Principal
                ;;
            *)
                echo " "    
                echo "Commande inconnu, Veuillez recommencer" 
                echo " "    
                read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
                echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>  /var/log/log_evt.log
        esac
    done
}

#----------------------------------------------#
#--------Fonction Action Utilisateur-----------#
#----------------------------------------------#


#----------------------------------------------#
#--------Fonction Action Ordinateur------------#
#----------------------------------------------#

#----------------------------------------------#
#-----Fonction Information Utilisateur---------#
#----------------------------------------------#


#----------------------------------------------#
#-----Fonction Information Ordinateur----------#
#----------------------------------------------#




#Demande d'infos sur la machine distante
	echo "=================================================="
    	echo "        Initialisation script pour connexion      "
   	echo "=================================================="
	echo ""
# Demande du nom d'utilisateur de la machine distante
	read -p "Veuillez entrer le nom d'utilisateur de la machine distante : " nom_distant
# Demande de l'adresse IP de la machine distante
	read -p "Veuillez entrer l'adresse IP de la machine distante : " ip_distante
# Demande d'identification    
    	read -p "Veuillez vous identifiez : " Operateur

# Début enregistrement evennement
echo $(date +%Y%m%d-%H%M%S)"-$Operateur-********StartScript********" >>  /var/log/log_evt.log    

#appel foncton MENU1 
Menu_Principal

# Fin enregistrement evennement
echo $(date +%Y%m%d-%H%M%S)"-$Operateur-********EndScript********" >>  /var/log/log_evt.log    
# Fin de script
exit 0
