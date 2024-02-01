function ls --wraps='eza --icons -Fa --group-directories-first' --description 'alias ls=eza --icons -Fa --group-directories-first'
  eza --icons -a -F=always --group-directories-first $argv
end
