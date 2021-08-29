
{# this is really from the dtplyr package, i just changed it to include less spaces #}

{% macro across(var_list, script_string, final_comma) %}

  {%- for v in var_list -%}
  {{- script_string | replace('{{var}}', v) -}}
  {%- if not loop.last -%},{%- endif -%}
  {%- if loop.last and final_comma|default(false) -%},{%- endif -%}
  {%- endfor -%}

{% endmacro %}