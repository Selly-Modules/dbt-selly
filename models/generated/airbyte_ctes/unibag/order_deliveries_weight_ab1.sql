{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('order_deliveries') }}
select
    _airbyte_order_deliveries_hashid,
    {{ json_extract_scalar('weight', ['real'], ['real']) }} as {{ adapter.quote('real') }},
    {{ json_extract_scalar('weight', ['sent'], ['sent']) }} as sent,
    {{ json_extract_scalar('weight', ['converted'], ['converted']) }} as converted,
    {{ json_extract_scalar('weight', ['multiplier'], ['multiplier']) }} as multiplier,
    {{ json_extract_scalar('weight', ['convertedWithMultiplier'], ['convertedWithMultiplier']) }} as convertedwithmultiplier,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_deliveries') }} as table_alias
-- weight at order-deliveries/weight
where 1 = 1
and weight is not null

