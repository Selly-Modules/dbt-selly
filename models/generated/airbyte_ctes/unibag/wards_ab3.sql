{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('wards_ab2') }}
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
        'district',
        'gidocode',
        'osirisid',
        'updatedat',
        'districtid',
        'provinceid',
        'searchstring',
    ]) }} as _airbyte_wards_hashid,
    tmp.*
from {{ ref('wards_ab2') }} tmp
-- wards
where 1 = 1

