set -g prefix C-b
unbind-key -n C-a

bind-key k selectp -U
bind-key j selectp -D
bind-key h selectp -L
bind-key l selectp -R

bind-key [ splitw -v
bind-key ] splitw -h

bind-key s setw synchronize-panes
