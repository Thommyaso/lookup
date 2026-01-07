# Move window in tmux (if you closed a window with index 2 you can move next one to that pos to avoid the gap)
move-window -t 2

# Creating Sql queries - it adds '' for any string between , that doesn't already have quotes and isn't a number: 
s/\v, *([^',0-9][^,]*)/, '\1'/g

# Removing , from the beginning of every line (if you want to remove every line that has it use 'g' instead of 's':
s/^,//

# Finding each line that has exactly 3 comas in it and replacing '),' at the end with ',0, ''),' - this could be used for other things!!
:g/\v^([^,]*,){3}[^,]*\),$/s/),$/,0, '')/

# Find any line that starts with a number, and remove that number:
:g/^\d\+/s/^\d\+\s*//

# finding every line thats not empty and adding something at the end:
:g/\v^.+/s/$//^\s*$/s/^/<ADD YOUR STUFF HERE>/gc/

# delete all empty lines:
:g/^\s*$/d

# Upload database via sql to devilbox if database file is too large for phpmyadmin:
mysql -h mysql -u root -pmysql dev_isisex_quote < /shared/httpd/dbs/projects_isisex_quotes.sql

# vpn cli: 
nmcli

# example nmcli vpn connection to VPN1:
nmcli connection up VPN\ 1

# error logging into a local log
$errorString = var_export('new path: ' .$new_path, true) . ";\n";
error_log($errorString);

or

error_log(var_export('new path: ' .$new_path, true) . ";\n");

# find out what docker containers you have: 
docker ps -a

# for remote db: 
ssh -L 0.0.0.0:3307:127.0.0.1:3306 - Accessible from Docker containers

# example command for finding a running process:
ps aux | grep "ssh.*3307" -- it can be killed using: kill <number of found process>

# vim ripgrepping bunch of classes present in tpl and placing them in quickfix list:
:cexpr system('rg "\b(p-[0-5]|px-[0-5]|py-[0-5]|p[trbl]-[0-5]|m-[0-5])\b" --type-add "tpl:*.tpl" -t tpl --vimgrep')

and then doing something with that stuff: 
:cdo s/\<\(p-[0-5]\|px-[0-5]\|py-[0-5]\|p[trbl]-[0-5]\|m-[0-5]\)\>/custom-\1/g | update

# displaying android logs (specifically task manager in this example)
adb logcat -c && adb logcat | grep -E "ReactNative|ReactNativeJS|TaskService"

# find command for searching on server without fd
find . -type f -iname "*footer*"

# way to find what ports are used 
sudo ss -tulpn | grep ':80 '

# check if you have any zombie processes
ps aux | grep Z

# checking your server condition
ab -n 1000 http://localhost:8080/

