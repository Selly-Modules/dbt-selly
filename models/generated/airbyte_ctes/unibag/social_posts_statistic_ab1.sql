{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('social_posts') }}
select
    _airbyte_social_posts_hashid,
    {{ json_extract_scalar('statistic', ['likes'], ['likes']) }} as likes,
    {{ json_extract_scalar('statistic', ['views'], ['views']) }} as {{ adapter.quote('views') }},
    {{ json_extract_scalar('statistic', ['comments'], ['comments']) }} as {{ adapter.quote('comments') }},
    {{ json_extract_scalar('statistic', ['uniqueViews'], ['uniqueViews']) }} as uniqueviews,
    {{ json_extract_scalar('statistic', ['shares_aibyte_transform'], ['shares_aibyte_transform']) }} as shares_aibyte_transform,
    {{ json_extract_scalar('statistic', ['uniqueShares_aibyte_transform'], ['uniqueShares_aibyte_transform']) }} as uniqueshares_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('social_posts') }} as table_alias
-- statistic at social-posts/statistic
where 1 = 1
and statistic is not null

