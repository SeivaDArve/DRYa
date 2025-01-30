
function f_find_best_OS {
   # Definir o Explorador de arquivos para cada OS para abrir a img

   # Antes desta fx, tem de ser definidas 2 var:
   #   1.  Uma no inicio do documento que india onde se contra a pasta com todas as img
   #   2.  Em cada fx de cada img individual, imediatamente de chamar esta fx, dizer o nome so do ficheiro
   #   Assim teremos "$pasta/$img"
  

      function f_cartoes_termux {
         termux-open $v_card_dir/$v_item  2>/dev/null
      }
         
      function f_cartoes_WSL2 {
         wslview     $v_card_dir/$v_item  2>/dev/null
      }

      function f_cartoes_linux {
         xdg-open    $v_card_dir/$v_item  2>/dev/null
      }

   # Find wich OS is running and run just that
      # uDev: TraitsID would simplify thus step and would save time (+ processor time)
      f_cartoes_WSL2 || f_cartoes_termux || f_cartoes_linux
}
