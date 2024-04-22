
# TSSR-2402-P2-G2-TheScriptingProject

- Présentation du projet & Objectifs finaux
- Introduction : Mise en contexte
- Membres du groupe de projet & Rôles par sprint
- Choix techniques
- Difficultés rencontrées
- Solutions trouvées
- Améliorations possibles

## Présentation du projet

Notre projet consistera à créer un script éxécutable sur une machine afin d'effectuer des tâches sur des machines distantes.

## Introduction : Mise en contexte

Imaginons un environnement informatique dans une entreprise où plusieurs machines sont connectées à un réseau local. Le but de notre projet est d'automatiser certaines tâches récurrentes, et de récupérer des informations sur ces machines à distance, sans nécessiter une intervention manuelle sur chacune d'entre elles.

## Membres du groupe de projet & Rôles par sprint

| Sprint  | Anaïs | Bruno | Grégory | Patrick | Thomas |
|   :---------: |  :-------: | :---------: |  :-------: | :-------: | :-------: |
| 1 |  Préparation documents | **PO** - Pseudo-Code/Squelette |  Prépa 2 VM  Windows | **SM** - Pseudo-Code/Squelette | Prépa 2 VM Linux |
| 2 |  Préparation documents | Script menu, Assemblage & Layout du script final|  **SM** - Script "Action Utilisateur" et Script "Information Utilisateur" | Script "Information Ordinateur" | **PO** - Script "Action Ordinateur" & Présentation sprint|
| 3 |  Préparation documents | **SM** - Code PowerShell & Support | Test script Bash & Script PS "Action Utilisateur" | **PO** - Script PS "Information Ordinateur" | Script "Action Ordinateur" PS & Menu PS |           
| 4 |  Préparation documents | Finalisation script PS & Fichier de journalisation | **PO** - Script PS "Information Utilisateur" & Documentation | Script PS "Information Ordinateur" & Documentation | **SM** - Debug script PS & Journalisation & Présentation|  



## **Choix techniques et contraintes**

Pour mener à bien le projet nous avons besoin de deux VM Server et deux VM Client.

Pour la communication entre VM Serveur et VM Client nous avons opté pour :

- Debian -> Ubuntu = **Protocole SSH**
- Windows Server -> Windows 10 = **Service WinRM**

### **VM Serveur**

| | Windows Server 2022 | Debian Server 12 |
|   :---------: |  :-------: | :-------: |
| Nom | `SRVWIN01` | `SRVLX01` |
| Utilisateur | `Administrator` | `root` |
| Mot de passe | `Azerty1*` | `Azerty1*` |
| Adresse IP | `172.16.10.5/24` | `172.16.10.10/24` |
| Configuration requise | `Powershell V. 7.4.1` + Service `WinRM` | `Protocole SSH` |

### **VM Client**

| | Windows 10 | Ubuntu 22.04 LTS 02 | 
|:-:|:-:|:-:|
| Nom | `CLIWIN01` | `CLILIN01` |
| Utilisateur | `wilder` | `wilder` |
| Mot de passe | `Azerty1*` | `Azerty1*` |
| Adresse IP | `172.16.10.20/24` | `172.16.10.30/24` |
| Configuration requise | Installation `WinRM` + [Chocolatey](https://community.chocolatey.org/courses/installation/installing)| `Protocole SSH` + Paquets |

***Vous trouverez le détail de l'installation à réaliser sur chaque poste dans la documentation annexe : [Install.md](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/main/INSTALL.md)***

## Difficultés rencontrées :

Concernant le script Bash (environnement Linux) nous n'avons pas rencontré de problématiques bloquantes ou complexes à résoudre.

En revanche sur la partie Windows, les principaux problèmes ont été observés essentiellement sur l'écriture du script Powershell (liés à certaines fonctions) :

- Mise à jour du système (Windows Update) :
  - Impossible de faire les mise à jour via le module PSWindowsUpdate nous rencontrons une erreur que nous ne pouvons résoudre 
  - Impossible de les faire via KBUpdate, comme avec PSWindowsUpdate, cela ne fonctionne pas.
- Fonction "Liste des sessions ouvertes par l'utilisateur" (N'affiche pas le même résultat que le script Bash)
- Installation de logiciels tiers
- Caratères spéciaux qui ne s'affichent pas correctement


## Solutions trouvées :

Installation du software **[Chocolatey](https://community.chocolatey.org/courses/installation/installing)** pour palier à la problématique citée ci-dessus : _installation logiciels tiers_

>La première version du script Powershell comprenait conjointement le protocole SSH et le service WinRM pour effecutuer les actions sur la machine client.
Afin d'optimiser l'ergonomie et de simplifier l'utilisation du script, nous avons décider de nous passer du protocole SSH. Chaque fonction a été réécrite en utilisant la commande liée au service WinRM :

```powershell
Invoke-Command -ComputerName "<NomDuPcClient>" Credential -ScriptBlock { Get-Process }
```


## Améliorations possibles :

Les deux scripts sont fonctionnels, cependant il subsiste des améliorations possibles :

**1. Mise à jour Windows via Script**
- Il est envisagé d'utiliser la solution Active Directory pour pouvoir faire les mises à jour Windows.

**2. Ergonomie/Utilisation**
- Ajout de couleurs
- Gestion des erreurs
- Traitement des fichiers de journalisation (Pour optimiser la consultation)
- Script Bash : Ajouter un rappel des interfaces réseaux disponibles lors de la consultation des adresses IP et/ou adresses MAC.
- Script PowerShell : trouvez la solution pour l'affichage correct des caractères spéciaux.

