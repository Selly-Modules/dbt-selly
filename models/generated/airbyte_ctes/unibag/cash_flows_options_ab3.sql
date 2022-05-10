{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cash_flows_options_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_cash_flows_hashid',
        'orderid',
        'ordercode',
        'givegiftid',
        'givegifttitle',
        'usergivegiftid',
    ]) }} as _airbyte_options_hashid,
    tmp.*
from {{ ref('cash_flows_options_ab2') }} tmp
-- options at cash-flows/options
where 1 = 1

