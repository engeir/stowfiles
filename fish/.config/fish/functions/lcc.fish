function lcc --wraps='lsblk -e 1,7' --description 'alias lcc=lsblk -e 1,7'
  lsblk -e 1,7 $argv

end
