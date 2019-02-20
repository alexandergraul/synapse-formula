{%- from "synapse/map.jinja" import synapse with context -%}

include:
  - synapse
  - synapse.user

# https://github.com/matrix-org/matrix-appservice-irc
irc-bridge-dependencies:
  pkg.installed:
    - pkgs:
        - nodejs8 # or 6 > 6.9 -> configuration
        - npm8
        
irc-bridge-installation:
  npm.installed:
    - user: {{ synapse.user }}
    - pkgs:
        - matrix-appservice-irc

irc-bridge-configuration:  
  file.managed:
    - name: <path-to-file>
    - source: salt://synapse/files/irc-bridge.yml
    - user: {{ synapse.user }}
    - group: {{ synapse.user }}

# https://github.com/tulir/mautrix-telegram
telegram-bridge-dependencies:
  pkg.installed:
    - pkgs:
{%- for pkg in synapse.pkg_dependencies %}
      - {{ pkg }}
{%- endfor %}
    
telegram-bridge-dir:
  file.directory:
    - name: {{ synapse.synapse_dir }}/telegram-bridge
    - user: {{ synapse.user }}
    - group: {{ synapse.user }}

telegram-bridge-virtualenv:
  virtualenv.manged:
    - name: {{ synapse.synapse_dir }}/telegram-bridge
    - user: {{ synapse.user }}
    - pip_pkgs:
        - mautrix-telegram[all]
      
# https://github.com/Half-Shot/matrix-appservice-discord

discord-bridge-dependencies:
  pkg.installed:
    - pkgs:
        - nodejs8 
        - npm8
        
discord-bridge-installation:
  npm.installed:
    - user: {{ synapse.user }}
    - pkgs:
        - <npm package once it exists>
