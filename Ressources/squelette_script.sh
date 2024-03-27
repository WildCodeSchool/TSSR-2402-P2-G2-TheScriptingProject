#!/bin/bash

# MENU PRINCIPAL :
    # On veut effectuer une action ==> MENU ACTION
    # On veut chercher information ==> MENU INFORMATION
    # On veut quitter le script ==> arrêt Scrit
    # En cas de mauvaise commande on redemande de refaire un choix.


# Détais des choix MENU ACTION :
        # Action utilisateur ==> MENU ACTION UTILISATEUR
        # Action machine distante ==> MENU ACTION MACHINE DISTANTE
        # Retour au menu principal ==> MENU PRINCIPAL
        # En cas de mauvaise commande on redemande de refaire un choix.


#  Détais des choix MENU INFORMATION
        # Action utilisateur ==> MENU INFORMATION UTILISATEUR
        # Action machine distante ==> MENU INFORMATION MACHINE DISTANTE
        # Retour au menu principal ==> MENU PRINCIPAL
        # En cas de mauvaise commande on redemande de refaire un choix.


# Détails des choix dans MENU ACTION UTILISATEUR
    # CHOIX 1 : Création de compte utilisateur
        # option : 1 ou plusieurs comptes
        # fonction AddUSer
    # CHOIX 2 : Changement de mot de passe
        # option : 1 ou plusieurs comptes
        # fonction ChangePassword
    # CHOIX 3 : Suppression de compte utilisateur
        # option : 1 ou plusieurs comptes
        # fonction DellUser
    # CHOIX 4 : Désativation de compte utilisateur
        # option : 1 ou plusieurs comptes
        # fonction DisableUser
    # CHOIX 5 : Ajout à un groupe d'administrateur
        # option : 1 ou plusieurs comptes
        # fonction AddGroupAdmin
    # CHOIX 6 : Ajout à un groupe local
        # option : 1 ou plusieurs comptes
        # fonction AddGroup
    # CHOIX 7 : Sortie d'un groupe local
        # option : 1 ou plusieurs comptes
        # fonction RemoveGroup  
    # CHOIX 8 : Retour menu précédent ==> MENU ACTION
    # CHOIX 9 : Retour menu principal ==> MENU PRINCIPAL


# Détails des choix dans MENU ACTION MACHINE DISTANTE
    # CHOIX 1 : Maintenance poste distant 
        # ACTION 1 : Arrêt du poste 
            # option : instantanné ou planifier
            # fonction StopComputer
        # ACTION 2 : Redémarrage du poste
            # option : instantanné ou planifier
            # fonction RebootComputer
        # ACTION 3 : Vérrouillage du poste
            # option : instantanné ou planifier
            # fonction LockComputer
        # ACTION 4 : Mise à jour du système
            # option : instantanné ou planifier
            # fonction UpdateComputer
        # ACTION 5 : Prise en main à distance
            # fonction PriseEnMain

    # CHOIX 2 : Gestion fichier et dossier            
        # ACTION 1 : Création de répertoire
            # option : 1 ou plusieurs
            # fonction CreateFolder
        # ACTION 2 : Suppression de répertoire
            # option : 1 ou plusieurs 
            # fonction DeleteFolder
        # ACTION 10 : Installation de logiciel
            # fonction InstallSoftware
        # ACTION 11 : Désinstallation de logiciel
            # fonction DellSoftware

    # CHOIX 3 : Sécurité Poste Distant                
        # ACTION 7 : Définition des règles du pare-feu
            # Fonction SetupFirewall
        # ACTION 8 : Activaiton pare-feu
            # Fonction EnableFirewall
        # ACTION 9 : Désactivation du pare-feu
            # Fonction DisableFirewall
    
    # CHOIX 4 : Exécution d'un script sur la machine distante
        # Fonction RunScript
    # CHOIX 5 : Retour menu précédent  ==> MENU ACTION
    # CHOIX 6 : Retour menu principal  ==> MENU PRINCIPAL


# Détails des choix dans MENU INFORMATION UTILISATEUR
    # CHOIX 1 : Date de dernière connexion d'un utilisateur
        # option : 1 ou plusieurs comptes
        # Fonction LastLoginUser
    # CHOIX 2 : Date de dernière modification d'un mot de passe utilisateur
        # option : 1 ou plusieurs comptes
        # Fonction LastPasswordChangeUser
    # CHOIX 3 : Liste des session ouvertes
        # Fonction WhoIsOnline
    # CHOIX 4 : Droit et permission de l'utilisateur sur un dossier
        # option : 1 ou plusieurs dossiers
        # Fonction UserRightAccesFolder
    # CHOIX 5 : Droit et permission de l'utilisateur sur un fichier
        # option : 1 ou plusieurs fichier
        # Fonction UserRightAccesFile
    # CHOIX 6 : Retour menu précédent  ==> MENU INFORMATION
    # CHOIX 7 : Retour menu principal  ==> MENU PRINCIPAL


# Détails des choix dans MENU INFORMATION MACHINE DISTANTE
    # CHOIX 1 : Information système
        # INFORMATION 1 : Version de l'OS         
            # Fonction OSVersion  
        # INFORMATION 2 : Liste utilisateur locaux            
            # Fonction UserList
        # INFORMATION 1 : Liste application & paquets installé                 
            # Fonction SoftwareList

    # CHOIX 2 : Information Hardware
        # INFORMATION 1 : CPU      
            # Fonction CPUInfo       
        # INFORMATION 2 : Nombre d'interfaces            
            # Fonction NetworkInfo
        # INFORMATION 3 : Adresse IP interface
            # Option : Toutes ou individuelles
            # Fonction IPadressInfo            
        # INFORMATION 4 : Adresse IP MAC
            # Option : Toutes ou individuelles      
            # Fonction MaCadressInfo
        # INFORMATION 5 : Mémoire RAM            
            # Fonction RAMInfo
        # INFORMATION 6 : Utilsation RAM
            # Fonction RAMUse
        # INFORMATION 7 : Utilisation disque
            # Fonction HardDriveUse
        # INFORMATION 8 : Utilisation processeur
            # Fonction CPUUse
    
    # CHOIX 3 : Information sécurité 
        # INFORMATION 1 : Ports ouverts             
            # Fonction OpenPortListe
        # INFORMATION 2 : Statut du pare-feu            
            # Fonction FirewallStatus
         
    # CHOIX 4 : Recherche information
        # INFORMATION 1 : recherche des event dans log_evt.log pour un user            
            # Fonction FindUserEvent
        # INFORMATION 2 : recherche des event dans log_evt.log pour un ordinateur
            # Fonction FindComputerrEvent
        
    # CHOIX 6 : Retour menu précédent  ==> MENU INFORMATION
    # CHOIX 7 : Retour menu principal  ==> MENU PRINCIPAL
