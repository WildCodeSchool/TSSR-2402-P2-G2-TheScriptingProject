#!/bin/bash



# Fonction pour afficher le menu

show_menu_computer() 

{


    # Effacer l'écran

    clear

    # Affichage actions

    echo "=================================================="

    echo '        Menu "Information Machine Distante" :          '

    echo "=================================================="

    echo "[1]  Version de l'OS"

    echo "[2]  Nombre d'interface"

    echo "[3]  Adresse IP de chaque interface"

    echo "[4]  Adresse Mac"

    echo "[5]  Liste des applications/paquets installées"

    echo "[6]  Liste des utilisateurs locaux"

    echo "[7]  Type de CPU, nombre de coeurs, etc."

    echo "[8]  Mémoire RAM totale et Utilisation"

    echo "[9] Utilisation du disque"

    echo "[10] Utilisation du processeur"

    echo "[11] Liste des ports ouverts"

    echo "[12] Statut du pare-feu"

    echo ""

    echo "[X]  Retour au menu précédent"

    echo ""

 }

# Fonction pour avoir la version de l'OS

GetOs()

{
    read -p "Voulez vous voir la version de l'OS? [O pour valider] " ConfOS


if [ $ConfOS = O ]; then

            clear

            lsb_release -a

            sleep 5s

        return

else

	        clear

	        echo "Mauvais choix - Retour au menu précédent"

	        sleep 2s

        return

fi   
}

# Fontion pour avoir le nombre d'interface

NbrCarte()

{
    read -p "voulez vous voir le nombre d'interface present sur cette machine? [O pour valider]" NbrI

if [ $NbrI = O ]; then

            clear

            echo "voici la liste des interface presente sur cette machine !:
            "

            ifconfig -a | grep UP | cut -d : -f1

            sleep 5s

        return

else

	        clear

	        echo "Mauvais choix - Retour au menu précédent"

	        sleep 2s

        return

fi
}

# Fonction pour Adresse IP de chaque interface

IpEach()

{

    read -p "Voulez vous voir les adresses IP ? [O pour valider]" AIp

if [ $AIp = O ]; then 

            clear

            echo "Voici les adresses Ip pour toutes les cartes monter:
            "

            $ ifconfig |  grep inet | head -n4

            sleep 5s

        return

else

	        clear

	        echo "Mauvais choix - Retour au menu précédent"

	        sleep 2s

        return

fi        
}

# Fonction pour avoir l'adresse Mac de chaque carte


MacAdr()

{

    read -p "Voulez vous voir les adresses mac ? [O pour valider]" MacA

if [ $MacA = O ]; then 
         clear

         echo " Voici les adresses mac pour toutes les cartes monter:
            "

         ip l | awk '/link\/ether/ {print $2}'



         sleep 5s

        return

else

	        clear

	        echo "Mauvais choix - Retour au menu précédent"

	        sleep 2s

        return

fi        
}

# Fonction qu'est qui est installé?

Application()

{

    read -p "voulez vous la liste des application et paquet installer? [O pour valider]" app

if [ $app = O ]; then

         clear

         echo " Voici la liste des application et paquet present sur cette machine: 
         "
         ls /usr/share/applications | awk -F '.desktop' ' { print $1}'

        sleep 5s

    return

else

            clear

            echo "Mauvais choix - Retour au menu précédent"

            sleep 2s

        return

fi
}

# Fonction liste des utilisateurs locaux

Userlist()

{

    read -p "Voulez vous voir la liste ds utilisateur locaux ? [O pour valider]" ListU

if [ $ListU = O ]; then 

         clear

         echo " Voici la liste ds utilisateur locaux:
            "

         cut -d: -f1 /etc/passwd

         sleep 5s

        return

else

	        clear

	        echo "Mauvais choix - Retour au menu précédent"

	        sleep 2s

        return

fi        
}

# Fontion Type de CPU, nombre de coeurs, etc.

GetCpu()

{

    read -p "Voulez vous voir les details du cpu ? [O pour valider]" Gcpu

if [ $Gcpu = O ]; then 

         clear

         echo " Voici le details du cpu de la machine:
            "

         lscpu | head -n15

         sleep 5s

        return

else

	        clear

	        echo "Mauvais choix - Retour au menu précédent"

	        sleep 2s

        return

fi        
}

# Fonction memoire ram et utilisation

RamInfo()

{

    read -p "Voulez vous voir les details de la RAM ? [O pour valider]" RamInf

if [ $RamInf = O ]; then 

         clear

         echo " Voici le details de la RAM sur cette machine:
            "

         free -m | head -n2

         sleep 5s

        return

else

	        clear

	        echo "Mauvais choix - Retour au menu précédent"

	        sleep 2s

        return

fi        
}

# Fonction Utilisation du disque

DiskInfo()

{

    read -p "Voulez vous voir les details du/des disques? [O pour valider]" DiskInf

if [ $DiskInf = O ]; then 

         clear

         echo " Voici les details du/des disques de cette machine:
            "

         df -h

         sleep 5s

        return

else

	        clear

	        echo "Mauvais choix - Retour au menu précédent"

	        sleep 2s

        return

fi        
}

# Fonction Utilisation du processeur

ProcesseurInfo()

{

    read -p "Voulez vous voir les details du processeur? [O pour valider]" ProcesseurInf

if [ $ProcesseurInf = O ]; then 

         clear

         echo " Voici les details du processeur de cette machine:
            "

         mpstat

         sleep 5s

        return

else

	        clear

	        echo "Mauvais choix - Retour au menu précédent"

	        sleep 2s

        return

fi        
}

# Fontion Statut du pare-feu et liste des ports ouverts

StatusPare_feu()

{

    read -p "Voulez vous voir les information lie au pare-feu ? [O pour valider]" FireW

if [ $FireW = O ]; then 

         clear

         echo " Voici les details du pare-feu de cette machine:
            "

         sudo ufw status 

         sleep 5s

        return

else

	        clear

	        echo "Mauvais choix - Retour au menu précédent"

	        sleep 2s

        return

fi        
}





show_menu_computer

GetOs

NbrCarte

IpEach

MacAdr

Application

Userlist

GetCpu

RamInfo

DiskInfo

ProcesseurInfo

StatusPare_feu
