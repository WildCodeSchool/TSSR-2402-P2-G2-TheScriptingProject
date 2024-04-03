#!/bin/bash

# Fonction pour afficher le menu

afficher_menu() {
    # Effacer l'écran
    clear
    # Affichage actions

    echo "=================================================="

    echo '        Menu Action utilisateur           '

    echo "=================================================="
    echo "[1] Création de compte utilisateur local"
    echo "[2] Changement de mot de passe"
    echo "[3] Suppression de compte utilisateur local"
    echo "[4] Désactivation de compte utilisateur local"
    echo "[5] Ajout à un groupe d'administration"
    echo "[6] Ajout à un groupe local"
    echo "[7] Sortie d'un groupe local"
    echo "[X]. Retour au menu précédent"
    echo ""
}

# 7 fonctions action
créer_utilisateur() {
    # Création de compte utilisateur local

    # Demande quel utilisateur à créer
    read -p "Quel compte utilisateur souhaitez-vous céer?" newUser

    # Vérification si l'utilisateur existe
    if cat /etc/passwd | grep $newUser >/dev/null; then
        #Si oui -> sortie du script
        echo "L'utilisateur existe déjà." && sleep 2s
    else
        #Création de l'utilsateur
        sudo useradd $newUser >/dev/null
        #Confirmation de la création
        echo "Compte $newUser créé." && sleep 2s
    fi
}

changer_mdp() {
    # Changement de mot de passe

    # Demande changment mot de passe -> pour quel utilisateur?
    read -p "Pour quel compte utilisateur souhaitez-vous modifier le mot de passe? " user_mdp

    # Est-ce que le nom existe sur le systeme ?
    if cat /etc/passwd | grep $user_mdp >/dev/null; then
        # si oui -> modifier le mot de passe
        sudo passwd $user_mdp
        echo "Le mot de passe est bien modifié." && sleep 2s
    else
        # si non -> sortie du script
        echo "L'utilisateur $user_mpd n'existe pas" && sleep 2s
    fi
}

supprimer_utilisateur() {
    # Suppression de compte utilisateur local

    # Demande quel compte utilisateur à supprimer
    read -p "Quel compte utilisateur souhaitez-vous supprimer?" user_del

    # Vérification si l'utilisateur existe
    if cat /etc/passwd | grep $user_del >/dev/null; then
        # Si oui -> demande de confirmation
        echo "Voulez-vous vraiment supprimer le compte $user_del ? (Oui/Non)"
        read confirmation
        #Si oui -> suppresion du compte
        if [ "$confirmation" == "Oui" ]; then
            sudo deluser $user_del
            echo "Le compte $user_del est supprimé" && sleep 2s
        else
            # Si non -> sortie du script
            echo "Supression annulée." && sleep 2s
        fi
    else
        # Si le compte n'existe pas
        echo "Le compte utilisateur n'existe pas." && sleep 2s
    fi
}

désactiver_utilisateur() {
    # Désactivation de compte utilisateur local

    # Demande quel compte utilisateur à désactiver
    read -p "Quel compte utilisateur souhaitez-vous désactiver?" user_lock

    # Vérification si l'utilisateur existe
    if cat /etc/passwd | grep $user_lock >/dev/null; then
        # Si l'utilisateur existe -> demande de confirmation
        echo "Voulez-vous vraiment désactiver le compte $user_lock? (Oui/Non)"
        read confirmation
        # Si oui -> désactivation du compte
        if [ "$confirmation" == "Oui" ]; then
            sudo usermod -L $user_lock
            # Vérification de la désactivation du compte
            if sudo cat /etc/shadow | grep $user_lock | grep ! >/dev/null; then
                echo "L'utilisateur $user_lock est désactivé" && sleep 2s
                sudo cat /etc/shadow | grep $user_lock | grep !
            else
                echo "L'utilisateur est toujours activé." && sleep 2s
            fi
        else
            # Si non -> sortie du script
            echo "Supression annulée." && sleep 2s
        fi
    else
        # Si l'utilisateur n'existe pas
        echo "L'utilisateur $user_mpd n'existe pas." && sleep 2s
    fi
}

ajouter_groupe_admin() {
    # Ajout à un groupe d'administration

    # Demande quel compte utilisateur à ajouter
    read -p "Quel compte utilisateur souhaitez-vous ajouter au groupe d'administration?" user_adm

    # Vérification si l'utilisateur existe
    if cat /etc/passwd | grep $user_adm >/dev/null; then
        # Si l'utilisateur existe -> ajout au compte sudo
        sudo usermod -aG sudo $user_adm
        echo "Le compte $user_adm est ajouté au groupe sudo." && sleep 2s
    else
        # Si non sortie du script
        echo "Le compte utilisateur n'existe pas." && sleep 2s
    fi
}

ajout_utilisateur_groupe() {
    # Ajout à un groupe local

    # Demande quel compte à ajouter au groupe local
    read -p "Quel compte utilisateur souhaitez-vous ajouter a un groupe local?" user_delgroup

    # Vérification si l'utilisateur existe
    if cat /etc/passwd | grep $user_delgroup >/dev/null; then
        # Si l'utilisateur existe -> demande quel groupe?
        read -p "A quel groupe souhaiter-vous ajouter l'utilisateur $user_delgroup?" choix_group
        if cat /etc/group | grep $choix_group >/dev/null; then
            sudo usermod -aG $choix_group $user_delgroup
            echo "Le compte $user_delgroup est ajouté au groupe $choix_group." && sleep 2s
            # Affichage des groupes de cet utilisateur (pour vérification)
            groups $user_delgroup && sleep 2s
        else
            echo "Le groupe n'existe pas." && sleep 2s
        fi
    else
        # Si non sortie du script
        echo "Le compte utilisateur n'existe pas." && sleep 2s
    fi
}

supprimer_utilisateur_groupe() {
    # Suppression compte d'un groupe local

    # Demande quel compte à supprimer d'un compte local
    read -p "Quel compte utilisateur souhaitez-vous supprimer d'un groupe local?" user_delgroup

    # Vérification si l'utilisateur existe
    if cat /etc/passwd | grep $user_delgroup >/dev/null; then
        # Si l'utilisateur existe -> demande quel groupe?
        read -p "De quel groupe souhaitez-vous supprimer l'utilisateur $user_delgroup?" choix_group
        if cat /etc/group | grep $choix_group >/dev/null; then
            sudo deluser $user_delgroup $choix_group
            echo "L'utilisateur $user_delgroup est supprimé du groupe $choix_group." && sleep 2s
            # Affichage des groupes de cet utilisateur (pour vérification)
            groups $user_delgroup && sleep 2s
        else
            echo "Le groupe n'existe pas." && sleep 2s
        fi
    else
        # Si non sortie du script
        echo "Le compte utilisateur n'existe pas." && sleep 2s
    fi
}

# Boucle principale pour afficher le menu et traiter les options
while true; do
    # Affiche le menu
    afficher_menu
    # Demande du choix action
    read -p "Veuillez faire votre choix action en donnant le numéro souhaité:" choix

    # Traitement de l'action choisie
    case $choix in
    1)
        créer_utilisateur
        ;;
    2)
        changer_mdp
        ;;
    3)
        supprimer_utilisateur
        ;;
    4)
        désactiver_utilisateur
        ;;
    5)
        ajouter_groupe_admin
        ;;
    6)
        ajout_utilisateur_groupe
        ;;
    7)
        supprimer_utilisateur_groupe
        ;;
    X)
        echo "Au revoir !"
        exit 0
        ;;
    *)
        echo "Option invalide. Veuillez choisir une option valide."
        read -p "Appuyez sur Entrée pour continuer..."
        ;;
    esac
done
