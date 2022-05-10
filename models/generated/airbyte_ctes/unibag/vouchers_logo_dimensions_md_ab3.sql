{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vouchers_logo_dimensions_md_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_dimensions_hashid',
        'url',
        'width',
        'height',
    ]) }} as _airbyte_md_hashid,
    tmp.*
from {{ ref('vouchers_logo_dimensions_md_ab2') }} tmp
-- md at vouchers/logo/dimensions/md
where 1 = 1

