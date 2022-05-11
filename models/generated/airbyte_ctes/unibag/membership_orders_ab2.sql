{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('membership_orders_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('user') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('user') }},
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast({{ adapter.quote('percent') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('percent') }},
    cast(targetid as {{ dbt_utils.type_string() }}) as targetid,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(commission as {{ dbt_utils.type_float() }}) as commission,
    {{ cast_to_boolean('isrejected') }} as isrejected,
    cast(membershipname as {{ dbt_utils.type_string() }}) as membershipname,
    cast(membershiplevel as {{ dbt_utils.type_float() }}) as membershiplevel,
    cast({{ adapter.quote('membershippromotion') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('membershippromotion') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('membership_orders_ab1') }}
-- membership_orders
where 1 = 1

