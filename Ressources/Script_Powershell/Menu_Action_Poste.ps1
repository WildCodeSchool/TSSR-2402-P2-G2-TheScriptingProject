function ShowMenuActionPoste
{
While ($true) {
# Effacer l'écran
    Clear-Host
# Affichage Menu Action
    Write-Host "==================================================" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host '                ACTION POSTE DISTANT"             ' -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "==================================================" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "Machine distante : $NomDistant@$IpDistante" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[1]  Arrêt" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[2]  Redémarrage" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[3]  Vérouillage" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[4]  MàJ du système" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[5]  Création de repertoire" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[6]  Suppression de repertoire" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[7]  Prise de main à distance" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[8]  Activation du pare-feu" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[9]  Désactivation du pare-feu" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[10] Règles du pare-feu" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[11] Installation/Désinstallation de logiciels" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[12] Exécution d'un script sur le poste distant" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "[X]  Retour au menu précédent" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host "" -ForegroundColor Yellow -BackgroundColor Black
    $ChoiceActionComputer = $(Write-Host -NoNewLine) + $(Write-Host "Faites votre choix : " -ForegroundColor Yellow -BackgroundColor Black -NoNewLine; Read-Host)
switch ($ChoiceActionComputer)
    {
        "1"
        {Shutdown
        }
        "2"
        {Reboot
        }
        "3"
        {Lock
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
        "X"
        {Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 2 
        return
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
        Write-Host " [1] Arrêt instantané du poste distant" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [2] Arrêt planifié du poste distant avec message d'avertissement" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [3] Arrêt planifié de la machine sans message d'avertissement" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [*] Revenir au menu précédent" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host ""
        $ConfMessage_S = Read-Host "Faites votre choix parmi la sélection ci-dessus" 
# Demande de choix pour le sous-menu de la fonction "Arrêt"	
        switch ($ConfMessage_S)
        {
            "1"
            {
                Write-Host "Arrêt instantané du poste distant en cours" -ForegroundColor Yellow -BackgroundColor Black
                try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { 
                        shutdown /s /f /t 0 
                        }
                Write-Host "Commande d'arrêt instantané envoyée avec succès à $IpDistante."
                Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                    Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
            }

            "2"
            {
                Write-Host "Arrêt planifié du poste distant avec message d'avertissement en cours" -ForegroundColor Yellow -BackgroundColor Black
                $Timer_S1 = Read-Host "Indiquer le compte à rebours (en secondes) "
                $MessageTimer_S1 = Read-Host "Indiquer le message à envoyer au poste distant "
                    try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                        param ($Timer_S1, $MessageTimer_S1)
                        shutdown /s /f /t $Timer_S1 /c "$MessageTimer_S1"
                        } -ArgumentList $Timer_S1, $MessageTimer_S1
                    Write-Host "Commande d'arrêt planifié avec message d'avertissement envoyée avec succès à $IpDistante."
                    Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                    catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                    Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
            }

            "3"
            {
                Write-Host "Arrêt planifié du poste distant en cours" -ForegroundColor Yellow -BackgroundColor Black
                $Timer_S2 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                    try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                        param ($Timer_S2)
                        shutdown /s /f /t $Timer_S2
                        } -ArgumentList $Timer_S2
                    Write-Host "Commande d'arrêt planifié envoyée avec succès à $IpDistante."
                    Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                    catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                    Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
            }
            
            default
            {
                Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1
                Return
            }
        }
    }
# Si confirmation NOK, sortie de la fonction "Arrêt"
    Else
    {
        Write-Host "Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1
        Return
    }
}

# Fonction "Redémarrage"
function Reboot
{
# Demande de confrmation
	$ConfReboot = Read-Host "Confirmez-vous le redémarrage du post distant ? [O pour valider] "
# Si confirmation OK, affichage du sous-menu de la fonction "Redémarrage"
	If  ($ConfReboot -eq "O") 
    {
        Write-Host " [1] Redémarrage instantané du poste distant" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [2] Redémarrage planifié du poste distant avec message d'avertissement" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [3] Redémarrage planifié du poste distant sans message d'avertissement" -ForegroundColor Yellow -BackgroundColor Black
		Write-Host " [*] Revenir au menu précédent" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host ""
        $ConfMessage_R = Read-Host "Faites votre choix parmi la sélection ci-dessus" 
# Demande de choix pour le sous-menu de la fonction "Redémarrage"	
        switch ($ConfMessage_R)
        {
            "1"
            {
                Write-Host "Redémarrage instantané du poste distant en cours" -ForegroundColor Yellow -BackgroundColor Black
                    try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                        shutdown /r /f /t 0
                        }
                    Write-Host "Commande de redémarrage du poste distant envoyée avec succès à $IpDistante."
                    }
                    catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                    Read-Host "Appuyer sur Entrée pour continuer ..."
                }
            }

            "2"
            {
                Write-Host "Redémarrage planifié du poste distant avec message d'avertissement en cours" -ForegroundColor Yellow -BackgroundColor Black
                $Timer_R1 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                $MessageTimer_R1 = Read-Host "Indiquer le message à envoyer au poste distant : "
                    try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                        param ($Timer_R1, $MessageTimer_R1)
                        shutdown /r /f /t $Timer_R1 /c "$MessageTimer_R1"
                        } -ArgumentList $Timer_R1, $MessageTimer_R1
                    Write-Host "Commande de redémarrage du poste distant avec message d'avertissement envoyée avec succès à $IpDistante."
                    Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                    catch {
                    Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                    Read-Host "Appuyer sur Entrée pour continuer ..."
                }
            }

            "3"
            {
                Write-Host "Redémarrage planifié du poste distant en cours" -ForegroundColor Yellow -BackgroundColor Black
                $Timer_R2 = Read-Host "Indiquer le compte à rebours (en secondes) : "
                    try {
                    Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                        param ($Timer_R2)
                        Start-Sleep -Seconds 1
                        shutdown /r /f /t $Timer_R2
                        } -ArgumentList $Timer_R2
                    Write-Host "Commande de redémarrage du poste distant envoyée avec succès à $IpDistante."
                    Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                        Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
            }
            
            default
            {
                Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                Start-Sleep -Seconds 1
                return
            }
        }
    }
# Si confirmation NOK, sortie de la fonction "Redémarrage"
    Else
    {
        Write-Host "Retour au menu de selection" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 1
        Return
    }
}

function Lock
{
# Demande de confirmation
	$ConfLock = Read-Host "Confirmez-vous le vérouillage de la session du poste distant ? [O pour valider] "
# Si confirmation OK, exécution de la commande "Vérouillage"
	If ($ConfLock -eq "O")
    {
		Write-Host "Session du poste distant en cours de vérouillage" -ForegroundColor Yellow -BackgroundColor Black
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {
                    logoff console
                    }
                Write-Host "Commande de vérouillage de la session du poste distant envoyée avec succès à $IpDistante."
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
    }

# Si confirmation NOK, sortie de la fonction "Vérouillage"	
	Else {
		Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
		Start-Sleep -Seconds 1
		Return	
    }
}


# Fonction "Activation du pare-feu"
function FirewallOn
{
# Demande de confirmation + Avertissement
	Write-Host "ATTENTION : Cette commande peut impacter l'éxécution du script" -ForegroundColor Yellow -BackgroundColor Black
	$ConfwWOn = Read-Host "Confirmez-vous l'activation du pare-feu sur le poste distant ? [O pour valider ] " 
# Si confirmation OK, éxécution de la commande "Activation du pare-feu"	
	if ( $ConfwWOn -eq "O" )
    { 
    $Command ={Set-NetFirewallProfile -Enabled true ; Get-NetFirewallProfile | Format-Table Name, Enabled}
        try {
            invoke-Command -ComputerName $IpDistante -ScriptBlock $Command -Credential $Credentials
            Write-Host "Le pare-feu de le poste distant a bien été activé" -ForegroundColor Yellow -BackgroundColor Black
            Start-Sleep -Seconds 1
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
# Si confirmation NOK, sortie de la fonction "Activation du pare-feu"
	else
    {
		Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
		Start-Sleep -Seconds 2
		return	
	}
}

# Fonction "Désactivation du pare-feu"
function FirewallOff
{
# Demande de confirmation + Avertissement
	Write-Host "ATTENTION : Cette commande peut impacter l'éxécution du script" -ForegroundColor Yellow -BackgroundColor Black
	$ConfwWOff = Read-Host "Confirmez-vous la désactivation du pare-feu sur le poste distant ? [O pour valider ] " 
# Si confirmation OK, éxécution de la commande "Activation du pare-feu"	
	if ( $ConfwWOff -eq "O" )
    { 
    $Command ={Set-NetFirewallProfile -Enabled false ; Get-NetFirewallProfile | Format-Table Name, Enabled}
        try {
            invoke-Command -ComputerName $IpDistante -ScriptBlock $Command -Credential $Credentials
            Write-Host "Le pare-feu de le poste distant a bien été désactivé" -ForegroundColor Yellow -BackgroundColor Black
            Start-Sleep -Seconds 1
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
	}
# Si confirmation NOK, sortie de la fonction "Activation du pare-feu"
	else
    {
		Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
		Start-Sleep -Seconds 2
		return	
	}
}


# Fonction "Règles du pare-feu"
function FirewallRules
{

    # Demande de confirmation + Avertissement concernant la sortie du script dès l'éxécution de cette fonction
    Write-Host "ATTENTION : Les commandes suivantes sont réservées à un public averti" -ForegroundColor Yellow -BackgroundColor Black
    $ConfFwRules = Read-Host "Confirmez-vous l'accès à la modification des règles du pare-feu ? [O Pour valider] "

    # Si confirmation OK, affichage du sous-menu de la fonction "Règles du pare-feu"
    if ($ConfFwRules -eq "O") {
        Write-Host " [1] Affichage de l'état actuel des règles du pare-feu" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host " [2] Création d'une règle pour ouvrir port TCP" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host " [3] Création d'une règle pour ouvrir port UDP" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host " [4] Suppression d'une règle" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host " [5] Réinitialiser le pare-feu" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host " [*] Revenir au menu précédent" -ForegroundColor Yellow -BackgroundColor Black

        while ($true) {
            $ConfMessageFw = Read-Host "Faites votre choix parmi la sélection ci-dessus "
            switch ($ConfMessageFw) {
                # Affichage de l'état actuel du pare-feu
                1 {
                    Write-Host "Affichage de l'état actuel des règles du pare-feu" -ForegroundColor Yellow -BackgroundColor Black
                    try {
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-NetFirewallRule } -Credential $Credentials
                        Start-Sleep -Seconds 1
                        Read-Host "Appuyez sur une touche pour continuer"
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                        Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                }
                # Exécution de la commande d'ouverture de port TCP
                2 {
                    Write-Host "Ouverture d'un port TCP sur tout les profils" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    $OpenTCP = Read-Host "Indiquer le n° du port à ouvrir "
					$NomdeRegleTCP = Read-Host "Spécifier le nom de la règle "
					$CommandFW= {
                        param($DisplayName)	
                        New-NetFirewallRule -DisplayName $DisplayName -Direction inbound -Profile Any -Action Allow -LocalPort $OpenTCP -Protocol TCP
                    }
                    Write-Host "Ouverture du port TCP $OpenTCP" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    try {
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock $CommandFW -ArgumentList $NomdeRegleTCP -Credential $Credentials
                        Write-Host "Port TCP $OpenTCP ouvert" -ForegroundColor Yellow -BackgroundColor Black
                        Start-Sleep -Seconds 1
                        Read-Host "Appuyez sur une touche pour continuer"
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                        Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                }
                # Exécution de la commande d'ouverture de port UDP
				3 {
                    Write-Host "Ouverture d'un port UDP sur tout les profils" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    $OpenUDP = Read-Host "Indiquer le n° du port à ouvrir "
					$NomdeRegleUDP = Read-Host "Spécifier le nom de la règle "
					$CommandFW2= {
                        param($DisplayName)	
                        New-NetFirewallRule -DisplayName $DisplayName -Direction inbound -Profile Any -Action Allow -LocalPort $OpenUDP -Protocol UDP
					}
                    Write-Host "Ouverture du port UDP $OpenUDP" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    try {
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock $CommandFW2 -ArgumentList $NomdeRegleUDP -Credential $Credentials
                        Write-Host "Port UDP $OpenUDP ouvert" -ForegroundColor Yellow -BackgroundColor Black
                        Start-Sleep -Seconds 1
                        Read-Host "Appuyez sur une touche pour continuer"
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                        Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                }
				# Exécution de la commande de fermeture de port
                4 {
                    Write-Host "Suppression d'une règle"
                    Start-Sleep -Seconds 1
                    $RegleSuppr = Read-Host "Indiquer la règle à supprimer : "
					$CommandFW3 = {
                        param($RulesNames)
                        Remove-NetFirewallRule -displayName $RulesNames
                    }
                    Write-Host "Suppression de la règle $RegleSuppr en cours" -ForegroundColor Yellow -BackgroundColor Black
                    Start-Sleep -Seconds 1
                    try {
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock $CommandFW3 -ArgumentList $RegleSuppr -Credential $Credentials
                        Write-Host "$RegleSuppr règle supprimé"
                        Start-Sleep -Seconds 1
                        Read-Host "Appuyez sur une touche pour continuer"
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                        Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                }	
                # Exécution de la commande de réinitialisation du pare-feu + Avertissement
                5 {
                    Write-Host "Réinitialisation du pare-feu" -ForegroundColor Yellow -BackgroundColor Black
                    Write-Host "ATTENTION : Cette commande peut compromettre la connexion à distance" -ForegroundColor Yellow -BackgroundColor Black
                    $ConfResetFW = Read-Host "Souhaitez-vous tout de même continuer ? [O pour valider] : "
                    # Si confirmation OK, exécution de la commande de réinitialisation du pare-feu
                    if ($ConfResetFW -eq "O") {
                        Start-Sleep -Seconds 1
                        try {
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock { netsh advfirewall reset }  -Credential $Credentials
                        Write-Host "Le pare-feu a été réinitialisé" -ForegroundColor Yellow -BackgroundColor Black
                        Start-Sleep -Seconds 1
                        Read-Host "Appuyez sur une touche pour continuer"
                        }
                        catch {
                            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                            Read-Host "Appuyer sur Entrée pour continuer ..."
                        }
                    }
                    # Si confirmation NOK, sortie de la fonction "Règles du pare-feu"
                    else {
                        Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                        Start-Sleep -Seconds 2
                    }
                }
                # Si autre/mauvais choix, sortie de la fonction "Règles du pare-feu"
                default {
                    Write-Host "Mauvais choix - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 2
                    return
                }
            }
        }
    }
}
# Fonction "Création Dossier"
function CreateDirectory {
    # Demande de confirmation
    $ConfCreateDirectory = Read-Host "Confirmez-vous la création d'un dossier ? [O pour valider] "
    # Si confirmation OK, exécution de la commande "Création Dossier"
    if ($ConfCreateDirectory -eq "O") {
        # Demande du nom du dossier à créer        
        $NameDirectory = Read-Host "Quel est le nom du dossier à créer ? "
        # Si aucun nom rentré, sortie de la fonction "Création Dossier"
        if ([string]::IsNullOrEmpty($NameDirectory)) {
            Write-Host "Vous n'avez pas indiqué de nom de dossier, retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return
        }			
        # Demande du chemin de destination du dossier à créer
        [String]$PathDirectory = Read-Host "Quel est le chemin de destination de votre dossier (Pensez à mettre les séparateurs '\' ) " 
        # Si le chemin n'est pas spécifié, utilisation du chemin courant
        if ([string]::IsNullOrEmpty($PathDirectory)) 
        {
		$PathDirectory = ".\"
        Write-Host "Pas de chemin indiqué, le dossier sera créée dans le répertoire Documents" -ForegroundColor Yellow -BackgroundColor Black
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
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
        if ($TestPath -eq "True") 
		{
		Write-Host "Le dossier existe déjà à l'emplacement spécifié." -ForegroundColor Cyan -BackgroundColor Black
		Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
		Start-Sleep -Seconds 2
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
                Write-Host "Le dossier $NameDirectory a été créé à l'emplacement $PathDirectory sur le poste." -ForegroundColor Yellow -BackgroundColor Black
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur une touche pour continuer"
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
    }
    # Si confirmation NOK, sortie de la fonction "Création Dossier"
    else {
        Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 2
        return
    }
}

# Fonction "Suppression Dossier"
function RemoveDirectory {
    # Demande de confirmation
    $ConfRemoveDirectory = Read-Host "Confirmez-vous la suppression d'un dossier ? [O pour valider] "
    # Si confirmation OK, exécution de la commande "Suppression Dossier"
    if ($ConfRemoveDirectory -eq "O") {
        # Demande du nom du dossier à supprimer        
        $NameDirectory2 = Read-Host "Indiquez le chemin du dossier à supprimer"
        # Si aucun nom rentré, sortie de la fonction "Suppression Dossier"
        if ([string]::IsNullOrEmpty($NameDirectory2)) {
            Write-Host "Vous n'avez pas indiqué de dossier, retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
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
            Start-Sleep -Seconds 2
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
                Write-Host "Le dossier $NameDirectory2 a été supprimé" -ForegroundColor Yellow -BackgroundColor Black
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur une touche pour continuer"
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
    }
    # Si confirmation NOK, sortie de la fonction "Suppression Dossier"
    else {
        Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 2
        return
    }
}

function Applications 
{
    While ($True)
    {
    Write-Host " [1] Installation d'applications" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [2] Désinstallation d'applications" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [3] Rechercher une application sur ChocolaTey" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [4] Liste des applications installées sur le poste" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [5] Liste des mises à jour disponibles des applications sur le poste" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [6] MàJ d'une application" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [7] MàJ de toutes les applications" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [*] Revenir au menu précédent" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host ""
    Write-Host "ATTENTION : L'installation de ChocolaTey sur le poste est obligatoire avant toute installation/désinstallation" -ForegroundColor Yellow -BackgroundColor Black
    $ChoiceAppMenu = Read-Host "Faites votre choix parmi la selection ci-dessus "

    switch ($ChoiceAppMenu)
    {
        1
        {
        $ConfAppInstall = Read-Host "Souhaitez-vous installer une application ? [O Pour valider]"
        
        If ($ConfAppInstall -eq "O")
        {
            $AppInstall = Read-Host "Indiquer le nom de l'application"
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppInstall) choco install $AppInstall -y --force } -ArgumentList $AppInstall
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur une touche pour continuer"
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        }
        }

        2
        {
        $ConfAppUnInstall = Read-Host "Souhaitez-vous désinstaller une application ? [O Pour valider]"
    
        If ($ConfAppUnInstall -eq "O")
        {
            $AppUnInstall = Read-Host "Indiquer le nom de l'application"
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppUnInstall) choco uninstall $AppUnInstall -y --force} -ArgumentList $AppUnInstall
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur une touche pour continuer"
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        }    

        }
        
        3
        {
            $ConfSearchAppChoco = Read-Host "Souhaitez-vous rechercher une application sur ChocolaTey ? [O Pour valider]"
            
        If ($ConfSearchAppChoco -eq "O")
        {
            $AppSearchChoco = Read-Host "Indiquer le nom de l'application à rechercher sur ChocolaTey"
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppSearchChoco) choco search --by-id-only $AppSearchChoco } -ArgumentList $AppSearchChoco
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur une touche pour continuer"
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        } 

        }

        4
        {
            $ConfSearchAppPC = Read-Host "Souhaitez-vous obtenir la liste des applications sur le poste ? [O Pour valider]"
            
        If ($ConfSearchAppPC -eq "O")
        {
            Write-Host "Voici la liste des applications installées sur le poste : "
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { choco list }
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur une touche pour continuer"
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            Read-Host "Appuyez sur une touche pour continuer"
            return 
        } 

        }

        5
        {
            $ConfSearchMajAppPC = Read-Host "Souhaitez-vous obtenir la liste des mises à jour disponibles des applications sur le poste ? [O Pour valider]"
            
        If ($ConfSearchMajAppPC -eq "O")
        {
            Write-Host "Voici la liste des mises à jour disponibles des applications sur le poste : "
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {choco outdated}
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur une touche pour continuer"
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        } 

        }

        6
        {
            $ConfMajApp = Read-Host "Souhaitez-vous mettre à jour une application ? [O Pour valider] "
            
        If ($ConfMajApp -eq "O")
        {
            $AppMaj = Read-Host "Indiquer le nom de l'application à mettre à jour"
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($AppMaj) choco upgrade $AppMaj -y } -ArgumentList $AppMaj
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur une touche pour continuer"
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        }

        }

        7
        {
            $ConfMajAppAll = Read-Host "Souhaitez-vous mettre à jour toutes les applications ? [O Pour valider] "
            
        If ($ConfMajAppAll -eq "O")
        {
            Write-Host "Toutes les applications du poste vont être mises à jour: " -ForegroundColor Yellow -BackgroundColor Black
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock {choco upgrade all -y}
                Start-Sleep -Seconds 1
                Read-Host "Appuyez sur une touche pour continuer"
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        }

        }

        default
        {
            Write-Host "Mauvais choix - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return
        }

        }
    }
}

function RemoteControl
{
	Write-Host "ATTENTION : Cette commande vous sortira momentanément du script" -ForegroundColor Yellow -BackgroundColor Black
	$ConfRemote = Read-Host "Confirmez-vous ? [O pour valider]" 

    If ($ConfRemote -eq "O")
    {
        While ($True)
        {
            Write-Host "[1] Contrôle par interface graphique (GUI)" -ForegroundColor Yellow -BackgroundColor Black
            Write-Host "[2] Contrôle par le terminal PowerShell" -ForegroundColor Yellow -BackgroundColor Black
            Write-Host "[*] Retour au menu précédent" -ForegroundColor Yellow -BackgroundColor Black
            Write-Host ""
            $ChoiceRemote = Read-Host "Faire un choix parmi la sélection ci-dessus"

            switch ($ChoiceRemote)
            
            {
                1
                { 
                    Write-Host "Contrôle par interface graphique (GUI)" -ForegroundColor Yellow -BackgroundColor Black
                    try {
                        mstsc -v $IpDistante
                        Start-Sleep -Seconds 1
                        Read-Host "Appuyez sur une touche pour continuer"
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                        Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                }

                2
                {
                    Write-Host "Contrôle par le terminal PowerShell" -ForegroundColor Yellow -BackgroundColor Black
                    try {
                        Enter-PSSession -ComputerName $IpDistante -Credential $Credentials
                    }
                    catch {
                        Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                        Read-Host "Appuyer sur Entrée pour continuer ..."
                    }
                }

                Default 
                {
                    Write-Host "Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
                    Start-Sleep -Seconds 2
                    return
                }
            }
        }
    }   
    else
    {
        Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
        Start-Sleep -Seconds 2
        return 
    }
}

function RemoteScript
{
    $ConfRS = Read-Host "Confirmez-vous l'éxécution d'un script sur le poste distant ? [O pour valider ]"
    if ($ConfRS -eq "O")
    {
        $NameScript = Read-Host "Quel est le nom du script (Sans l'extension) ?"
		$PathScript = Read-Host "Quel est le chemin du script ?"
        $PathNameScript = "$PathScript\$NameScript.ps1"
        $TestPathNameScript = Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($PathNameScript) Test-Path -Path $PathNameScript} -ArgumentList $PathNameScript
        if ($TestPathNameScript -eq $True)
        {
            Write-Host "Le script $NameScript existe" -ForegroundColor Yellow -BackgroundColor Black
            Write-Host "Le script $NameScript va être éxécuté" -ForegroundColor Yellow -BackgroundColor Black
            try {
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { Set-ExecutionPolicy RemoteSigned -Scope CurrentUser  }
                Invoke-Command -ComputerName $IpDistante -Credential $Credentials -ScriptBlock { param($PathNameScript) & $PathNameScript } -ArgumentList $PathNameScript
            }
            catch {
                Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red -BackgroundColor White
                Read-Host "Appuyer sur Entrée pour continuer ..."
            }
        }  
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent" -ForegroundColor Cyan -BackgroundColor Black
            Start-Sleep -Seconds 2
            return 
        } 
    }
}
