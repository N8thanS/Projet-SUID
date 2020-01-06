#!bin/bash

sqlite3 /home/ubuntu/projet/BDDprojet.db "select * from cksumdebase;" > /home/ubuntu/projet/cksumdebase

cat /home/ubuntu/projet/cksumdebase  | while read ligne; do
echo $ligne | cut -d '|' -f 1 >> /home/ubuntu/projet/NomFichier
done



cat /home/ubuntu/projet/NomFichier | while read ligne; do
cksum=$(cksum $ligne | cut -d ' ' -f 1)
taille=$(cksum $ligne | cut -d ' ' -f 2)
nom=$(cksum $ligne | cut -d ' ' -f 3)
done


i=$(( $i + 1 ))

cksumdebase=$(sed -n $i" p" /home/ubuntu/projet/cksumdebase | cut -d '|' -f 2)
tailledebase=$(sed -n $i" p" /home/ubuntu/projet/cksumdebase | cut -d '|' -f 3)


if [ $cksum=$cksumdebase ]; then

if [ $taille=$tailledebase ]; then
echo "le fichier "$nom" n'a pas été modifié !"
sqlite3 /home/ubuntu/projet/BDDprojet.db "insert into cksumcalcule values ('$nom', '$cksum', '$taille', '$date', 'identique');"
else

echo "la taille du fichier" $nom "à changé"
sqlite 3 /home/ubuntu/projet/BDDprojet.db "insert into cksumcalcule values ('$nom', '$cksum', '$taille', '$date', 'modifié');"
fi
else

echo "le fichier "$nom" à changé de cksum"
sqlite 3 /home/ubuntu/projet/BDDprojet.db "insert into cksumcalcule values ('$nom', '$cksum', '$taille', '$date', 'modifié');"
fi


