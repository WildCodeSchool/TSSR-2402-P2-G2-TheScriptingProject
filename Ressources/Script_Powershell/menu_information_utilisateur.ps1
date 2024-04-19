#menu_action_utilisateur.ps1

# En attendant le script final
$NomDistant = "wilder"
$IpDistante = "172.16.10.20"
$Credentials = Get-Credential -Credential $NomDistant

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
            try {
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
            catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                    Read-Host "Appuyer sur Entrée pour continuer ..."
            }
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
         try {
                $CmdInfoMdp=Invoke-Command -ComputerName $IpDistante -ScriptBlock { (Get-LocalUser -Name $using:userInf).PasswordLastSet } -Credential $Credentials 
                $CmdInfoMdp
                Start-Sleep -Seconds 2
                # Enregistrement des données
                Write-Host "Les données sont enregistrées dans le fichier" $PathInfoUser
                "Date de dernière modification de mot de passe de l'utilisateur $userInf : " | Out-File -Append -FilePath $PathInfoUser
                $CmdInfoMdp | Out-File -Append -FilePath $PathInfoUser    
                Read-Host "Appuyez sur Entrée pour continuer ..."
        }
         catch {
                 Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                 Read-Host "Appuyer sur Entrée pour continuer ..."
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
    try {
            $CmdInfoSession=Invoke-Command -ComputerName $IpDistante -ScriptBlock { (Get-WmiObject -class win32_ComputerSystem | select username).username } -Credential $Credentials 
            $CmdInfoSession
            Start-Sleep -Seconds 2
            # Enregistrement des données
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoUser
            "Session ouverte(s) sur le poste distant pour l'utilisateur $userInf : " | Out-File -Append -FilePath $PathInfoUser
            $CmdInfoMdp | Out-File -Append -FilePath $PathInfoUser    
            Read-Host "Appuyez sur Entrée pour continuer ..."
    }
    catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
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
            try {
                # affichage des droits et sauvegarde dans fichier
                $CmdInoFolder=Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($FolderPath) Get-Acl -Path $FolderPath | Format-Table -AutoSize} -ArgumentList $Dossier
                $CmdInoFolder
                Write-Host "Les données sont enregistrées dans le fichier" $PathInfoUser
                "Voici la liste des droits sur le dossier $Dossier  : " | Out-File -Append -FilePath $PathInfoUser
                $CmdInoFolder| Out-File -Append -FilePath $PathInfoUser
                Read-Host "Appuyez sur Entrée pour continuer ..."
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                Read-Host "Appuyer sur Entrée pour continuer ..."
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
            try {   
                # affichage des droits
                $CmdInoFile = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {param($FilePath) Get-Acl -Path $FilePath | Format-Table -AutoSize} -ArgumentList $Fichier
                $CmdInoFile
                # Enregistrement des données
                Write-Host "Les données sont enregistrées dans le fichier" $PathInfoUser
                "Voici les droits sur le fichier spécifié $Fichier : " | Out-File -Append -FilePath $PathInfoUser
                $CmdInoFile | Out-File -Append -FilePath $PathInfoUser
                Read-Host "Appuyez sur Entrée pour continuer ..."
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
                Read-Host "Appuyer sur Entrée pour continuer ..."
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


