#!/bin/bash
DIALOG=${DIALOG=dialog}

function create {
	if [ -f infos ]
		then
			rm infos
	fi
	if saisirNom "Saisir le nom de la base" "namedb"
		then
			connexion
			clear
			echo "saisie terminée"
		else 
			echo "erreur"
			clear
	fi
	
}

function saisirNom {
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15

	$DIALOG  --backtitle "Utilisation de bases de données avec BASH" --title "Saisie des informations" --clear \
        --inputbox "$1"  8 51  "test" 2> $tempfile
val=$?
case $val in
  0)
	echo "$2=`cat $tempfile`" >> infos
    return 0;;
  1)
    return -1;;
  255)
    if test -s $tempfile ; then
      cat $tempfile
    else
      echo "ESC pressed."
    fi
    ;;
esac
}

function saisirMdp {
	tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
	trap "rm -f $tempfile" 0 1 2 5 15

	$DIALOG  --backtitle "Utilisation de bases de données avec BASH" --title "Saisie des informations" --clear \
        --insecure --passwordbox "Le mot de passe de la basse"  8 51 2> $tempfile
val=$?
case $val in
  0)
	echo "mdp=`cat $tempfile`" >> infos
    return 0;;
  1)
    return -1;;
  255)
    if test -s $tempfile ; then
      cat $tempfile
    else
      echo "ESC pressed."
    fi
    ;;
esac
}

function connexion {
	selectionBase
	saisirNom "Saisir le login " "login"
	saisirMdp
	
}
function selectionBase {
	
		tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
		trap "rm -f $tempfile" 0 1 2 5 15

	$DIALOG --backtitle "Utilisation de bases de données avec BASH" \
		--title "Les Serveurs de Bases de données" --clear \
		--radiolist "Veuillez selectionner dans la liste  \n\
				suivante une base de données\n\
				La sélection est effectuée par la touche espace\n\n\ " 20 61 5 \
			"Mysql"  "le serveur Mysql." ON \
			"Sqlite"    "Le serveur de python." off \
			"Oracle" "Le serveur propriétaire d'oracle." off \
			"Mariadb"    "Le serveur remplaçant mysql." off 2> $tempfile
	retval=$?
	case $retval in
	0)
		echo "db=`cat $tempfile`" >> infos;;
	1)
		echo "Cancel pressed.";;
	255)
		echo "ESC pressed.";;
	esac
}

function Accueil {
	
	fichtemp=`tempfile 2>/dev/null` || fichtemp=/tmp/test$$
	trap "rm -f $fichtemp" 0 1 2 5 15
	$DIALOG --clear  --backtitle "Utilisation de bases de données avec BASH" --title "Gestionnaire de bases de données" \
		--menu "Choisir les action à effectuer au niveau de notre de données" 20 51 4 \
		"Creation" "Créer une base de données" \
		"Insertion" "Insérer dans une base de données" \
		"Modification" "Modifier une insertion" \
		"Suppression" "Supprimmer une insertion" 2> $fichtemp
	val=$?
	choix=`cat $fichtemp`
	case $val in
	0)	echo "'$choix' est votre choix"
	if test $choix = 'Creation'
		then 
			create
		fi;;
	1)	echo "Appuyez sur Annuler.";;
	255)	echo "Appuyez sur Echap.";;
	
esac
}

function insertionBase {
	nomdb=$1
	db=$2
	mdp=$3
	
}

Accueil
