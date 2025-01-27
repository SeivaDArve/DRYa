#!/bin/bash

# Defina a interface de rede
INTERFACE="eth0"  # Altere para o nome da sua interface, por exemplo, eth0 ou wlan0
INTERFACE="wlan0"  # Altere para o nome da sua interface, por exemplo, eth0 ou wlan0
INTERFACE="wlp3s0"  # Altere para o nome da sua interface, por exemplo, eth0 ou wlan0

# Função para gerar um número aleatório entre 1 e 254
random_ip_part() {
    echo $((RANDOM % 254 + 1))
}

# Geração do IP aleatório dentro da faixa 192.168.1.0/24
   NEW_IP="192.168.1.$(random_ip_part)"

# Exibe o novo IP gerado
   echo "Novo numero de IP gerado (para tentar aplicar): "
   echo " > $NEW_IP"
   echo


function f_remaining_fx {
   # If last command does not work, this fx will not run

   # Remove o IP atual
      sudo ip addr flush dev $INTERFACE

   # Adiciona o novo IP gerado
      sudo ip addr add $NEW_IP/24 dev $INTERFACE

   # Ativa a interface novamente
      sudo ip link set $INTERFACE up

   # Exibe a configuração final
      echo "O IP da interface $INTERFACE foi alterado para $NEW_IP"
}


# Desativa a interface de rede
   sudo ip link set $INTERFACE down 2>/dev/null  &&  f_remaining_fx

