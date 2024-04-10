# Fonction pour afficher le menu
function ShowMenuComputer  
{
While ($true) {
# Effacer l'écran
    Clear-Host
# Affichage Menu Action
    Write-Host "=================================================="
    Write-Host '           Menu "ACTION POSTE DISTANT"            '
    Write-Host "=================================================="
    Write-Host ""
    Write-Host "Machine distante : $NomDistant@$IpDistante"
    Write-Host ""
    Write-Host "[1]  Arrêt"
    Write-Host "[2]  Redémarrage"
    Write-Host "[3]  Vérouillage"
    Write-Host "[4]  MàJ du système"
    Write-Host "[5]  Création de repertoire"
    Write-Host "[6]  Suppression de repertoire"
    Write-Host "[7]  Prise de main à distance"
    Write-Host "[8]  Activation du pare-feu"
    Write-Host "[9]  Désactivation du pare-feu"
    Write-Host "[10] Règles du parefeu"
    Write-Host "[11] Installation d'un logiciel"
    Write-Host "[12] Désinstallation d'un logiciel"
    Write-Host "[13] Exécution d'un script sur la machine distante"
    Write-Host ""
    Write-Host "[X]  Retour au menu précédent"
    Write-Host ""
    $MainChoice = Read-Host "Faites votre choix"
switch ($MainChoice)
    {
        "1"
        {shutdown
        }
        "2"
        {reboot
        }
    }
               }
}
 
# Fonction "Arrêt"
function Shutdown 
{
# Demande de confrmation
	$ConfShutdown = Read-Host "Confirmez-vous l'arrêt du post distant ? [O pour valider] "
# Si confirmation OK, affichage du sous-menu de la fonction "Arrêt"
	If  ($ConfShutdown -eq "O") 
    {
    Write-Host " [1] Arrêt instantané de la machine"
		Write-Host " [2] Arrêt planifié de la machine avec message d'avertissement" 
		Write-Host " [3] Arrêt planifié de la machine sans message d'avertissement"
		Write-Host " [*] Revenir au menu précédent"
        Write-Host ""
        $ConfMessage_S = Read-Host "Faites votre choix parmi la sélection ci-dessus" 
# Demande de choix pour le sous-menu de la fonction "Arrêt"	
        switch ($ConfMessage_S)
        {
            "1"
            {
                Write-Host "Arrêt instantané en cours"
                ssh $NomDistant@$IpDistante shutdown /s /f /t 0
                Start-Sleep -Seconds 1
            }

            "2"
            {
                Write-Host "Arrêt planifié en cours"
                $Timer_S1 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                $MessageTimer_S1 = Read-Host "Indiquer le message à envoyer au poste distant : "
                Start-Sleep -Seconds 1
                ssh $NomDistant@$IpDistante shutdown /s /f /t $Timer_S1 /c "$MessageTimer_S1"
            }

            "3"
            {
                Write-Host "Arrêt planifié en cours"
                $Timer_S2 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                Start-Sleep -Seconds 1
                ssh $NomDistant@$IpDistante shutdown /s /f /t $Timer_S2
            }
            
            default
            {
                Write-Host "Retour au menu précédent"
                Start-Sleep -Seconds 1
                Return
            }
        }
    }
# Si confirmation NOK, sortie de la fonction "Arrêt"
    Else
    {
        Write-Host "Retour au menu de selection"
        Start-Sleep -Seconds 1
        Return
    }
}

# Fonction "Redémarrage"
function Reboot
{
# Demande de confrmation
	$ConfReboot = Read-Host "Confirmez-vous l'Redémarrage du post distant ? [O pour valider] "
# Si confirmation OK, affichage du sous-menu de la fonction "Redémarrage"
	If  ($ConfReboot -eq "O") 
    {
    Write-Host " [1] Redémarrage instantané de la machine"
		Write-Host " [2] Redémarrage planifié de la machine avec message d'avertissement" 
		Write-Host " [3] Redémarrage planifié de la machine sans message d'avertissement"
		Write-Host " [*] Revenir au menu précédent"
        Write-Host ""
        $ConfMessage_R = Read-Host "Faites votre choix parmi la sélection ci-dessus" 
# Demande de choix pour le sous-menu de la fonction "Redémarrage"	
        switch ($ConfMessage_R)
        {
            "1"
            {
                Write-Host "Redémarrage instantané en cours"
                ssh $NomDistant@$IpDistante shutdown /r /f /t 0
                Start-Sleep -Seconds 1
            }

            "2"
            {
                Write-Host "Redémarrage planifié en cours"
                $Timer_R1 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                $MessageTimer_R1 = Read-Host "Indiquer le message à envoyer au poste distant : "
                Start-Sleep -Seconds 1
                ssh $NomDistant@$IpDistante shutdown /r /f /t $Timer_R1 /c "$MessageTimer_R1"
            }

            "3"
            {
                Write-Host "Redémarrage planifié en cours"
                $Timer_R2 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                Start-Sleep -Seconds 1
                ssh $NomDistant@$IpDistante shutdown /r /f /t $Timer_R2
            }
            
            default
            {
                Write-Host "Retour au menu précédent"
                Start-Sleep -Seconds 1
                return
            }
        }
    }
# Si confirmation NOK, sortie de la fonction "Redémarrage"
    Else
    {
        Write-Host "Retour au menu de selection"
        Start-Sleep -Seconds 1
        Return
    }
}

function Lock
{
# Demande de confirmation
	$ConfLock = Read-Host "Confirmez-vous le vérouillage de la session de la machine distante ? [O pour valider] "
# Si confirmation OK, exécution de la commande "Vérouillage"
	If ($ConfLock -eq "O")
    {
		Write-Host "Session du poste distant en cours de vérouillage"
        ssh $NomDistant@$IpDistante logoff console
		Start-Sleep -Seconds 1
# Si confirmation NOK, sortie de la fonction "Vérouillage"	
	Else
		Write-Host "Opération annulée - Retour au menu précédent"
		Start-Sleep -Seconds 1
		Return	
    }
}


# Fonction "Activation du pare-feu"
function FirewallOn
{
# Demande de confirmation + Avertissement
	Write-Host "ATTENTION : Cette commande peut impacter l'éxécution du script"
	$ConfwWOn = Read-Host "Confirmez-vous l'activation du pare-feu sur la machine distante ? [O pour valider ] : " 
# Si confirmation OK, éxécution de la commande "Activation du pare-feu"	
	if ( $ConfwWOn -eq "O" )
    { 
    $Command ={Set-NetFirewallProfile -Enabled true ; Get-NetFirewallProfile | Format-Table Name, Enabled}
		invoke-Command -ComputerName $IpDistante -ScriptBlock $Command -Credential wilder
		Write-Host "Le pare-feu de la machine distante a bien été activé"
		Start-Sleep -Seconds 2
	}
# Si confirmation NOK, sortie de la fonction "Activation du pare-feu"
	else
    {
		Write-Host "Opération annulée - Retour au menu précédent"
		Start-Sleep -Seconds 2
		return	
	}
}

# Fonction "Désactivation du pare-feu"
function FirewallOff
{
# Demande de confirmation + Avertissement
	Write-Host "ATTENTION : Cette commande peut impacter l'éxécution du script"
	$ConfwWOff = Read-Host "Confirmez-vous la désactivation du pare-feu sur la machine distante ? [O pour valider ] : " 
# Si confirmation OK, éxécution de la commande "Activation du pare-feu"	
	if ( $ConfwWOff -eq "O" )
    { 
    $Command ={Set-NetFirewallProfile -Enabled false ; Get-NetFirewallProfile | Format-Table Name, Enabled}
		invoke-Command -ComputerName $IpDistante -ScriptBlock $Command -Credential wilder
		Write-Host "Le pare-feu de la machine distante a bien été désactivé"
		Start-Sleep -Seconds 2
	}
# Si confirmation NOK, sortie de la fonction "Activation du pare-feu"
	else
    {
		Write-Host "Opération annulée - Retour au menu précédent"
		Start-Sleep -Seconds 2
		return	
	}
}

$NomDistant = Read-Host "Quel est le nom de l'utilisateur/poste distant"
$IpDistante = Read-Host "Quelle est l'adresse IP du poste distant"
Start-Sleep -Seconds 1

Clear-Host

ShowMenuComputer

