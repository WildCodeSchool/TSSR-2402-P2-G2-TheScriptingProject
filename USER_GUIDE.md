# TSSR-2402-P2-G2-TheScriptingProject

## Documentation Utilisateur

Vous trouverez ci-dessous la notice d'utilisation du Super-Script, permettant d'effectuer des actions et de récupérer des informations sur un poste distant.

### Utlisation basique

#### Présentation du script

Le Super-Script est divisé en deux parties identiques :

- Le script SuperScript.sh, qui s'éxécute depuis un poste sous OS `Debian` vers un poste sous OS `Ubuntu`
- Le script SuperScript.ps1, qui s'éxécute depuis un poste sous OS `Windows Server 2022` vers un poste sous OS `Windows 10 Pro`

Notre dernière version de ce script a été optimisée avec la plus grande attention afin de garantir la meilleure utilisation possible

Voici un schéma expliquant son fonctionnement :


![Schema Script](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/assets/159007018/57a6a2ce-a84f-48ea-b7be-18505148cebe)



Bien evidemment, une option permettant de revenir au menu principal et au menu précédent est incluse dans chaque sous-menu

#### Exécution du script

L'éxécution du script est légérement différente suivant l'OS à partir duquel vous vous trouvez : 

- Sous Debian 12, la commande est la suivante : ```root@SRVLX01:<chemin_du_script> bash SuperScript.sh```
- Sous Windows Server 2022, la commande est la suivante : ```PS <chemin_du_script> .\SuperScript.ps1```


Une fois lancé, quelques informations vous seront demandées avant d'accéder au Menu Principal :

- Entrer le nom d'utilisateur du poste distant (Dans notre exemple, il s'agit de l'utilisateur `wilder`).
- Entrer l'adresse IP du poste distant (Dans notre exemple, il s'agit de `172.16.10.20` pour le poste sur Windows 10 Pro, et `172.16.10.30` pour le poste sur Ubuntu).
- Identification : Par exemple votre prénom, afin de faciliter la consultation des fichiers de journalisation.

## FAQ

**Q. J'ai une erreur, que faire ?**

*R. Dans ce cas, vérifiez bien que les informations entrées au lancement du script soient bonnes, notament le nom de l'utilisateur distant et l'adresse IP du poste ciblé.
Pensez à vérifier également que les pré-requis, disponibles dans la notice Administrateur [INSTALL.md](https://github.com/WildCodeSchool/TSSR-2402-P2-G2-TheScriptingProject/blob/main/INSTALL.md), aient bien été tous appliqués.
Si vous rencontrez toujours des erreurs après ces vérifications, contactez votre administrateur réseau.*

**Q. Que puis-je faire avec le Super-Script ?**

*R. Le Super-Script montre toute son efficacité dans le cadre de la récupération d'informations (Espace mémoire restant, liste des utilisateurs locaux, état du pare-feu, etc ... ), mais également pour la réalisation d'actions (Arrêt/Redémarrage du poste, création de comptes utilisateurs, installation de logiciels, etc ...).*

**Q. La mise à jour du système via le SuperScript.ps1 ne fonctionne pas, comment faire ?**

*R. Le problème est connu et nos équipes n'ont pas encore trouvé de solution à ce problème, en attendant de trouver un paliatif, vous pouvez toujours effectuer la mise à jour du poste distant via l'option "Prise de main à distance".*

**Q. Où sont situés les fichiers de journalisation ?**

*R. Voici la marche à suivre pour consulter les fichiers de journalisation :*

*Les fichiers de log se situent :*
 - *Pour le serveur Windows :* `C:\Windows\System32\LogFiles`
 - *Pour le serveur Linux :* `/var/log`

*Les fichier d'informations se situent :* 
 - *Pour le serveur Windows -> Dans le dossier Documents de la session qui éxécute le script* (*Par défaut :* `C:\Users\Administrator\Documents`)
 - *Pour le serveur Linux -> Dans le dossier Documents de la session qui éxécute le script* (*Par défaut* : `/root/Documents`)
