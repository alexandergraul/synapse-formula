{%- from "synapse/map.jinja" import synapse with context -%}

include:
  - synapse.user

riot-dir:
  file.directory:
    - name: {{ synapse.riot_dir }}
    - user: {{ synapse.user }}
    - group: {{ synapse.user }}
    - require:
      - user: synapse-user

riot-archive:
  archive.extracted:
    - name: {{ synapse.riot_dir }}
    - source: {{ synapse.riot_archive }}
    - archive_format: tar
    - skip_verify: True
    - user: {{ synapse.user }}
    - group: {{ synapse.user }}
    - if_missing: {{ synapse.riot_dir }}/index.html
{%- if salt['grains.get']('saltversioninfo') < [2016, 11, 0] %}
    - tar_options: '--strip-components=1'
{%- else %}
    - options: '--strip-components=1'
    - enforce_toplevel: False
{%- endif %}
    - require:
      - user: synapse-user
      - file: riot-dir

riot-conf-file:
  file.managed:
    - name: {{ synapse.riot_conf_file }}
    - source: salt://synapse/files/riot_config.json
    - template: jinja
    - user: {{ synapse.user }}
    - group: {{ synapse.user }}
    - require:
      - user: synapse-user
