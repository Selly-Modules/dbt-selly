{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('suppliers_reviewstatistic_ab1') }}
select
    _airbyte_suppliers_hashid,
    cast(total as {{ dbt_utils.type_float() }}) as total,
    cast(totalreview as {{ dbt_utils.type_float() }}) as totalreview,
    cast(totalscore1 as {{ dbt_utils.type_float() }}) as totalscore1,
    cast(totalscore2 as {{ dbt_utils.type_float() }}) as totalscore2,
    cast(totalscore3 as {{ dbt_utils.type_float() }}) as totalscore3,
    cast(totalscore4 as {{ dbt_utils.type_float() }}) as totalscore4,
    cast(totalscore5 as {{ dbt_utils.type_float() }}) as totalscore5,
    cast(scoreaverage as {{ dbt_utils.type_float() }}) as scoreaverage,
    cast(totalhasmedia as {{ dbt_utils.type_float() }}) as totalhasmedia,
    cast(totalhascontent as {{ dbt_utils.type_float() }}) as totalhascontent,
    cast(scoreaverageweektotal as {{ dbt_utils.type_float() }}) as scoreaverageweektotal,
    cast(scoreaverageyeartotal as {{ dbt_utils.type_float() }}) as scoreaverageyeartotal,
    cast(scoreaveragemonthtotal as {{ dbt_utils.type_float() }}) as scoreaveragemonthtotal,
    cast(scoreaveragetwomonthtotal as {{ dbt_utils.type_float() }}) as scoreaveragetwomonthtotal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('suppliers_reviewstatistic_ab1') }}
-- reviewstatistic at suppliers/reviewStatistic
where 1 = 1

