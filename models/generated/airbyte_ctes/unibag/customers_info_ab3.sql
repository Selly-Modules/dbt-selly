{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_info_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customers_hashid',
        adapter.quote('name'),
        'email',
        'address',
        'companyname',
        'taxidentificationnumber',
    ]) }} as _airbyte_info_hashid,
    tmp.*
from {{ ref('customers_info_ab2') }} tmp
-- info at customers/info
where 1 = 1

