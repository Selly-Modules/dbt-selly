{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_identifications__ation_addressentities_ab1') }}
select
    _airbyte_detectinformation_hashid,
    cast(ward as {{ dbt_utils.type_string() }}) as ward,
    cast(street as {{ dbt_utils.type_string() }}) as street,
    cast(district as {{ dbt_utils.type_string() }}) as district,
    cast(province as {{ dbt_utils.type_string() }}) as province,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_identifications__ation_addressentities_ab1') }}
-- addressentities at user-identifications/detectInformation/addressEntities
where 1 = 1

