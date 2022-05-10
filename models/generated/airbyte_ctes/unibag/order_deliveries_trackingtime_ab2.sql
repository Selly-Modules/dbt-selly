{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('order_deliveries_trackingtime_ab1') }}
select
    _airbyte_order_deliveries_hashid,
    cast(pickedat as {{ dbt_utils.type_string() }}) as pickedat,
    cast(completedat as {{ dbt_utils.type_string() }}) as completedat,
    cast(deliveringat as {{ dbt_utils.type_string() }}) as deliveringat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_deliveries_trackingtime_ab1') }}
-- trackingtime at order-deliveries/trackingTime
where 1 = 1

