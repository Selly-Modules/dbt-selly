{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('social_posts_sharestatistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_social_posts_hashid',
        'totalshare',
        'totalsharefromsocialpost',
        'totalsharefromproductdetail',
        'totaluniquesharefromsocialpost',
        'totaluniquesharefromproductdetail',
    ]) }} as _airbyte_sharestatistic_hashid,
    tmp.*
from {{ ref('social_posts_sharestatistic_ab2') }} tmp
-- sharestatistic at social-posts/shareStatistic
where 1 = 1

