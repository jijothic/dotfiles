set __toaster_color_orange "#fea63c"
set __toaster_color_blue "#7db9c7"
set __toaster_color_green "#f9ff44"
set __toaster_color_yellow "#ffd939"
set __toaster_color_pink "#ff5252"
set __toaster_color_red "#e84f4f"
set __toaster_color_grey "#cccccc"
set __toaster_color_white "#ffffff"
set __toaster_color_purple "#fe448b"
set __toaster_color_lilac "#b7416e"
set __toaster_color_grey_dark "#222222"

set __toaster_color_yellow_bold "#ffd939 --bold"
set __toaster_color_grey_bold "#cccccc --bold"

function __toaster_color_echo
  set_color (echo $argv[1] | cut -d '#' -f 2)
  if test (count $argv) -eq 2
    echo -n $argv[2]
  end
end

function __toaster_current_folder
  if test $PWD = '/'
    echo -n '/'
  else
    echo -n $PWD | grep -o -E '[^\/]+$'
  end
end

function __toaster_git_status_codes
  echo (git status --porcelain ^/dev/null | sed -E 's/(^.{3}).*/\1/' | tr -d ' \n')
end

function __toaster_git_branch_name
  echo (git rev-parse --abbrev-ref HEAD ^/dev/null)
end

function __toaster_rainbow
  if echo $argv[1] | grep -q -e $argv[3]
    __toaster_color_echo $argv[2] "彡ミ"
  end
end

function __toaster_git_status_icons
  set -l git_status (__toaster_git_status_codes)

  __toaster_rainbow $git_status $__toaster_color_pink 'D'
  __toaster_rainbow $git_status $__toaster_color_red 'D'
  __toaster_rainbow $git_status $__toaster_color_orange 'R'
  __toaster_rainbow $git_status $__toaster_color_white 'C'
  __toaster_rainbow $git_status $__toaster_color_green 'A'
  __toaster_rainbow $git_status $__toaster_color_blue 'U'
  __toaster_rainbow $git_status $__toaster_color_lilac 'M'
  __toaster_rainbow $git_status $__toaster_color_grey '?'
end

function __toaster_git_status
  # In git
  if test -n (__toaster_git_branch_name)

    #__toaster_color_echo $__toaster_color_blue " git"
    __toaster_color_echo $__toaster_color_grey " @ "
    __toaster_color_echo $__toaster_color_purple (__toaster_git_branch_name)

    if test -n (__toaster_git_status_codes)
      __toaster_color_echo $__toaster_color_red ' ●'
      __toaster_color_echo $__toaster_color_yellow ' [^._.^]ﾉ'
      __toaster_git_status_icons
    else
      __toaster_color_echo $__toaster_color_green ' ○'
    end
  end
end

function fish_prompt
  __toaster_color_echo $__toaster_color_yellow "•" 
  __toaster_color_echo $__toaster_color_red "•" 
  __toaster_color_echo $__toaster_color_lilac "•" 
  __toaster_color_echo $__toaster_color_blue "• " 
  __toaster_color_echo $__toaster_color_yellow (__toaster_current_folder)
  __toaster_git_status
  echo
  __toaster_color_echo $__toaster_color_grey "∷ "
end
