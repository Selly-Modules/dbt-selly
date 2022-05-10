{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('order_items_price_ab1') }}
select
    _airbyte_order_items_hashid,
    cast(base as {{ dbt_utils.type_float() }}) as base,
    cast(sell as {{ dbt_utils.type_float() }}) as sell,
    cast(market as {{ dbt_utils.type_float() }}) as market,
    cast(profit as {{ dbt_utils.type_float() }}) as profit,
    cast(volume as {{ dbt_utils.type_string() }}) as volume,
    cast(weight as {{ dbt_utils.type_float() }}) as weight,
    cast(maximum as {{ dbt_utils.type_float() }}) as maximum,
    cast(minimum as {{ dbt_utils.type_float() }}) as minimum,
    cast(profituni as {{ dbt_utils.type_float() }}) as profituni,
    cast(supplierprice as {{ dbt_utils.type_float() }}) as supplierprice,
    cast(membershippercent as {{ dbt_utils.type_float() }}) as membershippercent,
    cast(membershipcommission as {{ dbt_utils.type_float() }}) as membershipcommission,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_items_price_ab1') }}
-- price at order-items/price
where 1 = 1

