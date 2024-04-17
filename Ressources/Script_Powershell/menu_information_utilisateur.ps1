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

function ChangerMotDePasse 
{
    # Demande changement de mot de passe -> pour quel utilisateur?
    $userMdp = Read-Host "Pour quel compte utilisateur souhaitez-vous modifier le mot de passe?"

    # Vérification si l'utilisateur existe
    $userExists = ssh "$nom_distant@$ip_distante" "net user $userMdp" 2>$null
    if ($userExists) {
        # Si l'utilisateur existe, demander le nouveau mot de passe
        $newPassword = Read-Host "Entrez le nouveau mot de passe pour $userMdp" -AsSecureString
        $confirmPassword = Read-Host "Confirmez le nouveau mot de passe pour $userMdp" -AsSecureString

        # Convertir les SecureStrings en plain text pour pouvoir comparer 
        $newPasswordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($newPassword))
        $confirmPasswordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmPassword))

        # Vérifier si les mots de passe correspondent
        if ($newPasswordPlain -eq $confirmPasswordPlain) {
            # Changer le mot de passe de l'utilisateur
            Invoke-Command -ComputerName $ip_distante -Credential wilder -ScriptBlock {
                param($user, $password)
                net user $user $password
            } -ArgumentList $userMdp, $newPasswordPlain

            Write-Host "Le mot de passe de l'utilisateur $userMdp a été modifié avec succès." -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        else {
            Write-Host "Les mots de passe ne correspondent pas. Veuillez réessayer." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
    else {
        # Si l'utilisateur n'existe pas
        Write-Host "L'utilisateur $userMdp n'existe pas sur le poste distant." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}
