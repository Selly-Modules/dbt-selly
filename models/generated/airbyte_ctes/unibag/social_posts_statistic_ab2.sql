{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('social_posts_statistic_ab1') }}
select
    _airbyte_social_posts_hashid,
    cast(likes as {{ dbt_utils.type_float() }}) as likes,
    cast({{ adapter.quote('views') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('views') }},
    cast({{ adapter.quote('comments') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('comments') }},
    cast(uniqueviews as {{ dbt_utils.type_float() }}) as uniqueviews,
    cast(shares_aibyte_transform as {{ dbt_utils.type_string() }}) as shares_aibyte_transform,
    cast(uniqueshares_aibyte_transform as {{ dbt_utils.type_string() }}) as uniqueshares_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('social_posts_statistic_ab1') }}
-- statistic at social-posts/statistic
where 1 = 1

