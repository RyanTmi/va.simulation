# Simulation de variables aléatoire

## Sommaire

1. [Informations](#informations)
2. [Installation](#installation)
   1. [Avec **RStudio**](#avec-rstudio)
   2. [Sans **RStudio**](#sans-rstudio)
3. [Tester le projet](#tester-le-projet)

## Informations

Dans ce repertoire vous trouverez les différent fichier qui compose le projet :

- Le [sujet](Sujet.pdf)
- Le [support de projet](Elements.of.Information.Theory.Jul.2006.pdf)
- Le [rapport](Rapport.pdf)

Le projet contient du code R, il est donc nécessaire d'avoir R pour pouvoir le tester.

## Installation

Pour pouvoir utiliser le code vous devez installer les packages suivant en executant les commandes suivantes dans une console R :

```r
install.packages("R6")
install.packages("collections")
install.packages("tictoc")
```

Selon si vous avez **RStudio** utilisez les méthodes suivantes:

### Avec **RStudio**

Dans le répertoire **va_simulation** se trouve le projet **RStudio** qui contient le code source du projet. Vous pouvez tester le projet avec.

Dans **RStudio** dans l'onglet **Build**, cliquer sur **Install**.

Vous pouvez maintenant tester le projet.

### Sans **RStudio**

Lancer R via un terminal ou la console graphique depuis le repertoire dans lequel se trouve l'archive, sinon déplacez-vous dans ce repertoire avec la fonction `setwd("chemin-vers-le-repertoire")`.

Il suffit d'executer les commandes suivantes :

```r
install.packages("va.simulation_1.0.0.tar.gz", repos=NULL, type="source")
library(va.simulation)
```

## Tester le projet

Voici un exemple pour tester le projet :

```r
# ?tests_random_va pour avoir des infos sur la fonction tests_random_va

freqs <- c(0.4, 0.4, 0.2)
tests_random_va(freqs, plot=FALSE)
# plot=FALSE indique qu'il n'y aura pas d'affichage
# par default plot=TRUE
```
