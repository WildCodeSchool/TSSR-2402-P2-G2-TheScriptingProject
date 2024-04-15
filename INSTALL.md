# TSSR-2402-P2-G2-TheScriptingProject

## Documentation Administrateur

- Pré-requis techniques

### A. Installation Powershell 7.4.1

**Sur la VM server Windows SRVWIN01 uniquement**

- Pour installer PowerShell sur Windows, utilisez le lien suivant pour télécharger le package d’installation depuis GitHub.

[PowerShell-7.4.1-win-x64.msi](https://github.com/PowerShell/PowerShell/releases/download/v7.4.1/PowerShell-7.4.1-win-x64.msi)

- Une fois le package téléchargé, double-cliquez sur le fichier du programme d’installation.

![install](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/Dev/Ressources/Image_Greg/install2.PNG?raw=true)

Suivez les invites.

![installok](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/Dev/Ressources/Image_Greg/install.PNG?raw=true)

_Par défaut, le package est installé dans C:\ProgramFiles\PowerShell\7_

Vous trouverez Powershell 7.4.1 dans les applications.

![find](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/Dev/Ressources/Image_Greg/find.PNG?raw=true)

### B. Configuration du SSH

**Important : Action à réaliser sur les VM server Windows SRVWIN01 et client CLIWIN01**

- Exécuter Powershell en "mode administrateur"

- Pour installer le service SSH :
```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server
```
  
![SSH_WinServ_1](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/SSH%20WinServ/SSH_WinServ_1.jpg)

<br>

- Pour un démarrage automatique :

```powershell 
Set-Service sshd -StartupType Automatic
```

![SSH_WinServ_2](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/SSH%20WinServ/SSH_WinServ_2.jpg)

<br>

- Redémarer la VM et vérifier dans les Services que le serveur OpenSSH est bien "**en cours**" et en "**démarrage automatique**"

![SSH_WinServ_4](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/SSH%20WinServ/SSH_WinServ_4.jpg)








- FAQ
