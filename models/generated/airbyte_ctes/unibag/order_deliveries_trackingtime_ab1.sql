{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('order_deliveries') }}
select
    _airbyte_order_deliveries_hashid,
    {{ json_extract_scalar('trackingtime', ['pickedAt'], ['pickedAt']) }} as pickedat,
    {{ json_extract_scalar('trackingtime', ['completedAt'], ['completedAt']) }} as completedat,
    {{ json_extract_scalar('trackingtime', ['deliveringAt'], ['deliveringAt']) }} as deliveringat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_deliveries') }} as table_alias
-- trackingtime at order-deliveries/trackingTime
where 1 = 1
and trackingtime is not null

