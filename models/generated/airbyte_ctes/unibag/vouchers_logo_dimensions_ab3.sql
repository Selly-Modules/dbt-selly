{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vouchers_logo_dimensions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_logo_hashid',
        object_to_string('md'),
        object_to_string('sm'),
    ]) }} as _airbyte_dimensions_hashid,
    tmp.*
from {{ ref('vouchers_logo_dimensions_ab2') }} tmp
-- dimensions at vouchers/logo/dimensions
where 1 = 1

