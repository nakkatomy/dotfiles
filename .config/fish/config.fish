## env
# set -x PATH $PATH


## alias


## vi mode
fish_vi_key_bindings

## vi mode exclude[I]
function fish_mode_prompt
end


# prompt
function fish_mode_prompt
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold cyan white
            case insert
                set_color --bold green white
            case replace-one
                set_color --bold green white
            case visual
                set_color --bold red white
            end
        # echo (echo $USER)@(prompt_hostname)(prompt_pwd)>
        # echo (echo $USER)@ (prompt_pwd)'>'
    end
end


# git branch
function git_branch
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
end

# right prompt
function fish_right_prompt
    echo (git_branch)
end

