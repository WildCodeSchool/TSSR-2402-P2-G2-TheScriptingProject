#!/bin/bash

# Fonction pour afficher le menu
show_menu_computer() 

{
# Effacer l'écran
    clear
    # Affichage des actions
    echo "=================================================="
    echo '        Menu "Information Machine Distante" :          '
    echo "=================================================="
    echo "[1]  Version de l'OS"
    echo "[2]  Nombre d'interfaces"
    echo "[3]  Adresses IP de chaque interface"
    echo "[4]  Adresses MAC"
    echo "[5]  Liste des applications/paquets installés"
    echo "[6]  Liste des utilisateurs locaux"
    echo "[7]  Type de CPU, nombre de cœurs, etc."
    echo "[8]  Mémoire RAM totale et utilisation"
    echo "[9]  Utilisation du disque"
    echo "[10] Utilisation du processeur"
    echo "[11] Statut du pare-feu et liste des ports ouverts"
    echo ""
    echo "[X]  Retour au menu précédent"
    echo ""
}

# Fonction pour avoir la version de l'OS
GetOs()
{
    clear
    read -p "Voulez-vous voir la version de l'OS? [O pour valider] " ConfOS
    if [ "$ConfOS" = "O" ]; then
        clear
        ssh $nom_distant@$ip_distante lsb_release -a 
        ssh $nom_distant@$ip_distante lsb_release -a >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s
        return
    else
        clear
        echo "Mauvais choix - Retour au menu précédent"
        sleep 2s
        return
    fi   
}

# Fonction pour avoir le nombre d'interfaces
NbrCarte()
{
    clear
    read -p "Voulez-vous voir le nombre d'interfaces présentes sur cette machine? [O pour valider]" NbrI
    if [ "$NbrI" = "O" ]; then
        clear
        echo "Voici la liste des interfaces présentes sur cette machine :" 
        ssh $nom_distant@$ip_distante ifconfig -a | grep UP | cut -d : -f1
        echo "liste des cartes" >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante ifconfig -a | grep UP | cut -d : -f1 >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s       
    fi
}


#Fonction demande adresse IP
IPdemande()
{
    clear
    read -p "Quelle carte choisissez-vous ? " CartIp
   ssh $nom_distant@$ip_distante echo "$CartIp" && ifconfig "$CartIp" | awk ' /inet /{print $2, $3 ,$4, $5, $6}'
    echo "l'adresse ip de la carte "$CartIp" est :" >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
    ssh $nom_distant@$ip_distanteifconfig "$CartIp" | awk ' /inet /{print $2, $3 ,$4, $5, $6}' >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
    echo ""
    echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s    
}

#Fonction demande adresse Mac
MACdemande()
{
    clear
    read -p "Quelle carte choisissez-vous ? " CartMac
    ssh $nom_distant@$ip_distante echo "$CartMac" && ifconfig "$CartMac" | awk '/ether / {print $2}'
    ssh $nom_distant@$ip_distante echo "l'adresse mac de la carte "$CartMac" est:" >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
    ifconfig "$CartMac" | awk '/ether / {print $2}' >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
    echo ""
    echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s
}

# Fonction qu'est-ce qui est installé?
Application()
{
    clear 
    read -p "Voulez-vous la liste des applications et paquets installés? [O pour valider]" app
    if [ "$app" = "O" ]; then
        clear
        echo " Voici la liste des applications et paquets présents sur cette machine : "
        ssh $nom_distant@$ip_distante ls /usr/share/applications | awk -F '.desktop' ' { print $1}' 
        echo "liste des applications :" >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante ls /usr/share/applications | awk -F '.desktop' ' { print $1}' >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s
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
    clear
    read -p "Voulez-vous voir la liste des utilisateurs locaux ? [O pour valider]" ListU
    if [ "$ListU" = "O" ]; then 
        clear
        echo " Voici la liste des utilisateurs locaux :"
        ssh $nom_distant@$ip_distante cut -d: -f1 /etc/passwd 
        echo "liste des utilisateurs :" >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante cut -d: -f1 /etc/passwd  >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s
        return
    else
        clear
        echo "Mauvais choix - Retour au menu précédent"
        sleep 2s
        return
   fi        
}

# Fonction Type de CPU, nombre de cœurs, etc.
GetCpu()
{
    clear
    read -p "Voulez-vous voir les détails du CPU ? [O pour valider]" Gcpu
    if [ "$Gcpu" = "O" ]; then 
        clear
        echo " Voici les détails du CPU de la machine :"
        ssh $nom_distant@$ip_distante lscpu | head -n15 
        echo "Détail du CPU :" >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante lscpu | head -n15 >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s
        return
    else
        clear
        echo "Mauvais choix - Retour au menu précédent"
        sleep 2s
        return
    fi        
}


# Fonction mémoire RAM et utilisation
RamInfo()
{
    clear
    read -p "Voulez-vous voir les détails de la RAM ? [O pour valider]" RamInf
    if [ "$RamInf" = "O" ]; then 
        clear
        echo " Voici les détails de la RAM sur cette machine :"
        ssh $nom_distant@$ip_distante free -m | head -n2 
        echo "Détail de la RAM :" >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante free -m | head -n2 >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s
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
    clear 
    read -p "Voulez-vous voir les détails du/des disques ? [O pour valider]" DiskInf
    if [ "$DiskInf" = "O" ]; then 
        clear
        echo " Voici les détails du/des disques de cette machine :"
        ssh $nom_distant@$ip_distante df -h 
        echo "Détail des disques :" >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante df -h >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s
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
    clear
    read -p "Voulez-vous voir les détails du processeur ? [O pour valider]" ProcesseurInf
    if [ "$ProcesseurInf" = "O" ]; then 
        clear
        echo " Voici les détails du processeur de cette machine :"
        ssh $nom_distant@$ip_distante mpstat 
        echo "les détails du processeur :" >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        ssh $nom_distant@$ip_distante mpstat >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s
        return
    else
        clear
        echo "Mauvais choix - Retour au menu précédent"
        sleep 2s
        return
    fi        
}

# Fonction Statut du pare-feu et liste des ports ouverts
StatusPare_feu()

{
    clear
    read -p "Voulez-vous voir les informations liées au pare-feu ? [O pour valider]" FireW
    if [ "$FireW" = "O" ]; then
        clear
        echo " Voici les détails du pare-feu de cette machine :"
        ssh $nom_distant@$ip_distante sudo ufw status 
        ssh $nom_distant@$ip_distante sudo ufw status >> "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt"
        echo ""
        echo "Les données sont enregistrées dans le fichier" "$path_info_file""Info_""$ip_distante""_$(date +%Y-%m-%d).txt" && sleep 5s
        return
    else
        clear
        echo "Mauvais choix - Retour au menu précédent"
        sleep 2s
        return
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

while true ;do
    # on affiche le menu
    show_menu_computer 
    # on demande de faire un choix
    read -p "Faites votre choix parmi la sélection ci-dessus : " choix 
    # Liste des choix 
    case $choix in 
    1)
        GetOs
        ;;
    2)
        NbrCarte
        ;;  
    3)
        IPdemande
        ;;
    4)
        MACdemande
        ;;
    5)
        Application
        ;;
    6)
        Userlist
        ;;
    7)
        GetCpu
        ;;
    8)
        RamInfo
        ;;
    9)
        DiskInfo
        ;;
    10)
        ProcesseurInfo
        ;;
    11)
        StatusPare_feu
        ;;
    esac
done
