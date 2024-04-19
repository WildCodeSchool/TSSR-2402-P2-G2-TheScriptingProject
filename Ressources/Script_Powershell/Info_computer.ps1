$NomDistant = Read-Host "Veuillez entrer le nom d'utilisateur du Poste Distante "
$IpDistante = Read-Host "Veuillez entrer l'adresse IP du Poste Distante "
$Credentials = Get-Credential -Credential $NomDistant

function ShowMenuInfoPoste {
    While ($true) {
    # Effacer l'écran
    Clear-Host
    # Affichage des actions
    Write-Host "=================================================="
    Write-Host '        Menu "INFORMATION POSTE DISTANT"          '
    Write-Host "=================================================="
    Write-Host "[1]  Version de l'OS"
    Write-Host "[2]  Nombre d'interfaces"
    Write-Host "[3]  Adresses IP de chaque interface"
    Write-Host "[4]  Adresses MAC"
    Write-Host "[5]  Liste des applications/paquets installés"
    Write-Host "[6]  Liste des utilisateurs locaux"
    Write-Host "[7]  Type de CPU, nombre de coeurs, etc."
    Write-Host "[8]  Mémoire RAM totale et utilisation"
    Write-Host "[9]  Utilisation du disque"
    Write-Host "[10] Utilisation du processeur"
    Write-Host "[11] Statut du pare-feu"
    Write-Host "[12] Liste des ports ouverts"
    Write-Host ""
    Write-Host "[X]  Retour au menu précédent"
    Write-Host ""
$ChoiceInfoComputer = Read-Host "Faites votre choix"
switch ($ChoiceInfoComputer)
    {
        "1"
        {GetOS
        }
        "2"
        {NbrCarte
        }
        "3"
        {IPInterface
        }
        "4"
        {MACdemande
        }
        "5"
        {ApplicationList
        }
        "6"
        {UserList
        }
        "7"
        {GetCPU
        }
        "8"
        {RAMInfo
        }
        "9"
        {DiskInfo
        }
        "10"
        {ProcesseurInfo
        }
        "11"
        {StatutParefeu
        }
        "12"
        {StatutPort
        }
        "X"
        {Write-Host "Retour au menu précédent" -ForegroundColor Magenta -BackgroundColor Black
        Start-Sleep -Seconds 2 
        return
        }
    }
            }
}
#Fonction pour avoir la version de l'os
function GetOS {
    Clear-Host
    $GetOSConf = Read-Host "Voulez-vous voir la version de l'OS du poste distant ? [O pour valider]"
    Clear-Host
    Write-Host "Voici la version de l'OS du poste distant : "
    Write-Host ""

    if ($GetOSConf -eq "O") {
        try {
            $GetOSCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {(systeminfo)[2,3]}
            $GetOSCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici la version de l'OS du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $GetOSCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
            #return
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }
}

#Fonction pour avoir les cartes reseaux presente sur la machine.
function NbrCarte {
    Clear-Host
    $NbrCarteConf = Read-Host "Voulez-vous voir le nombre d'interfaces présentes sur le poste distant ? [O pour valider]"
    
    if ($NbrCarteConf -eq "O") {
        Clear-Host
        Write-Host "Voici la liste des interfaces présentes sur le poste distant : "
        
        #Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock { Get-NetAdapter }#| Where-Object { $_.Status -eq 'Up'  } a rajouter si on veux uniquement ceux qui sont actif 
        try{
            $NbrCarteCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock { ipconfig /all }
            $NbrCarteCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici la liste des interfaces présentes sur le poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $NbrCarteCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
        
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}

#Fonction pour demander l'address IP
function IPInterface {
    Clear-Host
    $IPInterfaceConf = Read-Host "Voulez-vous voir les adresses IP de chaque interface (IPv4 / IPv6) du poste distant ? [O pour valider]"
    
    if ($IPInterfaceConf -eq "O") {
        Clear-Host
        Write-Host "Voici les adresses IP de chaque interface (IPv4 / IPv6) du poste distant : "
        
        try{
            $IPInterfaceCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-NetIPAddress | Format-Table InterfaceAlias, AddressFamily, IPAddress }
            $IPInterfaceCMD
            Write-Host ""    
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici les adresses IP de chaque interface (IPv4 / IPv6) du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $IPInterfaceCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }    
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}


#Fonction pour avoir les addresses MAC
function MACDemande {
    Clear-Host
    $MACDemandeConf = Read-Host "Voulez-vous voir la liste des adresses MAC de chaque interface du poste distant ? [O pour valider]"

    if ($MACDemandeConf -eq "O") {
        clear-Host
        Write-Host "Voici la liste des adresses MAC de chaque interface du poste distant : "
        try{
            $MACDemande = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-NetAdapter | Format-Table Name, MacAddress, Status} 
            $MACDemande
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici la liste des adresses MAC de chaque interface du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $IPInterfaceCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}

#Fonction pour avoir la liste des application et paquet installer sur la machine
function ApplicationList {
    clear-host
    $ApplicationListConf = Read-Host "Voulez-vous la liste des applications/paquets installés sur le poste distant ? [O pour valider]"

    if ($ApplicationListConf -eq "O") {
        clear-host
        Write-Host "Voici la liste des applications/paquets installés sur le poste distant : "
        try{
            $ApplicationListCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {
                $INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion
                $INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion
                $INSTALLED | sort-object -Property DisplayName -Unique | Format-Table -AutoSize }
                $ApplicationListCMD
            Write-Host ""
            Start-Sleep -Seconds 1

            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici la liste des applications/paquets installés sur le poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $ApplicationListCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

# Fonction liste des utilisateurs locaux
function UserList {
    clear-host
    $UserListConf = read-host "Voulez-vous voir la liste des utilisateurs locaux du poste distant ? [O pour valider]"

    if ($UserListConf -eq "O") {
        clear-host
        $UserListCMD = Write-Host "Voici la liste des utilisateurs locaux du poste distant : "
        try{
            Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-LocalUser | Format-Table Name}
            $UserListCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici la liste des utilisateurs locaux du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $UserListCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction Type de CPU, nombre de coeurs, etc
function GetCPU {
    clear-host
    $GetCPUConf = Read-Host "Voulez-vous voir les détails du CPU du poste distant ? [O pour valider]"

    if ($GetCPUConf -eq "O") {
        clear-host
        Write-Host "Voici les détails du CPU du poste distant : "
        try{
            $GetCPUCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-WmiObject -Class Win32_Processor | Format-Table Name, NumberOfCores}
            $GetCPUCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici les détails du CPU du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $GetCPUCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction detail de la ram
function RAMInfo {
    clear-host
    $RAMInfoConf = Read-Host "Voulez-vous voir les détails de la RAM du poste distant ? [O pour valider]"

    if ($RAMInfoConf -eq "O") {
        clear-host
        Write-Host "Voici les détails de la RAM du poste distant : "
        try{
            $RAMInfoCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {(systeminfo)[24,25]}
            $RAMInfoCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici les détails de la RAM du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $RAMInfoCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction utilisation du disque
function DiskInfo {
    clear-host
    $DiskInfoConf = Read-Host "Voulez-vous voir les détails du/des disques du poste distant ? [O pour valider]"

    if ($DiskInfoConf -eq "O") {
        clear-host
        Write-Host "Voici les détails du/des disques du poste distant : "
        try{   
            $DiskInfoCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {get-wmiObject Win32_LogicalDisk | Format-Table DeviceID,Size, Freespace}
            $DiskInfoCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici les détails du/des disques du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $DiskInfoCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Foncion utilisation du processeur
function ProcesseurInfo {
    clear-host
    $ProcesseurInfoConf = Read-Host "Voulez-vous voir les détails de l'utilisation du processeur du poste distant ? [O pour valider]"

    if ($ProcesseurInfoConf -eq "O") {
        clear-host
        Write-Host "Voici les details de l'utilisation du processeur du poste distant : "
        try{       
            $ProcesseurInfoCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-Counter "\Processeur(_Total)\% temps processeur"}
            $ProcesseurInfoCMD
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici les details de l'utilisation du processeur du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $ProcesseurInfoCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction status du parefeu
function StatutParefeu {
    clear-host
    $StatutParefeuConf = Read-Host "Voulez-vous voir le statut du pare-feu du poste distant ? [O pour valider]"
    if ($StatutParefeuConf -eq "O") {
        clear-host
        Write-Host "Voici le statut du pare-feu du poste distant : "
        try{
            $StatutPareFeuCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-NetFirewallProfile | Format-Table Name, Enabled}
            $StatutPareFeuCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici le statut du pare-feu du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $StatutPareFeuCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
    catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        }
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Status des ports
function StatutPort {
    clear-host
    $StatutPortConf = Read-Host "Voulez-vous voir la liste des ports ouverts du poste distant ? [O pour valider]"
    if ($StatutPortConf -eq "O") {
        clear-host
        Write-Host "Voici la liste des ports ouverts du poste distant : "
        try{       
            $StatutPortCMD = Invoke-Command -ComputerName $IPDistante -Credential $Credentials -ScriptBlock {Get-NetTCPConnection | Select-Object LocalPort, State | Sort-Object LocalPort -Descending | Format-Table -AutoSize }
            $StatutPortCMD
            Write-Host ""
            Start-Sleep -Seconds 1
            Write-Host "Les données sont enregistrées dans le fichier" $PathInfoPoste
            "Voici la liste des ports ouverts du poste distant : " | Out-File -Append -FilePath $PathInfoPoste
            $StatutPortCMD | Out-File -Append -FilePath $PathInfoPoste
            Write-Host ""
            Read-Host "Appuyez sur Entrée pour continuer ..."
        }
        catch {
            Write-Host "Erreur lors de l'envoi de la commande : $_" -ForegroundColor Red
            Read-Host "Appuyer sur Entrée pour continuer ..."
        } 
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}
