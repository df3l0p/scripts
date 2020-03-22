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

cat > $1/hosts.yml << EOF
all: # keys must be unique, i.e. only one 'hosts' per group
    hosts:
        test1:
        test2:
            host_var: value
    vars:
        group_all_var: value
    children:   # key order does not matter, indentation does
        other_group:
            children:
                group_x:
                    hosts:
                        test5   # Note that one machine will work without a colon
                #group_x:
                #    hosts:
                #        test5  # But this won't
                #        test7  #
                group_y:
                    hosts:
                        test6:  # So always use a colon
            vars:
                g2_var2: value3
            hosts:
                test4:
                    ansible_host: 127.0.0.1
        last_group:
            hosts:
                test1 # same host as above, additional group membership
            vars:
                group_last_var: value
EOF
