# TSSR-2402-P2-G2-TheScriptingProject

## Documentation Administrateur

## Configuration des VM (Important)

## 1. VM Windows 10 Client

### Prérequis : 
 - Nom de Machine : CLIWIN01
 - Utilisateur : wilder (dans le groupe des admins locaux)
 - Mot de passe : Azerty1*
 - IP adresse : 172.16.10.20/24

### Configuration obligatoire :

* Désactivation du pare-feu,
Ouvrir une console PowerShell en administrateur 
```powershell
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
```

* Installer le logiciel Chocolatey :
```powershell
Set-ExecutionPolicy AllSigned -Scope Process -Force; iwr https://community.chocolatey.org/install.ps1 -UseBasicParsing | iex
```

* Configuration de démarrage automatique et démarrage du service **Registre Distant**
![registre](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/Dev/Ressources/Image_Greg/registre.PNG?raw=true)


* Créer un compte identique au compte administrateur du serveur : **Administrator** et le mettre dans le groupe des **administrateurs locaux**

![admin](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/Dev/Ressources/Image_Greg/admin.PNG?raw=true)

* Ouvrir une console PowerShell en administrateur
```powershell
# Récupérer l'index de l'interface
Get-NetConnectionProfile
# Modifier le profile
Set-NetConnectionProfile -InterfaceIndex <Index> -NetworkCategory Private
# Si le pare-feu est activé mettre l'exception WinRM
Enable-NetFirewallRule -Name WINRM-HTTP-In-Tcp
```
* Ouvrir un terminal **cmd.exe** en administrateur et exécuter les commandes :
```cmd
# Configuration du LocalAccountTokenFilterPolicy
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f

# Configuration du WinRM
winrm quickconfig
```

* Il est probable que le service WinRM ne soit pas configuré pour démarrer automatiquement. Voici comment le configurer pour un démarrage automatique :

1. Ouvre une console PowerShell en tant qu'administrateur.
2. Exécute la commande suivante :
    ```powershell
    Set-Service -Name winrm -StartupType 'Automatic'
    ```
3. Pour démarrer le service immédiatement, utilise :
    ```powershell
    Start-Service -Name winrm
    ```

Après ces étapes, le service WinRM devrait démarrer automatiquement à chaque redémarrage de la machine.

## 2. VM Windows Server 2022

### Prérequis : 

- Nom de Machine : SRVWIN01
- Utilisateur : Administrator (dans le groupe des admins locaux)
- Mot de passe : Azerty1* 
- IP adresse : 172.16.10.05/24

### Configuration obligatoire :

**Ajouter le PC client à la liste des hôte de confiance avec la commande :**
```powershell
Set-Item WSMan:\localhost\Client\TrustedHosts -Value *
```
(le caractère "*" permet d'ajouter toutes les machines clientes distantes, qu'importe leurs adresses IP)

**Installation Powershell 7.4.1**



- Pour installer PowerShell sur Windows, utilisez le lien suivant pour télécharger le package d’installation depuis GitHub.

[PowerShell-7.4.1-win-x64.msi](https://github.com/PowerShell/PowerShell/releases/download/v7.4.1/PowerShell-7.4.1-win-x64.msi)

- Une fois le package téléchargé, double-cliquez sur le fichier du programme d’installation.

![install](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/Dev/Ressources/Image_Greg/install2.PNG?raw=true)

Suivez les invites.

![installok](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/Dev/Ressources/Image_Greg/install.PNG?raw=true)

_Par défaut, le package est installé dans C:\ProgramFiles\PowerShell\7_

Vous trouverez Powershell 7.4.1 dans les applications.

![find](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/Dev/Ressources/Image_Greg/find.PNG?raw=true)

## 3. VM Ubuntu Client 22.04 LTS

#### Prérequis : 
 - Nom de Machine : CLILIN01
 - Utilisateur : wilder (dans lse groupe sudo)
 - Mot de passe : Azerty1*
 - IP adresse : 172.16.10.30/24

#### Configuration obligatoire :
**A. Installation SSH**

 - Exécuter le Terminal

```bash
sudo apt-get install openssh-server
```

![UBUNTU](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/Images%20Greg/install%20ssh%20Ubuntu%201.PNG)

Lors du message : **`Souhaitez-vous continuer ? [O/n]`**-> Taper **`O`**


- Une fois le SSH installé, il faut l'activer :
```bash
 sudo systemctl enable ssh
```

![active](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/Images%20Greg/activation%20ssh%20ubuntu.PNG)


**B. Installation des paquets nécessaires** 

- Exécuter le Terminal

- Pour installer le paquet de la commande ifconfig faire :
  ```bash
  sudo apt install net-tools
  ```

  ![](https://www.cjoint.com/doc/24_04/NDro5ObmV1n_IFconfig.png)

- Pour installer le paquet de la commande
  ```bash
  sudo apt install sysstat
  ```
  ![](https://www.cjoint.com/doc/24_04/NDrpmkMXM2n_Bash-proceseru.png)

## 4. VM Debian Server 12.2

- Nom de Machine : SRVLX01
- Utilisateur : root
- Mot de passe : Azerty1*
- IP adresse : 172.16.10.10/24

Installer SSH :
```bash
sudo apt-get install openssh-server
```

- Une fois le SSH installé, il faut l'activer :
```bash
 sudo systemctl enable ssh
```

## 5. F.A.Q 

**Q. Une fonctionnalité du script ne semble pas fonctionner ?**

*R. Vérifiez les pre-requis d'installation, vérifiez que la connexion est bonne et bien configurée (SSH pour Linux , configuration WinRM pour Windows)
Vérifiez également que la commande, necessitant un utilisateur ou un fichier/dossier, ait bien été renseignée.*

**Q. Les deux scripts sont-ils identiques ?**

*R. Les systèmes d'exploitation étant différents, les deux scripts le sont également.
De plus, la mise à jour de l'OS via le script PowerShell n'etant pas encore fonctionnelle, nos équipes travaillent actuellement sur une solution alternative.*

**Q. Le script PowerShell ne veut pas se lancer, j'ai un message évoquant un problème de droit  ?**

*R. Vérifiez que le script est bien lancé en mode administrateur et vérfiez bien la stratégie d'exécution du poste Serveur. 
Via la commande `Get-ExecutionPolicy -list` sous PowerShell vérifiez que pour **CurrentUser** vous être bien **Unrestricted**, le cas contraire veuillez rentrez la commande suivante `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted`
