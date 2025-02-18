#!/usr/bin/bash

# Função para exibir o uso da CPU
uso_cpu() {
    echo -e "\nUso total da CPU:"
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
}

# Função para exibir o uso da memória
uso_memoria() {
    echo -e "\nUso total de memória:"
    free -m | awk 'NR==2{printf "Usada: %sMB (%.2f%%)\nLivre: %sMB\n", $3, $3*100/$2, $4}'
}

# Função para exibir o uso do disco
uso_disco() {
    echo -e "\nUso total do disco:"
    df -h / | awk 'NR==2{printf "Usado: %s (%.2f%%)\nLivre: %s\n", $3, $3*100/$2, $4}'
}

# Função para exibir os 5 principais processos por uso de CPU
top_processos_cpu() {
    echo -e "\nTop 5 processos por uso de CPU:"
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
}

# Função para exibir os 5 principais processos por uso de memória
top_processos_memoria() {
    echo -e "\nTop 5 processos por uso de memória:"
    ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6
}

# Função para exibir a versão do sistema operacional
versao_sistema() {
    echo "Versão do Sistema Operacional:"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$PRETTY_NAME"
    else
        echo "Não foi possível determinar a versão do sistema."
    fi
}

# Função para exibir o tempo de atividade do sistema
tempo_atividade() {
    echo -e "\nTempo de Atividade:"
    uptime -p
}

# Função para exibir a média de carga do sistema
media_carga() {
    echo -e "\nMédia de Carga (1, 5, 15 minutos):"
    uptime | awk -F 'load average:' '{print $2}'
}

# Função para exibir os usuários conectados
usuarios_conectados() {
    echo -e "\nUsuários Conectados:"
    who
}

# Função para exibir tentativas de login com falha
tentativas_login_falha() {
    echo -e "\nTentativas de Login com Falha:"
    if [ -f /var/log/auth.log ]; then
        grep "Failed password" /var/log/auth.log | wc -l
    elif [ -f /var/log/secure ]; then
        grep "Failed password" /var/log/secure | wc -l
    else
        echo "Arquivo de log de autenticação não encontrado."
    fi
}

# Executa as funções
versao_sistema
tempo_atividade
media_carga
usuarios_conectados
tentativas_login_falha
uso_cpu
uso_memoria
uso_disco
top_processos_cpu
top_processos_memoria