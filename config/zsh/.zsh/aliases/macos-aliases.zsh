function work() {
  switch_desktop() {
    case $1 in
      1) key=18 ;; # 1
      2) key=19 ;; # 2
      3) key=20 ;; # 3
      4) key=21 ;; # 4
      5) key=23 ;; # 5
      *) echo "Usage: switch_desktop <1-5>"; return 1 ;;
    esac
    osascript -e "tell application \"System Events\" to key code $key using control down"
    sleep 1
  }

  switch_desktop 3
  open -a "Microsoft Teams"

  switch_desktop 4
  open -a "Microsoft Outlook"

  switch_desktop 5
  open -a "Slack"
}

