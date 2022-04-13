{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('social_post_views_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('user'),
        'clientip',
        'lastviewat',
        'socialpost',
    ]) }} as _airbyte_social_post_views_hashid,
    tmp.*
from {{ ref('social_post_views_ab2') }} tmp
-- social_post_views
where 1 = 1

