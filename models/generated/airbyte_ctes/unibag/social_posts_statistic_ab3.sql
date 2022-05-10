{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('social_posts_statistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_social_posts_hashid',
        'likes',
        adapter.quote('views'),
        adapter.quote('comments'),
        'uniqueviews',
        'shares_aibyte_transform',
        'uniqueshares_aibyte_transform',
    ]) }} as _airbyte_statistic_hashid,
    tmp.*
from {{ ref('social_posts_statistic_ab2') }} tmp
-- statistic at social-posts/statistic
where 1 = 1

