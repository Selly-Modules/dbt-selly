{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('social_post_views_ab3') }}
select
    _id,
    {{ adapter.quote('user') }} AS seller_id,
    socialpost AS social_post_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_social_post_views_hashid
from {{ ref('social_post_views_ab3') }}
-- social_post_views from {{ source('unibag', '_airbyte_raw_social_post_views') }}
where 1 = 1

