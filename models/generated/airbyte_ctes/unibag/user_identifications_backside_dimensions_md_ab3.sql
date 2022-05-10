{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_identifications_backside_dimensions_md_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_dimensions_hashid',
        'url',
        'width',
        'height',
    ]) }} as _airbyte_md_hashid,
    tmp.*
from {{ ref('user_identifications_backside_dimensions_md_ab2') }} tmp
-- md at user-identifications/backSide/dimensions/md
where 1 = 1

