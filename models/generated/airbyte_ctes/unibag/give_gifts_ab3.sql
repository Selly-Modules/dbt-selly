{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('give_gifts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'title',
        'status',
        adapter.quote('content'),
        'createdat',
        'createdby',
        'updatedat',
        'searchstring',
        'lastchangeusersat',
    ]) }} as _airbyte_give_gifts_hashid,
    tmp.*
from {{ ref('give_gifts_ab2') }} tmp
-- give_gifts
where 1 = 1

