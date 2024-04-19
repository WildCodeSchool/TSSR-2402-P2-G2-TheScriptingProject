#menu_action_utilisateur.ps1

# En attendant le script final

# Demande d'identification
$NomDistant = Read-Host "Veuillez entrer le nom d'utilisateur du Poste Distante "
$IpDistante = Read-Host "Veuillez entrer l'adresse IP du Poste Distante "
$Credentials = Get-Credential -Credential $NomDistant

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
    
