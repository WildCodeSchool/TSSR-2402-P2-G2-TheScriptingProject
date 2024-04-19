
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

Imaginons un environnement informatique dans une entreprise où plusieurs machines sont connectées à un réseau local. Le but de notre projet est d'automatiser certaines tâches récurrentes ou à récupérer des informations sur ces machines à distance, sans nécessiter une intervention manuelle sur chaque machine.

## Membres du groupe de projet & Rôles par sprint

| Sprint  | Anaïs | Bruno | Grégory | Patrick | Thomas |
|   :---------: |  :-------: | :---------: |  :-------: | :-------: | :-------: |
| 1 |  Préparation documents | **PO** - Pseudo-Code/squelette |  Prépa 2 VM  Windows | **SM** - Pseudo-Code/squelette | Prépa 2 VM Linux |
|  2 |  Préparation documents | Script menu, Assemblage et layout du script final|  **SM** Script action utilisateur et Script information utilisateur| Script information ordinateur | **PO** Script action ordinateur présentation sprint|
| 3 |  Préparation documents | **SM** Code powershell & support |  Test script bash & Script PS action utilisateur | **PO** Script PS info ordinateur | Script action ordinateur PS & Menu PS |           
| 4 |  Préparation documents | Finalisation script PS & fichier journalisation |  **PO** Script PS info utilisateur & Documentation | Script PS info ordinateur & Documentation| **SM** Debug script PS et journalisation & Présentation|  



## **Choix techniques et contraintes**

### **VM Serveur**

Pour mener à bien le projet nous avons besoin de deux VM serveur et deux VM client.

Pour la communication entre VM Serveur et VM Client nous avons opté pour :

- Debian -> Ubuntu = **Protocole SSH**
- Windows Server -> Windows 10 = **Service WinRM** 

||Windows Server 2022|Debian Server 14|
|:-:|:-:|:-:|
|Nom de Machine| SRVWIN01 |SRVLX01|
|Utilisateur|Administrator|root |
|Mot de passe|Azerty1*|Azerty1*|
|Adresse IP|172.16.10.5/24|172.16.10.10/24|
|Configuration requise|Powershell V 7.4.1 + service WinRM | Protocole SSH |

### **VM Client**

||Windows 10|Ubuntu 22.04 LTS 02| 
|:-:|:-:|:-:|
|Nom de Machine|CLIWIN01|CLILIN01|
|Utilisateur|wilder|wilder|
|PMot de passe|Azerty1*|Azerty1*|
|Adresse IP |172.16.10.20/24|172.16.10.30/24|
|Configuration requise|Installation WinRM + Chocolatey|Protocole SSH + Paquets |

**_Vos trouverez le détail de l'installation à réaliser sur chaque poste dans la documentation annexe :_ [Install.md](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/main/INSTALL.md)**

## Difficultés rencontrées :

Concernant le script Bash (environnement Linux) nous n'avons pas rencontré de problématiques bloquantes ou complexes à résoudre.

En revanche sur la patie Windows, les principaux problèmes on été observés essentiellement sur l'écriture du script Powershell (liés à certaines fonctions) :

- Mise à jour 
- Fonction "Liste des sessions ouvertes par l'utilisateur" (n'affiche pas le même résultat que sous le script bash)
- Installation de logiciels tiers


## Solutions trouvées :

Installation du software **Chocolatey** pour palier à la problématique cité ci-dessus : _installation logiciels tiers_

>La première version du script Powershell comprenait conjointement le protocole SSH et le service WinRM pour effecutuer les actions sur la machine client.
Afin d'optimiser l'ergonomie et simplifier l'utilisation du script, nous avons décider de nous passer du protocole SSH. Chaque fonction a été réécrite en utilisant la commande liée au service WinRM :

```powershell
Invoke-Command -ComputerName "<NomDuPcClient>" Credential -ScriptBlock { Get-Process } - 
```


## Améliorations possibles :

Les deux scripts sont fonctionnels, cependant il subsiste des améliorations possibles :

**1. Connexion réseau**
- Il est envisagé d'utiliser la solution Active Directory pour remplacer les protocoles SSH et WinRM.


**2. Ergonomie/Utilisation**
- Ajout de couleurs
- Gestion des erreurs
- Traitement des fichiers de journalisation (optimiser la consultation)

