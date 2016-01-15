#! /bin/bash
#author oury diallo 
echo "********************************______ Authentification ____________******************************"

echo "Entrer le nom de l'utilsateur "
read name
echo "Entrer le mot de passer admin"
read pass
echo "Entrer l'adresse du serveur "
read address
echo "Entrer le nom de la base "
read base
echo "Entrer le nom de la table"
read table

#******************************le fonctions *******************************************
function supprimer(){
		    	echo "#-------------  ci-dessous le contenu de la table ---------------#"
	
		    	var=$(mysql -u $name -h $address -p$pass -D $base -e "select * from $table ")
	
		   	 if [ $? -eq 0 ] #si le code de retour de la commande est egale a 0 
    		    	   then
				mysql -u $name -h $address -p$pass -D $base -e "select * from $table "
				#var=$(mysql -u root -ppasser -D oury2 -e "select count(*) as nombre from etudiant" -s -B) #retourne le nombre de colonne du tableau	
				echo "Entrer l'id de la colonne a supprimer   "
				read id_membre
				#if [ $id_memebre -ge $var] #si la valeur entre est inferieur au nombre de colonne
				#then
				 var=$(mysql -u $name -h $address -p$pass -D $base -e "delete from $table where id=$id_membre")
				 if [ $? -eq 0 ]
				    then
					echo "          ***________  suppression reussie  __________***          "	
					echo "#-------------  ci-dessous le contenu de la nouvelle table ---------------#"
					mysql -u $name -h $address -p$pass -D $base -e "select * from $table "
					
				    else
					echo "Erreur de suppression"
				fi
		   	 else  #si le code de retour est different de 0
				echo "erreur d'execution"
		   	fi 
		    
                    }

function ajouter(){

			echo "entre le nom a inserer"
			read nom
			echo "entrer le prenom a inserer"
			read prenom

			var=$(mysql -u $name -h $address -p$pass -D $base -e "insert into $table values('','$nom','$prenom')" )
			if [ $? -eq 0 ]
			  then
				echo "      ***__________ insertion reussit ___________***  "
				echo "#-------------  ci-dessous le contenu de la nouvelle table ------------#"				
				mysql -u $name -h $address -p$pass -D $base -e "select * from $table "
				
	        	fi
		
		 }

function modifier(){
		    echo "------------------------ Choisir la modification a effectuer --------------------- -------                  "
		    echo "					 1.Ajouter une colonne  		                              "
		    echo "					 2.Supprimer un colonne		              			      "
		    echo "					 3.modifier les donnes dans la table				      "
                    #echo "					 3.Renommer une colonne						      "
		    
		    echo "Entrer votre choix"
		    read  choix
		    case  $choix in
		    1)
		       echo "#-------------  ci-dessous le contenu de la table ---------------#"	
		       mysql -u $name -h $address -p$pass -D $base -e "select * from $table "	
		      echo "Saisir le nom de la nouvelle colonne a ajouter"
		      read new_name		
		      var=$(mysql -u $name -h $address -p$pass -D $base -e "ALTER TABLE $table ADD $new_name varchar(50) NOT NULL" )
		      if [ $? -eq 0 ]
			then
			    echo "Le novelle colonne a ete ajoute avec succes "	
			    echo "#-------------  ci-dessous le contenu de la nouvelle table ---------------#"
			    mysql -u $name -h $address -p$pass -D $base -e "select * from $table "			
 			else
			     echo "une erreur s est produit"	                  
		      fi	
                    ;;	
		    2)
			echo "#-------------  ci-dessous le contenu de la table ---------------#"
			 mysql -u $name -h $address -p$pass -D $base -e "select * from $table "			
 			echo "Entrer de la colonne a supprimer"	
			read  new_remove
			var=$(mysql -u $name -h $address -p$pass -D $base -e "ALTER TABLE $table drop $new_remove" )
			if [ $? -eq 0 ]
			   then
			   	 echo "***_______________ La colonne a ete supprimer avec succes_____________***  "
				 echo "#-------------  ci-dessous le contenu de la nouvelle table ---------------#"	
			  	 mysql -u $name -h $address -p$pass -D $base -e "select * from $table "			
 		           else
			     	echo "une erreur s est produit"	                  
		        fi	
		    ;;	
		  3)
			mysql -u $name -h $address -p$pass -D $base -e "select * from $table "
			echo "Entrer l'id du champ a modifier"	
			read  new_id
			echo "Entrer le nom de la colonne a modifier"	
			read  name_col
			echo "Entrer la valeur du nouvelle champ"	
			read  name_champ
			
		      var=$(mysql -u $name -h $address -p$pass -D $base -e "UPDATE etudiant set $name_col='$name_champ' where id=$new_id" )
			if [ $? -eq 0 ]
			   then
			   	 echo "***___________Le champ a ete modifier succes______________*** "	
			  	 mysql -u $name -h $address -p$pass -D $base -e "select * from $table "			
 		           else
			     	echo "une erreur s est produit"	                  
		        fi	
		    ;;	

		esac
  	       }



#******************************************* FIN des fonctions ***********************************************************



echo "*******************__________ Choix de la tache a effectuee __________********************"
echo "					 1.Ajouter  				      "
echo "					 2.Modifier 				      "
echo "					 3.supprimer				      "



echo "Entrer votre choix"
read  choix
case  $choix in
1) 

#echo "Entre le nom de la base a cree "
#read base
#mysql -u $name -h $address -p$pass  -e 'show databases' -s -B

   ajouter
;;
2)
   modifier
;;
3) 
  supprimer
;;

esac   
