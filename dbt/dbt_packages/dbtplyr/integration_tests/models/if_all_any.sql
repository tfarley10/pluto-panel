select 

  sum( case when {{ dbtplyr.if_all(['n_a', 'ind_a', 'ind_b'], '{{var}} < 2') }} then 1 else 0 end) as not_all,
  sum( case when {{ dbtplyr.if_any(['n_a', 'ind_a', 'ind_b'], '{{var}} < 2') }} then 1 else 0 end) as yes_any
  
from {{ ref('data') }}
