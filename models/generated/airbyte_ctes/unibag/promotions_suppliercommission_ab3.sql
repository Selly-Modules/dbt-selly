{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('promotions_suppliercommission_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_promotions_hashid',
        adapter.quote('type'),
        adapter.quote('value'),
    ]) }} as _airbyte_suppliercommission_hashid,
    tmp.*
from {{ ref('promotions_suppliercommission_ab2') }} tmp
-- suppliercommission at promotions/supplierCommission
where 1 = 1

