function gpull --wraps='git pull --ff-only' --description 'alias gpull=git pull --ff-only'
  git pull --ff-only $argv

end
