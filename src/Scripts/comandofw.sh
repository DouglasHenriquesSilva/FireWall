#! /bin/sh

echo""
echo "### Autor: DOUGLAS HENRIQUES ###"
echo"" 

#----------------------Configurações Gerais--------------------


#Libera ou bloqueia  as regras no inicio da aplicação das tabelas de filtro

#iptables -P INPUT ACCEPT

#iptables -P OUTPUT ACCEPT

#iptables -P FORWARD ACCEPT

#iptables -P INPUT DROP

#iptables -P OUTPUT DROP

#iptables -P OUTPUT DROP

#------------------------------------------------------------------------------>



echo "Proteção contra ping flood"
echo""
# A regra abaixo pode tomada como base para proteção contra ping flood
# Limite a taxa de pacotes de ping recebidos por meio de uma regra do iptables
iptables -A INPUT -i eth0 -p icmp --icmp-type echo-request -m limit --limit 10/s --limit-burst 20 -j ACCEPT
iptables -A INPUT -i eth0 -p icmp --icmp-type echo-request -j DROP


echo "Proteção contra syn flood"
echo""
# A regra abaixo é uma boa proteção para os ataques syn floods

iptables -A INPUT -p tcp --syn -m hashlimit --hashlimit-above 10/s --hashlimit-burst 20 --hashlimit-mode srcip --hashlimit-name SYN-FLOOD -j DROP

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
 iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "sexyrot" --algo bm -j DROP
 iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "xvideosporno" --algo bm -j DROP
 iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "xvideosporno" --algo bm -j DROP
 iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "cameraprime" --algo bm -j DROP
 iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "cameraprive" --algo bm -j DROP
 iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "loupanproduções" --algo bm -j DROP
 iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "loupaproduções" --algo bm -j DROP 
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



               # Lista de strings que correspondem a URLs de sites de pornografia
                  #BLOCKED_URLS=-("pornhub.com" "xvideos.com" "redtube.com")

                    # Loop através da lista e criar uma regra de bloqueio para cada URL
                                    #for URL in "${BLOCKED_URLS[@]}"
                                              #do
             #  iptables -A INPUT -p tcp -m string --string "$URL" --algo bm -j DROP
               #done






#------------------------------------------------------------------------------>

echo "Aplicando regras de bloqueio de VPN"
echo""
# Adiciona uma regra para bloquear o tráfego relacionado ao programa de VPN

# Bloqueia conexões VPN PPTP
iptables -A INPUT -p gre -j DROP
iptables -A OUTPUT -p gre -j DROP

# Bloqueia conexões VPN L2TP

iptables -A INPUT -p udp --dport 1701 -j DROP
iptables -A OUTPUT -p udp --dport 1701 -j DROP

# Bloqueia conexões VPN OpenVPN
iptables -A INPUT -p udp --dport 1194 -j DROP
iptables -A OUTPUT -p udp --dport 1194 -j DROP

#EXTENSIONS# Bloqueia conexões VPN IPSec
iptables -A INPUT -p udp --dport 500 -j DROP
iptables -A OUTPUT -p udp --dport 500 -j DROP
iptables -A INPUT -p udp --dport 4500 -j DROP
iptables -A OUTPUT -p udp --dport 4500 -j DROP

# Bloqueia conexões VPN SSTP
iptables -A INPUT -p tcp --dport 443 -j DROP
iptables -A OUTPUT -p tcp --dport 443 -j DROP

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
iptables -A INPUT -p tcp --dport 0:65535 -j DROP



#Libera porta servidor WEB

iptables -A OUTPUT -p tcp --dport 5146 -j ACCEPT

iptables -A INPUT -p tcp --sport 5146 -j ACCEPT






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
echo""
# Carrega as regras salvas anteriormente
iptables-restore < /root/regras_salvas.v4
echo""
echo""



# iptables -I FORWARD -m string --algo bm --string "$1" -j $2
# iptables -I OUTPUT -m string --algo bm --string "$1" -j $2



#Salva  em arquivo TXT sites bloqueados
#for i in $(cat /root/webs-negado.txt)
 #  do
  #     iptables -A FORWARD -m string --algo bm --string "$i" -j LOG --log-prefix "FIREWALL: HTTPS-NEGADO "


#§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§



#Parte do codigo que vai "capturar" os sites a serem Bloqueados/liberados
 iptables -A OUTPUT -p tcp -m multiport --dports 80,443 -m string --string "$1" --algo bm -j $2
 iptables -A FORWARD -p tcp -m multiport --dports 80,443 -m string --string "$1" --algo bm -j $2
# iptables -A IMPUT -p tcp -m multiport --Sports 80,443 -m string --string "$1" --algo bm -j $2

#done


#§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

opcao="";
if [ "$2" = "ACCEPT" ]; then
  opcao="LIBERADO"
elif [ "$2" = "DROP" ]; then
  opcao="BLOQUEADO"
else
  echo "Opção inválida!"
  exit 1
fi
echo ------------------------------------------------------------------------
echo""
echo "O site $1 foi $opcao"
echo""
echo ------------------------------------------------------------------------


##############################################################################################################

#----------------------------------------------------------------------------------
echo""
echo""
echo""
echo  "********* FIREWALL ATIVADO *********"
echo""


# iptables-save > /root/comandofw.sh
iptables-save > /root/regras_salvas.v4
# Salvas as regras  inseridas

