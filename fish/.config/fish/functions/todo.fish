function todo --wraps=calcurse\ -t\ --format-todo\ \"\(\%p\)\ \%m\\n\%N\"\ \|\ grep\ -v\ \"No\ note\ file\ found\" --description alias\ todo=calcurse\ -t\ --format-todo\ \"\(\%p\)\ \%m\\n\%N\"\ \|\ grep\ -v\ \"No\ note\ file\ found\"
  calcurse -t --format-todo "(%p) %m\n%N" | grep -v "No note file found" $argv

end
