
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
                ;;
            2)
                echo " "    
                echo "Vous avez choisit INFORMATION POSTE DISTANT" && sleep 2s
                echo "ACTION INFORMATION computer chosit" >> event.log
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

# Fonction pour afficher le menu action Ordinateur
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




# Début enregistrement evennement
echo "<Date>-<Heure>-<Utilisateur>-********StartScript********" >> event.log  



#appel foncton MENU1 
Menu_Principal

# Fin enregistrement evennement
echo "<Date>-<Heure>-<Utilisateur>-********EndScript********" >> event.log  
# Fin de script
exit 0








````






