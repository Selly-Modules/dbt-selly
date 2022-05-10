{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('suppliers_logo_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_suppliers_hashid',
        '_id',
        adapter.quote('name'),
        object_to_string('dimensions'),
    ]) }} as _airbyte_logo_hashid,
    tmp.*
from {{ ref('suppliers_logo_ab2') }} tmp
-- logo at suppliers/logo
where 1 = 1

