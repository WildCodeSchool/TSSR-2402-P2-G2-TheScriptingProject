#!/bin/bash


# Fonction pour afficher le menu

show_menu_computer() 

{

    # Effacer l'écran

    clear

    # Affichage actions

    echo "=================================================="

    echo '        Menu "Action Machine Distante" :          '

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

 }

 

#Fonction arrêt

shutdown()

{

read -p "Confirmez-vous l'arrêt de la machine distante ? [O pour valider] " conf_shutdown



if [ $conf_shutdown = O ]

	

then

		clear

		echo " [1] Arrêt instantané de la machine "

		echo " [2] Arrêt planifié de la machine avec message d'avertissement " 

		echo " [3] Arrêt planifié de la machine sans message d'avertissement "

		echo " [*] Revenir au menu précédent "

		

		while true

		do

		read -p "Choisissez comment vous souhaitez procéder : " conf_message_s

		case $conf_message_s in

				

			1) 

			echo "Arrêt instantanné en cours"

			sudo shutdown now

			return

			;;

			

			2) 

			echo "Arrêt planifié en cours"

			sleep 1s

			read -p "Indiquer l'heure de l'arrêt [hh:mm] " timer_s1

			notify-send "Arrêt de l'ordinateur prévu pour $timer_s1"

			echo "Message d'avertissement envoyé"

			sleep 2s

			sudo shutdown $timer_s1

			sleep 3s

			return

			;;

			

			3) 

			echo "Arrêt planifié en cours"

			read -p "Indiquer l'heure de l'arrêt [hh:mm] " timer_s2

			sudo shutdown $timer_s2

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

else

	echo "Mauvais choix - Retour au menu précédent"

	sleep 2s

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

		echo " [1] Redémarrage instantané de la machine "

		echo " [2] Redémarrage planifié de la machine avec message d'avertissement " 

		echo " [3] Redémarrage planifié de la machine sans message d'avertissement "

		echo " [*] Revenir au menu précédent "

		

		while true

		do

		read -p "Choisissez comment vous souhaitez procéder : " conf_message_r

		case $conf_message_r in

				

			1) 

			echo "Redémarrage instantanné en cours"

			sudo shutdown -r now

			return

			;;

			

			2) 

			echo "Redémarrage planifié en cours"

			sleep 1s

			read -p "Indiquer l'heure du redémarrage [hh:mm] " timer_s2

			notify-send "Redémarrage de l'ordinateur prévu pour $timer_s2"

			echo "Message d'avertissement envoyé"

			sleep 2s

			sudo shutdown -r $timer_s2

			sleep 3s

			return

			;;

			

			3) 

			echo "Redémarrage planifié en cours"

			read -p "Indiquer l'heure de l'arrêt [hh:mm] " timer_s2

			sudo shutdown -r $timer_s2

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

else

	echo "Mauvais choix - Retour au menu précédent"

	sleep 2s

return

fi	

}



while true

do

    # Affiche le menu

    show_menu_computer

    # Demande du choix action

    read -p "Veuillez faire votre choix action en donnant le numéro souhaité : " choix



    # Traitement de l'action choisie

    case $choix in

    1)

    	shutdown

    ;;

    

    2)

    	reboot

    ;;

    	

    esac	

done    	
