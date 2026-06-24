function Set-NomeUtilizadorEMaquina {
   # Este script altera apenas o nome da conta local e o nome do computador. A pasta do perfil em C:\Users\... não é renomeada. O PowerShell deve ser executado como Administrador.

   <#
      Multi
      Line
      Comment
   #>

   $v_novoUtilizador = Read-Host "Introduza o novo nome de utilizador"
   $v_novoComputador = Read-Host "Introduza o novo nome do computador"

   $v_utilizadorAtual = $env:USERNAME

   Rename-LocalUser -Name $v_utilizadorAtual -NewName $v_novoUtilizador
   Rename-Computer -NewName $v_novoComputador -Force

   Write-Host "Operação concluída."
   Write-Host "Novo utilizador: $v_novoUtilizador"
   Write-Host "Novo computador: $v_novoComputador"
   Write-Host "Reinicie o computador para aplicar a alteração do nome da máquina."
}

Set-NomeUtilizadorEMaquina
