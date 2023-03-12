local ret_status="%(?:%{$fg_bold[blue]%}❯ :%{$fg_bold[red]%}❯ )"
# local ret_status="%(?:%{$fg_bold[blue]%}λ :%{$fg_bold[red]%}λ )"
PROMPT='%{$fg_bold[blue]%}λ %{$fg_bold[blue]%}%c%{$reset_color%} $(git_prompt_info)${ret_status}%{$reset_color%}'
RPROMPT="%*"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}]%{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}]"
