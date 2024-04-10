################################################################################################################################################################################################################
################################################################################################################################################################################################################
# Script Bash pour maintenance et information sur Poste Distant Linux
# Version 0.8
# Réalisé en collaboration par Anais Lenglet, Bruno Serna, Grégory Dubois, Patrick Baggiolini et Thomas Scotti
# Dernière mise à jour le  08 / 04 / 2024
# Historique version
# V0.8 -- 08 / 04 / 2024 finalisation chemin pour enregistrement fichier information utilisateur/computeur
# V0.75 -- 05 / 04 / 2024 création répertoire "Documents" et création var pour chemin enregistrement info utilisateur/computeur
# V0.7 -- 04 / 04 / 2024 Ajout Fonction information ordinateur
# V0.6 -- 04 / 04 / 2024 Ajout log event / Fonction action ordinateur / Fonction action utilisateur Et  Fonction information utilisateur
# V0.5 -- 03 / 04 / 2024 Création script
################################################################################################################################################################################################################
################################################################################################################################################################################################################

####################################################
########### Fonction Menu Principal ################
####################################################

############## DEBUT FONCTION ######################

# Définition des codes de couleur ANSI
RED='\033[0;31m'
BLUEL='\033[0;36m'
BLUED='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Définition couleur du Background
BG_BLUE='\033[44m'

# Fonction menu principal
Menu_Principal() {
    while true; do
        # Effacer l'écran
        clear
        # Demande de premier choix ACTION / INFORMATION ou QUITTER
        echo "==================================================="
        echo -e "${BG_BLUE}                      Menu Principal               ${NC}"
        echo "==================================================="
        echo " "
        echo "Machine distante : $nom_distant@$ip_distante"
        echo " "
        echo "Bonjour, voici les choix possibles :"
        echo " "
        echo "[1] Menu ACTION sur Utilisateur ou POSTE DISTANT$"
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
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-ACTION a été chosit" >>/var/log/log_evt.log
            Menu_Action
            ;;
        2)
            # Envoie vers MENU INFORMATION
            echo " "
            echo "Vous avez choisit INFORMATION" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-INFORMATION a été chosit" >>/var/log/log_evt.log
            Menu_Information
            ;;
        X)
            # Arrêt script
            echo " "
            echo "J'espère que j'ai pu vous aider, à bientôt" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Sortie de Script" >>/var/log/log_evt.log
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-********EndScript********" >>/var/log/log_evt.log
            exit 0
            ;;
        *)
            # Erreur de commande
            echo " "
            echo "Commande inconnu, Veuillez recommencer"
            echo " "
            read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>/var/log/log_evt.log
            ;;
        esac
    done
}

# Fonction menu Action
Menu_Action() {
    while true; do
        # Effacer l'écran
        clear
        # Demande choix ACTION UTILISATEUR / ACTION POSTE DISTANT / retour menu principal
        echo "=============================================="
        echo -e "${BG_BLUE}                  Menu "Action"                 ${NC}"
        echo "=============================================="
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
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-ACTION Utilisateur choisit" >>/var/log/log_evt.log
            Menu_Action_Utilisateur
            ;;
        2)
            echo " "
            echo "Vous avez choisit ACTION POSTE DISTANT" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-ACTION Poste distant choisit" >>/var/log/log_evt.log
            Menu_Action_Ordinateur
            ;;
        X)
            echo " "
            echo "Retour au menu principal" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>/var/log/log_evt.log
            return
            ;;
        *)
            echo " "
            echo "Commande inconnu, Veuillez recommencer"
            echo " "
            read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>/var/log/log_evt.log
            ;;
        esac
    done
}

# Fonction menu Information
Menu_Information() {
    while true; do
        # Effacer l'écran
        clear
        # Demande choix INFORMATION UTILISATEUR / ACTION POSTE DISTANT / retour menu principal
        echo "==============================================="
        echo -e "${BG_BLUE}              Menu "INFORMATION"                 ${NC}"
        echo "==============================================="
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
            echo "Vous avez choisit INFORMATION utilisateur" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-ACTION Information utlisateur chosit" >>/var/log/log_evt.log
            Menu_Information_Utilsateur
            ;;
        2)
            echo " "
            echo "Vous avez choisit INFORMATION POSTE DISTANT" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-ACTION INFORMATION poste distant chosit" >>/var/log/log_evt.log
            Menu_Information_Ordinateur
            ;;
        X)
            echo " "
            echo "Retour au menu principal" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>/var/log/log_evt.log
            return
            ;;
        *)
            echo " "
            echo "Commande inconnu, Veuillez recommencer"
            echo " "
            read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>/var/log/log_evt.log
            ;;
        esac
    done
}

############## FIN FONCTION ######################

####################################################
########### Fonction Menu Action ###################
####################################################

############## DEBUT FONCTION ######################

# Fonction menu Action Utilisateur
Menu_Action_Utilisateur() {
    while true; do
        # Effacer l'écran
        clear
        #Demande choix ACTION UTILISATEUR / retour menu précédent / retour menu principal
        echo "=================================================="
        echo -e "${BG_BLUE}             Menu "Action utilisateur"         ${NC}"
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
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Création utilisateur chosit" >>/var/log/log_evt.log
            créer_utilisateur
            ;;
        2)
            echo " "
            echo "Vous avez choisit changement de mot de passe" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-changement de mot de passe chosit" >>/var/log/log_evt.log
            changer_mdp
            ;;
        3)
            echo " "
            echo "Vous avez choisit suppression de compte utilisateur" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Suppression de compte utilisateur chosit" >>/var/log/log_evt.log
            supprimer_utilisateur
            ;;
        4)
            echo " "
            echo "Vous avez choisit désactivation de compte utilisateur" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Désactivation de compte utilisateur chosit" >>/var/log/log_evt.log
            désactiver_utilisateur
            ;;
        5)
            echo " "
            echo "Vous avez choisit ajjout à groupe d'administration" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Ajjout à groupe d'administration chosit" >>/var/log/log_evt.log
            ajouter_groupe_admin
            ;;
        6)
            echo " "
            echo "Vous avez choisit ajjout à groupe local" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Ajjout à groupe loScal chosit" >>/var/log/log_evt.log
            ajout_utilisateur_groupe
            ;;
        7)
            echo " "
            echo "Vous avez choisit Sortie d'un groupe local" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Sortie d'un groupe local chosit" >>/var/log/log_evt.log
            supprimer_utilisateur_groupe
            ;;
        0)
            echo " "
            echo "Retour au menu précédent" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-retour au menu précédent choisit" >>/var/log/log_evt.log
            return
            ;;
        X)
            echo " "
            echo "Retour au menu principal" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>/var/log/log_evt.log
            Menu_Principal
            ;;
        *)
            echo " "
            echo "Commande inconnu, Veuillez recommencer"
            echo " "
            read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>/var/log/log_evt.log
            ;;
        esac
    done
}

# Fonction pour afficher le menu Ordinateur
Menu_Action_Ordinateur() {
    while true; do
        # Effacer l'écran1
        clear
        # Demande choix INFORMATION UTILISATEUR / ACTION POSTE DISTANT / retour menu principal
        echo "==================================================="
        echo -e "${BG_BLUE}        Menu "Action Machine Distante"               ${NC}"
        echo "==================================================="
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
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Arrêt choisit" >>/var/log/log_evt.log
            shutdown
            ;;

        2)
            echo " "
            echo "Vous avez choisit le rédemarrage de la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Redémarrage choisit" >>/var/log/log_evt.log
            reboot
            ;;

        3)
            echo " "
            echo "Vous avez choisit le vérrouillage de la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Vérrouillage machine distante choisit" >>/var/log/log_evt.log
            lock
            ;;

        4)
            echo " "
            echo "Vous avez choisit la mise à jour de la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Mise à jour choisit" >>/var/log/log_evt.log
            update
            ;;

        5)
            echo " "
            echo "Vous avez choisit de créér un répertoire sur la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Création de répertoire choisit" >>/var/log/log_evt.log
            create_directory
            ;;

        6)
            echo " "
            echo "Vous avez choisit de supprimer un répertoire sur la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Suppression de répertoire choisit" >>/var/log/log_evt.log
            remove_directory
            ;;

        7)
            echo " "
            echo "Vous avez choisit Prise de main à distance sur la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Prise de main à distance choisit" >>/var/log/log_evt.log
            remote_control
            ;;

        8)
            echo " "
            echo "Vous avez choisit Activation du pare-feu sur la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Activation du pare-feu choisit" >>/var/log/log_evt.log
            firewall_on
            ;;

        9)
            echo " "
            echo "Vous avez choisit Désactivation du pare-feu sur la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Désactivation du pare-feu choisit" >>/var/log/log_evt.log
            firewall_off
            ;;

        10)
            echo " "
            echo "Vous avez choisit Règles du parefeu sur la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Modificaiton règles du parefeu choisit" >>/var/log/log_evt.log
            firewall_rules
            ;;

        11)
            echo " "
            echo "Vous avez choisit Installation d'un logiciel sur la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Installation d'un logiciel choisit" >>/var/log/log_evt.log
            install_app
            ;;

        12)
            echo " "
            echo "Vous avez choisit Désinstallation d'un logiciel sur la machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Désinstallation d'un logiciel choisit" >>/var/log/log_evt.log
            uninstall_app
            ;;

        13)
            echo " "
            echo "Vous avez choisit Lancement d'un script depuis machine distante" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Lancement d'un script choisit" >>/var/log/log_evt.log
            remote_script
            ;;
        0)
            echo " "
            echo "Retour au menu précédent" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-retour au menu précédent choisit" >>/var/log/log_evt.log
            return
            ;;
        X)
            echo " "
            echo "Retour au menu principal" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>/var/log/log_evt.log
            Menu_Principal
            ;;
        *)
            echo " "
            echo "Commande inconnu, Veuillez recommencer"
            echo " "
            read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>/var/log/log_evt.log
            ;;
        esac
    done
}

############## FIN FONCTION ######################

####################################################
########### Fonction Menu iNFORMATION ##############
####################################################

############## DEBUT FONCTION ######################

# Fonction menu Information Utilisateur
Menu_Information_Utilsateur() {
    while true; do
        # Effacer l'écran
        clear
        #Demande choix INFOMRATION UTILISATEUR / retour menu précédent / retour menu principal
        echo "============================================="
        echo -e "${BG_BLUE}         Menu "Information utilisateur"        ${NC}"
        echo "============================================="
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
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Date dernière connexion utilisateur chosit" >>/var/log/log_evt.log
            info_connexion
            ;;
        2)
            echo " "
            echo "Vous avez choisit Date dernière modificaiton mot de passe utilisateur" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Date dernière modificaiton mot de passe utilisateur chosit" >>/var/log/log_evt.log
            info_modification
            ;;
        3)
            echo " "
            echo "Vous avez choisit Liste des session utilisateurs ouvertes" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Liste des session utilisateurs ouvertes chosit" >>/var/log/log_evt.log
            liste_sessions
            ;;
        4)
            echo " "
            echo "Vous avez choisit Droits/permission sur un dossier" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Droits/permission sur un dossier chosit" >>/var/log/log_evt.log
            droits_dossier
            ;;
        5)
            echo " "
            echo "Vous avez choisit Droits/permission sur un fichier" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Droits/permission sur un fichier chosit" >>/var/log/log_evt.log
            droits_fichier
            ;;
        0)
            echo " "
            echo "Retour au menu précédent" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-retour au menu précédent choisit" >>/var/log/log_evt.log
            return
            ;;
        X)
            echo " "
            echo "Retour au menu principal" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>/var/log/log_evt.log
            Menu_Principal
            ;;
        *)
            echo " "
            echo "Commande inconnu, Veuillez recommencer"
            echo " "
            read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>/var/log/log_evt.log
            ;;
        esac
    done
}

# Fonction menu Information ordinateur
Menu_Information_Ordinateur() {

    while true; do
        # Effacer l'écran
        clear
        #Demande choix INFOMRATION UTILISATEUR / retour menu précédent / retour menu principal
        echo "============================================="
        echo -e "${BG_BLUE}         Menu "Information utilisateur"        ${NC}"
        echo "============================================="
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
        echo "[6] Liste des utilisateurs locaux"
        echo "[7] Information CPU"
        echo "[8] Mémoire RAM totale et utilisation"
        echo "[9] Utilisation du disque"
        echo "[10] Utilisation du processeur"
        echo "[11] Statut du pare-feu et liste des ports ouverts"
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
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information version de l'OS chosit" >>/var/log/log_evt.log
            GetOs
            ;;
        2)
            echo " "
            echo "Vous avez choisit Nombre d'interface" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Nombre d'interface chosit" >>/var/log/log_evt.log
            NbrCarte
            ;;
        3)
            echo " "
            echo "Vous avez choisit Adresse IP de chaque interface" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Adresse IP de chaque interface chosit" >>/var/log/log_evt.log
            IPdemande
            ;;
        4)
            echo " "
            echo "Vous avez choisit Adresse MAC de chaque interface" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Adresse MAC de chaque interface chosit" >>/var/log/log_evt.log
            MACdemande
            ;;
        5)
            echo " "
            echo "Vous avez choisit Liste des application/paquets installées" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Liste des application/paquets installées chosit" >>/var/log/log_evt.log
            Application
            ;;
        6)
            echo " "
            echo "Vous avez choisit liste des utilsiateur locaux" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information liste utilsiateur chosit" >>/var/log/log_evt.log
            Userlist
            ;;
        7)
            echo " "
            echo "Vous avez choisit Information CPU" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information CPU chosit" >>/var/log/log_evt.log
            GetCpu
            ;;
        8)
            echo " "
            echo "Vous avez choisit Mémoire RAM totale et utilisation" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Mémoire RAM totale et utilisation chosit" >>/var/log/log_evt.log
            RamInfo
            ;;
        9)
            echo " "
            echo "Vous avez choisit Utilisation du disque" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Utilisation du disque chosit" >>/var/log/log_evt.log
            DiskInfo
            ;;
        10)
            echo " "
            echo "Vous avez choisit Utilisation du processeur" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Utilisation du processeur" >>/var/log/log_evt.log
            ProcesseurInfo
            ;;

        11)
            echo " "
            echo "Vous avez choisit Statut du pare-feu et liste des ports ouverts" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Information Statut du pare-feu et liste des ports ouverts" >>/var/log/log_evt.log
            StatusPare_feu
            ;;
        0)
            echo " "
            echo "Retour au menu précédent" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-retour au menu précédent choisit" >>/var/log/log_evt.log
            return
            ;;
        X)
            echo " "
            echo "Retour au menu principal" && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-Retour au menu principal choisit" >>/var/log/log_evt.log
            Menu_Principal
            ;;
        *)
            echo " "
            echo "Commande inconnu, Veuillez recommencer"
            echo " "
            read -p "Appuyez sur Entrée pour continuer..." && sleep 2s
            echo $(date +%Y%m%d-%H%M%S)"-$Operateur-erreur de commande" >>/var/log/log_evt.log
            ;;
        esac
    done
}

############## FIN FONCTION ######################

####################################################
########### Fonction Action Utilisateur ############
####################################################

############## DEBUT FONCTION ######################

# Création de compte utilisateur local
créer_utilisateur() {
    clear
    # Demande quel utilisateur à créer
    read -p "Quel compte utilisateur souhaitez-vous céer?" newUser
    # Vérification si l'utilisateur existe
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $newUser >/dev/null; then
        #Si oui -> sortie du script
        echo -e "${RED}L'utilisateur existe déjà.${NC}" && sleep 2s
    else
        #Création de l'utilsateur
        ssh $nom_distant@$ip_distante sudo -S useradd $newUser >/dev/null
        #Confirmation de la création
        echo -e "${GREEN}Compte $newUser créé.${NC}" && sleep 2s
    fi
}

# Changement de mot de passe
changer_mdp() {
    clear
    # Demande changment mot de passe -> pour quel utilisateur?
    read -p "Pour quel compte utilisateur souhaitez-vous modifier le mot de passe? " user_mdp

    # Est-ce que le nom existe sur le systeme ?
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_mdp >/dev/null; then
        # si oui -> modifier le mot de passe
        ssh $nom_distant@$ip_distante sudo -S passwd $user_mdp
        echo -e "${GREEN}Le mot de passe est bien modifié.${NC}" && sleep 2s
    else
        # si non -> sortie du script
        echo -e "${RED}L'utilisateur $user_mpd n'existe pas.${NC}" && sleep 2s
    fi
}

# Suppression de compte utilisateur local
supprimer_utilisateur() {
    clear
    # Demande quel compte utilisateur à supprimer
    read -p "Quel compte utilisateur souhaitez-vous supprimer?" user_del
    # Vérification si l'utilisateur existe
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_del >/dev/null; then
        # Si oui -> demande de confirmation
        echo "Voulez-vous vraiment supprimer le compte $user_del ? (Oui/Non)"
        read confirmation
        #Si oui -> suppresion du compte
        if [ "$confirmation" == "Oui" ]; then
            ssh $nom_distant@$ip_distante sudo -S deluser $user_del
            echo -e "${GREEN}Le compte $user_del est supprimé.${NC}" && sleep 2s
        else
            # Si non -> sortie du script
            echo -e "${RED}Supression annulée.${NC}" && sleep 2s
        fi
    else
        # Si le compte n'existe pas
        echo "${RED}Le compte utilisateur n'existe pas.${NC}" && sleep 2s
    fi
}

# Désactivation de compte utilisateur local
désactiver_utilisateur() {
    clear
    # Demande quel compte utilisateur à désactiver
    read -p "Quel compte utilisateur souhaitez-vous désactiver?" user_lock

    # Vérification si l'utilisateur existe
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_lock >/dev/null; then
        # Si l'utilisateur existe -> demande de confirmation
        echo "Voulez-vous vraiment désactiver le compte $user_lock? (Oui/Non)"
        read confirmation
        # Si oui -> désactivation du compte
        if [ "$confirmation" == "Oui" ]; then
            ssh $nom_distant@$ip_distante sudo -S usermod -L $user_lock
            # Vérification de la désactivation du compte
            if ssh $nom_distant@$ip_distante sudo -S cat /etc/shadow | grep $user_lock | grep ! >/dev/null; then
                echo -e "${GREEN}L'utilisateur $user_lock est désactivé.${NC}" && sleep 2s
                ssh $nom_distant@$ip_distante sudo -S sudo cat /etc/shadow | grep $user_lock | grep ! && sleep 2s
            else
                echo -e "${RED}L'utilisateur est toujours activé.${NC}" && sleep 2s
            fi
        else
            # Si non -> sortie du script
            echo -e "${RED}Supression annulée.${NC}" && sleep 2s
        fi
    else
        # Si l'utilisateur n'existe pas
        echo -e "${RED}L'utilisateur $user_mpd n'existe pas.${NC}" && sleep 2s
    fi
}

# Ajout utilisateur à un groupe d'administration
ajouter_groupe_admin() {
    clear
    # Demande quel compte utilisateur à ajouter
    read -p "Quel compte utilisateur souhaitez-vous ajouter au groupe d'administration?" user_adm

    # Vérification si l'utilisateur existe
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_adm >/dev/null; then
        # Si l'utilisateur existe -> ajout au compte sudo
        ssh $nom_distant@$ip_distante sudo -S usermod -aG sudo $user_adm
        echo -e "${GREEN}Le compte $user_adm est ajouté au groupe d'administration sudo.${NC}" && sleep 2s
    else
        # Si non sortie du script
        echo -e "${RED}Le compte utilisateur n'existe pas.${NC}" && sleep 2s
    fi
}

# Ajout utilsiateur à un groupe local
ajout_utilisateur_groupe() {
    clear
    # Demande quel compte à ajouter au groupe local
    read -p "Quel compte utilisateur souhaitez-vous ajouter a un groupe local?" user_addgroup
    # Vérification si l'utilisateur existe
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_addgroup >/dev/null; then
        # Si l'utilisateur existe -> demande quel groupe?
        read -p "A quel groupe souhaiter-vous ajouter l'utilisateur $user_addgroup?" choix_add_group
        if ssh $nom_distant@$ip_distante cat /etc/group | grep $choix_add_group >/dev/null; then
            ssh $nom_distant@$ip_distante sudo -S usermod -aG $choix_add_group $user_addgroup
            echo -e "${GREEN}Le compte $user_addgroup est ajouté au groupe $choix_add_group.${NC}" && sleep 2s
            # Affichage des groupes de cet utilisateur (pour vérification)
            echo "Affichage des groupes de l'utilisateur $user_addgroup : "
            ssh $nom_distant@$ip_distante groups $user_addgroup && sleep 2s
        else
            echo -e "${RED}Le groupe n'existe pas.${NC}" && sleep 2s
        fi
    else
        # Si non sortie du script
        echo -e "${RED}Le compte utilisateur n'existe pas.${NC}" && sleep 2s
    fi
}

# Suppression utilisateur d'un groupe local
supprimer_utilisateur_groupe() {
    clear
    # Demande quel compte à supprimer d'un compte local
    read -p "Quel compte utilisateur souhaitez-vous supprimer d'un groupe local?" user_delgroup

    # Vérification si l'utilisateur existe
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_delgroup >/dev/null; then
        # Si l'utilisateur existe -> demande quel groupe?
        read -p "De quel groupe souhaitez-vous supprimer l'utilisateur $user_delgroup?" choix_del_group
        if ssh $nom_distant@$ip_distante cat /etc/group | grep $choix_del_group >/dev/null; then
            ssh $nom_distant@$ip_distante sudo -S deluser $user_delgroup $choix_del_group
            echo -e "${GREEN}L'utilisateur $user_delgroup est supprimé du groupe $choix_del_group.${NC}" && sleep 2s
            # Affichage des groupes de cet utilisateur (pour vérification)
            echo "Affichage des groupes de l'utilisateur $user_delgroup : "
            ssh $nom_distant@$ip_distante groups $user_delgroup && sleep 2s
        else
            echo -e "${RED}Le groupe n'existe pas.${NC}" && sleep 2s
        fi
    else
        # Si non sortie du script
        echo -e "${RED}Le compte utilisateur n'existe pas.${NC}" && sleep 2s
    fi
}

############## FIN FONCTION ######################

####################################################
########### Fonction Action Ordinateur ############
####################################################

############## DEBUT FONCTION ######################

# Fonction "Arrêt"
shutdown() {
    clear
    # Demande de confrmation
    read -p "Confirmez-vous l'arrêt de la machine distante ? [O pour valider] " conf_shutdown
    # Si confirmation OK, affichage du sous-menu de la fonction "Arrêt"
    if [ $conf_shutdown = O ]; then
        echo " [1] Arrêt instantané de la machine"
        echo " [2] Arrêt planifié de la machine avec message d'avertissement"
        echo " [3] Arrêt planifié de la machine sans message d'avertissement"
        echo " [*] Revenir au menu précédent"
        # Demande de choix pour le sous-menu de la fonction "Arrêt"
        while true; do
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
reboot() {
    clear
    # Demande de confrmation
    read -p "Confirmez-vous l'arrêt de la machine distante ? [O pour valider] " conf_reboot
    # Si confirmation OK, affichage du sous-menu de la fonction "Redémarrage"
    if [ $conf_reboot = O ]; then
        echo " [1] Redémarrage instantané de la machine"
        echo " [2] Redémarrage planifié de la machine avec message d'avertissement"
        echo " [3] Redémarrage planifié de la machine sans message d'avertissement"
        echo " [*] Revenir au menu précédent"
        # Demande de choix pour le sous-menu de la fonction "Redémarrage"
        while true; do
            read -p "Choisissez comment vous souhaitez procéder : " conf_message_r
            case $conf_message_r in
            1)
                echo -e "${GREEN}Redémarrage instantanné en cours${NC}"
                ssh $nom_distant@$ip_distante sudo -S shutdown -r now
                return
                ;;
            2)
                echo -e "${GREEN}Redémarrage planifié en cours${NC}"
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
                echo -e "${GREEN}Redémarrage planifié en cours${NC}"
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
lock() {
    clear
    # Demande de confrmation
    read -p "Confirmez-vous le vérouillage de la session de la machine distante ? [O pour valider] " conf_lock
    # Si confirmation OK, exécution de la commande "Vérouillage"
    if [ $conf_lock = O ]; then
        ssh $nom_distant@$ip_distante sudo -S skill -KILL -u $nom_distant
        echo -e "${GREEN}La session de la machine distante a été vérouillée${NC}"
        sleep 2s
        return
        # Si confirmation NOK, sortie de la fonction "Vérouillage"
    else
        echo -e "${RED}Opération annulée - Retour au menu précédent${NC}"
        sleep 1s
        return
    fi
}

# Fonction MàJ
update() {
    clear
    # Demande de confrmation
    read -p "Confirmez-vous la mise-à-jour du système de la machine distante ? [O pour valider] " conf_update
    # Si confirmation OK, exécution de la commande "MàJ"
    if [ $conf_update = O ]; then
        ssh $nom_distant@$ip_distante sudo -S apt update && sudo -S apt upgrade -y
        echo -e "${GREEN}La mise-à-jour du système de la machine distante a été effectuée${NC}"
        sleep 2s
        return
        # Si confirmation NOK, sortie de la fonction "MàJ"
    else
        echo -e "${RED}Opération annulée - Retour au menu précédent${NC}"
        sleep 1s
        return
    fi
}

# Fonction "Création Dossier"
create_directory() {
    clear
    # Demande de confrmation
    read -p "Confirmez-vous la création d'un dossier ? [O pour valider] " conf_create_directory
    # Si confirmation OK, exécution de la commande "Création Dossier"
    if [ $conf_create_directory = O ]; then
        # Demande du nom du dossier à créer
        read -p "Quel est le nom du dossier à créer ? " name_directory
        # Si aucun nom rentré, sortie de la fonction "Création Dossier"
        if [ -z $name_directory ]; then
            echo -e "${RED}Vous n'avez pas indiqué de nom de dossier, retour au menu précédent${NC}"
            sleep 1s
            return
        fi
        # Demande du chemin de destination du dossier à créer
        read -p "Quel est le chemin de destination de votre dossier (Si pas de chemin indiqué, chemin courant utilisé) : " path_directory
        if ssh $nom_distant@$ip_distante [ -z "$path_directory" ]; then
            # Si le dossier existe à l'emplacement actuel, sortie de la fonction "Création Dossier"
            if ssh $nom_distant@$ip_distante "[ -d \"$name_directory\" ]"; then
                echo -e "${RED}Le dossier existe déja${NC}"
                echo "Retour au menu précédent"
                sleep 1s
                return
                # Si le dossier n'existe pas, et que le chemin n'est pas spécifié, création du dossier à l'emplacement actuel
            else
                echo "Le dossier n'existe pas."
                ssh $nom_distant@$ip_distante mkdir "$name_directory"
                echo -e "${GREEN}Le dossier $name_directory sera créé à l'emplacement actuel${NC}"
                sleep 2s
            fi
        else
            # Si le dossier existe dans l'emplacement spécifié, sortie de la fonction "Création Dossier"
            if ssh $nom_distant@$ip_distante "[ -d \"$path_directory/$name_directory\" ]"; then
                echo "Le dossier existe déjà"
                echo -e "${RED}Retour au menu précédent${NC}"
                sleep 1s
                return
                # Si le dossier n'existe pas, et que le chemin est spécifié, création du dossier à cet emplacement
            else
                echo "Le dossier n'existe pas"
                ssh $nom_distant@$ip_distante mkdir -p "$path_directory/$name_directory"
                echo -e "${GREEN}Le dossier $name_directory a été créé à l'emplacement $path_directory.${NC}"
                sleep 2s
            fi
        fi
        # Si confirmation NOK, sortie de la fonction "Création Dossier"
    else
        echo -e "${RED}Opération annulée - Retour au menu précédent${NC}"
        sleep 1s
        return
    fi
}

# Fonction "Suppression Dossier"
remove_directory() {
    clear
    # Demande de confrmation
    read -p "Confirmez-vous la suppression d'un dossier ? [O pour valider] " conf_remove_directory
    # Si confirmation OK, exécution de la commande "Suppression Dossier"
    if [ $conf_remove_directory = O ]; then
        # Demande du nom du dossier à supprimer
        read -p "Quel est le nom du dossier à supprimer ? " name_directory_2
        # Si aucun nom rentré, sortie de la fonction "Suppression Dossier"
        if [ -z "$name_directory_2" ]; then
            echo -e "${RED}Vous n'avez pas indiqué de nom de dossier, retour au menu précédent${NC}"
            return
        fi
        # Demande du chemin de destination du dossier à supprimer
        read -p "Quel est le chemin de votre dossier : " path_directory_2
        # Si le dossier existe à l'emplacement spécifié, demande de confirmation de la suppression du dossier
        if ssh $nom_distant@$ip_distante [ -d "$path_directory_2/$name_directory_2" ]; then
            read -p "Le dossier suivant $path_directory_2/$name_directory_2 sera supprimé, confirmez-vous ? [O pour valider] " conf_remove_directory_2
            # Si confirmation OK, éxécution de la commande de suppression de dossier
            if [ $conf_remove_directory_2 = O ]; then
                ssh $nom_distant@$ip_distante sudo -S rm -r "$path_directory_2/$name_directory_2"
                echo -e "${GREEN}Le dossier suivant $path_directory_2/$name_directory_2 a été supprimé${NC}"
                sleep 2s
                return
                # Si confirmation NOK, sortie de la fonction "Suppression Dossier"
            else
                echo -e "${RED}Opération annulée - Retour au menu précédent${NC}"
                sleep 1s
                return
            fi
            # Si le dossier n'existe pas à l'emplacement spécifié, sortie de la fonction "Suppression Dossier"
        else
            echo -e "${RED}Le dossier $path_directory_2/$name_directory_2 n'existe pas - Retour au menu précédent${NC}"
            sleep 2s

            return
        fi
    fi
}
# Fonction "Prise de main à distance"
remote_control() {
    clear
    # Demande de confirmation + Avertissement concernant la sortie du script dès l'éxécution de cette fonction
    echo -e "${RED}ATTENTION : Cette commande vous sortira momentanément du script${NC}"
    read -p "Confirmez-vous ? [O pour valider] : " conf_remote
    # Si confirmation OK, exécution de la commande "Prise de main à distance" + Sortie du script
    if [ $conf_remote = O ]; then
        echo -e "Accès à la commande de la machine distante :"
        sleep 2s
        ssh $nom_distant@$ip_distante
        # Si confirmation NOK, sortie de la fonction "Prise de main à distance"
    else
        echo -e "${RED}Opération annulée - Retour au menu précédent${NC}"
        sleep 1s
        return
    fi
}

# Fonction "Activation du pare-feu"
firewall_on() {
    clear
    # Demande de confirmation + Avertissement
    echo -e "${RED}ATTENTION : Cette commande peut impacter l'éxécution du script${NC}"
    read -p "Confirmez-vous l'activation du pare-feu sur la machine distante ? [O pour valider ] : " conf_fw_on
    # Si confirmation OK, éxécution de la commande "Activation du pare-feu"
    if [ $conf_fw_on = O ]; then
        ssh $nom_distant@$ip_distante sudo -S ufw enable
        ssh $nom_distant@$ip_distante sudo -S ufw status | cat
        echo -e "${GREEN}Le pare-feu de la machine distante a été activé${NC}"
        sleep 2s
        return
        # Si confirmation NOK, sortie de la fonction "Activation du pare-feu"
    else
        echo -e "${RED}Opération annulée - Retour au menu précédent${NC}"
        sleep 1s
        return
    fi
}

# Fonction "Désactivation du pare-feu"
firewall_off() {
    clear
    # Demande de confirmation + Avertissement
    echo -e "${RED}ATTENTION : Cette commande peut impacter la vulnérabilité de la machine distante${NC}"
    read -p "Confirmez-vous la désactivation du pare-feu sur la machine distante ? [O pour valider ] : " conf_fw_off
    # Si confirmation OK, éxécution de la commande "Désactivation du pare-feu
    if [ $conf_fw_off = O ]; then
        ssh $nom_distant@$ip_distante sudo -S ufw disable
        ssh $nom_distant@$ip_distante sudo -S ufw status | cat
        echo -e "${GREEN}Le pare-feu de la machine distante a été désactivé${NC}"
        sleep 2s
        return
        # Si confirmation NOK, sortie de la fonction "Désactivation du pare-feu"
    else
        echo -e "${RED}Opération annulée - Retour au menu précédent${NC}"
        sleep 1s
        return
    fi
}

# Fonction "Règles du pare-feu"
firewall_rules() {
    clear
    # Demande de confirmation + Avertissement concernant la sortie du script dès l'éxécution de cette fonction
    echo -e "${RED}ATTENTION : Les commandes suivantes sont reservées à un public averti${NC}"
    read -p "Confirmez-vous l'accès à la modification des régles du pare-feu ? [O Pour valider] : " conf_fw_rules
    # Si confirmation OK, affichage du sous-menu de la fonction "Règles du pare-feu
    if [ $conf_fw_rules = O ]; then
        echo " [1] Affichage de l'état actuel des règles du pare-feu"
        echo " [2] Ouverture d'un port (UDP et TCP)"
        echo " [3] Fermeture d'un port (UDP et TCP)"
        echo " [4] Activer la journalisation"
        echo " [5] Désactiver la journalisation"
        echo " [6] Réinitialiser le pare-feu"
        echo " [*] Revenir au menu précédent"
        while true; do
            read -p "Faites votre choix parmi la sélection ci-dessus : " conf_message_fw
            case $conf_message_fw in
            # Affichage de l'état actuel du pare-feu
            1)
                echo -e "Affichage de l'état actuel des règles du pare-feu"
                ssh $nom_distant@$ip_distante sudo -S ufw status verbose
                sleep 2s
                ;;
                # Exécution de la commande d'ouverture de port
            2)
                echo -e "${GREEN}Ouverture d'un port${NC}"
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
                echo -e "${GREEN}Fermeture d'un port${NC}"
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
                echo -e "${GREEN}Activation de la journalisation${NC}"
                sleep 2s
                ssh $nom_distant@$ip_distante sudo -S ufw logging on
                sleep 2s
                ;;
                # Exécution de la commande de désactivation de la journalisation
            5)
                echo -e "${GREEN}Désactivation de la journalisation${NC}"
                sleep 2s
                ssh $nom_distant@$ip_distante sudo -S ufw logging off
                sleep 2s
                ;;
                # Exécution de la commande de réinitialisation du pare-feu + Avertissement
            6)
                echo -e "${GREEN}Réinitialisation du pare-feu${NC}"
                echo "ATTENTION, cette commande peut compromettre la connexion à distance"
                read -p "Souhaitez-vous tout de même continuer ? [O pour valider] : " conf_reset_fw
                # Si confirlation OK, exécution de la commande de réinitialisation du pare-feu
                if [ $conf_reset_fw = O ]; then
                    sleep 1s
                    $nom_distant@$ip_distante sudo -S ufw reset
                    echo "Le pare-feu a été réinitialisé"
                    sleep 2s
                    return
                    # Si confirmation NOK, sortie de la fonction "Règles du pare-feu"
                else
                    echo -e "${RED}Opération annulée - Retour au menu précédent${NC}"
                    sleep 1s
                fi
                ;;

            # Si autre/mauvais choix, sortie de la fonction "Règles du pare-feu"
            *)
                echo -e "${RED}Retour au menu précédent${NC}"
                sleep 1s
                return
                ;;
            esac
        done
    fi
}
# Fonction "Installation Application"
install_app() {
    clear
    # Demande de confirmation
    read -p "Confirmez-vous l'accès à l'installation de logiciels ? [O Pour valider] : " conf_install
    # Si confirmation OK, affichage du sous-menu de la fonction "Installation Application"
    if [ $conf_install = O ]; then
        echo " [1] Installation via APT"
        echo " [2] Installation via SNAP"
        echo " [*] Revenir au menu précédent"
        while true; do
            read -p "Faites votre choix parmi la sélection ci-dessus : " conf_message_install
            case $conf_message_install in
            # Exécution de la commande "Installation via APT"
            1)
                read -p "Quel logiciel souhaitez-vous installer via APT : " apt_install
                echo "Vous avez choisi d'installer le logiciel $apt_install"
                sleep 1s
                ssh $nom_distant@$ip_distante sudo -S apt install $apt_install
                sleep 1s
                echo -e "${GREEN}Le logiciel $apt_install a été installé${NC}"
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
                echo -e "${GREEN}Le logiciel $snap_install a été installé${NC}"
                sleep 2s
                return
                ;;
                # Si autre/mauvais choix, sortie de la fonction "Installation Application"
            *)
                echo -e "${RED}Retour au menu précédent${NC}"
                sleep 1s
                return
                ;;
            esac
        done
    fi
}
# Fonction "Désinstallation Application"
uninstall_app() {
    clear
    # Demande de confirmation
    read -p "Confirmez-vous l'accès à la désinstallation de logiciels ? [O Pour valider] : " conf_uninstall
    # Si confirmation OK, affichage du sous-menu de la fonction "Installation Application"
    if [ $conf_uninstall = O ]; then
        echo " [1] Désinstallation via APT"
        echo " [2] Désinstallation via SNAP"
        echo " [*] Revenir au menu précédent"
        while true; do
            read -p "Faites votre choix parmi la sélection ci-dessus : " conf_message_uninstall
            case $conf_message_uninstall in
            # Exécution de la commande "Installation via APT"
            1)
                read -p "Quel logiciel souhaitez-vous désinstaller via APT : " apt_uninstall
                echo "Vous avez choisi de désinstaller le logiciel $apt_uninstall"
                sleep 1s
                ssh $nom_distant@$ip_distante sudo -S apt remove $apt_uninstall
                sleep 1s
                echo -e "${GREEN}Le logiciel $apt_uninstall a été désinstallé${NC}"
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
                echo -e "${GREEN}Le logiciel $snap_uninstall a été désinstallé${NC}"
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
remote_script() {
    clear
    # Demande de confirmation
    read -p "Confirmez-vous l'éxécution d'un script sur la machine distante ? [O pour valider ] : " conf_script
    # Si confirmation OK, éxécution de la commande "Script à distance""
    if [ $conf_script = O ]; then
        # Demande du nom et du chemin du script à éxécuter
        read -p "Quel est le nom du script ? : " name_script
        read -p "Quel est le chemin du script ? : " path_script
        # Vérification de l'existence du script à l'emplacement spécifié
        if ssh $nom_distant@$ip_distante test -e "$path_script/$name_script"; then
            # Si le script existe, il va être exécuté
            echo "Le script $name_script existe."
            echo -e "${GREEN}Le script $name_script va être éxécuté${NC}"
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
            echo -e "${RED}Opération annulée - Retour au menu précédent.${NC}"
            sleep 2s
            return
        fi
        # Si confirmation NOK, sortie de la fonction "Script à distance"
    else
        echo -e "${RED}Opération annulée - Retour au menu précédent${NC}"
        sleep 1s
        return
    fi

}

############## FIN FONCTION ######################

####################################################
######## Fonction Information Utilisateur ###########
####################################################

############## DEBUT FONCTION ######################

# Fonctions Informations utilisateur
info_connexion() {
    clear
    # Demande quel utilisateur
    echo ""
    echo "Date de dernière connexion"
    read -p "Tapez le nom d'utilisateur souhaité : " user_inf

    # Est-ce que le nom existe sur le systeme ?
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_inf >/dev/null; then
        # si oui -> affichage dernière connexion
        ssh $nom_distant@$ip_distante lastlog -u $user_inf && sleep 2s
        echo $nom_distant@$ip_distante "Dernière connexion : " >>"$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante lastlog -u $user_inf >>"$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt${NC}" && sleep 3s
    else
        # si non -> sortie du script
        echo -e "${RED}L'utilisateur $user_mpd n'existe pas.${NC}" && sleep 2s
    fi
}

# Fonctions Informations dernière modification de mot de passe
info_modification() {
    clear
    # Demande quel utilisateur
    echo ""
    echo "Date de dernière modification du mdp"
    read -p "Tapez le nom d'utilisateur souhaité : " user_inf

    # Est-ce que le nom existe sur le systeme ?
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_inf >/dev/null; then
        # si oui -> affichage dernière modification
        ssh $nom_distant@$ip_distante sudo -S chage -l $user_inf | head -n 1 && sleep 2s
        echo "Dernière modification du mot de passe : " >>"$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante sudo -S chage -l $user_inf | head -n 1 >>"$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt${NC}" && sleep 3s
    else
        # si non -> sortie du script
        echo -e "${RED}L'utilisateur $user_mpd n'existe pas${NC}" && sleep 2s
    fi

}

liste_sessions() {
    clear
    # Demande quel utilisateur
    echo ""
    echo "Liste des sessions ouvertes pour l'utilisateur"
    echo ""
    read -p "Tapez le nom d'utilisateur souhaité : " user_inf

    # Est-ce que le nom existe sur le systeme ?
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_inf >/dev/null; then
        # si oui -> affichage des sessions
        ssh $nom_distant@$ip_distante last $user_inf && sleep 2s
        echo "Liste des sessions : " >>"$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante last $user_inf >>"$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt${NC}" && sleep 3s

    else
        # si non -> sortie du script
        echo -e "${RED}L'utilisateur $user_inf n'existe pas.${NC}" && sleep 2s
    fi

}

droits_dossier() {
    clear
    # Demande quel utilisateur
    echo ""
    echo "Visualisation des droits sur un dossier"
    echo ""
    read -p "Tapez le nom d'utilisateur souhaité : " user_inf

    # Est-ce que le nom existe sur le systeme ?
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_inf >/dev/null; then
        # si oui -> demande quel dossier à verifier
        read -p "Sur quel dossier souhaitez-vous vérifier les droits ?
(spécifier chemin du dossier)" dossier_a
        if ssh $nom_distant@$ip_distante [ -d $dossier_a ]; then
            # affichage des droits
            ssh $nom_distant@$ip_distante ls -ld $dossier_a/ && sleep 2s
            echo "Droits et permission sur le dossier $dossier_a/ : " >>"$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"
            ssh $nom_distant@$ip_distante ls -ld $dossier_a/ >>"$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"
            echo ""
            echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt${NC}" && sleep 3s
        else
            # si non -> sortie du script
            echo "${RED}Le dossier $dossier_a n'existe pas.${NC}" && sleep 2s
        fi
    else
        # si non -> sortie du script
        echo -e "${RED}L'utilisateur $user_inf n'existe pas.${NC}" && sleep 2s
    fi
}

droits_fichier() {
    clear
    # Demande quel utilisateur
    echo ""
    echo "Visualisation des droits sur un fichier"
    echo ""
    read -p "Tapez le nom d'utilisateur souhaité : " user_inf

    # Est-ce que le nom existe sur le systeme ?
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_inf >/dev/null; then
        # si oui -> demande quel dossier à verifier
        read -p "Sur quel fichier souhaitez-vous vérifier les droits ?
(spécifier chemin du fichier)" fichier_a
        if ssh $nom_distant@$ip_distante [ -f $fichier_a ]; then
            # affichage des droits
            ssh $nom_distant@$ip_distante ls -l $fichier_a && sleep 2s
            echo "Droits et permission sur le fichier $fichier_a/ : " >>"$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"
            ssh $nom_distant@$ip_distante ls -l $fichier_a >>"$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"
            echo ""
            echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt${NC}" && sleep 3s
        else
            # si non -> sortie du script
            echo -e "${RED}Le fichier $fichier_a n'existe pas.${NC}" && sleep 2s
        fi
    else
        # si non -> sortie du script
        echo -e "${RED}L'utilisateur $user_inf n'existe pas.${NC}" && sleep 2s
    fi

}

############## FIN FONCTION ######################

####################################################
######## Fonction Information Ordinateur ############
####################################################

############## DEBUT FONCTION ######################

# Fonction pour avoir la version de l'OS
GetOs() {
    clear
    read -p "Voulez-vous voir la version de l'OS? [O pour valider] " ConfOS
    if [ "$ConfOS" = "O" ]; then
        clear
        ssh $nom_distant@$ip_distante lsb_release -a
        ssh $nom_distant@$ip_distante lsb_release -a >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
        return
    else
        clear
        echo -e "${RED}Mauvais choix - Retour au menu précédent${NC}"
        sleep 2s
        return
    fi
}

# Fonction pour avoir le nombre d'interfaces
NbrCarte() {
    clear
    read -p "Voulez-vous voir le nombre d'interfaces présentes sur cette machine? [O pour valider]" NbrI
    if [ "$NbrI" = "O" ]; then
        clear
        echo "Voici la liste des interfaces présentes sur cette machine :"
        ssh $nom_distant@$ip_distante ifconfig -a | grep UP | cut -d : -f1
        echo "liste des cartes" >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante ifconfig -a | grep UP | cut -d : -f1 >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
    fi
}

#Fonction demande adresse IP
IPdemande() {
    clear
    read -p "Quelle carte choisissez-vous ? " CartIp
    ssh $nom_distant@$ip_distante echo "$CartIp" && ifconfig "$CartIp" | awk ' /inet /{print $2, $3 ,$4, $5, $6}'
    echo "l'adresse ip de la carte "$CartIp" est :" >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
    ssh $nom_distant@$ip_distanteifconfig "$CartIp" | awk ' /inet /{print $2, $3 ,$4, $5, $6}' >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
    echo ""
    echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
}

#Fonction demande adresse Mac
MACdemande() {
    clear
    read -p "Quelle carte choisissez-vous ? " CartMac
    ssh $nom_distant@$ip_distante echo "$CartMac" && ifconfig "$CartMac" | awk '/ether / {print $2}'
    ssh $nom_distant@$ip_distante echo "l'adresse mac de la carte "$CartMac" est:" >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
    ifconfig "$CartMac" | awk '/ether / {print $2}' >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
    echo ""
    echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
}

# Fonction qu'est-ce qui est installé?
Application() {
    clear
    read -p "Voulez-vous la liste des applications et paquets installés? [O pour valider]" app
    if [ "$app" = "O" ]; then
        clear
        echo " Voici la liste des applications et paquets présents sur cette machine : "
        ssh $nom_distant@$ip_distante ls /usr/share/applications | awk -F '.desktop' ' { print $1}'
        echo "liste des applications :" >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante ls /usr/share/applications | awk -F '.desktop' ' { print $1}' >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
        return
    else
        clear
        echo -e "${RED}Mauvais choix - Retour au menu précédent${NC}"
        sleep 2s
        return
    fi
}

# Fonction liste des utilisateurs locaux
Userlist() {
    clear
    read -p "Voulez-vous voir la liste des utilisateurs locaux ? [O pour valider]" ListU
    if [ "$ListU" = "O" ]; then
        clear
        echo " Voici la liste des utilisateurs locaux :"
        ssh $nom_distant@$ip_distante cut -d: -f1 /etc/passwd
        echo "liste des utilisateurs :" >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante cut -d: -f1 /etc/passwd >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
        return
    else
        clear
        echo -e "${RED}Mauvais choix - Retour au menu précédent${NC}"
        sleep 2s
        return
    fi
}

# Fonction Type de CPU, nombre de cœurs, etc.
GetCpu() {
    clear
    read -p "Voulez-vous voir les détails du CPU ? [O pour valider]" Gcpu
    if [ "$Gcpu" = "O" ]; then
        clear
        echo " Voici les détails du CPU de la machine :"
        ssh $nom_distant@$ip_distante lscpu | head -n15
        echo "Détail du CPU :" >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante lscpu | head -n15 >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
        return
    else
        clear
        echo -e "${RED}Mauvais choix - Retour au menu précédent${NC}"
        sleep 2s
        return
    fi
}

# Fonction mémoire RAM et utilisation
RamInfo() {
    clear
    read -p "Voulez-vous voir les détails de la RAM ? [O pour valider]" RamInf
    if [ "$RamInf" = "O" ]; then
        clear
        echo " Voici les détails de la RAM sur cette machine :"
        ssh $nom_distant@$ip_distante free -m | head -n2
        echo "Détail de la RAM :" >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante free -m | head -n2 >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
        return
    else
        clear
        echo -e "${RED}Mauvais choix - Retour au menu précédent${NC}"
        sleep 2s
        return
    fi
}

# Fonction Utilisation du disque
DiskInfo() {
    clear
    read -p "Voulez-vous voir les détails du/des disques ? [O pour valider]" DiskInf
    if [ "$DiskInf" = "O" ]; then
        clear
        echo " Voici les détails du/des disques de cette machine :"
        ssh $nom_distant@$ip_distante df -h
        echo "Détail des disques :" >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante df -h >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
        return
    else
        clear
        echo -e "${RED}Mauvais choix - Retour au menu précédent${NC}"
        sleep 2s
        return
    fi
}

# Fonction Utilisation du processeur
ProcesseurInfo() {
    clear
    read -p "Voulez-vous voir les détails du processeur ? [O pour valider]" ProcesseurInf
    if [ "$ProcesseurInf" = "O" ]; then
        clear
        echo " Voici les détails du processeur de cette machine :"
        ssh $nom_distant@$ip_distante mpstat
        echo "les détails du processeur :" >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante mpstat >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
        return
    else
        clear
        echo -e "${RED}Mauvais choix - Retour au menu précédent${NC}"
        sleep 2s
        return
    fi
}

# Fonction Statut du pare-feu et liste des ports ouverts
StatusPare_feu() {
    clear
    read -p "Voulez-vous voir les informations liées au pare-feu ? [O pour valider]" FireW
    if [ "$FireW" = "O" ]; then
        clear
        echo " Voici les détails du pare-feu de cette machine :"
        ssh $nom_distant@$ip_distante sudo -S ufw status
        ssh $nom_distant@$ip_distante sudo -S ufw status >>"$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo -e "Les données sont enregistrées dans le fichier" "${GREEN}$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt${NC}" && sleep 5s
        return
    else
        clear
        echo -e "${RED}Mauvais choix - Retour au menu précédent${NC}"
        sleep 2s
        return
    fi
}

############## FIN FONCTION ######################

####################################################
################ Début script  #####################
####################################################

# Prérequis
# Création répertoire Documents
path_info_file=~/Documents/
if [ ! -d "$path_info_file" ]; then
    # Si le dossier existe pas le créér
    mkdir "$path_info_file"
fi

#Demande d'infos sur la machine distante
echo "=================================================="
echo -e "${BG_BLUE}        Initialisation script pour connexion      ${NC}"
echo "=================================================="
echo ""
# Demande du nom d'utilisateur de la machine distante
read -p "Veuillez entrer le nom d'utilisateur de la machine distante : " nom_distant
# Demande de l'adresse IP de la machine distante
read -p "Veuillez entrer l'adresse IP de la machine distante : " ip_distante
# Demande d'identification
read -p "Veuillez vous identifiez : " Operateur

# Début enregistrement evennement
echo $(date +%Y%m%d-%H%M%S)"-$Operateur-********StartScript********" >>/var/log/log_evt.log

#appel Fonction Principal
Menu_Principal

# Fin enregistrement evennement
echo $(date +%Y%m%d-%H%M%S)"-$Operateur-********EndScript********" >>/var/log/log_evt.log
# Fin de script
exit 0

####################################################
################ Fin script  #######################
####################################################
