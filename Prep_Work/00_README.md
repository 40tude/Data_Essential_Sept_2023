<!-- ------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------- -->
# VSCode
* CTRL K V : prevue markdown
* SHIFT ALT T  - CTRL 1 : focus terminal - focus editeur
* 

# Markdown

## Math en ligne
$H_0$ est ...

## Equations

$$ \int_\Omega \nabla u \cdot \nabla v~dx = \int_\Omega fv~dx $$
$$ \frac{x^2}{y_1} $$

## Commentaires

```
<!-- Comment -->
```


<!-- ------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------- -->
# Python Notebook & VSCode

## Keyboard shortcuts
* CTRL + ENTER : execute cellule
* CTRL + M + A : ajouter une cellule **Above**
* CTRL + M + B : ajouter une cellule **Below**
* Ctrl-M m : Passer la cellule en mode texte
* Ctrl-M y : Passer la cellule en mode code
* DD : supprimer la cellule
* ALT + SUPPR : effacer une sortie


## Lire un fichier dans le bon répertoire en mode debug dans VSCode

```
cwd = os.getcwd()
ScriptDir = os.path.dirname(os.path.realpath(__file__))
os.chdir(ScriptDir)
...
os.chdir(cwd)

```


## Convertir un notebook en code python
Dans une console
```
jupyter nbconvert --to python MyNotebook.ipynb 
```


## Redirection des IO depuis un fichier
```
import sys
import os

RedirectIOToFile = True

if RedirectIOToFile:
    gCwd = os.getcwd()
    gScriptDir = os.path.dirname(os.path.realpath(__file__))
    os.chdir(gScriptDir)
    sys.stdin = open("./Inputs.txt")

def CloseIO()->None:
    if RedirectIOToFile:
        sys.stdin.close()
        os.chdir(gCwd)

if __name__ == '__main__':
    # Reste du code
    CloseIO()
```





<!-- ------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------- -->
# Github & VSCode

## IMPORTANT
* Dans VSCode dans les parametres j'ai
  * désactivé le git : Confirm Sync
  * activé le git : Enable Smart Commit  

## Voir cette vidéo 
* https://youtu.be/hwqgzZBsc_I

## Pour débuter
* Installer Git sur la machine
  * Penser dans la console à saisir
    * git config --global user.name "Philippe BAUCOUR"
    * git config --global user.email philippe.baucour@gmail.com
  * Vérification avec : git config --list --show-origin
* Dans VSCode activer le compte 40tude de Github 
  * En bas à gauche cliquer la vignette au-dessus de la roue crantée
* Dans VSCode, clic icone controle code source
* Choisir Publier sur GitHub
  * Public repo
  * On peut choisir les sous répertoire à exclure/inclure

## Synchro
* En bas de la fenêtre VSCode, cliquer sur main

## Ajout d'un fichier
* Dans l'explorer de VSCode
* Je crée un fichier
* Dans le controle de code il est U (non suivi)
* Je clique sur + pour stager les modifications
* Je peux aussi cliquer sur le + en face de changement pour stager toutes les modifs
* Après je met un message de commit
* J'appuie sur Validation (commit) ou l'option Validation et Push

## Suppression d'un fichier
* Je supprime le fichier
* J'appuie sur le + en face de changements
* Message de commit
* Appuis sur Validation

## Résolution de problèmes
* Chronologie
  * En bas à panel de gauche
* Extensions
  * Git Graph
  * GitLens

## Alternative
* CTRL+SHIFT + P 
  * git:init
  * git:remote // pour ajouter dépot distant autre que github

## Cas où on peut pas faire le merge
* Boite de diag : You have not concluded your merge...
* Ouvrir la console, aller dans le répertoire du projet
* git merge --continue
* Accepter le nom de commit
* Revenir dans VSCode
* Push les modifications