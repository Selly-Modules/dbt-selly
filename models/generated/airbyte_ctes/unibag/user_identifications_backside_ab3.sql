{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_identifications_backside_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_user_identifications_hashid',
        '_id',
        adapter.quote('name'),
        object_to_string('dimensions'),
    ]) }} as _airbyte_backside_hashid,
    tmp.*
from {{ ref('user_identifications_backside_ab2') }} tmp
-- backside at user-identifications/backSide
where 1 = 1

