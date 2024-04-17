# TSSR-2402-P2-G2-TheScriptingProject

- Présentation du projet & Objectifs finaux
- Introduction : Mise en contexte
- Membres du groupe de projet & Rôles par sprint
- Choix techniques
- Difficultés rencontrées
- Solutions trouvées
- Améliorations possibles

## Présentation du projet :

Notre projet consistera à créer un script éxécutable sur une machine afin d'effectuer des tâches sur des machines distantes.

## Introduction : Mise en contexte 

Imaginons un environnement informatique dans une entreprise où plusieurs machines sont connectées à un réseau local. Le but de notre projet est d'automatiser certaines tâches récurrentes ou à récupérer des informations sur ces machines à distance, sans nécessiter une intervention manuelle sur chaque machine.

## Membres du groupe de projet & Rôles par sprint

| Sprint  | Anaïs | Bruno | Grégory | Patrick | Thomas |
|   :---------: |  :-------: | :---------: |  :-------: | :-------: | :-------: |
| 5 |  Préparation documents | **PO** - Pseudo-Code/squelette |  Prépa 2 VM  Windows | **SM** - Pseudo-Code/squelette | Prépa 2 VM Linux |
|  6 |  Préparation documents | Script menu, Assemblage et layout du script final|  **SM** Script action utilisateur et Script information utilisateur| Script information ordinateur | **PO** Script action ordinateur présentation sprint|
| 7 |  :-------: | **SM** Code powershell & support | Test script bash & code powershell | **PO** Script PS info_utilisateur | Script action ordinateur PS & Menu PS |           
| 8 |  :-------: | :---------: |  **PO** | :-------: | **SM** |  
| 9 |  :-------: | :---------: |  :-------: | :-------: | :-------: |  
## Prérequis techniques :

Pour mener à bien le projet nous avons besoin de deux VM serveur et deux VM client:

**VM Serveur Debian 12.2**
 - Nom de Machine : SRVLX01
 - Utilisateur : root
 - Mot de passe : Azerty1*
 - IP adresse : 172.16.10.10/24

**VM client Ubuntu 22.04 LTS**
 - Nom de Machine : CLILIN01
 - Utilisateur : wilder (dans le groupe sudo)
 - Mot de passe : Azerty1*
 - IP adresse : 172.16.10.30/24

**VM Windows Server 2022**
 - Nom de Machine : SRVWIN01
 - Utilisateur : Administrator (dans le groupe des admins locaux)
 - Mot de passe : Azerty1*
 - IP adresse : 172.16.10.05/24

**VM cleint Windows 10**
 - Nom de Machine : cliWIN01
 - Utilisateur : wilder (dans le groupe des admins locaux)
 - Mot de passe : Azerty1*
 - IP adresse : 172.16.10.20/24

## Difficultés rencontrées :
Durant le projet les principaux probleme on ete observer au niveaux du script power shell. 

## Solutions trouvées :

## Améliorations possibles :
