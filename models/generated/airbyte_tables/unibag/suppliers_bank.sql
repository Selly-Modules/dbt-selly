{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('suppliers_bank_ab3') }}
select
    _airbyte_suppliers_hashid,
    bank,
    branch,
    cardnumber,
    cardholdername,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_bank_hashid
from {{ ref('suppliers_bank_ab3') }}
-- bank at suppliers/bank from {{ ref('suppliers') }}
where 1 = 1

