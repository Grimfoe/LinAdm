В отдельных подпапках содержаться машины с описанным Vagrantfile для первой части задания

По второй части задания: в папке otus-linux-adm/selinx-dns-problems

1. Исправлен vagrantfile - добавлена конфигурация для сервера

    ns01.vm.provision "shell", inline: <<-SHELL
    sudo chcon -R -t named_zone_t /etc/named
    SHELL
	
	для клиента
	
	client.vm.provision "shell", inline: <<-SHELL
    nsupdate -k /etc/named.zonetransfer.key /opt/nsupdate.commands
    SHELL
	
	
2. В Playbook добавлена опция для клиента

 - name: copy nameupdate to client
    copy:
      src: files/client/nsupdate.commands
      dest: /opt/nsupdate.commands
      owner: root
      group: named
      mode: 0644
	  
3. Создан фаил nsupdate.commands, со списком команд для nsupdate на клиенте.
