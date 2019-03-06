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

irc-bridge-dir:
  file.directory:
    - name: {{ synapse.synapse_dir }}/irc-bridge
    - user: {{ synapse.user }}
    - group: {{ synapse.user }}        

irc-bridge-installation:
  npm.installed:
    - user: {{ synapse.user }}
    - pkgs:
        - matrix-appservice-irc

irc-bridge-configuration:  
  file.managed:
    - name: {{ synapse.synapse_dir }}/irc-bridge/config.yaml
    - source: salt://synapse/files/irc-bridge.yml
    - template: jinja
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

telegram-bridge-configuration:  
  file.managed:
    - name: {{ synapse.synapse_dir }}/telegram-bridge/config.yaml
    - source: salt://synapse/files/telegram-bridge.yml
    - template: jinja
    - user: {{ synapse.user }}
    - group: {{ synapse.user }}
      
# https://github.com/Half-Shot/matrix-appservice-discord

discord-bridge-dependencies:
  pkg.installed:
    - pkgs:
        - nodejs8 
        - npm8

discord-bridge-dir:
  file.directory:
    - name: {{ synapse.synapse_dir }}/discord-bridge
    - user: {{ synapse.user }}
    - group: {{ synapse.user }}

discord-bridge-installation:
  npm.installed:
    - user: {{ synapse.user }}
    - pkgs:
        - <npm package once it exists>

discord-bridge-configuration:  
  file.managed:
    - name: {{ synapse.synapse_dir }}/discord-bridge/config.yaml
    - source: salt://synapse/files/discord-bridge.yml
    - template: jinja
    - user: {{ synapse.user }}
    - group: {{ synapse.user }}
