function rest --wraps=timer\ 10m\ \&\&\ terminal-notifier\ -message\ \'Pomodoro\'\ \ \ \ \ \ \ \ -title\ \'Break\ is\ over!\ Get\ back\ to\ work\ 😬\'\ \ \ \ \ \ \ \ -appIcon\ \'\~/Pictures/pumpkin.png\'\ \ \ \ \ \ \ \ -sound\ Crystal --description alias\ rest=timer\ 10m\ \&\&\ terminal-notifier\ -message\ \'Pomodoro\'\ \ \ \ \ \ \ \ -title\ \'Break\ is\ over!\ Get\ back\ to\ work\ 😬\'\ \ \ \ \ \ \ \ -appIcon\ \'\~/Pictures/pumpkin.png\'\ \ \ \ \ \ \ \ -sound\ Crystal
  timer 10m && terminal-notifier -message 'Pomodoro'        -title 'Break is over! Get back to work 😬'        -appIcon '~/Pictures/pumpkin.png'        -sound Crystal $argv
        
end
