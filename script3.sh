#!/bin/bash


find / -perm -4000 2>/dev/null >/home/ubuntu/projet/find

sqlite3 /home/ubuntu/projet/BDDprojet.db "select * from cksumdebase;"> /home/ubuntu/projet/cksumdebase

nblignefind=$(wc -l /home/ubuntu/projet/find | cut -d " " -f 1)
nblignecksumdebase=$(wc -l /home/ubuntu/projet/cksumdebase | cut -d " " -f 1)
echo $nblignefind
echo $nblignecksumdebase

if [ $nblignefind = $nblignecksumdebase ]; then
	echo "Il n'y a pas de nouveau fichier SUID »"
else
	echo "Il y a un nouveau fichier :"
	cat /home/ubuntu/projet/find | while read ligne; do
	i=$(( $i + 1 ))
	nomdebase=$(sed -n $i" p" /home/ubuntu/projet/cksumdebase | cut -d '|' -f 1)

	if [ $ligne != $nomdebase ]; then
		nom=$(sed -n $i" p" /home/ubuntu/projet/find | cut -d '|' -f 1)
		echo $nom
		cksum=$(cksum $nom | cut -d ' ' -f 1)
		taille=$(cksum $nom | cut -d ' ' -f 2)
		sqlite3 /home/ubuntu/projet/BDDprojet.db "insert into cksumdebase values ('$nom',$cksum,$taille);"
	return
	fi
	done
fi
