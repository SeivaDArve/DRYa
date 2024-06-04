# Array tutorial:
   # v_array[0]="Name0"
   # v_array[1]="Name1"
   # v_array[2]="Name2"


# Detetar o Termux
   # No termux a variavel $PREFIX nao vem vazia e tras normalmente o conteudo: "/data/data/com.termux/files/usr"
   if [[ $PREFIX == "/data/data/com.termux/files/usr" ]]; then
      #echo "Estamos no termux"  # Debug
      traits_termux="true"
      export traits_termux
   else
      traits_termux="false"
      export traits_termux
   fi
      

# Catalogo de todas as variaveis do traitsID encontradas neste ficheiro desde o inicio
   # traits_termux = [ 'true' | 'false' ]
