#!/bin/bash
#Script liest die CPU-Temperatur(°C) und speichert diese in einer CSV-Datei #Format ist DATUM, ZEIT, TEMPERATUR

zieldatei="/var/www/html/mon/cpu_temp.csv"
anzahl=8640 #Wie viele Einträge sollen gespeichert werden.
datum=`date +%F`
zeit=`date +%H:%M`
groesse=`wc -l $zieldatei|cut -d' ' -f1`

#Folgende Zeile liest die CPU-Temperatur in die Variable raw_temp 
read raw_temp </etc/armbianmonitor/datasources/soctemp 2>/dev/null cpu_temp=`echo "scale=1 ; $raw_temp/1000" | bc`

#Ausgabe in Zieldatei
echo $datum, $zeit, $cpu_temp >>$zieldatei

#Folgende Verzweigung prüft Dateigröße und löscht bei Bedarf 1. Eintrag.
if (($groesse>$anzahl-1))
  then
  sed -i 1D $zieldatei
fi
