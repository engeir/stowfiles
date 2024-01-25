function work --wraps=timer\ 60m\ \&\&\ terminal-notifier\ -message\ \'Pomodoro\'\ \ \ \ \ \ \ \ -title\ \'Work\ Timer\ is\ up!\ Take\ a\ Break\ 😊\'\ \ \ \ \ \ \ \ -appIcon\ \'\~/Pictures/pumpkin.png\'\ \ \ \ \ \ \ \ -sound\ Crystal --description alias\ work=timer\ 60m\ \&\&\ terminal-notifier\ -message\ \'Pomodoro\'\ \ \ \ \ \ \ \ -title\ \'Work\ Timer\ is\ up!\ Take\ a\ Break\ 😊\'\ \ \ \ \ \ \ \ -appIcon\ \'\~/Pictures/pumpkin.png\'\ \ \ \ \ \ \ \ -sound\ Crystal
  timer 60m && terminal-notifier -message 'Pomodoro'        -title 'Work Timer is up! Take a Break 😊'        -appIcon '~/Pictures/pumpkin.png'        -sound Crystal $argv
        
end
