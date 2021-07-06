projects_path="~/projects"

function onReady(){ 
    tmux new -d -s $project_name -n editor
    tmux send-keys -t "$project_name:1.0" 'nvim' Enter
    tmux new-window -t $project_name -n terminal
    tmux splitw -h
    tmux select-window -t $session:1
    tmux a -t $project_name
}
