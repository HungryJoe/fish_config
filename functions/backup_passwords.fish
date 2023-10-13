function backup_passwords --description 'Backup ~/nrao_passwords.kdbx to autohome:~/nrao_passwords_versions/'
    /usr/bin/scp -O ~/nrao_passwords.kdbx skagan@shipman.aoc.nrao.edu:~/nrao_passwords_versions/nrao_passwords_(/bin/date +%Y-%m-%d).kdbx
end
