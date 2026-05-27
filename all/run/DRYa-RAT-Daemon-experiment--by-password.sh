#!/bin/bash
# Title:
# Description: Exeriment on Local Machines. (RAT as sync method)
# Warning: KEEP THIS FILE EXECUTABLE ONLY AFTER ASKING PASSWORD. 


#######################################################################
#                     GUIA: CRIANDO UM DAEMON EM BASH
#######################################################################

# Este arquivo NÃO é um daemon funcional.
# Ele serve apenas como documentação/comentários explicando:
#
# - O que é um daemon
# - Como estruturar um daemon em Bash
# - Como iniciar/parar
# - Como usar logs
# - Como salvar PID
# - Como rodar no Termux/Linux
#
# Você pode usar este arquivo como referência para criar o seu.


#######################################################################
# 1. O QUE É UM DAEMON?
#######################################################################

# Um daemon é um processo que roda continuamente em background.
#
# Exemplos:
#
# - monitor de rede
# - bot de automação
# - sincronizador de arquivos
# - servidor web
# - monitor de bateria
#
# Características:
#
# - roda sem interação do usuário
# - normalmente possui loop infinito
# - pode salvar logs
# - pode reiniciar automaticamente
# - geralmente grava seu PID


#######################################################################
# 2. ESTRUTURA BÁSICA
#######################################################################

# Um daemon simples em Bash normalmente possui:
#
# 1. Shebang
# 2. Variáveis de configuração
# 3. Arquivo de log
# 4. Arquivo PID
# 5. Loop principal
# 6. Sleep para evitar uso excessivo da CPU
# 7. Tratamento de sinais (SIGTERM/SIGINT)


#######################################################################
# 3. SHEBANG
#######################################################################

# Exemplo Linux:
#
#   #!/bin/bash
#
# Exemplo Termux:
#
#   #!/data/data/com.termux/files/usr/bin/bash
#
# O shebang define qual interpretador executará o script.


#######################################################################
# 4. ORGANIZAÇÃO DE PASTAS
#######################################################################

# Estrutura recomendada:
#
# ~/daemon/
# ├── scripts/
# ├── logs/
# ├── pids/
# └── config/
#
# Exemplo:
#
# ~/daemon/scripts/netmon.sh
# ~/daemon/logs/netmon.log
# ~/daemon/pids/netmon.pid


#######################################################################
# 5. ARQUIVO DE LOG
#######################################################################

# Daemons normalmente escrevem eventos em logs.
#
# Exemplo:
#
# echo "$(date) daemon iniciado" >> ~/daemon/logs/app.log
#
# Isso ajuda a:
#
# - depuração
# - monitoramento
# - auditoria
# - descobrir falhas


#######################################################################
# 6. ARQUIVO PID
#######################################################################

# PID = Process ID
#
# O daemon salva seu PID para que possa ser encerrado depois.
#
# Exemplo:
#
# echo $$ > ~/daemon/pids/app.pid
#
# $$ = PID do processo atual
#
# Depois:
#
# kill $(cat ~/daemon/pids/app.pid)


#######################################################################
# 7. LOOP PRINCIPAL
#######################################################################

# O coração do daemon normalmente é:
#
# while true
# do
#     # tarefa principal
#
#     sleep 10
# done
#
# O sleep é MUITO importante.
#
# Sem sleep:
#
# - CPU vai para 100%
# - bateria acaba rápido
# - Android/Linux pode matar o processo


#######################################################################
# 8. TAREFAS COMUNS
#######################################################################

# O daemon pode:
#
# - monitorar internet
# - verificar arquivos
# - enviar requests HTTP
# - automatizar backups
# - responder comandos
# - observar sensores
# - controlar bots
# - reiniciar programas


#######################################################################
# 9. EXECUTAR EM BACKGROUND
#######################################################################

# Formas comuns:
#
# ./daemon.sh &
#
# ou:
#
# nohup ./daemon.sh > /dev/null 2>&1 &
#
# Explicação:
#
# &                 -> envia para background
# nohup             -> ignora fechamento do terminal
# > /dev/null       -> descarta stdout
# 2>&1              -> descarta stderr


#######################################################################
# 10. VERIFICAR PROCESSO
#######################################################################

# Linux:
#
# ps aux | grep daemon
#
# ou:
#
# pgrep -af daemon
#
# ou:
#
# top
#
# ou:
#
# htop


#######################################################################
# 11. ENCERRAR O DAEMON
#######################################################################

# Via PID:
#
# kill PID
#
# ou:
#
# kill $(cat app.pid)
#
# Forçar:
#
# kill -9 PID
#
# OBS:
# kill -9 deve ser evitado quando possível.


#######################################################################
# 12. CAPTURANDO SINAIS
#######################################################################

# Daemons profissionais tratam sinais:
#
# trap 'cleanup' SIGINT SIGTERM
#
# Isso permite:
#
# - fechar arquivos
# - salvar estado
# - remover PID
# - finalizar corretamente


#######################################################################
# 13. FUNÇÃO CLEANUP
#######################################################################

# Exemplo conceitual:
#
# cleanup() {
#
#     echo "Encerrando..."
#
#     rm -f ~/daemon/pids/app.pid
#
#     exit 0
# }
#
# Isso evita PID "fantasma".


#######################################################################
# 14. RESTART AUTOMÁTICO
#######################################################################

# Algumas estratégias:
#
# while true
# do
#     ./programa
#
#     echo "reiniciando..."
#
#     sleep 5
# done
#
# Ou usar:
#
# - systemd
# - runit
# - supervisord
# - pm2


#######################################################################
# 15. NO TERMUX
#######################################################################

# Android pode suspender processos.
#
# Use:
#
# termux-wake-lock
#
# Isso reduz a chance do Android matar o daemon.
#
# Para iniciar no boot:
#
# - instalar Termux:Boot
# - usar ~/.termux/boot/


#######################################################################
# 16. BOAS PRÁTICAS
#######################################################################

# - sempre usar logs
# - usar sleep
# - tratar sinais
# - salvar PID
# - evitar loops agressivos
# - validar dependências
# - usar caminhos absolutos
# - evitar executar como root
# - documentar comportamento


#######################################################################
# 17. EXEMPLO DE FLUXO
#######################################################################

# Inicialização:
#
# 1. cria PID
# 2. abre log
# 3. entra em loop
#
# Loop:
#
# 1. executa tarefa
# 2. escreve log
# 3. dorme alguns segundos
#
# Encerramento:
#
# 1. captura SIGTERM
# 2. remove PID
# 3. fecha corretamente


#######################################################################
# 18. DIFERENÇA ENTRE SCRIPT E DAEMON
#######################################################################

# Script comum:
#
# - executa
# - termina
#
# Daemon:
#
# - executa continuamente
# - normalmente infinito
# - roda em background


#######################################################################
# 19. QUANDO USAR OUTRAS LINGUAGENS
#######################################################################

# Bash é ótimo para:
#
# - automação simples
# - monitoramento
# - wrappers
# - administração
#
# Para coisas maiores:
#
# - Python
# - Go
# - Rust
# - Node.js
#
# podem ser melhores.


#######################################################################
# 20. RESUMO
#######################################################################

# Um daemon Bash normalmente consiste em:
#
# - loop infinito
# - sleep
# - logs
# - PID
# - execução em background
#
# No Linux moderno:
#
# - geralmente usa systemd
#
# No Termux:
#
# - geralmente usa nohup + &
# - Termux:Boot
# - termux-wake-lock


#######################################################################
# FIM
#######################################################################
