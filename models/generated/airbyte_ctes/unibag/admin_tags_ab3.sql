{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('admin_tags_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('name'),
        adapter.quote('type'),
        'color',
        boolean_to_string('active'),
        'createdat',
        'updatedat',
        'searchstring',
    ]) }} as _airbyte_admin_tags_hashid,
    tmp.*
from {{ ref('admin_tags_ab2') }} tmp
-- admin_tags
where 1 = 1

