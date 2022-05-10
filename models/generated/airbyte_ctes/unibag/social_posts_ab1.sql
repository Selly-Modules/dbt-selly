{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_social_posts') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_array('_airbyte_data', ['tags'], ['tags']) }} as tags,
    {{ json_extract_scalar('_airbyte_data', ['isPin'], ['isPin']) }} as ispin,
    {{ json_extract_scalar('_airbyte_data', ['order'], ['order']) }} as {{ adapter.quote('order') }},
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['author'], ['author']) }} as author,
    {{ json_extract_array('_airbyte_data', ['cities'], ['cities']) }} as cities,
    {{ json_extract_array('_airbyte_data', ['photos'], ['photos']) }} as photos,
    {{ json_extract_scalar('_airbyte_data', ['reason'], ['reason']) }} as reason,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_array('_airbyte_data', ['videos'], ['videos']) }} as videos,
    {{ json_extract_scalar('_airbyte_data', ['content'], ['content']) }} as {{ adapter.quote('content') }},
    {{ json_extract_scalar('_airbyte_data', ['isTimer'], ['isTimer']) }} as istimer,
    {{ json_extract_scalar('_airbyte_data', ['startAt'], ['startAt']) }} as startat,
    {{ json_extract_array('_airbyte_data', ['products'], ['products']) }} as products,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['hasUpdate'], ['hasUpdate']) }} as hasupdate,
    {{ json_extract('table_alias', '_airbyte_data', ['statistic'], ['statistic']) }} as statistic,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_array('_airbyte_data', ['categories'], ['categories']) }} as categories,
    {{ json_extract_scalar('_airbyte_data', ['fromSystem'], ['fromSystem']) }} as fromsystem,
    {{ json_extract_scalar('_airbyte_data', ['contributor'], ['contributor']) }} as contributor,
    {{ json_extract_scalar('_airbyte_data', ['publishedAt'], ['publishedAt']) }} as publishedat,
    {{ json_extract_scalar('_airbyte_data', ['searchString'], ['searchString']) }} as searchstring,
    {{ json_extract_scalar('_airbyte_data', ['updatedCount'], ['updatedCount']) }} as updatedcount,
    {{ json_extract('table_alias', '_airbyte_data', ['shareStatistic'], ['shareStatistic']) }} as sharestatistic,
    {{ json_extract_scalar('_airbyte_data', ['enableNotificationForContributor'], ['enableNotificationForContributor']) }} as enablenotificationforcontributor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_social_posts') }} as table_alias
-- social_posts
where 1 = 1

