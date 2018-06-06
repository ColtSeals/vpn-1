#!/bin/bash

DATABASE="/home/DATABASE/users.db"

clear
echo -e "\033[01;36mLista de usuários criados:"
echo ""
NUMBER=$(awk  -F : '$3 >= 500 {print  $1}'  /etc/passwd | grep -v "nobody" | sort | wc -l)
if [ $NUMBER = "0" ]; then
  echo -e "\033[01;33mVocê não possui nenhum usuário criado no momento!"
else
  for USERS in `awk  -F : '$3 >= 500 {print  $1}'  /etc/passwd | grep -v "nobody" | sort`; do
    echo -ne "\033[01;33m"; echo $USERS
  done
fi
echo ""
echo -e "\033[01;31m•\033[01;33m 0:\033[01;36m RETORNAR AO MENU."
echo -e "\033[01;31m•\033[01;33m R:\033[01;36m RESETAR."
echo ""
echo -e "\033[01;35m---------------------------------------"
echo -ne "\033[01;32mNOME DO USUÁRIO:\033[01;33m"; read USER
if [ -z $USER ]; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou um nome de usuário vazio. Tente novamente!\033[0m"
  sleep 3s
  createuser
  exit
else
if [ "$USER" = "root" ]; then
  echo ""
  echo -e "\033[01;37;41mUsuário inválido. Tente novamente!\033[0m"
  sleep 3s
  createuser
  exit
else
if [ "$USER" = "0" ]; then
  h
  exit
else
if [ "$USER" = "R" ]; then
  createuser
  exit
else
if echo $USER | grep -q '[^a-z A-Z 0-9 ._-]'; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou um nome de usuário invaldoo. Use apenas letras, números\033[0m"; echo -e "\033[01;37;41mpontos e traços. Não use espaços, acentos ou caracteres especiais. T\033[0m"; echo -e "\033[01;37;41mente novamente!                                                     \033[0m"
  sleep 3s
  createuser
  exit
else
  awk  -F : '$3 >= 500 {print  $1}'  /etc/passwd | grep -v "nobody" | sort > /tmp/users.txt
if grep -xq "$USER" /tmp/users.txt; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou um nome de usuário já existente. Digite um nome de\033[0m"; echo -e "\033[01;37;41musuário que não seja existente na lista acima. Tente novamente!\033[0m"
  sleep 7s
  createuser
  exit
else
  CHARACTERS=$(echo $USER | wc -c)
if [ $CHARACTERS -gt 33 ]; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou um nome de usuário muito grande. Use no máximo 3\033[0m"; echo -e "\033[01;37;41m2 caracteres para o usuário. Tente novamente!                \033[0m"
  sleep 3s
  createuser
  exit
else
  echo -ne "\033[01;32mSENHA:\033[01;33m"; read PASSWORD
if [ -z $PASSWORD ]; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou uma senha vazia. Tente novamente!\033[0m"
  sleep 3s
  createuser
  exit
else
if [ "$PASSWORD" = "0" ]; then
  h
  exit
else
if [ "$PASSWORD" = "R" ]; then
  createuser
  exit
else
  echo -ne "\033[01;32mN° DE DIAS PARA EXPIRAR:\033[01;33m"; read DAYS
if echo $DAYS | grep -q '[^0-9R]'; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou um número de dias inválido. Tente novamente!\033[0m"
  sleep 3s
  createuser
  exit
else
if [ -z $DAYS ]; then
  echo ""
  echo -e "\033[1;37;41mVocê digitou um número vazio. Tente novamente!\033[0m"
  sleep 3s
  createuser
  exit
else
if [ "$DAYS" = "0" ]; then
  h
  exit
else
if [ "$DAYS" = "R" ]; then
  createuser
  exit
else
  echo -ne "\033[01;32mN° DE CONEXÕES PERMITIDAS:\033[01;33m"; read CONNECTIONS
if echo $CONNECTIONS | grep -q '[^0-9R]'; then
  echo ""
  echo -e "\033[01;37;41mVocê digitou um número inválido. Tente novamente!\033[0m"
  sleep 3s
  createuser
  exit
else
if [ -z $CONNECTIONS ]; then
  echo ""
  echo -e "\033[1;37;41mVocê digitou um número vazio. Tente novamente!\033[0m"
  sleep 3s
  createuser
  exit
else
if [ "$CONNECTIONS" = "0" ]; then
  h
  exit
else
if [ "$CONNECTIONS" = "R" ]; then
  createuser
  exit
else
  echo -e "\033[01;35m---------------------------------------"
  VALIDITY1=$(date "+%Y-%m-%d" -d "+ $DAYS days")
  VALIDITY2=$(date "+%d/%m/%Y" -d "+ $DAYS days")
  useradd -e $VALIDITY1 -M -s /bin/false $USER
  (echo $PASSWORD; echo $PASSWORD) | passwd $USER 1> /dev/null 2> /dev/null
  echo "$USER $PASSWORD $CONNECTIONS" >> $DATABASE
  echo -e "\033[01;31m      USÚARIO CRIADO COM SUCESSO!"
  echo -e "\033[01;35m---------------------------------------"
  echo -e "\033[01;32mNome do usuário:\033[01;33m $USER"
  echo -e "\033[01;32mData de validade:\033[01;33m $VALIDITY2 às \033[01;31m00:00:00"
  echo -e "\033[01;32mN° de conexões permitidas:\033[01;33m $CONNECTIONS"
  echo -e "\033[01;35m---------------------------------------"
  echo ""
  echo -e "\033[01;36mLista de usuários criados:"; echo ""
  for USERS in `awk  -F : '$3 >= 500 {print  $1}'  /etc/passwd | grep -v "nobody" | sort`; do
    echo -ne "\033[01;33m"; echo $USERS
  done
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
fi
echo ""
echo -ne "\033[01;36mENTER PARA VOLTAR AO MENU..."
read ENTER
h
exit