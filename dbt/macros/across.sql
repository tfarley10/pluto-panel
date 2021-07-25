{% macro across(var_list, script_string, final_comma) %}

  {%- for v in var_list -%}
  {{- script_string | replace('{{var}}', v) -}}
  {%- if not loop.last -%},{%- endif -%}
  {%- if loop.last and final_comma|default(false) -%},{%- endif -%}
  {%- endfor -%}

{% endmacro %}