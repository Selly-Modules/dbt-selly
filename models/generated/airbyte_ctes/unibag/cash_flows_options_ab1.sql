{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('cash_flows') }}
select
    _airbyte_cash_flows_hashid,
    {{ json_extract_scalar(adapter.quote('options'), ['orderId'], ['orderId']) }} as orderid,
    {{ json_extract_scalar(adapter.quote('options'), ['orderCode'], ['orderCode']) }} as ordercode,
    {{ json_extract_scalar(adapter.quote('options'), ['giveGiftId'], ['giveGiftId']) }} as givegiftid,
    {{ json_extract_scalar(adapter.quote('options'), ['giveGiftTitle'], ['giveGiftTitle']) }} as givegifttitle,
    {{ json_extract_scalar(adapter.quote('options'), ['userGiveGiftId'], ['userGiveGiftId']) }} as usergivegiftid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('cash_flows') }} as table_alias
-- options at cash-flows/options
where 1 = 1
and {{ adapter.quote('options') }} is not null

