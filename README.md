# administ
  Стек команд и стек данных:
  
  Для функционирования стекового процессора необходимо создать два стека: команд и данных. 
  В стек команд будут записываться команды, которые необходимо выполнить.
  В стек данных будут записываться числа, над которыми будут производить операции команды.
  
  Модуль процессора:
  
  Основная задача процессорного модуля (test) – в зависимости от поступающих на его входы команд, 
  выполнять нужный функционал.

  Главный модуль стекового процессора:
  
  Главный модуль или модуль main связывает между собой все части стекового процессора. 
  Также в зависимости от команд на входе, записывает команды в стек команд или читает команды и подает на вход модуля test. 
  Также модуль main является top-level entity.
