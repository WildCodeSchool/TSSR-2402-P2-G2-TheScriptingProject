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


# Fonction "Règles du pare-feu"
function FirewellRules
 {

    # Demande de confirmation + Avertissement concernant la sortie du script dès l'éxécution de cette fonction
    Write-Host "ATTENTION : Les commandes suivantes sont réservées à un public averti"
    $ConfFwRules = Read-Host "Confirmez-vous l'accès à la modification des règles du pare-feu ? [O Pour valider] : "

    # Si confirmation OK, affichage du sous-menu de la fonction "Règles du pare-feu"
    if ($ConfFwRules -eq "O") {
        Write-Host " [1] Affichage de l'état actuel des règles du pare-feu"
        Write-Host " [2] Création d'une règle pour ouvrir port TCP"
        Write-Host " [3] Création d'une règle pour ouvrir port UDP"
        Write-Host " [4] Suppression d'une règle"
        Write-Host " [5] Réinitialiser le pare-feu"
        Write-Host " [*] Revenir au menu précédent"

        while ($true) {
            $ConfMessageFw = Read-Host "Faites votre choix parmi la sélection ci-dessus "
            switch ($ConfMessageFw) {
                # Affichage de l'état actuel du pare-feu
                1 {
                    Write-Host "Affichage de l'état actuel des règles du pare-feu"
                    Invoke-Command -ComputerName $IpDistante -ScriptBlock { Get-NetFirewallRule } -Credential wilder
                    Start-Sleep -Seconds 2
					$Continuer = Read-Host "Appuyez sur une touche pour contiuer"
                }
                # Exécution de la commande d'ouverture de port TCP
                2 {
                    Write-Host "Ouverture d'un port TCP sur tout les profiles"
                    Start-Sleep -Seconds 2
                    $OpenTCP = Read-Host "Indiquer le n° du port à ouvrir "
					$NomdeRegleTCP = Read-Host "Spécifier le nom de la règle "
					$commandfw= {
					param($DisplayName)	
					New-NetFirewallRule -DisplayName $DisplayName -Direction inbound -Profile Any -Action Allow -LocalPort $OpenTCP -Protocol TCP
					}
	                Write-Host "Ouverture du port TCP $OpenTCP"
                    Start-Sleep -Seconds 2
                    Invoke-Command -ComputerName $IpDistante -ScriptBlock $commandfw -ArgumentList $NomdeRegleTCP -Credential wilder
                    Write-Host "Port TCP $OpenTCP ouvert"
                    Start-Sleep -Seconds 2
                }
			  	# Exécution de la commande d'ouverture de port UDP
				3 {
                    Write-Host "Ouverture d'un port UDP sur tout les profiles"
                    Start-Sleep -Seconds 2
                    $OpenUDP = Read-Host "Indiquer le n° du port à ouvrir "
					$NomdeRegleUDP = Read-Host "Spécifier le nom de la règle "
					$commandfw= {
					param($DisplayName)	
					New-NetFirewallRule -DisplayName $DisplayName -Direction inbound -Profile Any -Action Allow -LocalPort $OpenUDP -Protocol UDP
					}
	                Write-Host "Ouverture du port UDP $OpenUDP"
                    Start-Sleep -Seconds 2
                    Invoke-Command -ComputerName $IpDistante -ScriptBlock $commandfw -ArgumentList $NomdeRegleUDP -Credential wilder
                    Write-Host "Port UDP $OpenUDP ouvert"
                    Start-Sleep -Seconds 2
                }
				# Exécution de la commande de fermeture de port
                4 {
                    Write-Host "Suppression d'une règle"
                    Start-Sleep -Seconds 2
                    $RegleSuppr = Read-Host "Indiquer la règle à supprimer : "
					$commandfw = {
					param($RulesNames)
					Remove-NetFirewallRule -displayName $RulesNames}
                    Start-Sleep -Seconds 2
                    Invoke-Command -ComputerName $IpDistante -ScriptBlock $commandfw -ArgumentList $RegleSuppr -Credential wilder
                    Write-Host "$RegleSuppr règle supprimé"
                    Start-Sleep -Seconds 2
                }	
                # Exécution de la commande de réinitialisation du pare-feu + Avertissement
                5 {
                    Write-Host "Réinitialisation du pare-feu"
                    Write-Host "ATTENTION, cette commande peut compromettre la connexion à distance"
                    $ConfResetFw = Read-Host "Souhaitez-vous tout de même continuer ? [O pour valider] : "
                    # Si confirmation OK, exécution de la commande de réinitialisation du pare-feu
                    if ($ConfResetFw -eq "O") {
                        Start-Sleep -Seconds 1
                        Invoke-Command -ComputerName $IpDistante -ScriptBlock { netsh advfirewall reset }  -Credential wilder
                        Write-Host "Le pare-feu a été réinitialisé"
                        Start-Sleep -Seconds 2
                        return
                    }
                    # Si confirmation NOK, sortie de la fonction "Règles du pare-feu"
                    else {
                        Write-Host "Opération annulée - Retour au menu précédent"
                        Start-Sleep -Seconds 1
                    }
                }
                # Si autre/mauvais choix, sortie de la fonction "Règles du pare-feu"
                default {
                    Write-Host "Mauvais choix - Retour au menu précédent"
                    Start-Sleep -Seconds 1
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
            Write-Host "Vous n'avez pas indiqué de nom de dossier, retour au menu précédent"
            Start-Sleep -Seconds 1
            return
        }			
        # Demande du chemin de destination du dossier à créer
        [String]$PathDirectory = Read-Host "Quel est le chemin de destination de votre dossier (Pensez à mettre les séparateurs '\' ) " 
        # Si le chemin n'est pas spécifié, utilisation du chemin courant
        if ([string]::IsNullOrEmpty($PathDirectory)) 
        {
		$PathDirectory = ".\"
        Write-Host "Pas de chemin indiqué, le dossier sera créée dans le répertoire Documents"
        }
	# Vérification de l'existence du dossier sur l'ordinateur distant
		$CMDTestPath = {
		param($Path)	
		Test-Path -Path $Path
		}
    # Création d'une variable contenant chemin + nom de dossier
        $Directory = $PathDirectory + $NameDirectory
		$TestPath = Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDTestPath -ArgumentList $Directory -Credential $NomDistant
		if ($TestPath -eq "True") 
		{
		Write-Host "Le dossier existe déjà à l'emplacement spécifié."
		Write-Host "Retour au menu précédent"
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
		Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDCreate -ArgumentList $Directory -Credential $NomDistant
		
		Write-Host "Le dossier $NameDirectory a été créé à l'emplacement $PathDirectory sur le poste."
		Start-Sleep -Seconds 1
        }
    }
    # Si confirmation NOK, sortie de la fonction "Création Dossier"
    else {
        Write-Host "Opération annulée - Retour au menu précédent"
        Start-Sleep -Seconds 1
        return
    }
}

$NomDistant = Read-Host "Quel est le nom de l'utilisateur/poste distant"
$IpDistante = Read-Host "Quelle est l'adresse IP du poste distant"
Start-Sleep -Seconds 1

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
            Write-Host "Vous n'avez pas indiqué de dossier, retour au menu précédent"
            Start-Sleep -Seconds 1
            return       
        }	
    # Vérification de l'existence du dossier à supprimer
        $CMDTestPath = {
            param($Path)	
            Test-Path -Path $Path
            }

        $TestPathDirectory2 = Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDTestPath -ArgumentList $NameDirectory2 -Credential $NomDistant
    # Si le dossier ,'existe pas, retour au menu précédent
        if ($TestPathDirectory2 -eq $False)
        {
            Write-Host "Le dossier n'existe pas, retour au menu précédent"
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
		Invoke-Command -ComputerName $IpDistante -ScriptBlock $CMDRemoval -ArgumentList $NameDirectory2 -Credential $NomDistant
		
		Write-Host "Le dossier $NameDirectory2 a été supprimé"
		Start-Sleep -Seconds 1
        }
    }
    # Si confirmation NOK, sortie de la fonction "Suppression Dossier"
    else {
        Write-Host "Opération annulée - Retour au menu précédent"
        Start-Sleep -Seconds 1
        return
    }
}

function Applications 
{
    While ($True)
    {
    Write-Host " [1] Installation d'applications"
    Write-Host " [2] Désinstallation d'applications"
    Write-Host " [3] Installation de ChocolaTey"
    Write-Host " [4] Rechercher une application sur ChocolaTey"
    Write-Host " [5] Liste des applications installées sur le poste"
    Write-Host " [6] Liste des mises à jour disponibles des applications sur le poste"
    Write-Host " [7] MàJ d'une application"
    Write-Host " [8] MàJ de toutes les applications"
    Write-Host " [*] Revenir au menu précédent"
    Write-Host ""
    Write-Host "ATTENTION : L'installation de ChocolaTey sur le poste est obligatoire avant toute installation/désinstallation"
    $ChoiceAppMenu = Read-Host "Faites votre choix parmi la selection ci-dessus "

    switch ($ChoiceAppMenu)
    {
        1
        {
        $ConfAppInstall = Read-Host "Souhaitez-vous installer une application ? [O Pour valider]"
        
        If ($ConfAppInstall -eq "O")
        {
            $AppInstall = Read-Host "Indiquer le nom de l'application"
            Invoke-Command -ComputerName $IpDistante -Credential $NomDistant -ScriptBlock { param($AppInstall) choco install $AppInstall -y --force } -ArgumentList $AppInstall
            Read-Host "Appuyez sur ENTREE pour continuer ..."
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent"
            return 
        }
        }

        2
        {
        $ConfAppUnInstall = Read-Host "Souhaitez-vous désinstaller une application ? [O Pour valider]"
    
        If ($ConfAppUnInstall -eq "O")
        {
            $AppUnInstall = Read-Host "Indiquer le nom de l'application"
            Invoke-Command -ComputerName $IpDistante -Credential $NomDistant -ScriptBlock { param($AppUnInstall) choco uninstall $AppUnInstall -y --force} -ArgumentList $AppUnInstall
            Read-Host "Appuyez sur ENTREE pour continuer ..."
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent"
            return 
        }    

        }
        
        3
        {
        $ConfInstallChoco = Read-Host "Souhaitez-vous installer ChocolaTey ? [O Pour valider]"   

        If ($ConfInstallChoco -eq "O")
        {
            Invoke-Command -ComputerName $IpDistante -Credential $NomDistant -ScriptBlock {Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))}
            Read-Host "Appuyez sur ENTREE pour continuer ..."
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent"
            return 
        }  

        }

        4
        {
            $ConfSearchAppChoco = Read-Host "Souhaitez-vous rechercher une application sur ChocolaTey ? [O Pour valider]"
            
        If ($ConfSearchAppChoco -eq "O")
        {
            $AppSearchChoco = Read-Host "Indiquer le nom de l'application à rechercher sur ChocolaTey"
            Invoke-Command -ComputerName $IpDistante -Credential $NomDistant -ScriptBlock { param($AppSearchChoco) choco search --by-id-only $AppSearchChoco } -ArgumentList $AppSearchChoco
            Read-Host "Appuyez sur ENTREE pour continuer ..."
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent"
            return 
        } 

        }

        5
        {
            $ConfSearchAppPC = Read-Host "Souhaitez-vous obtenir la liste des applications sur le poste ? [O Pour valider]"
            
        If ($ConfSearchAppPC -eq "O")
        {
            Write-Host "Voici la liste des applications installées sur le poste : "
            Invoke-Command -ComputerName $IpDistante -Credential $NomDistant -ScriptBlock { choco list }
            Read-Host "Appuyez sur ENTREE pour continuer ..."
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent"
            return 
        } 

        }

        6
        {
            $ConfSearchMajAppPC = Read-Host "Souhaitez-vous obtenir la liste des mises à jour disponibles des applications sur le poste ? [O Pour valider]"
            
        If ($ConfSearchMajAppPC -eq "O")
        {
            Write-Host "Voici la liste des mises à jour disponibles des applications sur le poste : "
            Invoke-Command -ComputerName $IpDistante -Credential $NomDistant -ScriptBlock {choco outdated}
            Read-Host "Appuyez sur ENTREE pour continuer ..."
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent"
            return 
        } 

        }

        7
        {
            $ConfMajApp = Read-Host "Souhaitez-vous mettre à jour une application ? [O Pour valider] "
            
        If ($ConfMajApp -eq "O")
        {
            $AppMaj = Read-Host "Indiquer le nom de l'application à mettre à jour"
            Invoke-Command -ComputerName $IpDistante -Credential $NomDistant -ScriptBlock { param($AppMaj) choco upgrade $AppMaj -y } -ArgumentList $AppMaj
            Read-Host "Appuyez sur ENTREE pour continuer ..."
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent"
            return 
        }

        }

        8
        {
            $ConfMajAppAll = Read-Host "Souhaitez-vous mettre à jour toutes les applications ? [O Pour valider] "
            
        If ($ConfMajAppAll -eq "O")
        {
            Write-Host "Toutes les applications du poste vont être mises à jour: "
            Invoke-Command -ComputerName $IpDistante -Credential $NomDistant -ScriptBlock {choco upgrade all -y}
            Read-Host "Appuyez sur ENTREE pour continuer ..."
            Clear-Host
        }
        else 
        {
            Write-Host "Opération annulée - Retour au menu précédent"
            return 
        }

        }

        default
        {
            Write-Host "Retour au menu précédent"
            return
        }

        }
    }
}


$NomDistant = Read-Host "Quel est le nom de l'utilisateur/poste distant"
$IpDistante = Read-Host "Quelle est l'adresse IP du poste distant"
Start-Sleep -Seconds 1

Clear-Host

ShowMenuComputer

