{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('social_posts_ab3') }}
select
    _id,
    title,
    author AS author_id,
    {{ adapter.quote('content') }},
    status,
    cast({{ adapter.quote('photos') }} AS jsonb) AS photos,
    cast({{ adapter.quote('videos') }} AS jsonb) AS videos,
    string_to_array(REPLACE(REPLACE(REPLACE(tags::text, '[', ''), ']', ''), '"', ''), ',') AS tags,
    COALESCE(cast({{ adapter.quote('statistic') }}::json->>'views' AS integer), 0) AS statistic_views,
    COALESCE(cast({{ adapter.quote('statistic') }}::json->>'uniqueViews' AS integer), 0) AS statistic_unique_views,
    COALESCE(cast({{ adapter.quote('statistic') }}::json->>'likes' AS integer), 0) AS statistic_likes,
    COALESCE(cast({{ adapter.quote('statistic') }}::json->>'shares' AS integer), 0) AS statistic_shares,
    COALESCE(cast({{ adapter.quote('statistic') }}::json->>'comments' AS integer), 0) AS statistic_comments,
    string_to_array(REPLACE(REPLACE(REPLACE(products::text, '[', ''), ']', ''), '"', ''), ',') AS products,
    string_to_array(REPLACE(REPLACE(REPLACE(categories::text, '[', ''), ']', ''), '"', ''), ',') AS categories,
    string_to_array(REPLACE(REPLACE(REPLACE(cities::text, '[', ''), ']', ''), '"', ''), ',') AS cities,
    {{ adapter.quote('order') }},
    contributor AS contributor_id,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    publishedat::timestamp AS published_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_social_posts_hashid
from {{ ref('social_posts_ab3') }}
-- social_posts from {{ source('unibag', '_airbyte_raw_social_posts') }}
where 1 = 1

