
#!/bin/bash

function f_help {
   echo "Uso: $0 [-a|+a|--arquivo|--file arquivo] [-v] [-h] [--]"
   echo
   echo "  -a, +a, --arquivo ARQ     Especifica o arquivo de entrada"
   echo "  --file=ARQ                Idem, usando ="
   echo "  -v, --verbose             Ativa modo verboso"
   echo "  -h, --help                Mostra esta ajuda"
   echo "  --                        Fim das opções, argumentos seguintes são posicionais"
}



# Variáveis padrão
arquivo=""
verbose=0
unset b c

# Enquanto ainda houver argumentos a processar
while [ $# -gt 0 ]; do
  case "$1" in
    -a|--arquivo|--file)
      if [[ "$1" == *=* ]]; then
        # Argumento no formato --file=valor
        # O regex "${1#*=}" remove tudo antes do "=" (inclusive o próprio "=")
        # Exemplo: --arquivo=meuarquivo.txt
        # O resultado será: "meuarquivo.txt"
        arquivo="${1#*=}"
        shift
      else
        # Argumento no formato -a valor
        if [ -n "$2" ]; then
          arquivo="$2"
          shift 2
        else
          echo "Erro: a opção '$1' requer um argumento." >&2
          exit 1
        fi
      fi
      ;;
    --arquivo=*|--file=*)
      # Também permite diretamente --arquivo=valor
      # Aqui, novamente, o regex "${1#*=}" remove tudo antes do "="
      arquivo="${1#*=}"
      shift
      ;;
    -v|--verbose)
      verbose=1
      shift
      ;;
    -h|--help)
      f_help
      exit 0
      ;;
    --)
      # Se encontrou '--', ignora o resto das opções e trata como argumento posicional
      shift
      break
      ;;
    *)
      echo "Opção desconhecida: $1" >&2
      f_help
      exit 1
      ;;
  esac
done

# Exibe os valores processados
[[ -n $b ]] && echo $b
[[ -n $c ]] && echo $c
echo "Arquivo: $arquivo"
echo "Verbose: $verbose"

# Exibe os argumentos posicionais após '--'
if [ $# -gt 0 ]; then
  echo "Argumentos posicionais: $@"
fi








#     #!/bin/bash
#     
#     while [ $# -gt 0 ]; do
#       case "$1" in
#         -a)
#           echo "Flag -a"
#           ;;
#         -n)
#           echo "Flag -n"
#           ;;
#         -b)
#           echo "Flag -b"
#           ;;
#         -an|-na|-ab|-ba|-nb|-bn)  # combinações explícitas
#           # desdobrar manualmente
#           [[ "$1" == *a* ]] && echo "Flag -a"
#           [[ "$1" == *n* ]] && echo "Flag -n"
#           [[ "$1" == *b* ]] && echo "Flag -b"
#           ;;
#         --) # fim das opções
#           shift
#           break
#           ;;
#         *)
#           echo "Argumento não reconhecido: $1"
#           ;;
#       esac
#       shift
#     done
#     
