echo $(i3-msg -t get_workspaces | grep -o '"num":[0-9]*,"name":"[^"]*","visible":true,"focused":true' | grep -o '[0-9]*' | head -n1)
