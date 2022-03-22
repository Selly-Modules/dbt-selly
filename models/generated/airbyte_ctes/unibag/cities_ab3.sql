{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cities_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'code',
        adapter.quote('name'),
        'slug',
        adapter.quote('order'),
        'tncid',
        'region',
        adapter.quote('source'),
        'tempid',
        'tnccode',
        'osirisid',
        'updatedat',
        'searchstring',
    ]) }} as _airbyte_cities_hashid,
    tmp.*
from {{ ref('cities_ab2') }} tmp
-- cities
where 1 = 1

