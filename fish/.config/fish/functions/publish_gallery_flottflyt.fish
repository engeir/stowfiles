function publish_gallery_flottflyt --wraps='rsync -rtvzP ~/projects/gallery-flottflyt/photo-stream/_site/ root@flottflyt.xyz:/var/www/gallery-flottflyt' --description 'alias publish_gallery_flottflyt=rsync -rtvzP ~/projects/gallery-flottflyt/photo-stream/_site/ root@flottflyt.xyz:/var/www/gallery-flottflyt'
  rsync -rtvzP ~/projects/gallery-flottflyt/photo-stream/_site/ root@flottflyt.xyz:/var/www/gallery-flottflyt $argv
        
end
