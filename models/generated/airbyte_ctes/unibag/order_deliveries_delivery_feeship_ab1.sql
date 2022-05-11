{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('order_deliveries_delivery') }}
select
    _airbyte_delivery_hashid,
    {{ json_extract_scalar('feeship', ['cod'], ['cod']) }} as cod,
    {{ json_extract_scalar('feeship', ['total'], ['total']) }} as total,
    {{ json_extract_scalar('feeship', ['shipping'], ['shipping']) }} as shipping,
    {{ json_extract_scalar('feeship', ['insurance'], ['insurance']) }} as insurance,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_deliveries_delivery') }} as table_alias
-- feeship at order-deliveries/delivery/feeShip
where 1 = 1
and feeship is not null
