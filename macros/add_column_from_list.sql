 {% macro add_column_from_list(acceptable_values = [], table = '') %}
 {%- set table_values = get_columns(table = table) -%}
 {%- for val in table_values -%}
 {%- if val in acceptable_values -%}
 {{val}}
 {%- endif -%}
 {%- endfor -%}
{%- endmacro -%}
