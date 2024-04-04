#!/bin/bash

# Fonction pour afficher le menu

afficher_menu() {
    # Effacer l'écran
    clear
    # Affichage actions

    echo "=================================================="

    echo '        Menu Information utilisateur           '

    echo "=================================================="
    echo "[1] Date de dernière connexion d'un utilisateur"
    echo "[2] Date de dernière modification du mot de passe"
    echo "[3] Liste des sessions ouvertes par l'utilisateur"
    echo "[4] Droits/permissions de l'utilisateur sur un dossier"
    echo "[5] Droits/permissions de l'utilisateur sur un fichier"
    echo ""
    echo "[X]. Retour au menu précédent"
    echo ""
}

# Fonctions Informations

info_connexion() {

    # Demande quel utilisateur
    echo ""
    echo "Date de dernière connexion"
    read -p "Tapez le nom d'utilisateur souhaité : " user_inf

    # Est-ce que le nom existe sur le systeme ?
    if ssh $nom_distant@$ip_distante cat /etc/passwd | grep $user_inf >/dev/null; then
        # si oui -> affichage dernière connexion
        ssh $nom_distant@$ip_distante lastlog -u $user_inf && sleep 2s
        echo "Dernière connexion : " >>/home/wilder/Documents/info-$user_inf-$(date +%Y-%m-%d).txt
        ssh $nom_distant@$ip_distante lastlog -u $user_inf >>/home/wilder/Documents/info-$user_inf-$(date +%Y-%m-%d).txt
        echo ""
        echo "Les données sont enregistrées dans le fichier info-$user_inf-$(date +%Y-%m-%d).txt" && sleep 3s
    else
        # si non -> sortie du script
        echo "L'utilisateur $user_inf n'existe pas" && sleep 2s
    fi
}

info_modification() {

    # Demande quel utilisateur
    echo ""
    echo "Date de dernière modification du mdp"
    read -p "Tapez le nom d'utilisateur souhaité : " user_inf

    # Est-ce que le nom existe sur le systeme ?
    if $nom_distant@$ip_distante cat /etc/passwd | grep $user_inf >/dev/null; then
        # si oui -> affichage dernière connexion
        ssh $nom_distant@$ip_distante chage -l $user_inf | head -n 1 && sleep 2s
        ssh $nom_distant@$ip_distante chage -l $user_inf | head -n 1 >>/home/wilder/Documents/info-$user_inf-$(date +%Y-%m-%d).txt
        echo ""
        echo "Les données sont enregistrées dans le fichier info-$user_inf-$(date +%Y-%m-%d).txt" && sleep 3s
    else
        # si non -> sortie du script
        echo "L'utilisateur $user_inf n'existe pas" && sleep 2s
    fi

}

liste_sessions() {
    # Demande quel utilisateur
    echo ""
    echo "Liste des sessions ouvertes pour l'utilisateur"
    echo ""
    read -p "Tapez le nom d'utilisateur souhaité : " user_inf

    # Est-ce que le nom existe sur le systeme ?
    if $nom_distant@$ip_distante cat /etc/passwd | grep $user_inf >/dev/null; then
        # si oui -> affichage des sessions
        ssh $nom_distant@$ip_distante w -u $user_inf && sleep 2s
        ssh $nom_distant@$ip_distante w -u $user_inf >>/home/wilder/Documents/info-$user_inf-$(date +%Y-%m-%d).txt
        echo ""
        echo "Les données sont enregistrées dans le fichier info-$user_inf-$(date +%Y-%m-%d).txt" && sleep 3s

    else
        # si non -> sortie du script
        echo "L'utilisateur $user_inf n'existe pas" && sleep 2s
    fi

}

droits_dossier() {
    # Demande quel utilisateur
    echo ""
    echo "Visualisation des droits sur un dossier"
    echo ""
    read -p "Tapez le nom d'utilisateur souhaité : " user_inf

    # Est-ce que le nom existe sur le systeme ?
    if $nom_distant@$ip_distante cat /etc/passwd | grep $user_inf >/dev/null; then
        # si oui -> demande quel dossier à verifier
        read -p "Sur quel dossier souhaitez-vous vérifier les droits ?
(spécifier chemin du dossier)" dossier_a
        if $nom_distant@$ip_distante [ -d $dossier_a ]; then
            # affichage des droits
            ssh $nom_distant@$ip_distante ls -ld $dossier_a/ && sleep 2s
            ssh $nom_distant@$ip_distante ls -ld $dossier_a/ >>/home/wilder/Documents/info-$user_inf-$(date +%Y-%m-%d).txt
            echo ""
            echo "Les données sont enregistrées dans le fichier info-$user_inf-$(date +%Y-%m-%d).txt" && sleep 3s
        else
            # si non -> sortie du script
            echo "Le dossier $dossier_a n'existe pas" && sleep 2s
        fi
    else
        # si non -> sortie du script
        echo "L'utilisateur $user_inf n'existe pas" && sleep 2s
    fi
}

droits_fichier() {

    # Demande quel utilisateur
    echo ""
    echo "Visualisation des droits sur un fichier"
    echo ""
    read -p "Tapez le nom d'utilisateur souhaité : " user_inf

    # Est-ce que le nom existe sur le systeme ?
    if $nom_distant@$ip_distante cat /etc/passwd | grep $user_inf >/dev/null; then
        # si oui -> demande quel dossier à verifier
        read -p "Sur quel fichier souhaitez-vous vérifier les droits ?
(spécifier chemin du fichier)" fichier_a
        if $nom_distant@$ip_distante [ -f $fichier_a ]; then
            # affichage des droits
            ssh $nom_distant@$ip_distante ls -l $fichier_a && sleep 2s
            ssh $nom_distant@$ip_distante ls -l $fichier_a >>/home/wilder/Documents/info-$user_inf-$(date +%Y-%m-%d).txt
            echo ""
            echo "Les données sont enregistrées dans le fichier info-$user_inf-$(date +%Y-%m-%d).txt" && sleep 3s
        else
            # si non -> sortie du script
            echo "Le fichier $fichier_a n'existe pas" && sleep 2s
        fi
    else
        # si non -> sortie du script
        echo "L'utilisateur $user_inf n'existe pas" && sleep 2s
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
        info_connexion
        ;;
    2)
        info_modification
        ;;
    3)
        liste_sessions
        ;;
    4)
        droits_dossier
        ;;
    5)
        droits_fichier
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

