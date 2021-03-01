

{% set tables = get_tables(table_like = 'raw_') %}
{% set cols_list = ["zonedist1", "zn_dst1"] %}

{% for t in tables %}
{% set columns = get_columns(table = t) %}

  select
      uuid
    , borough
    , block
    , lot
    , year
    , cast({{make_bbl()}} as varchar(10)) as bbl
    , st_transform(geometry, 4326) as geometry,
     {% for column in columns %}
     {% if column in cols_list %}
      {{column}} as zone_dist
      {% endif %}
      {% endfor %}
  from source.{{t}}
  {% if not loop.last -%} union all {%- endif %}
  {% endfor %}
