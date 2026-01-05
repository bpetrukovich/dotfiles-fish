function fzf_search_git_branch --description "Search git branches. Replace the current token with the selected branch names."
    # Check if we're in a git repository
    if not git rev-parse --git-dir >/dev/null 2>&1
        commandline --function repaint
        return 1
    end

    set -f git_cmd git branch --all --format="%(refname:short)"
    # Filter out HEAD and add color with git
    set -f git_cmd $git_cmd | string match -v -- HEAD

    set -f fzf_arguments --multi --ansi $fzf_git_log_opts  # Reuse git log opts or set fzf_git_branch_opts
    set -f token (commandline --current-token)
    
    # Expand variables/tilde and unescape token (same as directory search)
    set -f expanded_token (eval echo -- $token)
    set -f unescaped_token (string unescape -- $expanded_token)

    # Seed fzf query with current token
    set --prepend fzf_arguments --query="$unescaped_token"
    
    # Preview: show recent commits and status for the branch
    set --prepend fzf_arguments --prompt="Branches> " --preview="
        git log -100 --oneline --color=always --graph {1} 2>/dev/null ||
        git log --oneline --color=always {1}..HEAD 2>/dev/null ||
        echo 'No commits'
    "

    set -f branches_selected ($git_cmd | _fzf_wrapper $fzf_arguments)

    if test $status -eq 0 -a -n "$branches_selected"
        # Replace current token with selected branches (space-separated)
        commandline --current-token --replace -- (string escape -- $branches_selected | string join ' ')
    end

    commandline --function repaint
end
