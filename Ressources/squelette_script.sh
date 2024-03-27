#!/bin/bash


# Affichage d'un menu pour choisir si on veut effectuer une action ou chercher une information

    # Si action, demandée si cela est fait sur un utilisateur de la machine distante ou su la machine distante
        # Action utilisateur ==> MENU ACTION UTILISATEUR
        # Action machine distante ==> MENU ACTION MACHINE DISTANTE

    # Si information, demandée si cela est fait sur un utilisateur de la machine distante ou su la machine distante
        # Information utilisateur ==> MENU INFORMATION UTILISATEUR
        # Information machine distante ==> MENU INFORMATION MACHINE DISTANTE

# Détails des choix dans MENU ACTION UTILISATEUR
    # CHOIX 1 : Création de compte utilisateur
        # option : 1 ou plusieurs comptes
    # CHOIX 2 : Changement de mot de passe
        # option : 1 ou plusieurs comptes
    # CHOIX 3 : Suppression de compte utilisateur
        # option : 1 ou plusieurs comptes
    # CHOIX 4 : Désativation de compte utilisateur
        # option : 1 ou plusieurs comptes
    # CHOIX 5 : Ajout à un groupe d'administrateur
        # option : 1 ou plusieurs comptes
    # CHOIX 6 : Ajout à un groupe local
        # option : 1 ou plusieurs comptes
    # CHOIX 7 : Sortie d'un groupe local
        # option : 1 ou plusieurs comptes

# Détails des choix dans MENU ACTION MACHINE DISTANTE
    # CHOIX 1 : Maintenance poste distant 
        # ACTION 1 : Arrêt du poste 
            # option : instantanné ou planifier
        # ACTION 2 : Redémarrage du poste
            # option : instantanné ou planifier
        # ACTION 3 : Vérrouillage du poste
            # option : instantanné ou planifier
        # ACTION 4 : Mise à jour du système
            # option : instantanné ou planifier
        # ACTION 5 : Prise en main à distance
    
    # CHOIX 2 : Gestion fichier et dossier            
        # ACTION 1 : Création de répertoire
            # option : 1 ou plusieurs
        # ACTION 2 : Suppression de répertoire
            # option : 1 ou plusieurs 
        # ACTION 10 : Installation de logiciel
        # ACTION 11 : Désinstallation de logiciel

    # CHOIX 3 : Sécurité Poste Distant                
        # ACTION 7 : Définition des règles du pare-feu
        # ACTION 8 : Activaiton pare-feu
        # ACTION 9 : Désactivation du pare-feu
    
    # CHOIX 3 : Exécution d'un script sur la machine distante

# Détails des choix dans MENU INFORMATION UTILISATEUR
    # CHOIX 1 : Date de dernière connexion d'un utilisateur
        # option : 1 ou plusieurs comptes
    # CHOIX 2 : Date de dernière modification d'un mot de passe utilisateur
        # option : 1 ou plusieurs comptes
    # CHOIX 3 : Liste des session ouvertes
    # CHOIX 4 : Droit et permission de l'utilisateur sur un dossier
        # option : 1 ou plusieurs dossiers
    # CHOIX 5 : Droit et permission de l'utilisateur sur un fichier
        # option : 1 ou plusieurs fichier
    

# Détails des choix dans MENU INFORMATION MACHINE DISTANTE
    # CHOIX 1 : Information système
        # INFORMATION 1 : Version de l'OS            
        # INFORMATION 2 : Liste utilisateur            
        # INFORMATION 1 : Liste application & paquets installé                 

    # CHOIX 2 : Information Hardware
        # INFORMATION 1 : CPU             
        # INFORMATION 2 : Nombre d'interfaces            
        # INFORMATION 3 : Adresse IP interface
            # Option : Toutes ou individuelles            
        # INFORMATION 4 : Adresse IP MAC
            # Option : Toutes ou individuelles      
        # INFORMATION 5 : Mémoire RAM            
        # INFORMATION 6 : Utilsation RAM
        # INFORMATION 7 : Utilisation disque
        # INFORMATION 8 : Utilisation processeur
    
    # CHOIX 3 : Information sécurité 
        # INFORMATION 1 : Ports ouverts             
        # INFORMATION 2 : Statut du pare-feu            
        
```
