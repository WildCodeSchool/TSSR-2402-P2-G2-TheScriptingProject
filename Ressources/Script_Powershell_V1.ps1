###############################################################################################################################################################################################################
################################################################################################################################################################################################################
# Script Powershell pour maintenance et information sur Poste Distant Windows
# Version 0.85
# Réalisé en collaboration par Anais Lenglet, Bruno Serna, Grégory Dubois, Patrick Baggiolini et Thomas Scotti
# Dernière mise à jour le  18 / 04 / 2024
# Historique version
# V0.85 -- 18 / 04 / 2024 mise à jour fonction actions 
# V0.8 -- 17 / 04 / 2024 Ajout fonction info user / computer
# V0.7 -- 17 / 04 / 2024 Ajout fonction action computer
# V0.6 -- 17 / 04 / 2024 Ajout fonction action user
# V0.5 -- 16 / 04 / 2024 Création script
################################################################################################################################################################################################################
################################################################################################################################################################################################################

####################################################
########### Fonction Menu Principal ################
####################################################

############## DEBUT FONCTION ######################

# Fonction menu principal
function Menu_Principal
{
    While ($true) 
    {   
    # Effacer l'écran
        Clear-Host
    # Demande de premier choix ACTION / INFORMATION ou QUITTER
        Write-Host "=================================="
        Write-Host "|         Menu Principal        | "
        Write-Host "=================================="
        Write-Host ""
        Write-Host "Poste Distante : $NomDistant@$IpDistante"
        Write-Host ""
        Write-Host "Bonjour, voici les différents choix possibles à effectuer sur le poste distant :"
        Write-Host ""
        Write-Host "[1] ACTION sur UTILISATEUR ou POSTE"
        Write-Host "[2] INFORMATION sur UTILISATEUR ou POSTE"
        Write-Host ""
        Write-Host "[X] Arrêter le script "
        Write-Host ""
        $ChoixMenuPrincipal = Read-Host "Veuillez faire votre choix : "
    # Traitement de l'action choisie
        Switch ($ChoixMenuPrincipal) 
        {
            "1" 
        # Envoie vers MENU ACTION
            { 
                Write-Host ""
                Write-Host "Vous avez choisi ACTION"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Menu Action a été choisi" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log        
                Menu_Action
                
            }
            "2" 
        # Envoie vers MENU INFORMATION
            { 
                Write-Host ""
                Write-Host "Vous avez choisi INFORMATION"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Menu Information a été choisi" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Menu_Information
                
            }
            "X" 
        # Arrêt Script
            { 
                Write-Host ""
                Write-Host "Arrêt du script"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Sortie du Script" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log    
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-********EndScript********" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                exit 
            }
            Default 
        # Erreur de commande
            { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Choix incorrect" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                
                Read-Host "Appuyez sur entrée pour continuer"
                Start-Sleep -Seconds 2
            }
        }
    }
}

# Fonction menu Action
    function Menu_Action
{
    While ($true)
    {
    # Effacer l'écran
        Clear-Host
    # Demande choix ACTION UTILISATEUR / ACTION POSTE DISTANT / retour menu principal
        Write-Host "=================================="
        Write-Host "|             ACTION            | "
        Write-Host "=================================="
        Write-Host ""
        Write-Host "Poste Distante : $NomDistant@$IpDistante"
        Write-Host ""
        Write-Host "Voici les différents choix possibles :"
        Write-Host ""
        Write-Host "[1] ACTION sur UTILISATEUR"
        Write-Host "[2] ACTION sur POSTE"
        Write-Host ""
        Write-Host "[X] Retour au menu principal"
        Write-Host ""
        $ChoixMenuAction = Read-Host "Veuillez faire votre choix : "
    # Traitement de l'action choisie
        Switch ($ChoixMenuAction) 
        {
            "1" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi ACTION sur UTILISATEUR"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Menu Action sur Uutilisateur a été choisi" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Menu_Action_Utilisateur
            }
            "2" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi ACTION sur POSTE"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Menu Action sur Poste a été choisi" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Menu_Action_Poste
            }
            "X" 
            { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Retour au menu principal" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Menu_Principal 
            }
            Default 
            { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Choix incorrect" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Read-Host "Appuyez sur entrée pour continuer"
                Start-Sleep -Seconds 2
            }
        }
    }
}

# Fonction menu Information
function Menu_Information 
{
    While ($true) 
    {
    # Effacer l'écran
        Clear-Host
    # Demande choix INFO UTILISATEUR / INFO POSTE DISTANT / retour menu principal
        Write-Host "=================================="
        Write-Host "=================================="
        Write-Host "|          INFORMATION           |"
        Write-Host "=================================="
        Write-Host ""
        Write-Host "Poste Distante : $NomDistant@$IpDistante"
        Write-Host ""
        Write-Host "Voici les différents choix possibles :"
        Write-Host ""
        Write-Host "[1] INFORMATION sur UTILISATEUR"
        Write-Host "[2] INFORMATION sur POSTE"
        Write-Host ""
        Write-Host "[X] Retour au menu principal"
        Write-Host ""
        $ChoixMenuInformation = Read-Host "Veuillez faire votre choix : "
    # Traitement de l'action choisie
        Switch ($ChoixMenuInformation) 
        {
            "1" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi INFORMATION sur UTILISATEUR"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Menu Information sur Utilsiateur choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Menu_Information_Utilisateur
            }
            "2"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi INFORMATION sur POSTE"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Menu Information sur Poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Menu_Information_Poste 
            }
            "X" 
            { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Retour au menu principal" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Menu_Principal 
            }
            Default 
            { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Choix incorrect" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Read-Host "Appuyez sur entrée pour continuer"
                Start-Sleep -Seconds 2
            }
        }
    }
}

############## FIN FONCTION ######################

####################################################
########### Fonction Menu Action ###################
####################################################

############## DEBUT FONCTION ######################

# Fonction menu Action Utilisateur
function Menu_Action_Utilisateur 
{   
    While ($true) 
    {
    # Effacer l'écran
        Clear-Host
    # Demande choix ACTION UTILISATEUR / retour menu précédent / retour menu principal
        Clear-Host
        Write-Host "=================================="
        Write-Host "|        ACTION UTILISATEUR     | "
        Write-Host "=================================="
        Write-Host ""
        Write-Host "Poste Distante : $NomDistant@$IpDistante"
        Write-Host ""
        Write-Host "Voici les différents choix possibles :"
        Write-Host ""
        Write-Host "[1] Création d'un compte utilisateur local"
        Write-Host "[2] Suppresion d'un compte utilisateur local"
        Write-Host "[3] Désactivation d'un compte utilisateur local"
        Write-Host "[4] Modification d'un mot de passe"
        Write-Host "[5] Ajout d'un compte à un groupe d'administration"
        Write-Host "[6] Ajout d'un compte à un groupe local"
        Write-Host "[7] Sortie d'un compte à un groupe local"
        Write-Host ""
        Write-Host "[0] Retour au menu précédent"
        Write-Host "[X] Retour au menu principal"
        Write-Host ""
    # Demande du choix action
        $ChoixMenuActionUtilisateur = Read-Host "Veuillez faire votre choix : "
    # Traitement de l'action choisie
        Switch ($ChoixMenuActionUtilisateur) 
        {
            "1" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de créer un compte utilisateur local"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Création de compte utilisateur chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                CreateUser               
                
            }
            "2" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de supprimer un compte utilisateur local"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Suppression de compte utilisateur chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                DelUser              
            }
            "3" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de désactiver un compte utilisateur local"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Désactivation de compte utilisateur choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log  
                DisableUser             
            }
            "4" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de modifier un mot de passe"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Changement de mot de passe choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log   
                PasswordUser      
            }
            "5" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'ajouter un compte à un groupe d'administration"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Ajout d'un compte à un groupe d'administration choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log 
                UserAddAdminGroup
            }
            "6" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'ajouter un compte à un groupe local"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Ajout d'un compte à un groupe local choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log    
                UserAddGroup 
            }
            "7"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de retirer un compte d'un groupe local"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Suppression d'un compte à un groupe local choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log     
                UserDelGroup
            }
            "0" 
            { 
                Write-Host ""
                Write-Host "Retour au menu précédent"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Retour au menu précédent" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Menu_Action    
            }
            "X" 
            { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Retour au menu principal" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Menu_Principal 
            }
            Default 
            { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Choix incorrect" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Read-Host "Appuyez sur entrée pour continuer"
                Start-Sleep -Seconds 2
            }
        }
    }
}

# Fonction pour afficher le menu action Ordinateur
function Menu_Action_Poste
{
    While ($true) 
    {
    # Effacer l'écran1
        Clear-Host
    # Demande choix ACTION Poste / retour menu précédent / retour menu principal
        Write-Host "=================================="
        Write-Host "|       ACTION POSTE DISTANT     | "
        Write-Host "=================================="
        Write-Host ""
        Write-Host "Poste Distante : $NomDistant@$IpDistante"
        Write-Host ""
        Write-Host "Voici les différents choix possibles :"
        Write-Host ""
        Write-Host "[1]  Arrêt"
        Write-Host "[2]  Redémarrage"
        Write-Host "[3]  Vérouillage"
        Write-Host "[4]  MàJ du système"
        Write-Host "[5]  Création de dossier"
        Write-Host "[6]  Suppression de dossier"
        Write-Host "[7]  Prise de main à distance"
        Write-Host "[8]  Activation du pare-feu"
        Write-Host "[9]  Désactivation du pare-feu"
        Write-Host "[10] Règles du parefeu"
        Write-Host "[11] Installation/Désinstallation d'un logiciel"
        Write-Host "[12] Exécution d'un script sur le Poste Distante"
        Write-Host ""
        Write-Host "[0] Retour au menu précédent"
        Write-Host "[X] Retour au menu principal"
        Write-Host ""
    # Demande du choix action
        $ChoixMenuActionPoste = Read-Host "Veuillez faire votre choix : "
    # Traitement de l'action choisie
        Switch ($ChoixMenuActionPoste) 
        {
            "1" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'arrêter le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Arrêt poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                Shutdown
            }
            "2" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de redémarrer le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Redémarrage poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2        
                Reboot
            }
            "3"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de vérouiller le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Vérouillage du poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2         
                Lock
            }
            "4" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de mettre à jour le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Mise à jour du poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "5" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de créer un dossier"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Création d'un dossier sur poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                CreateDirectory
            }
            "6"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de supprimer un dossier"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Suppresision d'un dossier sur poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                RemoveDirectory
            }
            "7" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de prendre la main sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Prise en main sur poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                RemoteControl
            }
            "8" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'activer le pare-feu sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Activation du pare-feu du poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                FirewallOn
            }
            "9" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de désactiver le pare-feu sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Désactivation du pare-feu du poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                FirewallOff
            }
            "10" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de modifier les règles du pare-feu sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Modification de règle du pare-feu du poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                FirewallRules
            }
            "11" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'installer/désinstaller un logiciel sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Installation/Désinstallation de logiciel sur le poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                Applications
            }
            "12"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'éxécuter un script sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Exécution d'un script sur le poste distant" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                RemoteScript
            }
            "0" 
            { 
                Write-Host ""
                Write-Host "Retour au menu précédent"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Retour au menu précédent" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2
                Menu_Action
            }
            "X" 
            { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Retour au menu principal" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Menu_Principal 
            }
            Default 
            { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Choix incorrect" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Read-Host "Appuyez sur entrée pour continuer"
                Start-Sleep -Seconds 2
            }
        }
    }
}
    

############## FIN FONCTION ######################

####################################################
########### Fonction Menu iNFORMATION ##############
####################################################

############## DEBUT FONCTION ######################

# Fonction menu Information Utilisateur
function Menu_Information_Utilisateur 
{   
    While ($true) 
    {
    # Effacer l'écran 
        Clear-Host
    #Demande choix INFOMRATION UTILISATEUR / retour menu précédent / retour menu principal
        Write-Host "=================================="
        Write-Host "|    INFORMATION UTILISATEUR    | "
        Write-Host "=================================="
        Write-Host ""
        Write-Host "Poste Distante : $NomDistant@$IpDistante"
        Write-Host ""
        Write-Host "Voici les différents choix possibles :"
        Write-Host ""
        Write-Host "[1]  Date de la dernière connexion de l'utilisateur"
        Write-Host "[2]  Date de la dernière modification du mot de passe de l'utilisateur"
        Write-Host "[3]  Liste des sessions utilisateurs ouvertes"
        Write-Host "[4]  Droits/permissions sur un dossier"
        Write-Host "[5]  Droits/permissions sur un fichier"
        Write-Host ""
        Write-Host "[0] Retour au menu précédent"
        Write-Host "[X] Retour au menu principal"
        Write-Host ""
    # Demande du choix action
        $ChoixMenuInformationUtilisateur = Read-Host "Veuillez faire votre choix : "
    # Traitement de l'action choisie
        Switch ($ChoixMenuInformationUtilisateur) 
        {
            "1" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la date de la dernière connexion de l'utilisateur"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Date dernière connexion utilisateur" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                InfoConnexion
            }
            "2" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la date de la dernière modification du mot de passe de l'utilisateur"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Date dernière modificaiton mot de passe utilisateur chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                InfoModificationMdp
            }
            "3" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des sessions utilisateurs ouvertes"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Liste des session utilisateurs ouvertes chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                InfoLogSession
            }
            "4" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter les droits et permissions sur un dossier"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Droits/permission sur un dossier chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                droitsDossier
            }
            "5"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter les droits et permissions sur un fichier"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Droits/permission sur un fichier chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2   
                droitsFichier
            }
            "0"
            { 
                Write-Host ""
                Write-Host "Retour au menu précédent"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Retour au menu précédent" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2
                Menu_Information
            }
            "X" 
            { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Retour au menu principal" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2
                Menu_Principal 
            }
            Default 
            { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Choix incorrect" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Read-Host "Appuyez sur entrée pour continuer"
                Start-Sleep -Seconds 2
            }
        }
    }
}

# Fonction menu Information ordinateur
    function Menu_Information_Poste 
{
    While ($true) 
    {
    # Effacer l'écran
        Clear-Host
    # Demande choix INFOMRATION UTILISATEUR / retour menu précédent / retour menu principal
        Write-Host "=================================================="
        Write-Host '        Menu "INFORMATION POSTE DISTANT"          '
        Write-Host "=================================================="
        Write-Host ""
        Write-Host "Poste Distante : $NomDistant@$IpDistante"
        Write-Host ""
        Write-Host "Voici les différents choix possibles :"
        Write-Host ""
        Write-Host "[1]  Version de l'OS"
        Write-Host "[2]  Nombre d'interfaces réseaux"
        Write-Host "[3]  Adresse IP de chaque interface réseau"
        Write-Host "[4]  Adresse MAC de chaque interface réseau"
        Write-Host "[5]  Liste des applications / paquets installés"
        Write-Host "[6]  Liste des utilisateurs locaux"
        Write-Host "[7]  Informations CPU"
        Write-Host "[8]  Mémoire RAM totale & Utilisation"
        Write-Host "[9]  Utilisation du disque dur"
        Write-Host "[10] Utilisation du processeur"
        Write-Host "[11] Statut du pare-feu "
        Write-Host "[12] Liste des ports ouverts sur le pare-feu"
        Write-Host ""
        Write-Host "[0] Retour au menu précédent"
        Write-Host "[X] Retour au menu principal"
        Write-Host ""
    # Demande du choix action
        $ChoixMenuInformationPoste = Read-Host "Veuillez faire votre choix : "
    # Traitement de l'action choisie
        Switch ($ChoixMenuInformationPoste) 
        {
            "1" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la version de l'OS"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information version de l'OS  chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2
                GetOS
            }
            "2" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter le nombre d'interfaces réseaux"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information sur le nombre d'interfaces réseaux chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                NbrCarte
            }
            "3"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'adresse IP de chaque interface réseau"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information adresse IP de chaque interface chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                IPInterface
            }
            "4" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'adresse MAC de chaque interface réseau"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information adresse MAC de chaque interface chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                MACDemande
            }
            "5" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des applications / paquets installés"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information Liste des applicattions/paquets chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                ApplicationList
            }
            "6" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des utilisateurs locaux"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information Liste utilsiateurs locaux choisit " | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                UserList
            }
            "7"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des informations CPU"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information sur le CPU chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                GetCPU
            }
            "8" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la mémoire RAM totale et l'utilisation"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information RAM totale et utilisation chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2       
                RAMInfo 
            }
            "9" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'utilisation du disque dur"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur--Information Utilisation du disque dur chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2
                DiskInfo
            }
            "10"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'utilisation du processeur"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information Utilisation du processeur chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2
                ProcesseurInfo
            }
            "11"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter le statut du pare-feu "
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-statut du pare-feu chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                StatutParefeu
            }
            "12"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des ports ouverts sur le pare-feu"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Liste des ports ouverts sur le pare-feu choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
                StatutPort
            }

            "0" 
            { 
                Write-Host ""
                Write-Host "Retour au menu précédent"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Retour au menu précédent" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2
                Menu_Information
            }
            "X" 
            { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Retour au menu principal" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2
                Menu_Principal 
            }
            Default 
            { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Choix incorrect" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Read-Host "Appuyez sur entrée pour continuer"
                Start-Sleep -Seconds 2
            }
        }
    }
}

############## FIN FONCTION ######################


####################################################
########### Fonction Action Utilisateur ############
####################################################

############## DEBUT FONCTION ######################

# Fonction Création de compte utilisateur local
function CreateUser 
{
    #Création d'un compte utilisateur local 
    # Demande quel utilisateur à créer
    $newUser = Read-Host "Quel compte utilisateur souhaitez-vous créer?"

    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalUser -Name $using:newUser } 
    if ($userExists) {
        # Si oui -> sortie du script
        Write-Host "L'utilisateur existe déjà." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
    else {
        Write-Host "Le compte $newUser n'existe pas et va être créé."
        $Mdp = Read-Host "Taper le mot de passe"
        # Création de l'utilisateur
        Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { New-LocalUser -Name $using:newUser -Password (ConvertTo-SecureString -AsPlainText $using:Mdp -Force) } 
        # Confirmation de la création
        Write-Host "Compte $newUser créé." -ForegroundColor Green
        Start-Sleep -Seconds 2
    }
}


# Fonction Suppression de compte utilisateur local
function DelUser 
{
    # Demande quel compte utilisateur à supprimer
    $userDel = Read-Host "Quel compte utilisateur souhaitez-vous supprimer ?"

    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalUser -Name $using:UserDel } 
    if ($userExists) {
        # Si il exsite -> demande de confirmation
        $confirmation = Read-Host "Voulez-vous vraiment supprimer le compte $userDel ? (Oui/Non)"
        # Si oui -> suppression du compte
        if ($confirmation -eq "Oui") {
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Remove-LocalUser -Name $using:UserDel } 
            Write-Host "Le compte $userDel est supprimé." -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        else {
            # Si non -> sortie du script
            Write-Host "Suppression annulée." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
    else {
        # Si le compte n'existe pas
        Write-Host "Le compte utilisateur n'existe pas." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}


# Fonction Désactivation de compte utilisateur local
function DisableUser 
{
    # Demande quel compte utilisateur à désactiver
    $userLock = Read-Host "Quel compte utilisateur souhaitez-vous désactiver ?"

    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalUser -Name $using:UserLock } 
    if ($userExists) {
        # Si l'utilisateur existe -> demande de confirmation
        $confirmation = Read-Host "Voulez-vous vraiment désactiver le compte $userLock ? (Oui/Non)"
        # Si oui -> désactivation du compte
        if ($confirmation -eq "Oui") {
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Disable-LocalUser -Name $using:UserLock } 
            Write-Host "L'utilisateur $userLock est désactivé." -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        else {
            # Si non -> sortie du script
            Write-Host "Désactivation annulée." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
    else {
        # Si l'utilisateur n'existe pas
        Write-Host "L'utilisateur $userLock n'existe pas." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}

# Fonction Changement de mot de passe de compte utilisateur local
function PasswordUser
{
    # Modification d'un mot de passe
    # Demande changement du mot de passe -> pour quel utilisateur ?
    $userMdp = Read-Host "Pour quel compte utilisateur souhaitez-vous modifier le mot de passe ?"

    # Vérifie si le nom d'utilisateur existe sur le système distant
    $userExist = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalUser -Name $using:UserMdp } 
    if ($userExist) {
        # Si oui -> demander de taper le nouveau mdp
        $newMdp = Read-Host "Entrer le nouveu mot de passe :"
        Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Set-LocalUser -Name $using:userMdp -Password (ConvertTo-SecureString -AsPlainText $using:newMdp -Force) } 
        Write-Host "Le mot de passe est bien modifié." -ForegroundColor Green
        Start-Sleep -Seconds 2
    }
    else {
        # Si non -> sortie du script
        Write-Host "L'utilisateur $userMdp n'existe pas." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}

# Fonction ajout utilisateur à un groupe d'administration
function UserAddAdminGroup 
{
    # Demande quel compte utilisateur à ajouter
    $userAdm = Read-Host "Quel compte utilisateur souhaitez-vous ajouter au groupe d'administration?"

    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalUser -Name $using:UserAdm } 
    if ($userExists) {
        # Si l'utilisateur existe -> ajout au groupe Administrators
        Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Add-LocalGroupMember -Group Administrateurs -Member $using:userAdm } 
        Write-Host "Le compte $userAdm est ajouté au groupe Administrateurs." -ForegroundColor Green
        Start-Sleep -Seconds 2
    }
    else {
        # Si non sortie du script
        Write-Host "Le compte utilisateur n'existe pas." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}

# Fonction ajout utilisateur à un groupe local
Function UserAddGroup
{
    # Demande quel compte à ajouter au groupe local
    $userAddG = Read-Host "Quel compte utilisateur souhaitez-vous ajouter à un groupe local?"
    
    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalUser -Name $using:UserAddG } 
    if ($userExists) {
        # Si l'utilisateur existe -> demande quel groupe?
        $choixAddGroup = Read-Host "À quel groupe souhaitez-vous ajouter l'utilisateur $userAddG?"
    
        $groupExists = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalGroup -Name $using:choixAddGroup } 
            
        if ($groupExists) {
            Write-Host "Ajout du compte en cours..." -ForegroundColor Green
            Start-Sleep -Seconds 2
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Add-LocalGroupMember -Group $using:choixAddGroup -Member $using:userAddG } 
            Write-Host "Le compte $userAddG est ajouté au groupe $choixAddGroup." -ForegroundColor Green

            # Affichage des utilisateurs du groupe pour vérification
            Write-Host "Vous trouverez ci-dessous la liste des utilisateurs du groupe $choixAddGroup ." -ForegroundColor Green
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalGroupMember -Group $using:choixAddGroup } 
	    Start-Sleep -Seconds 2
        }
        else {
            Write-Host "Le groupe n'existe pas." -ForegroundColor Red
        }
    }
    else {
        # Si non, sortie du script
        Write-Host "Le compte utilisateur n'existe pas." -ForegroundColor Red
    }
}

# Fonction suppression utilisateur à un groupe local
Function UserDelGroup
{
    # Suppression utilisateur d'un groupe local
    $userDel = Read-Host "Quel compte utilisateur souhaitez-vous supprimer d'un groupe local?"
        
    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalUser -Name $using:UserDel } 
    if ($userExists) {
        # Si l'utilisateur existe -> demande quel groupe?
        $choixDelGroup = Read-Host "De quel groupe souhaitez-vous supprimer l'utilisateur $userDel?"
        
        $groupExists = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalGroup -Name $using:choixDelGroup } 
                
        if ($groupExists) {
            # Si le groupe existe -> suppression de l'utilisateur du groupe
            Write-Host "Traitement en cours..." -ForegroundColor Green
            Start-Sleep -Seconds 2
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Remove-LocalGroupMember -Group $using:choixDelGroup -Member $using:userDel } 
            Write-Host "Le compte $userDel est supprimé du groupe $choixDelGroup." -ForegroundColor Green

            # Affichage des utilisateurs du groupe pour vérification
            Write-Host "Vous trouverez ci-dessous la liste des utilisateurs du groupe $choixDelGroup ." -ForegroundColor Green
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Get-LocalGroupMember -Group $using:choixDelGroup } 
	    Start-Sleep -Seconds 2
        }
        else {
            Write-Host "Le groupe n'existe pas." -ForegroundColor Red
        }
    }
    else {
        # Si non, sortie du script
        Write-Host "Le compte utilisateur n'existe pas." -ForegroundColor Red
    }
}


############## FIN FONCTION ######################


####################################################
########### Fonction Action Ordinateur ############
####################################################

############## DEBUT FONCTION ####################
# Fonction "Arrêt"
function Shutdown 
{
# Demande de confrmation
	$ConfShutdown = Read-Host "Confirmez-vous l'arrêt du post distant ? [O pour valider] "
# Si confirmation OK, affichage du sous-menu de la fonction "Arrêt"
	If  ($ConfShutdown -eq "O") 
    {
        Write-Host " [1] Arrêt instantané du poste distant" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [2] Arrêt planifié du poste distant avec message d'avertissement" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [3] Arrêt planifié de la machine sans message d'avertissement" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [*] Revenir au menu précédent" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host ""
        $ConfMessage_S = Read-Host "Faites votre choix parmi la sélection ci-dessus" 
# Demande de choix pour le sous-menu de la fonction "Arrêt"	
        switch ($ConfMessage_S)
        {
            "1"
            {
                Write-Host "Arrêt instantané du poste distant en cours" -ForegroundColor Yellow -BackgroundColor Black
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { 
                    shutdown /s /f /t 0 
                    }
                Start-Sleep -Seconds 1
                Write-Host "Commande d'arrêt instantané envoyée avec succès à $IpDistante."
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }

            "2"
            {
                Write-Host "Arrêt planifié du poste distant avec message d'avertissement en cours" -ForegroundColor Yellow -BackgroundColor Black
                $Timer_S1 = Read-Host "Indiquer le compte à rebours (en secondes) "
                $MessageTimer_S1 = Read-Host "Indiquer le message à envoyer au poste distant "
                Start-Sleep -Seconds 1
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                    param ($Timer_S1, $MessageTimer_S1)
                    Start-Sleep -Seconds 1
                    shutdown /s /f /t $Timer_S1 /c "$MessageTimer_S1"
                    } -ArgumentList $Timer_S1, $MessageTimer_S1
                Write-Host "Commande d'arrêt planifié avec message d'avertissement envoyée avec succès à $IpDistante."
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }

            "3"
            {
                Write-Host "Arrêt planifié du poste distant en cours" -ForegroundColor Yellow -BackgroundColor Black
                $Timer_S2 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                Start-Sleep -Seconds 1
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                    param ($Timer_S2)
                    Start-Sleep -Seconds 1
                    shutdown /s /f /t $Timer_S2
                    } -ArgumentList $Timer_S2
                Write-Host "Commande d'arrêt planifié envoyée avec succès à $IpDistante."
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
            
            default
            {
                Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1
                Return
            }
        }
    }
# Si confirmation NOK, sortie de la fonction "Arrêt"
    Else
    {
        Write-Host "Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1
        Return
    }
}

# Fonction "Redémarrage"
function Reboot
{
# Demande de confrmation
	$ConfReboot = Read-Host "Confirmez-vous le redémarrage du post distant ? [O pour valider] "
# Si confirmation OK, affichage du sous-menu de la fonction "Redémarrage"
	If  ($ConfReboot -eq "O") 
    {
        Write-Host " [1] Redémarrage instantané du poste distant" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [2] Redémarrage planifié du poste distant avec message d'avertissement" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [3] Redémarrage planifié du poste distant sans message d'avertissement" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [*] Revenir au menu précédent" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host ""
        $ConfMessage_R = Read-Host "Faites votre choix parmi la sélection ci-dessus" 
# Demande de choix pour le sous-menu de la fonction "Redémarrage"	
        switch ($ConfMessage_R)
        {
            "1"
            {
                Write-Host "Redémarrage instantané du poste distant en cours" -ForegroundColor Yellow -BackgroundColor Black
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                    shutdown /r /f /t 0
                    }
                Start-Sleep -Seconds 1
                Write-Host "Commande de redémarrage du poste distant envoyée avec succès à $IpDistante."
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }

            "2"
            {
                Write-Host "Redémarrage planifié du poste distant avec message d'avertissement en cours" -ForegroundColor Yellow -BackgroundColor Black
                $Timer_R1 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                $MessageTimer_R1 = Read-Host "Indiquer le message à envoyer au poste distant : "
                Start-Sleep -Seconds 1
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                    param ($Timer_R1, $MessageTimer_R1)
                    Start-Sleep -Seconds 1
                    shutdown /r /f /t $Timer_R1 /c "$MessageTimer_R1"
                    } -ArgumentList $Timer_R1, $MessageTimer_R1
                Start-Sleep -Seconds 1
                Write-Host "Commande de redémarrage du poste distant avec message d'avertissement envoyée avec succès à $IpDistante."
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }

            "3"
            {
                Write-Host "Redémarrage planifié du poste distant en cours" -ForegroundColor Yellow -BackgroundColor Black
                $Timer_R2 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                Start-Sleep -Seconds 1
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                    param ($Timer_R2)
                    Start-Sleep -Seconds 1
                    shutdown /r /f /t $Timer_R2
                    } -ArgumentList $Timer_R2
                Start-Sleep -Seconds 1
                Write-Host "Commande de redémarrage du poste distant envoyée avec succès à $IpDistante."
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
            
            default
            {
                Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1
                return
            }
        }
    }
# Si confirmation NOK, sortie de la fonction "Redémarrage"
    Else
    {
        Write-Host "Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1
        Return
    }
}

function Lock
{
# Demande de confirmation
	$ConfLock = Read-Host "Confirmez-vous le vérouillage de la session du poste distant ? [O pour valider] "
# Si confirmation OK, exécution de la commande "Vérouillage"
	If ($ConfLock -eq "O")
    {
		Write-Host "Session du poste distant en cours de vérouillage" -ForegroundColor Yellow -BackgroundColor Black
        Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
            logoff console
            }
		Start-Sleep -Seconds 1
        Write-Host "Commande de vérouillage de la session du poste distant envoyée avec succès à $IpDistante."
        Read-Host "Appuyer sur Entrée pour continuer ..."

# Si confirmation NOK, sortie de la fonction "Vérouillage"	
	Else
		Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
		Start-Sleep -Seconds 1
		Return	
    }
}


# Fonction "Activation du pare-feu"
function FirewallOn
{
# Demande de confirmation + Avertissement
	Write-Host "ATTENTION : Cette commande peut impacter l'éxécution du script" -ForegroundColor Yellow -BackgroundColor Black
	$ConfwWOn = Read-Host "Confirmez-vous l'activation du pare-feu sur le poste distant ? [O pour valider ] : " 
# Si confirmation OK, éxécution de la commande "Activation du pare-feu"	
	if ( $ConfwWOn -eq "O" )
    { 
    $Command ={Set-NetFirewallProfile -Enabled true ; Get-NetFirewallProfile | Format-Table Name, Enabled}
		invoke-Command -ComputerName $IpDistante -ScriptBlock $Command -Credential $Credentials
		Write-Host "Le pare-feu de le poste distant a bien été activé" -ForegroundColor Yellow -BackgroundColor Black
		Start-Sleep -Seconds 1
        Read-Host "Appuyer sur Entrée pour continuer ..."
	}
# Si confirmation NOK, sortie de la fonction "Activation du pare-feu"
	else
    {
		Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
		Start-Sleep -Seconds 2
		return	
	}
}

# Fonction "Désactivation du pare-feu"
function FirewallOff
{
# Demande de confirmation + Avertissement
	Write-Host "ATTENTION : Cette commande peut impacter l'éxécution du script" -ForegroundColor Yellow -BackgroundColor Black
	$ConfwWOff = Read-Host "Confirmez-vous la désactivation du pare-feu sur le poste distant ? [O pour valider ] : " 
# Si confirmation OK, éxécution de la commande "Activation du pare-feu"	
	if ( $ConfwWOff -eq "O" )
    { 
    $Command ={Set-NetFirewallProfile -Enabled false ; Get-NetFirewallProfile | Format-Table Name, Enabled}
		invoke-Command -ComputerName $IpDistante -ScriptBlock $Command -Credential $Credentials
		Write-Host "Le pare-feu de le poste distant a bien été désactivé" -ForegroundColor Yellow -BackgroundColor Black
		Start-Sleep -Seconds 1
        Read-Host "Appuyer sur Entrée pour continuer ..."
	}
# Si confirmation NOK, sortie de la fonction "Activation du pare-feu"
	else
    {
		Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
		Start-Sleep -Seconds 2
		return	
	}
}


# Fonction "Règles du pare-feu"
function FirewallRules
 {

    # Demande de confirmation + Avertissement concernant la sortie du script dès l'éxécution de cette fonction
    Write-Host "ATTENTION : Les commandes suivantes sont réservées à un public averti" -ForegroundColor Yellow -BackgroundColor Black
    $ConfFwRules = Read-Host "Confirmez-vous l'accès à la modification des règles du pare-feu ? [O Pour valider] : "

    # Si confirmation OK, affichage du sous-menu de la fonction "Règles du pare-feu"
    if ($ConfFwRules -eq "O") {
        Write-Host " [1] Affichage de l'état actuel des règles du pare-feu" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host " [2] Création d'une règle pour ouvrir port TCP" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host " [3] Création d'une règle pour ouvrir port UDP" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host " [4] Suppression d'une règle" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host " [5] Réinitialiser le pare-feu" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host " [*] Revenir au menu précédent" -ForegroundColor Yellow -BackgroundColor Black

        while ($true) {
            $ConfMessageFw = Read-Host "Faites votre choix parmi la sélection ci-dessus "
            switch ($ConfMessageFw) {
                # Affichage de l'état actuel du pare-feu
                1 {
                    Write-Host "Affichage de l'état actuel des règles du pare-feu" -ForegroundColor Yellow -BackgroundColor Black
                    Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-NetFirewallRule } -Credential $Credentials
                    Start-Sleep -Seconds 1
					Read-Host "Appuyez sur une touche pour continuer"
                }
                # Exécution de la commande d'ouverture de port TCP
                2 {
                    Write-Host "Ouverture d'un port TCP sur tout les profils" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    $OpenTCP = Read-Host "Indiquer le n° du port à ouvrir "
					$NomdeRegleTCP = Read-Host "Spécifier le nom de la règle "
					$commandfw= {
					param($DisplayName)	
					New-NetFirewallRule -DisplayName $DisplayName -Direction inbound -Profile Any -Action Allow -LocalPort $OpenTCP -Protocol TCP
					}
	                Write-Host "Ouverture du port TCP $OpenTCP" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    Invoke-Command -ComputerName $IpDistante -ScriptBlock $commandfw -ArgumentList $NomdeRegleTCP -Credential $Credentials
                    Write-Host "Port TCP $OpenTCP ouvert" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    Read-Host "Appuyez sur une touche pour continuer"
                }
			  	# Exécution de la commande d'ouverture de port UDP
				3 {
                    Write-Host "Ouverture d'un port UDP sur tout les profils" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    $OpenUDP = Read-Host "Indiquer le n° du port à ouvrir "
					$NomdeRegleUDP = Read-Host "Spécifier le nom de la règle "
					$commandfw= {
					param($DisplayName)	
					New-NetFirewallRule -DisplayName $DisplayName -Direction inbound -Profile Any -Action Allow -LocalPort $OpenUDP -Protocol UDP
					}
	                Write-Host "Ouverture du port UDP $OpenUDP" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    Invoke-Command -ComputerName $IpDistante -ScriptBlock $commandfw -ArgumentList $NomdeRegleUDP -Credential $Credentials
                    Write-Host "Port UDP $OpenUDP ouvert" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    Read-Host "Appuyez sur une touche pour continuer"
                }
				# Exécution de la commande de fermeture de port
                4 {
                    Write-Host "Suppression d'une règle"
                    Start-Sleep -Seconds 1
                    $RegleSuppr = Read-Host "Indiquer la règle à supprimer : "
					$commandfw = {
					param($RulesNames)
					Remove-NetFirewallRule -displayName $RulesNames}
                    Start-Sleep -Seconds 1
                    Invoke-Command -ComputerName $IpDistante -ScriptBlock $commandfw -ArgumentList $RegleSuppr -Credential $Credentials
                    Write-Host "$RegleSuppr règle supprimé"
                    Start-Sleep -Seconds 1
                    Read-Host "Appuyez sur une touche pour continuer"
                }	
                # Exécution de la commande de réinitialisation du pare-feu + Avertissement
                5 {
                    Write-Host "Réinitialisation du pare-feu" -ForegroundColor Yellow -BackgroundColor Black
                    Write-Host "ATTENTION : Cette commande peut compromettre la connexion à distance" -ForegroundColor Yellow -BackgroundColor Black
                    $ConfResetFw = Read-Host "Souhaitez-vous tout de même continuer ? [O pour valider] : "
                    # Si confirmation OK, exécution de la commande de réinitialisation du pare-feu
                    if ($ConfResetFw -eq "O") {
                        Start-Sleep -Seconds 1
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock { netsh advfirewall reset }  -Credential $Credentials
                        Write-Host "Le pare-feu a été réinitialisé" -ForegroundColor Yellow -BackgroundColor Black
                        Start-Sleep -Seconds 1
                        Read-Host "Appuyez sur une touche pour continuer"
                        return
                    }
                    # Si confirmation NOK, sortie de la fonction "Règles du pare-feu"
                    else {
                        Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                        Start-Sleep -Seconds 2
                    }
                }
                # Si autre/mauvais choix, sortie de la fonction "Règles du pare-feu"
                default {
                    Write-Host "Mauvais choix - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 2
                    return
                }
            }
        }
    }
}
# Fonction "Création Dossier"
function CreateDirectory {
    # Demande de confirmation
    $ConfCreateDirectory = Read-Host "Confirmez-vous la création d'un dossier ? [O pour valider] "
    # Si confirmation OK, exécution de la commande "Création Dossier"
    if ($ConfCreateDirectory -eq "O") {
        # Demande du nom du dossier à créer        
        $NameDirectory = Read-Host "Quel est le nom du dossier à créer ? "
        # Si aucun nom rentré, sortie de la fonction "Création Dossier"
        if ([string]::IsNullOrEmpty($NameDirectory)) {
            Write-Host "Vous n'avez pas indiqué de nom de dossier, retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return
        }			
        # Demande du chemin de destination du dossier à créer
        [String]$PathDirectory = Read-Host "Quel est le chemin de destination de votre dossier (Pensez à mettre les séparateurs '\' ) " 
        # Si le chemin n'est pas spécifié, utilisation du chemin courant
        if ([string]::IsNullOrEmpty($PathDirectory)) 
        {
		$PathDirectory = ".\"
        Write-Host "Pas de chemin indiqué, le dossier sera créée dans le répertoire Documents" -ForegroundColor Yellow -BackgroundColor Black
        }
	# Vérification de l'existence du dossier sur l'ordinateur distant
		$CMDTestPath = {
		param($Path)	
		Test-Path -Path $Path
		}
    # Création d'une variable contenant chemin + nom de dossier
        $Directory = $PathDirectory + $NameDirectory
		$TestPath = Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDTestPath -ArgumentList $Directory -Credential $Credentials
		if ($TestPath -eq "True") 
		{
		Write-Host "Le dossier existe déjà à l'emplacement spécifié." -ForegroundColor Cyan -BackgroundColor Black
		Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
		Start-Sleep -Seconds 2
		return
		}
		else 
    # Création du dossier sur l'ordinateur distant
		{
        $CMDCreate = {
        param($Folder)
        New-Item -ItemType Directory -Path $Folder
        }
		Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDCreate -ArgumentList $Directory -Credential $Credentials
		
		Write-Host "Le dossier $NameDirectory a été créé à l'emplacement $PathDirectory sur le poste." -ForegroundColor Yellow -BackgroundColor Black
		Start-Sleep -Seconds 1
        Read-Host "Appuyez sur une touche pour continuer"
        }
    }
    # Si confirmation NOK, sortie de la fonction "Création Dossier"
    else {
        Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 2
        return
    }
}

# Fonction "Suppression Dossier"
function RemoveDirectory {
    # Demande de confirmation
    $ConfRemoveDirectory = Read-Host "Confirmez-vous la suppression d'un dossier ? [O pour valider] "
    # Si confirmation OK, exécution de la commande "Suppression Dossier"
    if ($ConfRemoveDirectory -eq "O") {
        # Demande du nom du dossier à supprimer        
        $NameDirectory2 = Read-Host "Indiquez le chemin du dossier à supprimer"
        # Si aucun nom rentré, sortie de la fonction "Suppression Dossier"
        if ([string]::IsNullOrEmpty($NameDirectory2)) {
            Write-Host "Vous n'avez pas indiqué de dossier, retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return       
        }	
    # Vérification de l'existence du dossier à supprimer
        $CMDTestPath = {
            param($Path)	
            Test-Path -Path $Path
            }

        $TestPathDirectory2 = Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDTestPath -ArgumentList $NameDirectory2 -Credential $Credentials
    # Si le dossier ,'existe pas, retour au menu précédent
        if ($TestPathDirectory2 -eq $False)
        {
            Write-Host "Le dossier n'existe pas, retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return   
        }

		else 
    # Suppression du dossier
		{
        $CMDRemoval = {
        param($Folder)
        Remove-Item -Path $Folder
        }
		Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDRemoval -ArgumentList $NameDirectory2 -Credential $Credentials
		
		Write-Host "Le dossier $NameDirectory2 a été supprimé" -ForegroundColor Yellow -BackgroundColor Black
		Start-Sleep -Seconds 1
        Read-Host "Appuyez sur une touche pour continuer"
        }
    }
    # Si confirmation NOK, sortie de la fonction "Suppression Dossier"
    else {
        Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 2
        return
    }
}

function Applications 
{
    While ($True)
    {
    Write-Host " [1] Installation d'applications" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [2] Désinstallation d'applications" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [3] Rechercher une application sur ChocolaTey" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [4] Liste des applications installées sur le poste" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [5] Liste des mises à jour disponibles des applications sur le poste" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [6] MàJ d'une application" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [7] MàJ de toutes les applications" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [*] Revenir au menu précédent" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host ""
    Write-Host "ATTENTION : L'installation de ChocolaTey sur le poste est obligatoire avant toute installation/désinstallation" -ForegroundColor Yellow -BackgroundColor Black
    $ChoiceAppMenu = Read-Host "Faites votre choix parmi la selection ci-dessus "

    switch ($ChoiceAppMenu)
    {
        1
        {
        $ConfAppInstall = Read-Host "Souhaitez-vous installer une application ? [O Pour valider]"
        
        If ($ConfAppInstall -eq "O")
        {
            $AppInstall = Read-Host "Indiquer le nom de l'application"
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppInstall) choco install $AppInstall -y --force } -ArgumentList $AppInstall
            Start-Sleep -Seconds 1
            Read-Host "Appuyez sur une touche pour continuer"
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        }
        }

        2
        {
        $ConfAppUnInstall = Read-Host "Souhaitez-vous désinstaller une application ? [O Pour valider]"
    
        If ($ConfAppUnInstall -eq "O")
        {
            $AppUnInstall = Read-Host "Indiquer le nom de l'application"
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppUnInstall) choco uninstall $AppUnInstall -y --force} -ArgumentList $AppUnInstall
            Start-Sleep -Seconds 1
            Read-Host "Appuyez sur une touche pour continuer"
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        }    

        }
        
        3
        {
            $ConfSearchAppChoco = Read-Host "Souhaitez-vous rechercher une application sur ChocolaTey ? [O Pour valider]"
            
        If ($ConfSearchAppChoco -eq "O")
        {
            $AppSearchChoco = Read-Host "Indiquer le nom de l'application à rechercher sur ChocolaTey"
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppSearchChoco) choco search --by-id-only $AppSearchChoco } -ArgumentList $AppSearchChoco
            Start-Sleep -Seconds 1
            Read-Host "Appuyez sur une touche pour continuer"
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        } 

        }

        4
        {
            $ConfSearchAppPC = Read-Host "Souhaitez-vous obtenir la liste des applications sur le poste ? [O Pour valider]"
            
        If ($ConfSearchAppPC -eq "O")
        {
            Write-Host "Voici la liste des applications installées sur le poste : "
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { choco list }
            Start-Sleep -Seconds 1
            Read-Host "Appuyez sur une touche pour continuer"
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            Read-Host "Appuyez sur une touche pour continuer"
            return 
        } 

        }

        5
        {
            $ConfSearchMajAppPC = Read-Host "Souhaitez-vous obtenir la liste des mises à jour disponibles des applications sur le poste ? [O Pour valider]"
            
        If ($ConfSearchMajAppPC -eq "O")
        {
            Write-Host "Voici la liste des mises à jour disponibles des applications sur le poste : "
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {choco outdated}
            Start-Sleep -Seconds 1
            Read-Host "Appuyez sur une touche pour continuer"
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        } 

        }

        6
        {
            $ConfMajApp = Read-Host "Souhaitez-vous mettre à jour une application ? [O Pour valider] "
            
        If ($ConfMajApp -eq "O")
        {
            $AppMaj = Read-Host "Indiquer le nom de l'application à mettre à jour"
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppMaj) choco upgrade $AppMaj -y } -ArgumentList $AppMaj
            Start-Sleep -Seconds 1
            Read-Host "Appuyez sur une touche pour continuer"
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        }

        }

        7
        {
            $ConfMajAppAll = Read-Host "Souhaitez-vous mettre à jour toutes les applications ? [O Pour valider] "
            
        If ($ConfMajAppAll -eq "O")
        {
            Write-Host "Toutes les applications du poste vont être mises à jour: " -ForegroundColor Yellow -BackgroundColor Black
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {choco upgrade all -y}
            Start-Sleep -Seconds 1
            Read-Host "Appuyez sur une touche pour continuer"
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        }

        }

        default
        {
            Write-Host "Mauvais choix - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return
        }

        }
    }
}

function RemoteControl
{
	Write-Host "ATTENTION : Cette commande vous sortira momentanément du script" -ForegroundColor Yellow -BackgroundColor Black
	$ConfRemote = Read-Host "Confirmez-vous ? [O pour valider]" 

    If ($ConfRemote -eq "O")
    {
        While ($True)
        {
            Write-Host "[1] Contrôle par interface graphique (GUI)" -ForegroundColor Yellow -BackgroundColor Black
            Write-Host "[2] Contrôle par le terminal PowerShell" -ForegroundColor Yellow -BackgroundColor Black
            Write-Host "[*] Retour au menu précédent" -ForegroundColor Yellow -BackgroundColor Black
            Write-Host ""
            $ChoiceRemote = Read-Host "Faire un choix parmi la sélection ci-dessus"

            switch ($ChoiceRemote)
            
            {
                1
                { 
                    Write-Host "Contrôle par interface graphique (GUI)" -ForegroundColor Yellow -BackgroundColor Black
                    mstsc -v $IpDistante
                    Start-Sleep -Seconds 1
                    Read-Host "Appuyez sur une touche pour continuer"
                    return
                }

                2
                {
                    Write-Host "Contrôle par le terminal PowerShell" -ForegroundColor Yellow -BackgroundColor Black
                    Enter-PSSession -ComputerName $IpDistante -Credential $Credentials
                    return
                }

                Default 
                {
                    Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 2
                    return
                }
            }
        }
    }   
    else
    {
        Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 2
        return 
    }
}

function RemoteScript
{
    $ConfRS = Read-Host "Confirmez-vous l'éxécution d'un script sur le poste distant ? [O pour valider ]"
    if ($ConfRS -eq "O")
    {
        $NameScript = Read-Host "Quel est le nom du script (Sans l'extension) ?"
		$PathScript = Read-Host "Quel est le chemin du script ?"
        $PathNameScript = "$PathScript\$NameScript.ps1"
        $TestPathNameScript = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($PathNameScript) Test-Path -Path $PathNameScript} -ArgumentList $PathNameScript
        if ($TestPathNameScript -eq $True)
        {
            Write-Host "Le script $NameScript existe" -ForegroundColor Yellow -BackgroundColor Black
            Write-Host "Le script $NameScript va être éxécuté" -ForegroundColor Yellow -BackgroundColor Black
            Start-Sleep -Seconds 1
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Set-ExecutionPolicy RemoteSigned -Scope CurrentUser  }
            Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($PathNameScript) & $PathNameScript } -ArgumentList $PathNameScript
        }  
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        } 
    }
}

############## FIN FONCTION ######################

####################################################
######## Fonction Information Utilisateur ###########
####################################################

############## DEBUT FONCTION ######################

# Fonction dernière connexion
function InfoConnexion { 
    # Demande quel utilisateur?
    $userInf = Read-Host "Quel compte utilisateur souhaitez-vous vérifier?"
    $PathInfoUser = "C:\Users\Administrator\Documents\Info_${UserInf}_$(Get-Date -Format "yyyyMMdd").txt"    
    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserInf } -Credential $Credentials 
    if ($userExists) {
        # Si oui -> affichage date de dernière connexion
        Write-Host "Date de dernière connexion de l'utilisateur $userInf."
        $CmdInfoCo = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-WinEvent -FilterHashtable @{
                LogName = 'Security'
                ID      = 4624
            } | Where-Object { $_.Properties[5].Value -eq $using:userInf } | Select-Object -ExpandProperty TimeCreated -First 1  } -Credential $Credentials 
        $CmdInfoCo
        Start-Sleep -Seconds 2
        # Enregistrement des données
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoUser
        "Date de dernière connexion de l'utilisateur $userInf : " | Out-File -Append -FilePath $PathInfoUser
        $CmdInfoCo | Out-File -Append -FilePath $PathInfoUser    
        Read-Host "Appuyez sur Entrée pour continuer ..."

    }
    else {
        # Si non, sortie du script
        Write-Host "Le compte utilisateur n'existe pas." -ForegroundColor Red
    }
}

# Fonction dernière modification mot de passe
function InfoModificationMdp { 
    # Demande quel utilisateur?
    Write-Host "Date de dernière modification du mdp"
    $userInf = Read-Host "Tapez le nom d'utilisateur souhaité "
    $PathInfoUser = "C:\Users\Administrator\Documents\Info_${UserInf}_$(Get-Date -Format "yyyyMMdd").txt"    
    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserInf } -Credential $Credentials 
    if ($userExists) {
        # Si oui -> affichage date de dernière connexion
        $CmdInfoMdp = Write-Host "Date de dernière modification du mot de passe l'utilisateur $userInf."
        Invoke-Command -ComputerName $IpDistante -ScriptBlock { (Get-LocalUser -Name $using:userInf).PasswordLastSet } -Credential $Credentials 
        $CmdInfoMdp
        Start-Sleep -Seconds 2
        # Enregistrement des données
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoUser
        "Date de dernière modification de mot de passe de l'utilisateur $userInf : " | Out-File -Append -FilePath $PathInfoUser
        $CmdInfoMdp | Out-File -Append -FilePath $PathInfoUser    
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        # Si non, sortie du script
        Write-Host "Le compte utilisateur n'existe pas." -ForegroundColor Red
    }
}

# Fonction dernière sessions ouvertesr
function InfoLogSession { 
    Clear-Host
    $InfLog = Read-Host "Voulez-vous voir les sessions actives sur le poste distant? [O pour valider]"
    $PathInfoUser = "C:\Users\Administrator\Documents\Info_${UserInf}_$(Get-Date -Format "yyyyMMdd").txt"    
    if ($Inflog -eq "O") {
        # Si oui -> affichage liste sessions ouvertes
        Write-Host "Session ouverte(s) sur le poste distant."
        Invoke-Command -ComputerName $IpDistante -ScriptBlock { (Get-WmiObject -class win32_ComputerSystem | select username).username } -Credential $Credentials 
        Start-Sleep -Seconds 2
    }
    else {
        # Si non, sortie du script
        Write-Host "Mauvais choix - Retour au menu précédent" -ForegroundColor Red
    }
}

# Fonction droit dossier
function droitsDossier 
{
    # Demande quel utilisateur
    Write-Host ""
    Write-Host "Visualisation des droits sur un dossier"
    Write-Host ""
    $User = Read-Host "Tapez le nom d'utilisateur souhaité "
    $PathInfoUser = "C:\Users\Administrator\Documents\Info_${User}_$(Get-Date -Format "yyyyMMdd").txt"

    # Vérifie si l'utilisateur existe sur le serveur distant
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock {param($UserName ) Get-LocalUser -Name $UserName  } -ArgumentList $User -Credential $Credentials
    if ( $userExists)
    {
        # si oui -> demande quel dossier à vérifier
        $Dossier = Read-Host "Sur quel dossier souhaitez-vous vérifier les droits ? (spécifiez le chemin du dossier)"
        $TestDossier = Invoke-Command -ComputerName $IpDistante -ScriptBlock {  param($Path) Test-Path -Path $Path} -ArgumentList $Dossier -Credential $Credentials
        # Vérifie si le dossier existe sur le serveur distant
        if ($TestDossier -eq $true) 
        {
            # affichage des droits et sauvegarde dans fichier
            $CmdInoFolder=Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($FolderPath) Get-Acl -Path $FolderPath } -ArgumentList $Dossier
            $CmdInoFolder
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoUser
            "Voici la liste des droits sur le dossier $Dossier  : " | Out-File -Append -FilePath $PathInfoUser
            $CmdInoFolder| Out-File -Append -FilePath $PathInfoUser
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        else
        {
            # si non -> sortie du script
            Write-Host "Le dossier $Dossier n'existe pas"
            Start-Sleep -Seconds 2
        }
    }
    else 
    {
        # si non -> sortie du script
        Write-Host "L'utilisateur $User n'existe pas"
        Start-Sleep -Seconds 2
    }
    Start-Sleep -Seconds 2
    Read-Host "Appuyez sur Entrée pour continuer ..."
}

# Fonction droit fichier
function droitsFichier {
    # Demande quel utilisateur
    Write-Host ""
    Write-Host "Visualisation des droits sur un fichier"
    Write-Host ""
    $UserInf = Read-Host "Tapez le nom d'utilisateur souhaité "
    $PathInfoUser = "C:\Users\Administrator\Documents\Info_${UserInf}_$(Get-Date -Format "yyyyMMdd").txt"    
    # Vérifie si l'utilisateur existe sur le serveur distant
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserInf } -Credential $Credentials 
    if ($userExists) {
        # si oui -> demande quel fichier à vérifier
        $Fichier = Read-Host "Sur quel fichier souhaitez-vous vérifier les droits ? (spécifiez le chemin du fichier)"

        # Vérifie si le fichier existe sur le serveur distant
        if ($Fichier) {
            # affichage des droits
            $CmdInoFile = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                param($FilePath)
                Get-Acl -Path $FilePath } -ArgumentList $Fichier
            $CmdInoFile
            # Enregistrement des données
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoUser
            "Voici les droits sur le fichier spécifié $Fichier : " | Out-File -Append -FilePath $PathInfoUser
            $CmdInoFile | Out-File -Append -FilePath $PathInfoUser
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        else {
            # si non -> sortie du script
            Write-Host "Le fichier $Fichier n'existe pas"
            Start-Sleep -Seconds 2
        }
    }
    else {
        # si non -> sortie du script
        Write-Host "L'utilisateur $UserInf n'existe pas"
        Start-Sleep -Seconds 2
    }
    Start-Sleep -Seconds 2
    Read-Host "Appuyez sur Entrée pour continuer ..."
}


############## FIN FONCTION ######################

####################################################
######## Fonction Information Ordinateur ############
####################################################

############## DEBUT FONCTION ######################

#Fonction pour avoir la version de l'os
function GetOS {
    Clear-Host
    $GetOSConf = Read-Host "Voulez-vous voir la version de l'OS du poste distant ? [O pour valider]"
    Clear-Host
    Write-Host "Voici la version de l'OS du poste distant : "
    Write-Host ""

    if ($GetOSConf -eq "O") {
        $GetOSCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {(systeminfo)[2,3]}
        $GetOSCMD
        Write-Host ""
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici la version de l'OS du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $GetOSCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
        return
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }
}

#Fonction pour avoir les cartes reseaux presente sur le poste.
function NbrCarte {
    Clear-Host
    $NbrCarteConf = Read-Host "Voulez-vous voir le nombre d'interfaces présentes sur le poste distant ? [O pour valider]"
    
    if ($NbrCarteConf -eq "O") {
        Clear-Host
        Write-Host "Voici la liste des interfaces présentes sur le poste distant : "
        
        #Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock { Get-NetAdapter }#| Where-Object { $_.Status -eq 'Up'  } a rajouter si on veux uniquement ceux qui sont actif 
        $NbrCarteCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock { ipconfig /all }
        $NbrCarteCMD
        Write-Host ""
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici la liste des interfaces présentes sur le poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $NbrCarteCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}

#Fonction pour demander l'address IP
function IPInterface {
    Clear-Host
    $IPInterfaceConf = Read-Host "Voulez-vous voir les adresses IP de chaque interface (IPv4 / IPv6) du poste distant ? [O pour valider]"
    
    if ($IPInterfaceConf -eq "O") {
        Clear-Host
        Write-Host "Voici les adresses IP de chaque interface (IPv4 / IPv6) du poste distant : "
        
        $IPInterfaceCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-NetIPAddress | Format-Table InterfaceAlias, AddressFamily, IPAddress }
        $IPInterfaceCMD
        Write-Host ""    
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici les adresses IP de chaque interface (IPv4 / IPv6) du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $IPInterfaceCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}

#Fonction pour avoir les addresses MAC
function MACDemande {
    Clear-Host
    $MACDemandeConf = Read-Host "Voulez-vous voir la liste des adresses MAC de chaque interface du poste distant ? [O pour valider]"

    if ($MACDemandeConf -eq "O") {
        clear-Host
        Write-Host "Voici la liste des adresses MAC de chaque interface du poste distant : "
        $MACDemande = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-NetAdapter | Format-Table Name, MacAddress, Status} 
        $MACDemande
        Write-Host ""
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici la liste des adresses MAC de chaque interface du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $IPInterfaceCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}

#Fonction pour avoir la liste des application et paquet installer sur le poste
function ApplicationList {
    clear-host
    $ApplicationListConf = Read-Host "Voulez-vous la liste des applications/paquets installés sur le poste distant ? [O pour valider]"

    if ($ApplicationListConf -eq "O") {
        clear-host
        Write-Host "Voici la liste des applications/paquets installés sur le poste distant : "
        $ApplicationListCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {
            $INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion
            $INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion
            $INSTALLED | sort-object -Property DisplayName -Unique | Format-Table -AutoSize }
            $ApplicationListCMD
        Write-Host ""
        Start-Sleep -Seconds 1

        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici la liste des applications/paquets installés sur le poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $ApplicationListCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

# Fonction liste des utilisateurs locaux
function UserList {
    clear-host
    $UserListConf = read-host "Voulez-vous voir la liste des utilisateurs locaux du poste distant ? [O pour valider]"

    if ($UserListConf -eq "O") {
        clear-host
        $UserListCMD = Write-Host "Voici la liste des utilisateurs locaux du poste distant : "
        Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-LocalUser | Format-Table Name}
        $UserListCMD
        Write-Host ""
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici la liste des utilisateurs locaux du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $UserListCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction Type de CPU, nombre de coeurs, etc
function GetCPU {
    clear-host
    $GetCPUConf = Read-Host "Voulez-vous voir les détails du CPU du poste distant ? [O pour valider]"

    if ($GetCPUConf -eq "O") {
        clear-host
        Write-Host "Voici les détails du CPU du poste distant : "
        $GetCPUCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-WmiObject -Class Win32_Processor | Format-Table Name, NumberOfCores}
        $GetCPUCMD
        Write-Host ""
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici les détails du CPU du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $GetCPUCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction detail de la ram
function RAMInfo {
    clear-host
    $RAMInfoConf = Read-Host "Voulez-vous voir les détails de la RAM du poste distant ? [O pour valider]"

    if ($RAMInfoConf -eq "O") {
        clear-host
        Write-Host "Voici les détails de la RAM du poste distant : "
        $RAMInfoCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {(systeminfo)[24,25]}
        $RAMInfoCMD
        Write-Host ""
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici les détails de la RAM du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $RAMInfoCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction utilisation du disque
function DiskInfo {
    clear-host
    $DiskInfoConf = Read-Host "Voulez-vous voir les détails du/des disques du poste distant ? [O pour valider]"

    if ($DiskInfoConf -eq "O") {
        clear-host
        Write-Host "Voici les détails du/des disques du poste distant : "
        $DiskInfoCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {get-wmiObject Win32_LogicalDisk | Format-Table DeviceID,Size, Freespace}
        $DiskInfoCMD
        Write-Host ""
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici les détails du/des disques du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $DiskInfoCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Foncion utilisation du processeur
function ProcesseurInfo {
    clear-host
    $ProcesseurInfoConf = Read-Host "Voulez-vous voir les détails de l'utilisation du processeur du poste distant ? [O pour valider]"

    if ($ProcesseurInfoConf -eq "O") {
        clear-host
        Write-Host "Voici les details de l'utilisation du processeur du poste distant : "
        $ProcesseurInfoCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-Counter "\Processeur(_Total)\% temps processeur"}
        $ProcesseurInfoCMD
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici les details de l'utilisation du processeur du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $ProcesseurInfoCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction status du parefeu
function StatutParefeu {
    clear-host
    $StatutParefeuConf = Read-Host "Voulez-vous voir le statut du pare-feu du poste distant ? [O pour valider]"
    if ($StatutParefeuConf -eq "O") {
        clear-host
        Write-Host "Voici le statut du pare-feu du poste distant : "
        $StatutPareFeuCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-NetFirewallProfile | Format-Table Name, Enabled}
        $StatutPareFeuCMD
        Write-Host ""
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici le statut du pare-feu du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $StatutPareFeuCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Status des ports
function StatutPort {
    clear-host
    $StatutPortConf = Read-Host "Voulez-vous voir la liste des ports ouverts du poste distant ? [O pour valider]"
    if ($StatutPortConf -eq "O") {
        clear-host
        Write-Host "Voici la liste des ports ouverts du poste distant : "
        $StatutPortCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-NetTCPConnection | Select-Object LocalPort, State | Sort-Object LocalPort -Descending | Format-Table -AutoSize }
        $StatutPortCMD
        Write-Host ""
        Start-Sleep -Seconds 1
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
        "Voici la liste des ports ouverts du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
        $StatutPortCMD | Out-File -Append -FilePath $PathInfoPoste
        Write-Host ""
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

############## FIN FONCTION ######################


####################################################
################ Début script  #####################
####################################################

#Demande d'infos sur le Poste Distante
clear-Host
Write-Host "=================================================="
Write-Host        "Initialisation script pour connexion"
Write-Host "=================================================="
Write-Host ""
# Demande d'identification
$NomDistant = Read-Host "Veuillez entrer le nom d'utilisateur du Poste Distante "
$IpDistante = Read-Host "Veuillez entrer l'adresse IP du Poste Distante "
$Credentials = Get-Credential -Credential $NomDistant
$Operateur = Read-Host "Veuillez vous identifiez "

$PathInfoPoste="C:\Users\Administrator\Documents\Info_${IPDistante}_$(Get-Date -Format "yyyyMMdd").txt"
# Début enregistrement evennement
$(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-********StartScript********" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log

Menu_Principal   

# Fin enregistrement evennement
$(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-********EndScript********" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
# Fin de script
exit 0

####################################################
################ Fin script  #######################
####################################################
