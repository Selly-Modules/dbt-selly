{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('social_posts_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    tags,
    {{ cast_to_boolean('ispin') }} as ispin,
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('order') }},
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(author as {{ dbt_utils.type_string() }}) as author,
    cities,
    photos,
    cast(reason as {{ dbt_utils.type_string() }}) as reason,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    videos,
    cast({{ adapter.quote('content') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('content') }},
    {{ cast_to_boolean('istimer') }} as istimer,
    cast(startat as {{ dbt_utils.type_string() }}) as startat,
    products,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    {{ cast_to_boolean('hasupdate') }} as hasupdate,
    cast(statistic as {{ dbt_utils.type_string() }}) as statistic,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    categories,
    {{ cast_to_boolean('fromsystem') }} as fromsystem,
    cast(contributor as {{ dbt_utils.type_string() }}) as contributor,
    cast(publishedat as {{ dbt_utils.type_string() }}) as publishedat,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    cast(updatedcount as {{ dbt_utils.type_float() }}) as updatedcount,
    cast(sharestatistic as {{ dbt_utils.type_string() }}) as sharestatistic,
    {{ cast_to_boolean('enablenotificationforcontributor') }} as enablenotificationforcontributor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('social_posts_ab1') }}
-- social_posts
where 1 = 1

