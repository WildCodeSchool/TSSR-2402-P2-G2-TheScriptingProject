#menu_action_utilisateur.ps1

# En attendant le script final
$nom_distant = "wilder"
$ip_distante = "172.16.10.20"


function 1 {
    #Création d'un compte utilisateur local 
    # Demande quel utilisateur à créer
    $newUser = Read-Host "Quel compte utilisateur souhaitez-vous créer?"

    # Vérification si l'utilisateur existe
    $userExists = ssh $nom_distant@$ip_distante "net user $newUser"
    if ($userExists) {
        # Si oui -> sortie du script
        Write-Host "L'utilisateur existe déjà."
        Start-Sleep -Seconds 2
    }
    else {
        Write-Host "Le compte $newUser n'existe pas et va être créé."
        # Création de l'utilisateur
        ssh $nom_distant@$ip_distante "net user $newUser /add" > $null
        # Confirmation de la création
        Write-Host "Compte $newUser créé."
        Start-Sleep -Seconds 2
    }
}

function 2 {
    # Demande quel compte utilisateur à supprimer
    $userDel = Read-Host "Quel compte utilisateur souhaitez-vous supprimer ?"

    # Vérification si l'utilisateur existe
    $userExists = ssh $nom_distant@$ip_distante "net user $userDel"
    if ($userExists) {
        # Si il exsite -> demande de confirmation
        $confirmation = Read-Host "Voulez-vous vraiment supprimer le compte $userDel ? (Oui/Non)"
        # Si oui -> suppression du compte
        if ($confirmation -eq "Oui") {
            ssh $nom_distant@$ip_distante "net user $userDel /delete"
            Write-Host "Le compte $userDel est supprimé."
            Start-Sleep -Seconds 2
        }
        else {
            # Si non -> sortie du script
            Write-Host "Suppression annulée."
            Start-Sleep -Seconds 2
        }
    }
    else {
        # Si le compte n'existe pas
        Write-Host "Le compte utilisateur n'existe pas."
        Start-Sleep -Seconds 2
    }
}

function 3 {
    # Demande quel compte utilisateur à désactiver
    $userLock = Read-Host "Quel compte utilisateur souhaitez-vous désactiver ?"

    # Vérification si l'utilisateur existe
    $userExists = ssh $nom_distant@$ip_distante "net user $userLock"
    if ($userExists) {
        # Si l'utilisateur existe -> demande de confirmation
        $confirmation = Read-Host "Voulez-vous vraiment désactiver le compte $userLock ? (Oui/Non)"
        # Si oui -> désactivation du compte
        if ($confirmation -eq "Oui") {
            ssh $nom_distant@$ip_distante "net user $userLock /active:no"
            Write-Host "L'utilisateur $userLock est désactivé."
            Start-Sleep -Seconds 2
        }
        else {
            # Si non -> sortie du script
            Write-Host "Désactivation annulée."
            Start-Sleep -Seconds 2
        }
    }
    else {
        # Si l'utilisateur n'existe pas
        Write-Host "L'utilisateur $userLock n'existe pas."
        Start-Sleep -Seconds 2
    }
}


function 4 {
    # Modification d'un mot de passe
    # Demande changement du mot de passe -> pour quel utilisateur ?
    $userMdp = Read-Host "Pour quel compte utilisateur souhaitez-vous modifier le mot de passe ?"

    # Vérifie si le nom d'utilisateur existe sur le système distant
    $userExist = ssh $nom_distant@$ip_distante "net user $userMdp"
    if ($userExist) {
        # Si oui -> demander de taper le nouveau mdp
        $newMdp = Read-Host "Entrer le nouveu mot de passe :"
        ssh $nom_distant@$ip_distante "net user $userMdp $newMdp"
        Write-Host "Le mot de passe est bien modifié."
        Start-Sleep -Seconds 2
    }
    else {
        # Si non -> sortie du script
        Write-Host "L'utilisateur $userMdp n'existe pas."
        Start-Sleep -Seconds 2
    }
}




function Menu_Action_Utilisateur {

    While ($true) {
    
        Clear-Host
        Write-Host "=================================="
        Write-Host "|        ACTION UTILISATEUR     | "
        Write-Host "=================================="
        Write-Host ""
        Write-Host "Machine distante : "
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
    
        $ChoixMenuActionUtilisateur = Read-Host "Veuillez faire votre choix : "
    
        Switch ($ChoixMenuActionUtilisateur) {
            "1" { 
                Write-Host ""
                Write-Host "Vous avez choisi de créer un compte utilisateur local"
                Start-Sleep -Seconds 1
    
                break    
                    
            }
    
            "2" { 
                Write-Host ""
                Write-Host "Vous avez choisi de supprimer un compte utilisateur local"
                Start-Sleep -Seconds 1
    
                break
            }
    
            "3" { 
                Write-Host ""
                Write-Host "Vous avez choisi de désactiver un compte utilisateur local"
                Start-Sleep -Seconds 1
                     
                break
            }
    
            "4" { 
                Write-Host ""
                Write-Host "Vous avez choisi de modifier un mot de passe"
                Start-Sleep -Seconds 1
                     
                break
            }
    
            "5" { 
                Write-Host ""
                Write-Host "Vous avez choisi d'ajouter un compte à un groupe d'administration"
                Start-Sleep -Seconds 1
                     
                break
            }
    
            "6" { 
                Write-Host ""
                Write-Host "Vous avez choisi d'ajouter un compte à un groupe local"
                Start-Sleep -Seconds 1
                     
                break
            }
    
            "7" { 
                Write-Host ""
                Write-Host "Vous avez choisi de retirer un compte d'un groupe local"
                Start-Sleep -Seconds 1
                     
                break
            }
    
            "0" { 
                Write-Host ""
                Write-Host "Retour au menu précédent"
                Start-Sleep -Seconds 1
                Menu_Action
                     
                break
            }
    
            "X" { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Start-Sleep -Seconds 1
                Menu_Principal 
            }
    
            Default { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
                Start-Sleep -Seconds 1
            }
        }
    }
}
    
