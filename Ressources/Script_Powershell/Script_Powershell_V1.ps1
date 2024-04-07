function Menu_Principal {
    Clear-Host
    Write-Host "=================================="
    Write-Host "|         Menu Principal        | "
    Write-Host "=================================="
    Write-Host ""
    Write-Host "Machine distante : "
    Write-Host ""
    Write-Host "Bonjour, voici les différents choix possibles à effectuer sur le poste distant :"
    Write-Host ""
    Write-Host "[1] ACTION sur UTILISATEUR ou POSTE"
    Write-Host "[2] INFORMATION sur UTILISATEUR ou POSTE"
    Write-Host ""
    Write-Host "[X] Arrêter le script "
    Write-Host ""

    do {
        $ChoixMenuPrincipal = Read-Host "Veuillez faire votre choix : "

        Switch ($ChoixMenuPrincipal) {
            "1" { 
                Write-Host ""
                Write-Host "Vous avez choisi ACTION"
                Menu_Action
                break
            }

            "2" { 
                Write-Host ""
                Write-Host "Vous avez choisi Information"
                Menu_Information
                break
            }

            "X" { 
                Write-Host ""
                Write-Host "Arrêt du script"
                exit 
            }

            Default { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
            }
        }
    } while ($true)
}

function Menu_Action {
    Clear-Host
    Write-Host "=================================="
    Write-Host "|             ACTION            | "
    Write-Host "=================================="
    Write-Host ""
    Write-Host "Machine distante : "
    Write-Host ""
    Write-Host "Voici les différents choix possibles :"
    Write-Host ""
    Write-Host "[1] ACTION sur UTILISATEUR"
    Write-Host "[2] ACTION sur POSTE"
    Write-Host ""
    Write-Host "[X] Retour au menu principal"
    Write-Host ""

    do {
        $ChoixMenuAction = Read-Host "Veuillez faire votre choix : "

        Switch ($ChoixMenuAction) {
            "1" { 
                Write-Host ""
                Write-Host "Vous avez choisi ACTION sur UTILISATEUR"
                Menu_Action_Utilisateur
                break
            }

            "2" { 
                Write-Host ""
                Write-Host "Vous avez choisi ACTION sur POSTE"
                Menu_Action_Poste
                break
            }

            "X" { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Menu_Principal 
            }

            Default { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
            }
        }
    } while ($true)
}

function Menu_Information {
    Clear-Host
    Write-Host "=================================="
    Write-Host "|          INFORMATION           | "
    Write-Host "=================================="
    Write-Host ""
    Write-Host "Machine distante : "
    Write-Host ""
    Write-Host "Voici les différents choix possibles :"
    Write-Host ""
    Write-Host "[1] INFORMATION sur UTILISATEUR"
    Write-Host "[2] INFORMATION sur POSTE"
    Write-Host ""
    Write-Host "[X] Retour au menu principal"
    Write-Host ""

    do {
        $ChoixMenuInformation = Read-Host "Veuillez faire votre choix : "

        Switch ($ChoixMenuInformation) {
            "1" { 
                Write-Host ""
                Write-Host "Vous avez choisi INFORMATION sur UTILISATEUR"
                Menu_Information_Utilisateur
                break
            }

            "2" { 
                Write-Host ""
                Write-Host "Vous avez choisi INFORMATION sur POSTE"
                Menu_Information_Poste 
                break
            }

            "X" { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Menu_Principal 
            }

            Default { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
            }
        }
    } while ($true)
}

function Menu_Action_Utilisateur {
    Clear-Host
    Write-Host "=================================="
    Write-Host "|        ACTION UTILISATEUR     | "
    Write-Host "=================================="
    Write-Host ""
    Write-Host "Machine distante : "
    Write-Host ""
    Write-Host "Voici les différents choix possibles :"
    Write-Host ""
    Write-Host "[1] Création d'un compte utilisateur local"
    Write-Host "[2] Suppresion d'un compte utilisateur local"
    Write-Host "[3] Désactivation d'un compte utilisateur local"
    Write-Host "[4] Modification d'un mot de passe"
    Write-Host "[5] Ajout d'un compte à un groupe d'administration"
    Write-Host "[6] Ajout d'un compte à un groupe local"
    Write-Host "[7] Sortie d'un compte à un groupe local"
    Write-Host ""
    Write-Host "[0] Retour au menu précédent"
    Write-Host "[X] Retour au menu principal"
    Write-Host ""

    do {
        $ChoixMenuActionUtilisateur = Read-Host "Veuillez faire votre choix : "

        Switch ($ChoixMenuActionUtilisateur) {
            "1" { 
                Write-Host ""
                Write-Host "Vous avez choisi de créer un compte utilisateur local"
                 
                break
            }

            "2" { 
                Write-Host ""
                Write-Host "Vous avez choisi de supprimer un compte utilisateur local"
                 
                break
            }

            "3" { 
                Write-Host ""
                Write-Host "Vous avez choisi de désactiver un compte utilisateur local"
                 
                break
            }

            "4" { 
                Write-Host ""
                Write-Host "Vous avez choisi de modifier un mot de passe"
                 
                break
            }

            "5" { 
                Write-Host ""
                Write-Host "Vous avez choisi d'ajouter un compte à un groupe d'administration"
                 
                break
            }

            "6" { 
                Write-Host ""
                Write-Host "Vous avez choisi d'ajouter un compte à un groupe local"
                 
                break
            }

            "7" { 
                Write-Host ""
                Write-Host "Vous avez choisi de retirer un compte d'un groupe local"
                 
                break
            }

            "0" { 
                Write-Host ""
                Write-Host "Retour au menu précédent"
                Menu_Action
                 
                break
            }

            "X" { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Menu_Principal 
            }

            Default { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
            }
        }
    } while ($true)
}

function Menu_Action_Poste {
    Clear-Host
    Write-Host "=================================="
    Write-Host "|           ACTION POSTE         | "
    Write-Host "=================================="
    Write-Host ""
    Write-Host "Machine distante : "
    Write-Host ""
    Write-Host "Voici les différents choix possibles :"
    Write-Host ""
    Write-Host "[1]  Arrêt"
    Write-Host "[2]  Redémarrage"
    Write-Host "[3]  Vérouillage"
    Write-Host "[4]  MàJ du système"
    Write-Host "[5]  Création de dossier"
    Write-Host "[6]  Suppression de dossier"
    Write-Host "[7]  Prise de main à distance"
    Write-Host "[8]  Activation du pare-feu"
    Write-Host "[9]  Désactivation du pare-feu"
    Write-Host "[10] Règles du parefeu"
    Write-Host "[11] Installation d'un logiciel"
    Write-Host "[12] Désinstallation d'un logiciel"
    Write-Host "[13] Exécution d'un script sur la machine distante"
    Write-Host ""
    Write-Host "[0] Retour au menu précédent"
    Write-Host "[X] Retour au menu principal"
    Write-Host ""

    do {
        $ChoixMenuActionPoste = Read-Host "Veuillez faire votre choix : "

        Switch ($ChoixMenuActionPoste) {
            "1" { 
                Write-Host ""
                Write-Host "Vous avez choisi d'arrêter le poste"
                 
                break
            }

            "2" { 
                Write-Host ""
                Write-Host "Vous avez choisi de redémarrer le poste"
                 
                break
            }

            "3" { 
                Write-Host ""
                Write-Host "Vous avez choisi de vérouiller le poste"
                 
                break
            }

            "4" { 
                Write-Host ""
                Write-Host "Vous avez choisi de mettre à jour le poste"
                 
                break
            }

            "5" { 
                Write-Host ""
                Write-Host "Vous avez choisi de créer un dossier"
                 
                break
            }

            "6" { 
                Write-Host ""
                Write-Host "Vous avez choisi de supprimer un dossier"
                 
                break
            }

            "7" { 
                Write-Host ""
                Write-Host "Vous avez choisi de prendre la main sur le poste"
                 
                break
            }

            "8" { 
                Write-Host ""
                Write-Host "Vous avez choisi d'activer le pare-feu sur le poste"
                 
                break
            }

            "9" { 
                Write-Host ""
                Write-Host "Vous avez choisi de désactiver le pare-feu sur le poste"
                 
                break
            }

            "10" { 
                Write-Host ""
                Write-Host "Vous avez choisi de modifier les règles du pare-feu sur le poste"
                 
                break
            }

            "11" { 
                Write-Host ""
                Write-Host "Vous avez choisi d'installer un logiciel sur le poste"
                 
                break
            }

            "12" { 
                Write-Host ""
                Write-Host "Vous avez choisi de désinstaller un logiciel sur le poste"
                 
                break
            }

            "13" { 
                Write-Host ""
                Write-Host "Vous avez choisi d'éxécuter un script sur le poste"
                 
                break
            }

            "0" { 
                Write-Host ""
                Write-Host "Retour au menu précédent"
                Menu_Action
                 
                break
            }

            "X" { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Menu_Principal 
            }

            Default { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
            }
        }
    } while ($true)
}

function Menu_Information_Utilisateur {

    Clear-Host
    Write-Host "=================================="
    Write-Host "|    INFORMATION UTILISATEUR    | "
    Write-Host "=================================="
    Write-Host ""
    Write-Host "Machine distante : "
    Write-Host ""
    Write-Host "Voici les différents choix possibles :"
    Write-Host ""
    Write-Host "[1]  Date de la dernière connexion de l'utilisateur"
    Write-Host "[2]  Date de la dernière modification du mot de passe de l'utilisateur"
    Write-Host "[3]  Liste des sessions utilisateurs ouvertes"
    Write-Host "[4]  Droits/permissions sur un dossier"
    Write-Host "[5]  Droits/permissions sur un fichier"
    Write-Host ""
    Write-Host "[0] Retour au menu précédent"
    Write-Host "[X] Retour au menu principal"
    Write-Host ""

    do {
        $ChoixMenuInformationUtilisateur = Read-Host "Veuillez faire votre choix : "

        Switch ($ChoixMenuInformationUtilisateur) {
            "1" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la date de la dernière connexion de l'utilisateur"
                 
                break
            }

            "2" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la date de la dernière modification du mot de passe de l'utilisateur"
                 
                break
            }

            "3" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des sessions utilisateurs ouvertes"
                 
                break
            }

            "4" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter les droits et permissions sur un dossier"
                 
                break
            }

            "5" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter les droits et permissions sur un fichier"
                 
                break
            }

            "0" { 
                Write-Host ""
                Write-Host "Retour au menu précédent"
                Menu_Information
                 
                break
            }

            "X" { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Menu_Principal 
            }

            Default { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
            }
        }
    } while ($true)
}

function Menu_Information_Poste {

Clear-Host
    Write-Host "=================================="
    Write-Host "|        INFORMATION POSTE      | "
    Write-Host "=================================="
    Write-Host ""
    Write-Host "Machine distante : "
    Write-Host ""
    Write-Host "Voici les différents choix possibles :"
    Write-Host ""
    Write-Host "[1]  Version de l'OS"
    Write-Host "[2]  Nombre d'interfaces réseaux"
    Write-Host "[3]  Adresse IP de chaque interface réseau"
    Write-Host "[4]  Adresse MAC de chaque interface réseau"
    Write-Host "[5]  Liste des applications / paquets installés"
    Write-Host "[6]  Liste des utilisateurs locaux"
    Write-Host "[7]  Informations CPU"
    Write-Host "[8]  Mémoire RAM totale & Utilisation"
    Write-Host "[9]  Utilisation du disque dur"
    Write-Host "[10] Utilisation du processeur"
    Write-Host "[11] Statut du pare-feu & Liste des ports ouverts"
    Write-Host ""
    Write-Host "[0] Retour au menu précédent"
    Write-Host "[X] Retour au menu principal"
    Write-Host ""

    do {
        $ChoixMenuInformationPoste = Read-Host "Veuillez faire votre choix : "

        Switch ($ChoixMenuInformationPoste) {
            "1" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la version de l'OS"
                 
                break
            }

            "2" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter le nombre d'interfaces réseaux"
                 
                break
            }

            "3" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'adresse IP de chaque interface réseau"
                 
                break
            }

            "4" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'adresse MAC de chaque interface réseau"
                 
                break
            }

            "5" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des applications / paquets installés"
                 
                break
            }

            "6" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des utilisateurs locaux"
                 
                break
            }

            "7" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la liste des informations CPU"
                 
                break
            }

            "8" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter la mémoire RAM totale et l'utilisation"
                 
                break
            }

            "9" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'utilisation du disque dur"
                 
                break
            }

            "10" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter l'utilisation du processeur"
                 
                break
            }

            "11" { 
                Write-Host ""
                Write-Host "Vous avez choisi de consulter le statut du pare-feu et la liste des ports ouverts"
                 
                break
            }

            "0" { 
                Write-Host ""
                Write-Host "Retour au menu précédent"
                Menu_Information
                 
                break
            }

            "X" { 
                Write-Host ""
                Write-Host "Retour au menu principal"
                Menu_Principal 
            }

            Default { 
                Write-Host ""
                Write-Host "Choix incorrect, veuillez recommencer."
            }
        }
    } while ($true)
}
Menu_Principal
