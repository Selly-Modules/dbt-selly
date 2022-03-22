{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('districts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'city',
        'code',
        adapter.quote('name'),
        'slug',
        'tncid',
        'cityid',
        adapter.quote('source'),
        'tnccode',
        'gidocode',
        'osirisid',
        'updatedat',
        'searchstring',
    ]) }} as _airbyte_districts_hashid,
    tmp.*
from {{ ref('districts_ab2') }} tmp
-- districts
where 1 = 1

