###############################################################################################################################################################################################################
################################################################################################################################################################################################################
# Script Powershell pour maintenance et information sur Poste Distant Windows
# Version 0.9
# Réalisé en collaboration par Anais Lenglet, Bruno Serna, Grégory Dubois, Patrick Baggiolini et Thomas Scotti
# Dernière mise à jour le  1 / 04 / 2024
# Historique version
# V0.9 -- 19 / 04 / 2024 mise à jour fonction ACTION ET INFO et ajout Try/Catch
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
        Write-Host "[*] Arrêter le script "
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
            "*" 
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
        Write-Host "[*] Retour au menu principal"
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
            "*" 
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
        Write-Host "[*] Retour au menu principal"
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
            "*" 
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
        Write-Host "[*] Retour au menu principal"
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
            "*" 
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
    # Effacer l'écran
    Clear-Host
# Affichage Menu Action
    Write-Host "==============================================" -ForegroundColor DarkYellow
    Write-Host '             ACTION POSTE DISTANT             ' -ForegroundColor DarkYellow
    Write-Host "==============================================" -ForegroundColor DarkYellow
    Write-Host "" -ForegroundColor DarkYellow
    Write-Host "Machine distante : $NomDistant@$IpDistante" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "" -ForegroundColor DarkYellow
    Write-Host "[1]  Arrêt" -ForegroundColor DarkYellow
    Write-Host "[2]  Redémarrage" -ForegroundColor DarkYellow
    Write-Host "[3]  Vérouillage" -ForegroundColor DarkYellow
    Write-Host "[4]  MàJ du système" -ForegroundColor DarkYellow
    Write-Host "[5]  Création de repertoire" -ForegroundColor DarkYellow
    Write-Host "[6]  Suppression de repertoire" -ForegroundColor DarkYellow
    Write-Host "[7]  Prise de main à distance" -ForegroundColor DarkYellow
    Write-Host "[8]  Activation du pare-feu" -ForegroundColor DarkYellow
    Write-Host "[9]  Désactivation du pare-feu" -ForegroundColor DarkYellow
    Write-Host "[10] Règles du pare-feu" -ForegroundColor DarkYellow
    Write-Host "[11] Gestion des applications" -ForegroundColor DarkYellow
    Write-Host "[12] Exécution d'un script sur le poste distant" -ForegroundColor DarkYellow
    Write-Host ""
    Write-Host "[0] Retour au menu précédent" -ForegroundColor DarkYellow
    Write-Host "[*] Retour au menu principal"  -ForegroundColor DarkYellow
    Write-Host ""
    $ChoiceActionComputer = Read-Host "Faites votre choix parmi la sélection ci-dessus "
    Write-Host ""
    switch ($ChoiceActionComputer)
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
            "*" 
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
        Write-Host "[*] Retour au menu principal"
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
            "*" 
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
        Write-Host "[*] Retour au menu principal"
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
            "*" 
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

#
# Fonction Création de compte utilisateur local
function CreateUser 
{
    #Création d'un compte utilisateur local 
    # Demande quel utilisateur à créer
    $newUser = Read-Host "Quel compte utilisateur souhaitez-vous créer?"

    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:newUser } -Credential $Credentials
    if ($userExists) 
    {
        # Si oui -> sortie du script
        Write-Host "L'utilisateur existe déjà." -ForegroundColor Red
        Start-Sleep -Seconds 2
        Read-Host "Appuyer sur Entrée pour continuer ..."
    }
    else 
    {
        Write-Host "Le compte $newUser n'existe pas et va être créé."
        $Mdp = Read-Host "Taper le mot de passe"
        try 
        {
            # Création de l'utilisateur
            Invoke-Command -ComputerName $IpDistante -ScriptBlock { New-LocalUser -Name $using:newUser -Password (ConvertTo-SecureString -AsPlainText $using:Mdp -Force) } -Credential $Credentials
            # Confirmation de la création
            Write-Host "Compte $newUser créé." -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
}


# Fonction Suppression de compte utilisateur local
function DelUser 
{
    # Demande quel compte utilisateur à supprimer
    $userDel = Read-Host "Quel compte utilisateur souhaitez-vous supprimer ?"

    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserDel } -Credential $Credentials
    if ($userExists)
    {
        # Si il exsite -> demande de confirmation
        $confirmation = Read-Host "Voulez-vous vraiment supprimer le compte $userDel ? (Oui/Non)"
        # Si oui -> suppression du compte
        if ($confirmation -eq "Oui") 
        {
            try 
            {   
                Invoke-Command -ComputerName $IpDistante -ScriptBlock { Remove-LocalUser -Name $using:UserDel } -Credential $Credentials
                Write-Host "Le compte $userDel est supprimé." -ForegroundColor Green
                Start-Sleep -Seconds 2
            }
            catch 
            {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
        else 
        {
            # Si non -> sortie du script
            Write-Host "Suppression annulée." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
    else 
    {
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
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserLock } -Credential $Credentials
    if ($userExists) 
    {
        # Si l'utilisateur existe -> demande de confirmation
        $confirmation = Read-Host "Voulez-vous vraiment désactiver le compte $userLock ? (Oui/Non)"
        # Si oui -> désactivation du compte
        if ($confirmation -eq "Oui") 
        {
            try 
            {     
                Invoke-Command -ComputerName $IpDistante -ScriptBlock { Disable-LocalUser -Name $using:UserLock } -Credential $Credentials
                Write-Host "L'utilisateur $userLock est désactivé." -ForegroundColor Green
                Start-Sleep -Seconds 2
            }
            catch 
            {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
        else
        {
            # Si non -> sortie du script
            Write-Host "Désactivation annulée." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
    else 
    {
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
    $userExist = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserMdp } -Credential $Credentials
    if ($userExist) 
    {
        # Si oui -> demander de taper le nouveau mdp
        $newMdp = Read-Host "Entrer le nouveu mot de passe :"
        try 
        {
            Invoke-Command -ComputerName $IpDistante -ScriptBlock { Set-LocalUser -Name $using:userMdp -Password (ConvertTo-SecureString -AsPlainText $using:newMdp -Force) } -Credential $Credentials
            Write-Host "Le mot de passe est bien modifié." -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else 
    {
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
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserAdm } -Credential $Credentials
    if ($userExists) 
    {  
        # Si l'utilisateur existe -> ajout au groupe Administrators
        try
        {
            Invoke-Command -ComputerName $IpDistante -ScriptBlock { Add-LocalGroupMember -Group Administrateurs -Member $using:userAdm } -Credential $Credentials
            Write-Host "Le compte $userAdm est ajouté au groupe Administrateurs." -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        catch  
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else
    {
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
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserAddG } -Credential $Credentials
    if ($userExists)
    {
        # Si l'utilisateur existe -> demande quel groupe?
        $choixAddGroup = Read-Host "À quel groupe souhaitez-vous ajouter l'utilisateur $userAddG?"
    
        $groupExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalGroup -Name $using:choixAddGroup } -Credential $Credentials
            
        if ($groupExists) 
        {
            Write-Host "Ajout du compte en cours..." -ForegroundColor Green
            Start-Sleep -Seconds 2
            try 
            {
                Invoke-Command -ComputerName $IpDistante -ScriptBlock { Add-LocalGroupMember -Group $using:choixAddGroup -Member $using:userAddG } -Credential $Credentials
                Write-Host "Le compte $userAddG est ajouté au groupe $choixAddGroup." -ForegroundColor Green
            }
            catch 
            {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
            # Affichage des utilisateurs du groupe pour vérification
            Write-Host "Vous trouverez ci-dessous la liste des utilisateurs du groupe $choixAddGroup ." -ForegroundColor Green
            Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalGroupMember -Group $using:choixAddGroup } -Credential $Credentials
            Start-Sleep -Seconds 2
        }
        else 
        {
            Write-Host "Le groupe n'existe pas." -ForegroundColor Red
        }
    }
    else 
    {
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
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserDel } -Credential $Credentials
    if ($userExists) 
    {
        # Si l'utilisateur existe -> demande quel groupe?
        $choixDelGroup = Read-Host "De quel groupe souhaitez-vous supprimer l'utilisateur $userDel?"
        
        $groupExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalGroup -Name $using:choixDelGroup } -Credential $Credentials
                
        if ($groupExists) 
        {
            # Si le groupe existe -> suppression de l'utilisateur du groupe
            Write-Host "Traitement en cours..." -ForegroundColor Green
            Start-Sleep -Seconds 2
            try 
            {
                Invoke-Command -ComputerName $IpDistante -ScriptBlock { Remove-LocalGroupMember -Group $using:choixDelGroup -Member $using:userDel } -Credential $Credentials
                Write-Host "Le compte $userDel est supprimé du groupe $choixDelGroup." -ForegroundColor Green
            }
            catch 
            {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
            # Affichage des utilisateurs du groupe pour vérification
            Write-Host "Vous trouverez ci-dessous la liste des utilisateurs du groupe $choixDelGroup ." -ForegroundColor Green
            Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalGroupMember -Group $using:choixDelGroup } -Credential $Credentials
            Start-Sleep -Seconds 2
        }       
        else 
        {
            Write-Host "Le groupe n'existe pas." -ForegroundColor Red
        }
    }
    else 
    {
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
	$ConfShutdown = Read-Host "Appuyez sur [O] pour confirmer l'arrêt du poste distant "
# Si confirmation OK, affichage du sous-menu de la fonction "Arrêt"
	If  ($ConfShutdown -eq "O") 
    {
        While ($true)
        {
            Clear-Host
            Write-Host "=================================================================" -ForegroundColor DarkYellow
            Write-Host '                               ARRÊT                             ' -ForegroundColor DarkYellow
            Write-Host "=================================================================" -ForegroundColor DarkYellow
            Write-Host ""
            Write-Host " [1] Arrêt instantané du poste distant" -ForegroundColor DarkYellow
            Write-Host " [2] Arrêt planifié du poste distant avec message d'avertissement" -ForegroundColor DarkYellow
            Write-Host " [3] Arrêt planifié de la machine sans message d'avertissement" -ForegroundColor DarkYellow
            Write-Host ""
            Write-Host " [0] Revenir au menu précédent" -ForegroundColor DarkYellow
            Write-Host ""
            $ConfMessage_S = Read-Host "Faites votre choix parmi la sélection ci-dessus "
            Write-Host ""
    # Demande de choix pour le sous-menu de la fonction "Arrêt"	
            switch ($ConfMessage_S)
            {
                "1"
                {
                    Write-Host "Arrêt instantané du poste distant en cours" -ForegroundColor DarkYellow
                    Write-Host ""
                    try 
                    {
                        Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { 
                            shutdown /s /f /t 0 
                            }
                    Write-Host "Commande d'arrêt instantané envoyée avec succès à $IpDistante"
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... " 
                    }
                    catch 
                    {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                    }
                }

                "2"
                {
                    Write-Host "Arrêt planifié du poste distant avec message d'avertissement en cours" -ForegroundColor DarkYellow
                    Write-Host ""
                    $Timer_S1 = Read-Host "Indiquer le compte à rebours (en secondes) "
                    Write-Host ""
                    $MessageTimer_S1 = Read-Host "Indiquer le message à envoyer au poste distant "
                    Write-Host ""
                        try 
                        {
                        Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                            param ($Timer_S1, $MessageTimer_S1)
                            shutdown /s /f /t $Timer_S1 /c "$MessageTimer_S1"
                            } -ArgumentList $Timer_S1, $MessageTimer_S1
                        Write-Host "Commande d'arrêt planifié avec message d'avertissement envoyée avec succès à $IpDistante"
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                        }
                        catch 
                        {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                        }
                }

                "3"
                {
                    Write-Host "Arrêt planifié du poste distant en cours" -ForegroundColor DarkYellow
                    Write-Host ""
                    $Timer_S2 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                    Write-Host ""
                        try {
                        Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                            param ($Timer_S2)
                            shutdown /s /f /t $Timer_S2
                            } -ArgumentList $Timer_S2
                        Write-Host "Commande d'arrêt planifié envoyée avec succès à $IpDistante"
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                        }
                        catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                        }
                }
                
                *
                {
                    Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    return 
                }
                default
                {
                    Write-Host "Mauvais choix - Veuillez recommencer" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 1
                }
            }
        
        }
    }   
    # Si confirmation NOK, sortie de la fonction "Arrêt"
    Else
    {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
    }
}


# Fonction "Redémarrage"
function Reboot
{
# Demande de confrmation
	$ConfReboot = Read-Host "Appuyez sur [O] pour confirmer le redémarrage du poste distant "
# Si confirmation OK, affichage du sous-menu de la fonction "Redémarrage"
	If  ($ConfReboot -eq "O") 
    {
        While ($true)
        {
            Clear-Host
            Write-Host "=======================================================================" -ForegroundColor DarkYellow
            Write-Host '                              REDEMARRAGE                              ' -ForegroundColor DarkYellow
            Write-Host "=======================================================================" -ForegroundColor DarkYellow
            Write-Host ""
            Write-Host " [1] Redémarrage instantané du poste distant" -ForegroundColor DarkYellow
            Write-Host " [2] Redémarrage planifié du poste distant avec message d'avertissement" -ForegroundColor DarkYellow
            Write-Host " [3] Redémarrage planifié du poste distant sans message d'avertissement" -ForegroundColor DarkYellow
            Write-Host ""
            Write-Host " [0] Revenir au menu précédent" -ForegroundColor DarkYellow
            Write-Host ""
            $ConfMessage_R = Read-Host "Faites votre choix parmi la sélection ci-dessus "
            Write-Host "" 
    # Demande de choix pour le sous-menu de la fonction "Redémarrage"	
            switch ($ConfMessage_R)
            {
                "1"
                {
                    Write-Host "Redémarrage instantané du poste distant en cours" -ForegroundColor DarkYellow
                    Write-Host ""
                        try {
                        Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                            shutdown /r /f /t 0
                            }
                        Write-Host "Commande de redémarrage du poste distant envoyée avec succès à $IpDistante" -ForegroundColor Green
                        Write-Host ""
                        }
                        catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                    }
                }

                "2"
                {
                    Write-Host "Redémarrage planifié du poste distant avec message d'avertissement en cours" -ForegroundColor DarkYellow
                    Write-Host ""
                    $Timer_R1 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                    Write-Host ""
                    $MessageTimer_R1 = Read-Host "Indiquer le message à envoyer au poste distant : "
                    Write-Host ""
                        try {
                        Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                            param ($Timer_R1, $MessageTimer_R1)
                            shutdown /r /f /t $Timer_R1 /c "$MessageTimer_R1"
                            } -ArgumentList $Timer_R1, $MessageTimer_R1
                        Write-Host "Commande de redémarrage du poste distant avec message d'avertissement envoyée avec succès à $IpDistante" -ForegroundColor Green
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                        }
                        catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                    }
                }

                "3"
                {
                    Write-Host "Redémarrage planifié du poste distant en cours" -ForegroundColor DarkYellow
                    Write-Host ""
                    $Timer_R2 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                    Write-Host ""
                        try {
                        Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                            param ($Timer_R2)
                            Start-Sleep -Seconds 1
                            shutdown /r /f /t $Timer_R2
                            } -ArgumentList $Timer_R2
                        Write-Host "Commande de redémarrage du poste distant envoyée avec succès à $IpDistante" -ForegroundColor Green
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                        }
                        catch {
                            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                            Write-Host ""
                            Read-Host "Appuyez sur Entrée pour continuer ... " 
                        }
                }
                
                *
                {
                    Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    return
                }
                default
                {
                    Write-Host "Mauvais choix - Veuillez recommencer" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 1
                }
            }
        }
    }
# Si confirmation NOK, sortie de la fonction "Redémarrage"
    Else
    {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
    }
}

function Lock
{
# Demande de confirmation
	$ConfLock = Read-Host "Appuyez sur [O] pour confirmer le vérouillage du poste distant "
    Write-Host ""
# Si confirmation OK, exécution de la commande "Vérouillage"
	If ($ConfLock -eq "O")
    {
		Write-Host "Session du poste distant en cours de vérouillage" -ForegroundColor DarkYellow
        Write-Host ""
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                    logoff console
                    }
                Write-Host "Commande de vérouillage de la session du poste distant envoyée avec succès à $IpDistante" -ForegroundColor Green
                Write-Host ""
                Read-Host "Appuyez sur Entrée pour continuer ... " 
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                Write-Host ""
                Read-Host "Appuyez sur Entrée pour continuer ... " 
            }
    }

# Si confirmation NOK, sortie de la fonction "Vérouillage"	
	Else {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
    }
}

# Fonction "Activation du pare-feu"
function FirewallOn
{
# Demande de confirmation + Avertissement
	Write-Host "ATTENTION : Cette commande peut impacter l'éxécution du script" -ForegroundColor DarkYellow
    Write-Host ""
	$ConfwWOn = Read-Host "Appuyez sur [O] pour confirmer l'activation du pare-feu du poste distant " 
    Write-Host ""
# Si confirmation OK, éxécution de la commande "Activation du pare-feu"	
	if ( $ConfwWOn -eq "O" )
    { 
    $Command ={Set-NetFirewallProfile -Enabled true ; Get-NetFirewallProfile | Format-Table Name, Enabled}
        try {
            invoke-Command -ComputerName $IpDistante -ScriptBlock $Command -Credential $Credentials
            Write-Host "Le pare-feu du poste distant a bien été activé" -ForegroundColor Green
            Start-Sleep -Seconds 1
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ... " 
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ... " 
        }
    }
# Si confirmation NOK, sortie de la fonction "Activation du pare-feu"
	else
    {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
	}
}

# Fonction "Désactivation du pare-feu"
function FirewallOff
{
# Demande de confirmation + Avertissement
	Write-Host "ATTENTION : Cette commande peut impacter l'éxécution du script" -ForegroundColor DarkYellow
    Write-Host ""
	$ConfwWOff = Read-Host "Appuyez sur [O] pour confirmer la désactivation du pare-feu du poste distant " 
    Write-Host ""
# Si confirmation OK, éxécution de la commande "Activation du pare-feu"	
	if ( $ConfwWOff -eq "O" )
    { 
    $Command ={Set-NetFirewallProfile -Enabled false ; Get-NetFirewallProfile | Format-Table Name, Enabled}
        try {
            invoke-Command -ComputerName $IpDistante -ScriptBlock $Command -Credential $Credentials
            Write-Host "Le pare-feu du poste distant a bien été désactivé" -ForegroundColor Green
            Start-Sleep -Seconds 1
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ... " 
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ... " 
        }
	}
# Si confirmation NOK, sortie de la fonction "Activation du pare-feu"
	else
    {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
	}
}


# Fonction "Règles du pare-feu"
function FirewallRules
{

    # Demande de confirmation + Avertissement concernant la sortie du script dès l'éxécution de cette fonction
    Write-Host "ATTENTION : Les commandes suivantes sont réservées à un public averti" -ForegroundColor DarkYellow
    Write-Host ""
    $ConfFwRules = Read-Host "Appuyez sur [O] pour confirmer l'accès à la modification des règles du pare-feu du poste distant "

    # Si confirmation OK, affichage du sous-menu de la fonction "Règles du pare-feu"
    if ($ConfFwRules -eq "O") {
        while ($true) {
        Clear-Host
        Write-Host "======================================================" -ForegroundColor DarkYellow
        Write-Host '                   REGLES PARE-FEU                    ' -ForegroundColor DarkYellow
        Write-Host "======================================================" -ForegroundColor DarkYellow
        Write-Host ""
        Write-Host " [1] Affichage de l'état actuel des règles du pare-feu" -ForegroundColor DarkYellow
        Write-Host " [2] Création d'une règle pour ouvrir port TCP" -ForegroundColor DarkYellow
        Write-Host " [3] Création d'une règle pour ouvrir port UDP" -ForegroundColor DarkYellow
        Write-Host " [4] Suppression d'une règle" -ForegroundColor DarkYellow
        Write-Host " [5] Réinitialiser le pare-feu" -ForegroundColor DarkYellow
        Write-Host ""
        Write-Host " [0] Revenir au menu précédent" -ForegroundColor DarkYellow
        Write-Host ""
            $ConfMessageFw = Read-Host "Faites votre choix parmi la sélection ci-dessus "
            Write-Host ""
            switch ($ConfMessageFw) {
                # Affichage de l'état actuel du pare-feu
                1 {
                    Write-Host "Affichage de l'état actuel des règles du pare-feu" -ForegroundColor DarkYellow
                    Write-Host ""
                    try {
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-NetFirewallRule } -Credential $Credentials
                        Start-Sleep -Seconds 1
                        Read-Host "Appuyez sur Entrée pour continuer ... "
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                    }
                }
                # Exécution de la commande d'ouverture de port TCP
                2 {
                    Write-Host "Ouverture d'un port TCP sur tous les profils" -ForegroundColor DarkYellow
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    $OpenTCP = Read-Host "Indiquer le n° du port à ouvrir "
                    Write-Host ""
					$NomdeRegleTCP = Read-Host "Spécifier le nom de la règle "
					$CommandFW= {
                        param($DisplayName)	
                        New-NetFirewallRule -DisplayName $DisplayName -Direction inbound -Profile Any -Action Allow -LocalPort $OpenTCP -Protocol TCP
                    }
                    Write-Host "Ouverture du port TCP $OpenTCP" -ForegroundColor DarkYellow
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    try {
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock $CommandFW -ArgumentList $NomdeRegleTCP -Credential $Credentials
                        Write-Host ""
                        Write-Host "Port TCP $OpenTCP ouvert" -ForegroundColor Green
                        Start-Sleep -Seconds 1
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... "
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                    }
                }
                # Exécution de la commande d'ouverture de port UDP
				3 {
                    Write-Host "Ouverture d'un port UDP sur tous les profils" -ForegroundColor DarkYellow
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    $OpenUDP = Read-Host "Indiquer le n° du port à ouvrir "
                    Write-Host ""
					$NomdeRegleUDP = Read-Host "Spécifier le nom de la règle "
					$CommandFW2= {
                        param($DisplayName)	
                        New-NetFirewallRule -DisplayName $DisplayName -Direction inbound -Profile Any -Action Allow -LocalPort $OpenUDP -Protocol UDP
					}
                    Write-Host "Ouverture du port UDP $OpenUDP" -ForegroundColor DarkYellow
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    try {
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock $CommandFW2 -ArgumentList $NomdeRegleUDP -Credential $Credentials
                        Write-Host ""
                        Write-Host "Port UDP $OpenUDP ouvert" -ForegroundColor Green
                        Start-Sleep -Seconds 1
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... "
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                    }
                }
				# Exécution de la commande de fermeture de port
                4 {
                    Write-Host "Suppression d'une règle"
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    $RegleSuppr = Read-Host "Indiquer la règle à supprimer : "
                    Write-Host ""
					$CommandFW3 = {
                        param($RulesNames)
                        Remove-NetFirewallRule -displayName $RulesNames
                    }
                    Write-Host "Suppression de la règle $RegleSuppr en cours" -ForegroundColor DarkYellow
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    try {
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock $CommandFW3 -ArgumentList $RegleSuppr -Credential $Credentials
                        Write-Host "Règle $RegleSuppr supprimée" -ForegroundColor Green
                        Start-Sleep -Seconds 1
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... "
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                    }
                }	
                # Exécution de la commande de réinitialisation du pare-feu + Avertissement
                5 {
                    Write-Host "Réinitialisation du pare-feu" -ForegroundColor DarkYellow
                    Write-Host ""
                    Write-Host "ATTENTION : Cette commande peut compromettre la connexion à distance" -ForegroundColor DarkYellow
                    Write-Host ""
                    $ConfResetFW = Read-Host "Appuyez sur [O] pour confirmer la réinitialisation du pare-feu du poste distant "
                    Write-Host ""
                    # Si confirmation OK, exécution de la commande de réinitialisation du pare-feu
                    if ($ConfResetFW -eq "O") {
                        Start-Sleep -Seconds 1
                        try {
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock { netsh advfirewall reset }  -Credential $Credentials
                        Write-Host "Le pare-feu a été réinitialisé" -ForegroundColor Green
                        Start-Sleep -Seconds 1
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... "
                        }
                        catch {
                            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                            Write-Host ""
                            Read-Host "Appuyez sur Entrée pour continuer ... " 
                        }
                    }
                    # Si confirmation NOK, sortie de la fonction "Règles du pare-feu"
                    else {
                        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
                        Start-Sleep -Seconds 1 
                    }
                }

                *
                {
                    Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    return
                }
                default
                {
                    Write-Host "Mauvais choix - Veuillez recommencer" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 1
                }
            }
        }
    }
    else {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
    }
}
# Fonction "Création Dossier"
function CreateDirectory {
    # Demande de confirmation
    $ConfCreateDirectory = Read-Host "Appuyez sur [O] pour confirmer la création d'un dossier sur le poste distant "
    Write-Host ""
    # Si confirmation OK, exécution de la commande "Création Dossier"
    if ($ConfCreateDirectory -eq "O") {
        # Demande du nom du dossier à créer        
        $NameDirectory = Read-Host "Indiquer le nom du dossier "
        Write-Host ""
        # Si aucun nom rentré, sortie de la fonction "Création Dossier"
        if ([string]::IsNullOrEmpty($NameDirectory)) {
            Write-Host "Vous n'avez pas indiqué de nom de dossier, retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 1
            return
        }			
        # Demande du chemin de destination du dossier à créer
        [String]$PathDirectory = Read-Host "Indiquer le chemin de destination de votre dossier (Pensez à mettre les séparateurs '\' ) " 
        Write-Host ""
        # Si le chemin n'est pas spécifié, utilisation du chemin courant
        if ([string]::IsNullOrEmpty($PathDirectory)) 
        {
		$PathDirectory = ".\"
        Write-Host "Pas de chemin indiqué, le dossier sera créée dans le répertoire Documents" -ForegroundColor DarkYellow
        Write-Host ""
        }
	# Vérification de l'existence du dossier sur l'ordinateur distant
		$CMDTestPath = {
		param($Path)	
		Test-Path -Path $Path
		}
    # Création d'une variable contenant chemin + nom de dossier
        $Directory = $PathDirectory + $NameDirectory
        try {
            $TestPath = Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDTestPath -ArgumentList $Directory -Credential $Credentials
        }
            catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ... " 
        }
        if ($TestPath -eq "True") 
		{
		Write-Host "Le dossier existe déjà à l'emplacement spécifié." -ForegroundColor Cyan -BackgroundColor Black
        Write-Host ""
		Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
		Start-Sleep -Seconds 1
		return
		}
		else 
    # Création du dossier sur l'ordinateur distant
		{
        $CMDCreate = {
        param($Folder)
        New-Item -ItemType Directory -Path $Folder
        }
            try {
                Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDCreate -ArgumentList $Directory -Credential $Credentials
                Write-Host "Le dossier $NameDirectory a été créé à l'emplacement $PathDirectory sur le poste." -ForegroundColor Green
                Write-Host ""
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur Entrée pour continuer ... "
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                Write-Host ""
                Read-Host "Appuyez sur Entrée pour continuer ... " 
            }
        }
    }
    # Si confirmation NOK, sortie de la fonction "Création Dossier"
    else {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
    }
}

# Fonction "Suppression Dossier"
function RemoveDirectory {
    # Demande de confirmation
    $ConfRemoveDirectory = Read-Host "Appuyez sur [O] pour confirmer la suppression d'un dossier sur le poste distant "
    Write-Host ""
    # Si confirmation OK, exécution de la commande "Suppression Dossier"
    if ($ConfRemoveDirectory -eq "O") {
        # Demande du nom du dossier à supprimer        
        $NameDirectory2 = Read-Host "Indiquez le chemin du dossier à supprimer "
        Write-Host ""
        # Si aucun nom rentré, sortie de la fonction "Suppression Dossier"
        if ([string]::IsNullOrEmpty($NameDirectory2)) {
            Write-Host "Vous n'avez pas indiqué de dossier, retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 1
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
            Start-Sleep -Seconds 1
            return   
        }

		else 
    # Suppression du dossier
		{
        $CMDRemoval = {
        param($Folder)
        Remove-Item -Path $Folder
        }
            try {
                Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDRemoval -ArgumentList $NameDirectory2 -Credential $Credentials
                Write-Host "Le dossier $NameDirectory2 a été supprimé" -ForegroundColor Green
                Write-Host ""
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur Entrée pour continuer ... "
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                Write-Host ""
                Read-Host "Appuyez sur Entrée pour continuer ... " 
            }
        }
    }
    # Si confirmation NOK, sortie de la fonction "Suppression Dossier"
    else {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
    }
}

function Applications 
{
    $ConfApplications = Read-Host "Appuyez sur [O] pour confirmer l'accès à la gestion des applications du poste distant "
    if ($ConfApplications -eq "O") {
        While ($True)
        {
        Clear-Host
        Write-Host "=====================================================================" -ForegroundColor DarkYellow
        Write-Host '                         GESTION APPLICATIONS                        ' -ForegroundColor DarkYellow
        Write-Host "=====================================================================" -ForegroundColor DarkYellow
        Write-Host ""
        Write-Host " [1] Installation d'applications" -ForegroundColor DarkYellow
        Write-Host " [2] Désinstallation d'applications" -ForegroundColor DarkYellow
        Write-Host " [3] Rechercher une application sur ChocolaTey" -ForegroundColor DarkYellow
        Write-Host " [4] Liste des applications installées sur le poste" -ForegroundColor DarkYellow
        Write-Host " [5] Liste des mises à jour disponibles des applications sur le poste" -ForegroundColor DarkYellow
        Write-Host " [6] MàJ d'une application" -ForegroundColor DarkYellow
        Write-Host " [7] MàJ de toutes les applications" -ForegroundColor DarkYellow
        Write-Host ""
        Write-Host " [0] Revenir au menu précédent" -ForegroundColor DarkYellow
        Write-Host ""
        Write-Host "ATTENTION : L'installation de ChocolaTey sur le poste distant est INDISPENSABLE" -ForegroundColor DarkYellow
        Write-Host ""
        $ChoiceAppMenu = Read-Host "Faites votre choix parmi la sélection ci-dessus "
        Write-Host ""

        switch ($ChoiceAppMenu)
        {
            1
            {
            $ConfAppInstall = Read-Host "Appuyez sur [O] pour confirmer l'installation d'une application sur le poste distant "
            Write-Host ""
            
            If ($ConfAppInstall -eq "O")
            {
                $AppInstall = Read-Host "Indiquer le nom de l'application "
                Write-Host ""
                try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppInstall) choco install $AppInstall -y --force } -ArgumentList $AppInstall
                    Start-Sleep -Seconds 1
                    Read-Host "Appuyez sur Entrée pour continuer ... "
                }
                catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... " 
                }
            }
            else 
            {
                Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1 
            }
            }

            2
            {
            $ConfAppUnInstall = Read-Host "Appuyez sur [O] pour confirmer la désinstallation d'une application sur le poste distant "
            Write-Host ""
        
            If ($ConfAppUnInstall -eq "O")
            {
                $AppUnInstall = Read-Host "Indiquer le nom de l'application "
                Write-Host ""
                try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppUnInstall) choco uninstall $AppUnInstall -y --force} -ArgumentList $AppUnInstall
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... "
                }
                catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... " 
                }
            }
            else 
            {
                Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1 
            }    

            }
            
            3
            {
                $ConfSearchAppChoco = Read-Host "Appuyez sur [O] pour confirmer la recherche d'une application sur ChocolaTey "
                Write-Host ""
                
            If ($ConfSearchAppChoco -eq "O")
            {
                $AppSearchChoco = Read-Host "Indiquer le nom de l'application à rechercher sur ChocolaTey "
                Write-Host ""
                try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppSearchChoco) choco search --by-id-only $AppSearchChoco } -ArgumentList $AppSearchChoco
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... "
                }
                catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... " 
                }
            }
            else 
            {
                Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1 
            } 

            }

            4
            {
                $ConfSearchAppPC = Read-Host "Appuyez sur [O] pour confirmer l'obtention de la liste des applications sur le poste distant "
                Write-Host ""
                
            If ($ConfSearchAppPC -eq "O")
            {
                Write-Host "Voici la liste des applications installées sur le poste distant : "
                Write-Host ""
                try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { choco list }
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... "
                }
                catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... " 
                }
            }
            else 
            {
                Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1 
            } 

            }

            5
            {
                $ConfSearchMajAppPC = Read-Host "Appuyez sur [O] pour confirmer l'obtention de la liste des mises à jour disponibles des applications sur le poste distant ? [O Pour valider] "
                Write-Host ""
                
            If ($ConfSearchMajAppPC -eq "O")
            {
                Write-Host "Voici la liste des mises à jour disponibles des applications sur le poste distant : "
                Write-Host ""
                try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {choco outdated}
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... "
                }
                catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... " 
                }
            }
            else 
            {
                Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1 
            } 

            }

            6
            {
                $ConfMajApp = Read-Host "Appuyez sur [O] pour confirmer la mise à jour d'une application du poste distant "
                Write-Host ""
                
            If ($ConfMajApp -eq "O")
            {
                $AppMaj = Read-Host "Indiquer le nom de l'application à mettre à jour "
                Write-Host ""
                try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppMaj) choco upgrade $AppMaj -y } -ArgumentList $AppMaj
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... "
                }
                catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... " 
                }
            }
            else 
            {
                Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1  
            }

            }

            7
            {
                $ConfMajAppAll = Read-Host "Appuyez sur [O] pour confirmer la mise à jour de toutes les applications du poste distant "
                Write-Host ""
                
            If ($ConfMajAppAll -eq "O")
            {
                Write-Host "Toutes les applications du poste vont être mises à jour :" -ForegroundColor DarkYellow
                Write-Host ""
                try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {choco upgrade all -y}
                    Start-Sleep -Seconds 1
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... "
                }
                catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                    Write-Host ""
                    Read-Host "Appuyez sur Entrée pour continuer ... " 
                }
            }
            else 
            {
                Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1 
            }

            }

            *
            {
                Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1
                return
            }

            default
            {
                Write-Host "Mauvais choix - Veuillez recommencer" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1
            }

            }
        }
    }
    else {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
    }
}

function RemoteControl
{
	Write-Host "ATTENTION : Cette commande vous sortira du script" -ForegroundColor DarkYellow
    Write-Host ""
	$ConfRemote = Read-Host "Appuyez sur [O] pour confirmer la prise de main à distance sur le poste distant ? [O pour valider]" 

    If ($ConfRemote -eq "O")
    {
        While ($True)
        {
            Clear-Host
            Write-Host "==========================================" -ForegroundColor DarkYellow
            Write-Host '        PRISE DE MAIN A DISTANCE          ' -ForegroundColor DarkYellow
            Write-Host "==========================================" -ForegroundColor DarkYellow
            Write-Host ""
            Write-Host "[1] Contrôle par interface graphique (GUI)" -ForegroundColor DarkYellow
            Write-Host "[2] Contrôle par le terminal PowerShell" -ForegroundColor DarkYellow
            Write-Host ""
            Write-Host "[0] Retour au menu précédent" -ForegroundColor DarkYellow
            Write-Host ""
            $ChoiceRemote = Read-Host "Faites votre choix parmi la sélection ci-dessus "
            Write-Host ""

            switch ($ChoiceRemote)
            
            {
                1
                { 
                    Write-Host "Contrôle par interface graphique (GUI)" -ForegroundColor DarkYellow
                    mstsc -v $IpDistante
                    Start-Sleep -Seconds 1
                    Read-Host "Appuyez sur Entrée pour continuer ... "
                }

                2
                {
                    Write-Host "Contrôle par le terminal PowerShell" -ForegroundColor DarkYellow
                    try {
                        Enter-PSSession -ComputerName $IpDistante -Credential $Credentials
                        exit
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                        Write-Host ""
                        Read-Host "Appuyez sur Entrée pour continuer ... " 
                    }
                }

                *
                {
                    Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    return
                }
                
                default
                {
                    Write-Host "Mauvais choix - Veuillez recommencer" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 1 
                }
            }
        }
    }   
    else
    {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
    }
}

function RemoteScript
{
    $ConfRS = Read-Host "Appuyez sur [O] pour confirmer l'éxécution d'un script sur le poste distant "
    Write-Host ""
    if ($ConfRS -eq "O")
    {
        $NameScript = Read-Host "Indiquer le nom du script (Sans l'extension .ps1) "
        Write-Host ""
		$PathScript = Read-Host "Indiquer le chemin du script "
        Write-Host ""
        $PathNameScript = "$PathScript\$NameScript.ps1"
        try 
        {
        $TestPathNameScript = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($PathNameScript) Test-Path -Path $PathNameScript} -ArgumentList $PathNameScript
        if ($TestPathNameScript -eq $True)
        {
            Write-Host "Le script $NameScript existe" -ForegroundColor DarkYellow
            Write-Host ""
            Write-Host "Le script $NameScript va être éxécuté" -ForegroundColor DarkYellow
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Set-ExecutionPolicy RemoteSigned -Scope CurrentUser  }
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($PathNameScript) & $PathNameScript } -ArgumentList $PathNameScript
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                Write-Host ""
                Read-Host "Appuyez sur Entrée pour continuer ... " 
            }
        }
        }   
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ... " 
        }
        }
    else 
    {
        Write-Host "Opération annulée - Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1 
    } 
        
}

############## FIN FONCTION ######################

####################################################
######## Fonction Information Utilisateur ###########
####################################################

############## DEBUT FONCTION ######################

# Fonction dernière connexion
function InfoConnexion { 
    Clear-Host
    $InfoCo = Read-Host "Voulez-vous voir la date de dernière de connexion d'un utilsiateur ? [O pour valider]"
    if ($InfoCo -eq "O") 
    {
        Write-Host ""
        # si oui -> demande quel utilisateur ciblé
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
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
    }
    else 
    {
        # Si non, sortie du script
        Write-Host "Mauvais choix - Retour au menu précédent" -ForegroundColor Red
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
}

# Fonction dernière modification mot de passe
function InfoModificationMdp { 
    Clear-Host
    $InfoMdp = Read-Host "Voulez-vous voir la date de dernière modification du mot de passe d'un utilisateur ? [O pour valider]"
    if ($InfoMdp -eq "O") 
    {
        Write-Host ""
        # si oui -> demande quel utilisateur ciblé
        $userInf = Read-Host "Tapez le nom d'utilisateur souhaité "
        $PathInfoUser = "C:\Users\Administrator\Documents\Info_${UserInf}_$(Get-Date -Format "yyyyMMdd").txt"    
        # Vérification si l'utilisateur existe
        $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserInf } -Credential $Credentials 
        if ($userExists) {
            # Si oui -> affichage date de dernière connexion
            Write-Host "Date de dernière modification du mot de passe l'utilisateur $userInf."
            $CmdInfoMdp=Invoke-Command -ComputerName $IpDistante -ScriptBlock { (Get-LocalUser -Name $using:userInf).PasswordLastSet } -Credential $Credentials 
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
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
    }
    else 
    {
        # Si non, sortie du script
        Write-Host "Mauvais choix - Retour au menu précédent" -ForegroundColor Red
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
}

# Fonction dernière sessions ouvertesr
function InfoLogSession { 
    Clear-Host
    $InfLog = Read-Host "Voulez-vous voir les sessions actives sur le poste distant? [O pour valider]"
    if ($Inflog -eq "O") {
        Write-Host ""
        # Si oui -> affichage liste sessions ouvertes
        $userInf = Read-Host "Tapez le nom d'utilisateur souhaité "
        $PathInfoUser = "C:\Users\Administrator\Documents\Info_${UserInf}_$(Get-Date -Format "yyyyMMdd").txt"    
        Write-Host "Session ouverte(s) sur le poste distant."
        $CmdInfoSession=Invoke-Command -ComputerName $IpDistante -ScriptBlock { (Get-WmiObject -class win32_ComputerSystem | select username).username } -Credential $Credentials 
        $CmdInfoSession
        Start-Sleep -Seconds 2
        # Enregistrement des données
        Write-Host "Les données sont enregistrées dans le fichier" $PathInfoUser
        "Session ouverte(s) sur le poste distant pour l'utilisateur $userInf : " | Out-File -Append -FilePath $PathInfoUser
        $CmdInfoMdp | Out-File -Append -FilePath $PathInfoUser    
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    else 
    {
        # Si non, sortie du script
        Write-Host "Mauvais choix - Retour au menu précédent" -ForegroundColor Red
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
}

# Fonction droit dossier
function droitsDossier 
{
    Clear-Host
    $InfoDossier = Read-Host "Voulez-vous voir les droits sur un fichier d'un utilisateur ? [O pour valider]"
    if ($InfoDossier -eq "O") 
    {
        Write-Host ""
        # si oui -> affichage des droits sur le dossier
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
                $CmdInoFolder=Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($FolderPath) Get-Acl -Path $FolderPath | Format-Table -AutoSize} -ArgumentList $Dossier
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
                Read-Host "Appuyez sur Entrée pour continuer ..."
            }
        }
        else 
        {
            # si non -> sortie du script
            Write-Host "L'utilisateur $User n'existe pas"
            Start-Sleep -Seconds 2
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
    }
    else 
    {
        # Si non, sortie du script
        Write-Host "Mauvais choix - Retour au menu précédent" -ForegroundColor Red
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }
}

# Fonction droit fichier
function droitsFichier {
    Clear-Host
    $InfoFichier = Read-Host "Voulez-vous voir les droits sur un fichier d'un utilisateur ? [O pour valider]"
    if ($InfoFichier -eq "O") 
    {
        # si oui -> affichage des droits sur le fichier
        # Demande quel utilisateur
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
                $CmdInoFile = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {param($FilePath) Get-Acl -Path $FilePath | Format-Table -AutoSize} -ArgumentList $Fichier
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
                Read-Host "Appuyez sur Entrée pour continuer ..."
            }
        }
        else {
            # si non -> sortie du script
            Write-Host "L'utilisateur $UserInf n'existe pas"
            Start-Sleep -Seconds 2
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
    }
    else 
    {
        # Si non, sortie du script
        Write-Host "Mauvais choix - Retour au menu précédent" -ForegroundColor Red
        Read-Host "Appuyez sur Entrée pour continuer ..."
    }

}


############## FIN FONCTION ######################

####################################################
######## Fonction Information Ordinateur ############
####################################################

############## DEBUT FONCTION ######################

#Fonction pour avoir la version de l'os
function GetOS 
{
    Clear-Host
    $GetOSConf = Read-Host "Voulez-vous voir la version de l'OS du poste distant ? [O pour valider]"
    Write-Host ""
    Clear-Host
    Write-Host "Voici la version de l'OS du poste distant : "
    Write-Host ""

    if ($GetOSConf -eq "O") 
    {
        try 
        {
            $GetOSCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {(systeminfo)[2,3]}
            $GetOSCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            Write-Host ""
            "Voici la version de l'OS du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $GetOSCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
            #return
        }
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else 
    {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }
}

#Fonction pour avoir les cartes reseaux presente sur la machine.
function NbrCarte 
{
    Clear-Host
    $NbrCarteConf = Read-Host "Voulez-vous voir le nombre d'interfaces présentes sur le poste distant ? [O pour valider]"
    Write-Host ""
    
    if ($NbrCarteConf -eq "O") 
    {
        Clear-Host
        Write-Host "Voici la liste des interfaces présentes sur le poste distant : "
        Write-Host ""
        
        #Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock { Get-NetAdapter }#| Where-Object { $_.Status -eq 'Up'  } a rajouter si on veux uniquement ceux qui sont actif 
        try
        {
            $NbrCarteCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock { ipconfig /all }
            $NbrCarteCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            Write-Host ""
            "Voici la liste des interfaces présentes sur le poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $NbrCarteCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
        
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
            Write-Host ""
        }
    }
    else 
    {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}

#Fonction pour demander l'address IP
function IPInterface 
{
    Clear-Host
    $IPInterfaceConf = Read-Host "Voulez-vous voir les adresses IP de chaque interface (IPv4 / IPv6) du poste distant ? [O pour valider]"
    
    if ($IPInterfaceConf -eq "O") 
    {
        Clear-Host
        Write-Host "Voici les adresses IP de chaque interface (IPv4 / IPv6) du poste distant : "
        Write-Host ""
        
        try
        {
            $IPInterfaceCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-NetIPAddress | Format-Table InterfaceAlias, AddressFamily, IPAddress }
            $IPInterfaceCMD
            Write-Host ""    
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            Write-Host ""
            "Voici les adresses IP de chaque interface (IPv4 / IPv6) du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $IPInterfaceCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }    
    else 
    {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}


#Fonction pour avoir les addresses MAC
function MACDemande 
{
    Clear-Host
    $MACDemandeConf = Read-Host "Voulez-vous voir la liste des adresses MAC de chaque interface du poste distant ? [O pour valider]"

    if ($MACDemandeConf -eq "O") 
    {
        clear-Host
        Write-Host "Voici la liste des adresses MAC de chaque interface du poste distant : "
        try
        {
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
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else 
    {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}

#Fonction pour avoir la liste des application et paquet installer sur la machine
function ApplicationList 
{
    clear-host
    $ApplicationListConf = Read-Host "Voulez-vous la liste des applications/paquets installés sur le poste distant ? [O pour valider]"
    Write-Host ""

    if ($ApplicationListConf -eq "O") 
    {
        clear-host
        Write-Host "Voici la liste des applications/paquets installés sur le poste distant : "
        try
        {
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
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else 
    {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

# Fonction liste des utilisateurs locaux
function UserList 
{
    clear-host
    $UserListConf = read-host "Voulez-vous voir la liste des utilisateurs locaux du poste distant ? [O pour valider]"
    Write-Host ""

    if ($UserListConf -eq "O") 
    {
        clear-host
        $UserListCMD = Write-Host "Voici la liste des utilisateurs locaux du poste distant : "
        try
        {
            Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-LocalUser | Format-Table Name}
            $UserListCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            Write-Host ""
            "Voici la liste des utilisateurs locaux du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $UserListCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else 
    {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction Type de CPU, nombre de coeurs, etc
function GetCPU 
{
    clear-host
    $GetCPUConf = Read-Host "Voulez-vous voir les détails du CPU du poste distant ? [O pour valider]"

    if ($GetCPUConf -eq "O") 
    {
        clear-host
        Write-Host "Voici les détails du CPU du poste distant : "
        Write-Host ""
        try
        {
            $GetCPUCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-WmiObject -Class Win32_Processor | Format-Table Name, NumberOfCores}
            $GetCPUCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            Write-Host ""
            "Voici les détails du CPU du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $GetCPUCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else 
    {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction detail de la ram
function RAMInfo 
{
    clear-host
    $RAMInfoConf = Read-Host "Voulez-vous voir les détails de la RAM du poste distant ? [O pour valider]"

    if ($RAMInfoConf -eq "O") 
    {
        clear-host
        Write-Host "Voici les détails de la RAM du poste distant : "
        Write-Host ""
        try
        {
            $RAMInfoCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {(systeminfo)[24,25]}
            $RAMInfoCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            Write-Host ""
            "Voici les détails de la RAM du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $RAMInfoCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else 
    {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction utilisation du disque
function DiskInfo 
{
    clear-host
    $DiskInfoConf = Read-Host "Voulez-vous voir les détails du/des disques du poste distant ? [O pour valider]"

    if ($DiskInfoConf -eq "O") 
    {
        clear-host
        Write-Host "Voici les détails du/des disques du poste distant : "
        Write-Host ""
        try
        {   
            $DiskInfoCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {get-wmiObject Win32_LogicalDisk | Format-Table DeviceID,Size, Freespace}
            $DiskInfoCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            Write-Host ""
            "Voici les détails du/des disques du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $DiskInfoCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else 
    {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Foncion utilisation du processeur
function ProcesseurInfo {
    clear-host
    $ProcesseurInfoConf = Read-Host "Voulez-vous voir les détails de l'utilisation du processeur du poste distant ? [O pour valider]"
    Write-Host ""

    if ($ProcesseurInfoConf -eq "O") 
    {
        clear-host
        Write-Host "Voici les details de l'utilisation du processeur du poste distant : "
        try
        {       
            $ProcesseurInfoCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-Counter "\Processeur(_Total)\% temps processeur"}
            $ProcesseurInfoCMD
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici les details de l'utilisation du processeur du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $ProcesseurInfoCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else 
    {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction status du parefeu
function StatutParefeu 
{
    clear-host
    $StatutParefeuConf = Read-Host "Voulez-vous voir le statut du pare-feu du poste distant ? [O pour valider]"
    if ($StatutParefeuConf -eq "O") 
    {
        clear-host
        Write-Host "Voici le statut du pare-feu du poste distant : "
        Write-Host ""
        try
        {
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
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Status des ports
function StatutPort 
{
    clear-host
    $StatutPortConf = Read-Host "Voulez-vous voir la liste des ports ouverts du poste distant ? [O pour valider]"
    Write-Host ""
    if ($StatutPortConf -eq "O") 
    {
        clear-host
        Write-Host "Voici la liste des ports ouverts du poste distant : "
        try
        {       
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
        catch 
        {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Write-Host ""
            Read-Host "Appuyer sur Entrée pour continuer ..."
        } 
    }
    else 
    {
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
