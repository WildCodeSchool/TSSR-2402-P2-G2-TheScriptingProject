
#Fonction menu info utilisateur
function ShowMenuComputer {
    # Effacer l'écran
    Clear-Host

    # Affichage des actions
    Write-Host "=================================================="
    Write-Host '        Menu "Information Machine Distante":      '
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
    Write-Host "[11] Statut du pare-feu et liste des ports ouverts"
    Write-Host ""
    Write-Host "[X]  Retour au menu précédent"
    Write-Host ""
}

#Fonction pour avoir la version de l'os
function GetOS {
    Clear-Host
    $ConfOS = Read-Host "Voulez-vous voir la version de l'OS? [O pour valider]"

    if ($ConfOS -eq "O") {
        Clear-Host
        Invoke-Command -ComputerName $IP -ScriptBlock {(systeminfo)[2,3]}
        Invoke-Command -ComputerName $IP -ScriptBlock {(systeminfo)[2,3]} >> "/home/wilder/Documents/info-CLIWIN01-$((Get-Date).ToString('yyyy-MM-dd')).txt"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$((Get-Date).ToString('yyyy-MM-dd')).txt"
        Start-Sleep -Seconds 3
        return
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }
}

#Fonction pour avoir les cartes reseaux presente sur la machine.
function Get-NbrCarte {
    Clear-Host
    $NbrI = Read-Host "Voulez-vous voir le nombre d'interfaces présentes sur cette machine? [O pour valider]"
    
    if ($NbrI -eq "O") {
        Clear-Host
        Write-Host "Voici la liste des interfaces présentes sur cette machine :"
        
        $interfaces = Invoke-Command -ComputerName $IP -ScriptBlock { Get-NetAdapter }#| Where-Object { $_.Status -eq 'Up'  } a rajouter si on veux uniquement ceux qui sont actif 
        $interfaces = Invoke-Command -ComputerName $IP -ScriptBlock { Get-NetAdapter } >> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "Liste des cartes"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" 
        Start-Sleep -Seconds 3
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}

#Fonction pour demander l'address IP
function Get-IPDemande {
    Clear-Host
    $CartIp = Read-Host "Quelle carte choisissez-vous ?"
    
    if ($CartIp -eq "O") {
        Clear-Host
        Write-Host "Voici la totalite des addresses IPv4 et IPv6"
        
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-NetIPAddress | Select-Object InterfaceAlias, AddressFamily, IPAddress } 
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-NetIPAddress | Select-Object InterfaceAlias, AddressFamily, IPAddress } >> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "Liste des adresses IP" 
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt"
        Start-Sleep -Seconds 3
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}

#Fonction pour avoir les addresses MAC
function MACdemande {
    Clear-Host
    $CartMac = Read-Host "Quelle carte choisissez-vous ?"

    if ($CartMac -eq "O") {
        clear-Host
        Write-Host "Voici la liste des addresses MAC disponible"
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-NetAdapter |Select-Object Name, MacAddress, Status} 
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-NetAdapter |Select-Object Name, MacAddress, Status} >> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "Liste des adresses MAC"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt"
        Start-Sleep -Seconds 3
    }
    else {
        Clear-Host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
        return
    }   
}

#Fonction pour avoir la liste des application et paquet installer sur la machine
function Application {
    clear-host
    $app = Read-Host "Voulez-vous la liste des applications et paquets installés? [O pour valider]"

    if ($app -eq "O") {
        clear-host
        Write-Host "Voici la liste des applications et paquets présents sur cette machine : "
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall*}
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall*}>> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "Liste des Programes"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt"
        Start-Sleep -Seconds 3
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
    $ListU = read-host "Voulez-vous voir la liste des utilisateurs locaux ? [O pour valider]"

    if ($ListU -eq "O") {
        clear-host
        Write-Host "Voici la liste des utilisateurs locaux : "
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-LocalUser |Select-Object Name}
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-LocalUser |Select-Object Name}>> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "Liste des Utilisateur"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt"
        Start-Sleep -Seconds 3
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction Type de CPU, nombre de coeurs, etc
function GetCpu{
    clear-host
    $Gcpu = Read-Host "Voulez-vous voir les détails du CPU ? [O pour valider]"

    if ($Gcpu -eq "O") {
        clear-host
        Write-Host " Voici les détails du CPU de la machine : "
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-WmiObject -Class Win32_Processor | Select-Object Name, NumberOfCores}
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-WmiObject -Class Win32_Processor | Select-Object Name, NumberOfCores} >> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "Detail du Cpu"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt"
        Start-Sleep -Seconds 3
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction detail de la ram
function RamInfo {
    clear-host
    $RamI = Read-Host "Voulez-vous voir les détails de la RAM ? [O pour valider]"

    if ($RamI -eq "O") {
        clear-host
        Write-Host "Voici les détails de la RAM sur cette machine"
        Invoke-Command -ComputerName $IP -ScriptBlock {(systeminfo)[24,25]}
        Invoke-Command -ComputerName $IP -ScriptBlock {(systeminfo)[24,25]}>> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "detail de la ram"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt"
        Start-Sleep -Seconds 3
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
    $DiskInf = Read-Host "Voulez-vous voir les détails du/des disques ? [O pour valider]"

    if ($DiskInf -eq "O") {
        clear-host
        Write-Host "Voici les détails du/des disques de cette machine :"
        Invoke-Command -ComputerName $IP -ScriptBlock {get-wmiObject Win32_LogicalDisk | Select-Object DeviceID,Size, Freespace}
        Invoke-Command -ComputerName $IP -ScriptBlock {get-wmiObject Win32_LogicalDisk | Select-Object DeviceID,Size, Freespace} >> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "Detail du disque"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt"
        Start-Sleep -Seconds 3
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
    $ProcesseurInf = Read-Host "Voulez-vous voir les détails du processeur ? [O pour valider]"

    if ($ProcesseurInf -eq "O") {
        clear-host
        Write-Host "Voici les details du processeur sur cette machine : "
        Invoke-Command -ComputerName $IP -ScriptBlock {get-process |select-object Processname, cpu}
        Invoke-Command -ComputerName $IP -ScriptBlock {get-process |select-object Processname, cpu} >> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "detail du processeur"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt"
        Start-Sleep -Seconds 3
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Fonction status du parefeu
function StatusParefeu {
    clear-host
    $FireW = Read-Host "Voulez-vous voir les informations liées au pare-feu ? [O pour valider]"
    if ($FireW -eq "O") {
        clear-host
        Write-Host "Voici les détails du pare-feu de cette machine :"
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-NetFirewallProfile | Format-Table Name, Enabled}
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-NetFirewallProfile | Format-Table Name, Enabled}>> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "Detail du parefeu"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt"
        Start-Sleep -Seconds 3
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

#Status des ports
function StatusPort {
    clear-host
    $FireW = Read-Host "Voulez-vous voir les informations liées au ports ? [O pour valider]"
    if ($FireW -eq "O") {
        clear-host
        Write-Host "Voici les détails du pare-feu de cette machine :"
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-NetTCPConnection | Select-Object LocalPort}
        Invoke-Command -ComputerName $IP -ScriptBlock {Get-NetTCPConnection | Select-Object LocalPort}>> "/home/wilder/Documents/info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt" -Value "Detail des ports"
        Write-Host ""
        Write-Host "Les données sont enregistrées dans le fichier info-CLIWIN01-$(Get-Date -Format 'yyyy-MM-dd').txt"
        Start-Sleep -Seconds 3
    }
    else {
        clear-host
        Write-Host "Mauvais choix - Retour au menu précédent"
        Start-Sleep -Seconds 2
    }
}

