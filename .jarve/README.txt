About file: jarve-read-and-run-file.sh
 > Quando é iniciado o termux, temos a opcao de abrir o 'jarve sentinel' que vai procurar coisas para fazer
   Uma das coisas que vai procurar para fazer, é comandos que possam vir de outros dispositivos que eatejam a correr DRYa
   Para o jarve ouvir esses comandos remotos, vai mudar para o 'git branch' chamado 'jarve-sentinel' e vai
   Fazer uso deste ficheiro lá existente

   Sempre que passar 1x o ciclo de while loop, vai haver um 'git pull" a este ramo do repositorio e se houver conteudos no ficheiro 'jarve-read-and-run-file.sh', executa-os linha apos linha
