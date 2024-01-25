function publish_flottflyt --wraps='rsync -rtvzP --delete ~/projects/flottflyt/public/ root@flottflyt.xyz:/var/www/flottflyt' --description 'alias publish_flottflyt=rsync -rtvzP --delete ~/projects/flottflyt/public/ root@flottflyt.xyz:/var/www/flottflyt'
  rsync -rtvzP --delete ~/projects/flottflyt/public/ root@flottflyt.xyz:/var/www/flottflyt $argv
        
end
