{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('social_posts_sharestatistic_ab3') }}
select
    _airbyte_social_posts_hashid,
    totalshare,
    totalsharefromsocialpost,
    totalsharefromproductdetail,
    totaluniquesharefromsocialpost,
    totaluniquesharefromproductdetail,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sharestatistic_hashid
from {{ ref('social_posts_sharestatistic_ab3') }}
-- sharestatistic at social-posts/shareStatistic from {{ ref('social_posts') }}
where 1 = 1

