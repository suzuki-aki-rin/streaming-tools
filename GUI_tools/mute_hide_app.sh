#!/bin/bash

#
# usage:
# mute_app "app name" [mute|unmute] [hide|unhide|shade|unshade]
#
# e.g. app name : "Street Fighter 6"

app_name=$1
ismute=$2
ishide=$3

mute_app() {
  local app_name="$1"
  local action="$2"

  # sink-input一覧からアプリ名に該当するIDを抽出
  #     pactl list sink-inputs | grep -B 20 'application.name = "$APP_NAME"' | grep 'シンク入力' | awk '{print $2}' | tr -d '#'
  pactl list sink-inputs | awk -v app="$app_name" '/^シンク入力/ {gsub(/#/, "", $2); id=$2}
      $0 ~ "application.name = \""app"\"" {print id}
    ' | while read id; do
    case "$action" in
    mute)
      pactl set-sink-input-mute "$id" 1
      ;;
    unmute)
      pactl set-sink-input-mute "$id" 0
      ;;
      # toggle)
      #     # 現在のミュート状態を取得してトグル
      #     mute_state=$(pactl list sink-inputs | awk -v id="$id" '
      #     $0 ~ "Sink Input #"id {found=1}
      #     found && /Mute:/ {print $2; exit}
      #     ')
      #     if [ "$mute_state" = "yes" ]; then
      #         pactl set-sink-input-mute "$id" 0
      #     else
      #         pactl set-sink-input-mute "$id" 1
      #     fi
      #     ;;
    esac
  done
}

hide_app() {
  local app_name="$1"
  local action="$2"
  case "$action" in
  shade)
    wmctrl -r "$app_name" -b add,shaded
    ;;
  unshade)
    wmctrl -r "$app_name" -b remove,shaded
    wmctrl -a "$app_name"
    ;;
  hide)
    wmctrl -r "$app_name" -b add,hidden
    ;;
  unhide)
    wmctrl -a "$app_name"
    ;;
  esac
}

mute_app "$app_name" "$ismute"
hide_app "$app_name" "$ishide"
