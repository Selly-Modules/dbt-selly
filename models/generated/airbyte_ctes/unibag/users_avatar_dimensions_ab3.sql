{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_avatar_dimensions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_avatar_hashid',
        object_to_string('md'),
        object_to_string('sm'),
    ]) }} as _airbyte_dimensions_hashid,
    tmp.*
from {{ ref('users_avatar_dimensions_ab2') }} tmp
-- dimensions at users/avatar/dimensions
where 1 = 1

