###############################################################################################################################################################################################################
################################################################################################################################################################################################################
# Script Powershell pour maintenance et information sur Poste Distant Windows
# Version 0.5
# Réalisé en collaboration par Anais Lenglet, Bruno Serna, Grégory Dubois, Patrick Baggiolini et Thomas Scotti
# Dernière mise à jour le  16 / 04 / 2024
# Historique version
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
        Write-Host "Machine distante : $NomDistant@$IpDistante"
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
                exit 
            }
            Default 
        # Erreur de commande
            { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Choix incorrect" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Read-Host "Appuyez sur une touche pour continuer..."
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
        Write-Host "Machine distante : $NomDistant@$IpDistante"
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
                Read-Host "Appuyez sur une touche pour continuer..."
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
        Write-Host "Machine distante : $NomDistant@$IpDistante"
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
                Read-Host "Appuyez sur une touche pour continuer..."
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
        Write-Host "Machine distante : $NomDistant@$IpDistante"
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
                
            }
            "2" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de supprimer un compte utilisateur local"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Suppression de compte utilisateur chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log              
            }
            "3" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de désactiver un compte utilisateur local"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Désactivation de compte utilisateur choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log               
            }
            "4" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de modifier un mot de passe"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Changement de mot de passe choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log         
            }
            "5" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'ajouter un compte à un groupe d'administration"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Ajout d'un compte à un groupe d'administration choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log 
            }
            "6" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'ajouter un compte à un groupe local"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Ajout d'un compte à un groupe local choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log     
            }
            "7"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de retirer un compte d'un groupe local"
                Start-Sleep -Seconds 2
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Suppression d'un compte à un groupe local choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log     
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
                    Read-Host "Appuyez sur une touche pour continuer..."
                Start-Sleep -Seconds 2
            }
        }
    }
}

# Fonction pour afficher le menu Ordinateur
function Menu_Action_Poste
{
    While ($true) 
    {
    # Effacer l'écran1
        Clear-Host
    # Demande choix ACTION Poste / retour menu précédent / retour menu principal
        Write-Host "=================================="
        Write-Host "|           ACTION POSTE         | "
        Write-Host "=================================="
        Write-Host ""
        Write-Host "Machine distante : $NomDistant@$IpDistante"
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
        Write-Host "[11] Installation d'un logiciel"
        Write-Host "[12] Désinstallation d'un logiciel"
        Write-Host "[13] Exécution d'un script sur la machine distante"
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
            }
            "2" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de redémarrer le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Redémarrage poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2        
            }
            "3"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de vérouiller le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Vérouillage du poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2         
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
            }
            "6"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de supprimer un dossier"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Suppresision d'un dossier sur poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "7" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de prendre la main sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Prise en main sur poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "8" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'activer le pare-feu sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Activation du pare-feu du poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "9" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de désactiver le pare-feu sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Désactivation du pare-feu du poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "10" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de modifier les règles du pare-feu sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Modification de règle du pare-feu du poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "11" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'installer un logiciel sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Installation de logiciel sur le poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "12"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de désinstaller un logiciel sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Désinstallation de logiciel sur le poste choisit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "13" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi d'éxécuter un script sur le poste"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Exécution d'un script sur le poste distant" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
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
                    Read-Host "Appuyez sur une touche pour continuer..."
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
        Write-Host "Machine distante : $NomDistant@$IpDistante"
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
            }
            "2" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la date de la dernière modification du mot de passe de l'utilisateur"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Date dernière modificaiton mot de passe utilisateur chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "3" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des sessions utilisateurs ouvertes"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Liste des session utilisateurs ouvertes chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "4" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter les droits et permissions sur un dossier"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Droits/permission sur un dossier chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "5"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter les droits et permissions sur un fichier"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Droits/permission sur un fichier chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
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
                    Read-Host "Appuyez sur une touche pour continuer..."
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
        Write-Host "=================================="
        Write-Host "|        INFORMATION POSTE      | "
        Write-Host "=================================="
        Write-Host ""
        Write-Host "Machine distante : $NomDistant@$IpDistante"
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
        Write-Host "[11] Statut du pare-feu & Liste des ports ouverts"
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
            }
            "2" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter le nombre d'interfaces réseaux"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information sur le nombre d'interfaces réseaux chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "3"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'adresse IP de chaque interface réseau"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information adresse IP de chaque interface chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "4" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'adresse MAC de chaque interface réseau"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information adresse MAC de chaque interface chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "5" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des applications / paquets installés"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information Liste des applicattions/paquets chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "6" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des utilisateurs locaux"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information Liste utilsiateurs locaux choisit " | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "7"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des informations CPU"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information sur le CPU chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
            }
            "8" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la mémoire RAM totale et l'utilisation"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information RAM totale et utilisation chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2        
            }
            "9" 
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'utilisation du disque dur"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur--Information Utilisation du disque dur chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2
            }
            "10"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'utilisation du processeur"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Information Utilisation du processeur chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2
            }
            "11"
            { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter le statut du pare-feu et la liste des ports ouverts"
                $(Get-Date -Format "yyyyMMdd-HHmmss")+"-$Operateur-Droits/permission sur un fichier chosit" | Out-File -Append -FilePath C:\Windows\System32\LogFiles\log_evt.log
                Start-Sleep -Seconds 2    
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
                Read-Host "Appuyez sur une touche pour continuer..."
                Start-Sleep -Seconds 2
            }
        }
    }
}
    
    
    # En attendant le script final
    #Demande d'infos sur la machine distante
    clear-Host
    Write-Host "=================================================="
    Write-Host        "Initialisation script pour connexion"
    Write-Host "=================================================="
    Write-Host ""
    # Demande d'identification
    $NomDistant = Read-Host "Veuillez entrer le nom d'utilisateur de la machine distante "
    $IpDistante = Read-Host "Veuillez entrer l'adresse IP de la machine distante "
    $Operateur = Read-Host "Veuillez vous identifiez "
    Write-Host " Veuillez rentrez le mot de passe de la session de connexion :"
    $Credentials = Get-Credential -Credential $NomDistant
    
    
    Menu_Principal
    
