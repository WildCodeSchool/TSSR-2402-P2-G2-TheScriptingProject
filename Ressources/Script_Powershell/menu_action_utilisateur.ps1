#menu_action_utilisateur.ps1

# En attendant le script final
$nom_distant = "wilder"
$ip_distante = "172.16.10.20"


function 1 
{
    #Création d'un compte utilisateur local 
    # Demande quel utilisateur à créer
    $newUser = Read-Host "Quel compte utilisateur souhaitez-vous créer?"

    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:newUser } -Credential wilder
    if ($userExists) {
        # Si oui -> sortie du script
        Write-Host "L'utilisateur existe déjà." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
    else {
        Write-Host "Le compte $newUser n'existe pas et va être créé."
        $Mdp = Read-Host "Taper le mot de passe"
        # Création de l'utilisateur
        Invoke-Command -ComputerName $IpDistante -ScriptBlock { New-LocalUser -Name $using:newUser -Password (ConvertTo-SecureString -AsPlainText $using:Mdp -Force) } -Credential wilder
        # Confirmation de la création
        Write-Host "Compte $newUser créé." -ForegroundColor Green
        Start-Sleep -Seconds 2
    }
}

function 2 
{
    # Demande quel compte utilisateur à supprimer
    $userDel = Read-Host "Quel compte utilisateur souhaitez-vous supprimer ?"

    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserDel } -Credential wilder
    if ($userExists) {
        # Si il exsite -> demande de confirmation
        $confirmation = Read-Host "Voulez-vous vraiment supprimer le compte $userDel ? (Oui/Non)"
        # Si oui -> suppression du compte
        if ($confirmation -eq "Oui") {
            Invoke-Command -ComputerName $IpDistante -ScriptBlock { Remove-LocalUser -Name $using:UserDel } -Credential wilder
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

function 3 
{
    # Demande quel compte utilisateur à désactiver
    $userLock = Read-Host "Quel compte utilisateur souhaitez-vous désactiver ?"

    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserLock } -Credential wilder
    if ($userExists) {
        # Si l'utilisateur existe -> demande de confirmation
        $confirmation = Read-Host "Voulez-vous vraiment désactiver le compte $userLock ? (Oui/Non)"
        # Si oui -> désactivation du compte
        if ($confirmation -eq "Oui") {
            Invoke-Command -ComputerName $IpDistante -ScriptBlock { Disable-LocalUser -Name $using:UserLock } -Credential wilder
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


function 4 
{
    # Modification d'un mot de passe
    # Demande changement du mot de passe -> pour quel utilisateur ?
    $userMdp = Read-Host "Pour quel compte utilisateur souhaitez-vous modifier le mot de passe ?"

    # Vérifie si le nom d'utilisateur existe sur le système distant
    $userExist = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserMdp } -Credential wilder
    if ($userExist) {
        # Si oui -> demander de taper le nouveau mdp
        $newMdp = Read-Host "Entrer le nouveu mot de passe :"
        Invoke-Command -ComputerName $IpDistante -ScriptBlock { Set-LocalUser -Name $using:userMdp -Password (ConvertTo-SecureString -AsPlainText $newMdp -Force) } -Credential wilder
        Write-Host "Le mot de passe est bien modifié." -ForegroundColor Green
        Start-Sleep -Seconds 2
    }
    else {
        # Si non -> sortie du script
        Write-Host "L'utilisateur $userMdp n'existe pas." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}

function 5 
{
    # Demande quel compte utilisateur à ajouter
    $userAdm = Read-Host "Quel compte utilisateur souhaitez-vous ajouter au groupe d'administration?"

    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserAdm } -Credential wilder
    if ($userExists) {
        # Si l'utilisateur existe -> ajout au groupe Administrators
        Invoke-Command -ComputerName $ip_distante -ScriptBlock { Add-LocalGroupMember -Group Administrateurs -Member $using:userAdm } -Credential wilder
        Write-Host "Le compte $userAdm est ajouté au groupe Administrateurs." -ForegroundColor Green
        Start-Sleep -Seconds 2
    }
    else {
        # Si non sortie du script
        Write-Host "Le compte utilisateur n'existe pas." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}

Function 6 
{
    # Demande quel compte à ajouter au groupe local
    $userAddG = Read-Host "Quel compte utilisateur souhaitez-vous ajouter à un groupe local?"
    
    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserAddG } -Credential wilder
    if ($userExists) {
        # Si l'utilisateur existe -> demande quel groupe?
        $choixAddGroup = Read-Host "À quel groupe souhaitez-vous ajouter l'utilisateur $userAddG?"
    
        $groupExists = Invoke-Command -ComputerName $ip_distante -ScriptBlock { Get-LocalGroup -Name $using:choixAddGroup } -Credential wilder
            
        if ($groupExists) {
            Write-Host "Ajout du compte en cours..." -ForegroundColor Green
            Start-Sleep -Seconds 2
            Invoke-Command -ComputerName $ip_distante -ScriptBlock { Add-LocalGroupMember -Group $using:choixAddGroup -Member $using:userAddG } -Credential wilder
            Write-Host "Le compte $userAddG est ajouté au groupe $choixAddGroup." -ForegroundColor Green

            # Affichage des utilisateurs du groupe pour vérification
            Write-Host "Vous trouverez ci-dessous la liste des utilisateurs du groupe $choixAddGroup ." -ForegroundColor Green
            Invoke-Command -ComputerName $ip_distante -ScriptBlock { Get-LocalGroupMember -Group $using:choixAddGroup } -Credential wilder
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

Function 7 
{
    # Suppression utilisateur d'un groupe local
    $userDel = Read-Host "Quel compte utilisateur souhaitez-vous supprimer d'un groupe local?"
        
    # Vérification si l'utilisateur existe
    $userExists = Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-LocalUser -Name $using:UserDel } -Credential wilder
    if ($userExists) {
        # Si l'utilisateur existe -> demande quel groupe?
        $choixDelGroup = Read-Host "De quel groupe souhaitez-vous supprimer l'utilisateur $userDel?"
        
        $groupExists = Invoke-Command -ComputerName $ip_distante -ScriptBlock { Get-LocalGroup -Name $using:choixDelGroup } -Credential wilder
                
        if ($groupExists) {
            # Si le groupe existe -> suppression de l'utilisateur du groupe
            Write-Host "Traitement en cours..." -ForegroundColor Green
            Start-Sleep -Seconds 2
            Invoke-Command -ComputerName $ip_distante -ScriptBlock { Remove-LocalGroupMember -Group $using:choixDelGroup -Member $using:userDel } -Credential wilder
            Write-Host "Le compte $userDel est supprimé du groupe $choixDelGroup." -ForegroundColor Green

            # Affichage des utilisateurs du groupe pour vérification
            Write-Host "Vous trouverez ci-dessous la liste des utilisateurs du groupe $choixDelGroup ." -ForegroundColor Green
            Invoke-Command -ComputerName $ip_distante -ScriptBlock { Get-LocalGroupMember -Group $using:choixDelGroup } -Credential wilder
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
    
