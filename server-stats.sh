#!/usr/bin/bash

# Função para exibir o uso da CPU
uso_cpu() {
    echo "Uso total da CPU:"
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

# Executa as funções
uso_cpu
uso_memoria
uso_disco
top_processos_cpu
top_processos_memoria