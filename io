#!/bin/bash

function CTRL () 
{
open
exit
}
trap CTRL SIGINT

while true; do
  clear
  echo ""
  echo -ne " \033[01;37;44m"; printf '%38s%-28s\n' "MONITORING"; echo -ne "\033[0m"
  echo -e " \033[01;37;44m USUÁRIO                    CONEXÃO                        STATUS \033[0m"
  echo ""
  cat /etc/passwd | grep -v "nobody" | awk  -F : '$3 >= 500 {print  $1}' | sort > /tmp/users.txt
  cat /tmp/users.txt | sort | while read MONITOR; do
    USERS=$(echo $MONITOR | cut -d " " -f1)
    NUMBER1=$(ps -u $USERS | grep sshd | wc -l)
    NUMBER2=$(grep "$USERS" /etc/openvpn/openvpn-status.log | wc -l)
	    if [ "$MONITORING2" -gt "0" ]; then
    	TIME=$(ps -o etime $(ps -u $USERS |grep sshd |awk 'NR==1 {print $1}')|awk 'NR==2 {print $1}')
    if [ $NUMBER1 -gt 0 -a $NUMBER2 -gt 0 ]; then
      echo -ne " \033[01;37m"; printf '%-28s%-31s%s\n' " $USERS" "OpenVPN/SSH" "Online"   "$TIME"
    elif [ $NUMBER1 -gt 0 ]; then
      echo -ne " \033[01;37m"; printf '%-28s%-31s%s\n' " $USERS" "SSH" "Online"
    elif [ $NUMBER2 -gt 0 ]; then
      echo -ne " \033[01;37m"; printf '%-28s%-31s%s\n' " $USERS" "OpenVPN" "Online"
    else
      echo -ne " \033[01;37m"; printf '%-28s%-31s%s\n' " $USERS" "INATIVO" "Offline"      "00:00"
    fi
   echo ""
   echo -e "\033[01;36m APERTE CTRL+C PARA VOLTAR AO MENU..."
   sleep 10s