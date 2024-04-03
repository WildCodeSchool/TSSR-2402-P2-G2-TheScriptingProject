
```bash
#----------------------------------------------#
#-------- Fonction Menu Principal--------------#
#----------------------------------------------#

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
        echo "[X] Retour menu précédent "
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
                echo "Retour au menu précédent"  && sleep 2s
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
        echo "[X] Retour menu précédent "
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
                echo "Retour au menu précédent"  && sleep 2s
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
# Fonction pour afficher le menu
Menu_Action_Ordinateur() 
{
    while true; do
        # Effacer l'écran
        clear
        # Demande choix INFORMATION UTILISATEUR / ACTION POSTE DISTANT / retour menu principal
        echo "=================================================="
        echo '        Menu "Action Machine Distante"            '
        echo "=================================================="
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
        # Demande du choix action
        echo " "    
        read -p "Veuillez faire votre choix en donnant le numéro souhaité : " choix_Menu_Action_User

        case $choix_Menu_Action_User in
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
            X)
                echo " "    
                echo "Retour au menu principal" && sleep 2s
                echo "retour menu principal choisit" >> event.log
                return
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






