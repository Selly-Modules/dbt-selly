{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_price_ab1') }}
select
    _airbyte_orders_hashid,
    cast(sell as {{ dbt_utils.type_float() }}) as sell,
    cast(total as {{ dbt_utils.type_float() }}) as total,
    cast(market as {{ dbt_utils.type_float() }}) as market,
    cast(weight as {{ dbt_utils.type_float() }}) as weight,
    cast(maximum as {{ dbt_utils.type_float() }}) as maximum,
    cast(minimum as {{ dbt_utils.type_float() }}) as minimum,
    cast(profituni as {{ dbt_utils.type_float() }}) as profituni,
    cast(promotion as {{ dbt_utils.type_float() }}) as promotion,
    cast(supplierprice as {{ dbt_utils.type_float() }}) as supplierprice,
    cast(wholesalebonus as {{ dbt_utils.type_float() }}) as wholesalebonus,
    cast(membershippercent as {{ dbt_utils.type_float() }}) as membershippercent,
    cast(membershipcommission as {{ dbt_utils.type_float() }}) as membershipcommission,
    cast(base_aibyte_transform as {{ dbt_utils.type_string() }}) as base_aibyte_transform,
    cast(profit_aibyte_transform as {{ dbt_utils.type_string() }}) as profit_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_price_ab1') }}
-- price at orders/price
where 1 = 1

