function publish_eirikenger --wraps='rsync -rtvzP ~/projects/eirikenger/ root@flottflyt.xyz:/var/www/eirikenger' --description 'alias publish_eirikenger=rsync -rtvzP ~/projects/eirikenger/ root@flottflyt.xyz:/var/www/eirikenger'
  rsync -rtvzP ~/projects/eirikenger/ root@flottflyt.xyz:/var/www/eirikenger $argv
        
end
