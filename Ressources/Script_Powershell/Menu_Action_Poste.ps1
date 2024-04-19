function ShowMenuActionPoste
{
While ($true) {
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
    Write-Host "[*]  Retour au menu précédent" -ForegroundColor DarkYellow
    Write-Host ""
    $ChoiceActionComputer = Read-Host "Faites votre choix parmi la sélection ci-dessus "
    Write-Host ""
switch ($ChoiceActionComputer)
    {
        "1"
        {
        Shutdown
        }
        "2"
        {
        Reboot
        }
        "3"
        {
        Lock
        }
        "4"
        {
        }
        "5"
        {CreateDirectory
        }
        "6"
        {RemoveDirectory
        }
        "7"
        {RemoteControl
        }
        "8"
        {FirewallOn
        }
        "9"
        {FirewallOff
        }
        "10"
        {FirewallRules
        }
        "11"
        {Applications
        }
        "12"
        {RemoteScript
        }
        "*"
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
            Write-Host " [*] Revenir au menu précédent" -ForegroundColor DarkYellow
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
            Write-Host " [*] Revenir au menu précédent" -ForegroundColor DarkYellow
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
        Write-Host " [*] Revenir au menu précédent" -ForegroundColor DarkYellow
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
        Write-Host " [*] Revenir au menu précédent" -ForegroundColor DarkYellow
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
            Write-Host "[*] Retour au menu précédent" -ForegroundColor DarkYellow
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

