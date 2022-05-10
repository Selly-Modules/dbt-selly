{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('session_deliveries') }}
select
    _airbyte_session_deliveries_hashid,
    {{ json_extract_scalar('delivery', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('delivery', ['fee'], ['fee']) }} as fee,
    {{ json_extract_scalar('delivery', ['desc'], ['desc']) }} as {{ adapter.quote('desc') }},
    {{ json_extract_scalar('delivery', ['note'], ['note']) }} as note,
    {{ json_extract_scalar('delivery', ['title'], ['title']) }} as title,
    {{ json_extract('table_alias', 'delivery', ['feeShip'], ['feeShip']) }} as feeship,
    {{ json_extract_scalar('delivery', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('delivery', ['sourceId'], ['sourceId']) }} as sourceid,
    {{ json_extract_scalar('delivery', ['courierName'], ['courierName']) }} as couriername,
    {{ json_extract_scalar('delivery', ['serviceCode'], ['serviceCode']) }} as servicecode,
    {{ json_extract_scalar('delivery', ['serviceName'], ['serviceName']) }} as servicename,
    {{ json_extract_scalar('delivery', ['deliveryCode'], ['deliveryCode']) }} as deliverycode,
    {{ json_extract_scalar('delivery', ['maxDeliveryDays'], ['maxDeliveryDays']) }} as maxdeliverydays,
    {{ json_extract_scalar('delivery', ['minDeliveryDays'], ['minDeliveryDays']) }} as mindeliverydays,
    {{ json_extract_scalar('delivery', ['realShippingFee'], ['realShippingFee']) }} as realshippingfee,
    {{ json_extract_scalar('delivery', ['estimateTimeDelivery'], ['estimateTimeDelivery']) }} as estimatetimedelivery,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries') }} as table_alias
-- delivery at session-deliveries/delivery
where 1 = 1
and delivery is not null

