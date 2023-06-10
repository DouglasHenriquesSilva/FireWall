#! /bin/sh

echo""
echo "### Autor: DOUGLAS HENRIQUES ###"
echo"" 
echo""
#----------------------Configurações Gerais--------------------

# Limpa as regras do FireWall
 iptables -F
 
 # Verifica se o arquivo de regras salvas existe e cria se não existir
if [ ! -f "/root/regras_salvas.v4" ]; then
  touch /root/regras_salvas.v4
fi

#Desliga interface de rede interna(verificar nome da rede de acordo com cada computador)
echo "Desabilitando rede interna"
 ip link set enp0s3 down
 sleep 3



#Libera ou bloqueia  as regras no inicio da aplicação das tabelas de filtro

#iptables -P INPUT ACCEPT

#iptables -P OUTPUT ACCEPT

#iptables -P FORWARD ACCEPT

#iptables -P INPUT DROP

#iptables -P OUTPUT DROP

#iptables -P OUTPUT DROP


#------------------------------------------------------------------------------>

echo "Aplicando regras de bloqueio de Executaveis"
echo""
  iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "exe" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "exe" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "bat" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "bat" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "msi" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "msi" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "zip" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "zip" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "rar" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "rar" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "cmd" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "cmd" --algo bm -j DROP

echo "Aplicando regras de bloqueio a conteudo inapropriado"
echo"" 
 iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "porn" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "porn" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "sex" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "sex" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "xxx" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "xxx" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "pornotube" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "pornotube" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "sexyhot" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "sexyhot" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "xvideosporno" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "xvideosporno" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "cameraprive" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "cameraprive" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "loupanproduções" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "loupanproduções" --algo bm -j DROP 
 iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "POVBRAZIL" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "POVIBRAZIL" --algo bm -j DROP 
 iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "porno" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "porno" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "SEXO" --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "SEXO" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "redtube"  --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "redtube" --algo bm -j DROP
iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "xvideos"  --algo bm -j DROP
iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "xvideos" --algo bm -j DROP


#------------------------------------------------------------------------------>

#Habilitando o Encaminhamento de Pacotes NAT
echo "habilitando NAT"
echo ""

#nano /etc/sysctl.conf
# /etc/sysctl.conf -> net.ipv4.ip_forwarding = 1 ACCEPT

sysctl -p
echo""

#------------------------------------------------------------------------------>

# Bloqueia o tráfego de entrada em portas não permitidas
#
# iptables -A INPUT -p tcp --dport 0:65535 -j DROP


#Libera porta servidor WEB

iptables -A OUTPUT -p tcp --dport 5146 -j ACCEPT
iptables -A INPUT -p tcp --sport 5146 -j ACCEPT



iptables -A OUTPUT -p tcp --dport 5500 -j ACCEPT
iptables -A INPUT -p tcp --sport 5500 -j ACCEPT


#----Libera trafego LOOPBACK-----------------------------------
echo "Libera trafego LOOPBACK"
echo""
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#------------------------------------------------------------------------------>

#----Permite pacotes ICM(Entrada e Saida de ping)--------------
echo "Liberando Protocolo PING"
echo""
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT

#------------------------------------------------------------------------------>

#----Permite a Saida de Consulta DNS---------------------------
echo "Permitindo consulta DNS"
echo""
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT

#------------------------------------------------------------------------------>

#----Permite a Saida para Web----------------------------------
echo "Habilitando Saida HTTP-HTTPS"
echo""
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --sport 80 -j ACCEPT

iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --sport 443 -j ACCEPT


#------------------------------------------------------------------------------>

#---- Rede Local <-> Internet ---------------------------------

#----permite acesso SSH----------------------------------------
echo "Habilitando SSH"
echo""
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

#------------------------------------------------------------------------------>

#Mascara internet para rede de fora(NAT)
echo "Habilitando regra de trafego NAT a DMZ"
echo""
iptables -A POSTROUTING -t nat -o enp0s8 -j MASQUERADE

#iptables -A POSTROUTING -t nat -o enp0s3 -j MASQUERADE

#------------------------------------------------------------------------------>


########################## Bloqueio de sites por String ########################################################
echo "+++++++++++++++++++++++++++++++++++++++++++++++"
echo "**** INICIANDO BLOQUEIO DE SITES!!! ****"
echo""

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
# Carrega as regras salvas anteriormente
  iptables-restore < /root/regras_salvas.v4
  echo""

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨

#§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

# Código que vai "capturar" os sites a serem bloqueados/liberados
if [ -z "$2" ]; then
  echo "O segundo argumento Liberado/Bloqueado está faltando. Forneça um valor válido para a opção do Firewall."
  
echo""
echo""
echo""
  echo  "********* FIREWALL ATIVADO *********"
echo""
  exit 1
fi






if [ "$2" = "ACCEPT" ]; then
  iptables-save | grep -v "$1" | iptables-restore
else
  iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "$1" --algo bm -j $2
  iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "$1" --algo bm -j $2
fi

echo "As regras foram configuradas."
#§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

echo""
echo""
echo""
echo  "********* FIREWALL ATIVADO *********"
echo""

#¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
# Salvas as regras  inseridas

 iptables-save > /root/regras_salvas.v4
 
¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨
#Habilita a rede interna(verificar nome da rede de acordo com cada computador)
echo "habilitando rede interna"
 ip link set enp0s3 up
 
 #iptables -L
 


