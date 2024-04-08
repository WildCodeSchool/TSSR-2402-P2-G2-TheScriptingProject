#!/bin/bash



# Fonction pour afficher le menu



afficher_menu() {

    # Effacer l'écran

    clear

    # Affichage actions



    echo "=================================================="



    echo '        Menu Information utilisateur           '



    echo "=================================================="

    echo ""

    echo "Machine distante : $nom_distant@$ip_distante"

    echo ""

    echo "[1] Date de dernière connexion d'un utilisateur"

    echo "[2] Date de dernière modification du mot de passe"

    echo "[3] Liste des sessions ouvertes par l'utilisateur"

    echo "[4] Droits/permissions de l'utilisateur sur un dossier"

    echo "[5] Droits/permissions de l'utilisateur sur un fichier"

    echo ""

    echo "[X]. Retour au menu précédent"

    echo ""

}





# Fonctions Informations utilisateur

info_connexion() {

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

        echo echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"&& sleep 3s

    else

        # si non -> sortie du script

        echo "L'utilisateur $user_mpd n'existe pas" && sleep 2s

    fi

}



# Fonctions Informations dernière modification de mot de passe

info_modification() {

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

        echo echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"&& sleep 3s

    else

        # si non -> sortie du script

        echo "L'utilisateur $user_mpd n'existe pas" && sleep 2s

    fi



}



liste_sessions() {

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

        echo echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"&& sleep 3s



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

            echo echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"&& sleep 3s

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

            echo echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$user_inf""_$(date +%Y-%m-%d).txt"&& sleep 3s

        else

            # si non -> sortie du script

            echo "Le fichier $fichier_a n'existe pas" && sleep 2s

        fi

    else

        # si non -> sortie du script

        echo "L'utilisateur $user_inf n'existe pas" && sleep 2s

    fi



}



# Prérequis

# Création répertoire Documents

path_info_file=~/Documents/

if [ ! -d "$path_info_file" ] ;then

    # Si le dossier existe pas le créér       

    mkdir "$path_info_file"

fi 





# Demande d'infos sur la machine distante

    echo "=================================================="

    echo "        Initialisation script pour connexion      "

    echo "=================================================="

	echo ""

# Demande du nom d'utilisateur de la machine distante

	read -p "Veuillez entrer le nom d'utilisateur de la machine distante : " nom_distant

# Demande de l'adresse IP de la machine distante

	read -p "Veuillez entrer l'adresse IP de la machine distante : " ip_distante

	echo ""

	

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
