#!/bin/bash
#description    :Creates the base folder/file structure for ansible
#author         :Daniel Ferreira Lopes
#usage          :init.sh <path to root project>  
#==============================================================================

# Check if filepath is provided
if [ -z "$1" ]; then
    echo "usage: $0 <file path>"
    echo "Example: $0 infra/multimedia"
    exit 1
fi

# Create base folder structure
mkdir -p $1/{group_vars,host_vars,roles,templates,files}

# playbook entrypoint
cat > $1/main.yml << EOF
---
- name: "main"
  hosts: all
  tasks:
  - debug:
    msg: hey
EOF


cat > $1/readme.md << EOF
todo: information about the playbook
EOF
