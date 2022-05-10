{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('cash_flows_options_ab3') }}
select
    _airbyte_cash_flows_hashid,
    orderid,
    ordercode,
    givegiftid,
    givegifttitle,
    usergivegiftid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_options_hashid
from {{ ref('cash_flows_options_ab3') }}
-- options at cash-flows/options from {{ ref('cash_flows') }}
where 1 = 1

