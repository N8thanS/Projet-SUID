#!/bin/bash

find / -perm -4000  2>/dev/null >/home/ubuntu/projet/find

cat /home/ubuntu/projet/find | while read ligne;do

cksum=$(cksum $ligne | cut -d ' ' -f 1)

taille=$(cksum $ligne | cut -d ' ' -f 2)

nom=$(cksum $ligne | cut -d ' ' -f 3)


echo $cksum" "$taille" "$nom


sqlite3 /home/ubuntu/projet/BDDprojet.db "insert into cksumdebase values ('$nom','$cksum','$taille');"

done
