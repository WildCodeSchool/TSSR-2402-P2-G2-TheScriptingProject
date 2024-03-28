# TSSR-2402-P2-G2-TheScriptingProject

## Documentation Administrateur

- Pré-requis techniques
- Etapes d'installation et de configuration
- FAQ


## Etapes d'installation et de configuration

### I. Configuration du SSH

#### 1. VM Windows Server
- Exécuter Powershell en "**mode administrateur**"

- Pour installer le service SSH :
```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server
```
  
![SSH_WinServ_1](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/SSH%20WinServ/SSH_WinServ_1.jpg)



- Pour un démarrage automatique :

```powershell 
Set-Service sshd -StartupType Automatic
```

![SSH_WinServ_2](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/SSH%20WinServ/SSH_WinServ_2.jpg)



- Redémarer la VM et vérifier dans les Services que le serveur OpenSSH est bien "**en cours**" et en "**démarrage automatique**"

![SSH_WinServ_4](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/SSH%20WinServ/SSH_WinServ_4.jpg)




#### 2. VM Ubuntu Client

- Exécuter le Terminal

- Pour installer le service SSH :
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



- Pour terminer, génerer une clé à destination de Windows Server :  
```bash
ssh-keyscan -t rsa 172.16.10.10
```

![gen](https://raw.githubusercontent.com/WildCodeSchool/TSSR-2402-P1-G1-SecurisationDeMotDePasse/main/Images/Images%20Greg/generer%20cl%C3%A9%20ubuntu.PNG)


