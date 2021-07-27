bspc subscribe monitor | while read -r line; do
  case $line in
      monitor_add*|monitor_geometry*)
        if [ "$(bspc query -M | wc -l)" -eq "3" ]; then
          bspc monitor $(bspc query -M | sed -n 1p) -d 1 2 3
          bspc monitor $(bspc query -M | sed -n 2p) -d 4 5 6
          bspc monitor $(bspc query -M | sed -n 3p) -d 7 8 9 0
        elif [ "$(bspc query -M | wc -l)" -eq "2" ]; then
	  bspc monitor eDP-1 -d 1 2 3
	  if [ "$(bspc query -M --names | sed -n 1p)" = "eDP-1" ]; then
	    bspc monitor $(bspc query -M --names | sed -n 2p) -d 4 5 6 7 8 9 0
	  else
	    bspc monitor ^2 -s ^1
            bspc monitor $(bspc query -M --names | sed -n 1p) -d 4 5 6 7 8 9 0
	  fi
        else
          bspc monitor eDP-1 -d 1 2 3 4 5 6 7 8 9 0
	  bspc wm -O eDP-1 HDMI-1
	  bspc wm -O eDP-1 DP-2
        fi
        ;;
      *)
      ;;
  esac
done &
