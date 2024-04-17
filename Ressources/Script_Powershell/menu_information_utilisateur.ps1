#menu_action_utilisateur.ps1

# En attendant le script final
$nom_distant = "wilder"
$ip_distante = "172.16.10.20"


function InfoConnexion 
{ 
    # Demande quel utilisateur?
    $userInf = Read-Host "Quel compte utilisateur souhaitez-vous vérifier?"
    
    # Vérification si l'utilisateur existe
    $userExists = ssh $nom_distant@$ip_distante "net user $userInf"
    if ($userExists) {
        # Si oui -> affichage date de dernière connexion
        Write-Host "Date de dernière connexion de l'utilisateur $userInf."
        Invoke-Command -ComputerName $ip_distante -ScriptBlock { Get-WinEvent -FilterHashtable @{
                LogName = 'Security'
                ID      = 4624
            } | Where-Object { $_.Properties[5].Value -eq $using:userInf } | Select-Object -ExpandProperty TimeCreated -First 1 
        } -Credential wilder
        Start-Sleep -Seconds 2
    }
    else {
        # Si non, sortie du script
        Write-Host "Le compte utilisateur n'existe pas." -ForegroundColor Red
    }
}

function InfoModificationMdp 
{ 
    # Demande quel utilisateur?
    Write-Host "Date de dernière modification du mdp"
    $userInfMdp = Read-Host "Tapez le nom d'utilisateur souhaité "

    # Vérification si l'utilisateur existe
    $userExists = ssh $nom_distant@$ip_distante "net user $userInfMdp"
    if ($userExists) {
        # Si oui -> affichage date de dernière connexion
        Write-Host "Date de dernière modification du mot de passe l'utilisateur $userInfMdp."
        Invoke-Command -ComputerName $ip_distante -ScriptBlock { (Get-LocalUser -Name $using:userInfMdp).PasswordLastSet
        } -Credential wilder
        Start-Sleep -Seconds 2
    }
    else {
        # Si non, sortie du script
        Write-Host "Le compte utilisateur n'existe pas." -ForegroundColor Red
    }
}
