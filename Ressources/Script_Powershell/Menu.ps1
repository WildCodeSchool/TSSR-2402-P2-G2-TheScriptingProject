# Définition de la fonction
function Saluer {
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

        $choixMenu1  = Read-Host -Prompt "Quelle est votre choix"      

        switch  ($choixMenu1) {
                    
            1 { echo "Vous avez choisit ACTION"   }

            2 { echo "Vous avez choisit INFORMATION" }    

            3 { echo "J'espère que j'ai pu vous aider, à bientôt" }
            
            default { echo "Commande inconnu, Veuillez recommencer" }

        }
   
}

# Appel de la fonction
Saluer 