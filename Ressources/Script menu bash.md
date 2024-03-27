
```bash
echo "<Date>-<Heure>-<Utilisateur>-********StartScript********" >> event.log  

MENU1()

{

	while true ; do

	clear

    #Demande de première action ACTION ou Information

        echo "Bonjour, voici les choix possible :"

        echo " "

        echo "Tapez 1 pour ACTION sur Utilisateur ou POSTE DISTANT"

        echo " "

    # renvoie vers MENU ACTION 

        echo "Tapez 2 pour INFORMATION sur Utilisateur ou POSTE DISTANT"

        echo " "

    # renvoie vers MENU INFORMATION

        echo "Tapez 3 pour quitter l'assitant "

        echo " "

        read -p "Quelle est votre choix " choixMenu1



        case $choixMenu1 in

            

            1) echo "Vous avez choisit ACTION" && sleep 2s

               echo "ACTION a été chosit" >> event.log        

                MENU2 ;;

            2) echo "Vous avez choisit INFORMATION" && sleep 2s

               echo "INFORMATION a été chosit" >> event.log                     

            	MENU3 ;;

            3) echo "J'espère que j'ai pu vous aider, à bientôt" && sleep 2s

               echo "Demande de sortie" >> event.log        

            

		echo "<Date>-<Heure>-<Utilisateur>-********EndScript********" >> event.log  

               exit 0 ;;

            *) echo "Commande inconnu, Veuillez recommencer" && sleep 2s              

		echo "erreur de commande" >> event.log ;;        

        esac

        done

    

}



MENU2() 

{

 while true ; do

 	clear

    #Navigation si ACTION sur USER ou PC

    echo "Bonjour, voici les choix possible :"

    echo " "

    echo "Tapez 1 pour ACTION sur Utilisateur"

    echo " "   

    echo "Tapez 2 pour ACTION POSTE DISTANT"

    echo " "

    echo "Tapez 3 ou tout autre caractère pour revenir en arrière "

    echo " "    

    read -p "Quelle est votre choix " choixMenu2



    case $choixMenu2 in

        1) echo "Vous avez choisit ACTION utilsiateur" && sleep 2s

        echo "ACTION USER chosit" >> event.log ;;

        2) echo "Vous avez choisit ACTION POSTE DISTANT"  && sleep 2s

        echo "ACTION POSTE DISTANT chosit" >> event.log ;;

        3) echo "Retour au menu précédent"  && sleep 2s

        MENU1

	echo "retour menu 1" >> event.log;;        

        *) echo "Commande inconnu, Veuillez recommencer" && sleep 2s

  	echo "erreur de commande" >> event.log ;;

    esac

 done

}



MENU3() 

{

while true ; do

	clear

    #Navigation si INFORMATION sur USER ou PC

    echo "Bonjour, voici les choix possible :"

    echo " "    

    echo "Tapez 1 pour INFORMATION sur Utilisateur"

    echo " "    

    echo "Tapez 2 pour INFORMATION POSTE DISTANT"

    echo " "    

    echo "Tapez 3 ou tout autre caractère pour revenir en arrière "

    echo " "    

    read -p "Quelle est votre choix " choixMenu3

        case $choixMenu3 in

        1) echo "Vous avez choisit INFORMATION utilsiateur" && sleep 2s

        echo "ACTION INFORMATION user chosit" >> event.log;;

        2) echo "Vous avez choisit INFORMATION POSTE DISTANT" && sleep 2s

        echo "ACTION INFORMATION computer chosit" >> event.log;;

        3) echo "Retour au menu précédent" && sleep 2s

        MENU1

	echo "retour menu 1" >> event.log;;        

        *) echo "Commande inconnu, Veuillez recommencer" && sleep 2s

        echo "erreur de commande" >> event.log ;;

        esac

done

}

Adduser () {

    # afficher question "donner un nom d'utilisateur" 

    read -p "Veuiller donner un nom d'utilisateur :" utilisateur

    # est-ce que le nom existe sur le systeme ?

    if cat /etc/passwd | grep $utilisateur > /dev/null

    then

        # => si oui (le nom existe) => on sort du script + message

        echo "l'utilisateur existe déjà"&& sleep 2s

        echo "RETOUR MENU2"

        MENU2

     else

        # si non => on continue

        # creation du nom donné plus haut pour créer l'utilisateur

        # verification de la creation du compte

        #if sudo useradd $utilisateur

        sudo useradd $utilisateur > /dev/null

        if cat /etc/passwd | grep $utilisateur > /dev/null

        then

            # attribution de droits et/ou de groupe

            # RAZ mot de passe

            # si utilisateur crée => message

            #read -p "mot de passe ?" motDePasse

            #passwd -u $utilisateur $motDePasse

            echo "Compte $utilisateur crée"&& sleep 2s

	echo "RETOUR MENU2"

        else

            # sortie d'erreur + message "creation utilisateur impossible"

            echo "compte $utilisateur non-crée"&& sleep 2s

	    echo "RETOUR MENU2"

            MENU2

        fi

    fi



}



#appel foncton MENU1 

MENU1

echo "<Date>-<Heure>-<Utilisateur>-********EndScript********" >> event.log  
````






