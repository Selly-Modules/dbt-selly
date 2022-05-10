{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('orders') }}
select
    _airbyte_orders_hashid,
    {{ json_extract_scalar('delivery', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('delivery', ['fee'], ['fee']) }} as fee,
    {{ json_extract_scalar('delivery', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('delivery', ['note'], ['note']) }} as note,
    {{ json_extract_scalar('delivery', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('delivery', ['status'], ['status']) }} as status,
    {{ json_extract('table_alias', 'delivery', ['weight'], ['weight']) }} as weight,
    {{ json_extract('table_alias', 'delivery', ['feeShip'], ['feeShip']) }} as feeship,
    {{ json_extract_scalar('delivery', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('delivery', ['freeShip'], ['freeShip']) }} as freeship,
    {{ json_extract('table_alias', 'delivery', ['location'], ['location']) }} as {{ adapter.quote('location') }},
    {{ json_extract_scalar('delivery', ['sourceId'], ['sourceId']) }} as sourceid,
    {{ json_extract_scalar('delivery', ['courierName'], ['courierName']) }} as couriername,
    {{ json_extract_scalar('delivery', ['serviceCode'], ['serviceCode']) }} as servicecode,
    {{ json_extract_scalar('delivery', ['serviceName'], ['serviceName']) }} as servicename,
    {{ json_extract_scalar('delivery', ['customerName'], ['customerName']) }} as customername,
    {{ json_extract_scalar('delivery', ['customerPhone'], ['customerPhone']) }} as customerphone,
    {{ json_extract_scalar('delivery', ['discountValue'], ['discountValue']) }} as discountvalue,
    {{ json_extract_scalar('delivery', ['serviceDelivery'], ['serviceDelivery']) }} as servicedelivery,
    {{ json_extract_scalar('delivery', ['estimateDeliveryAt'], ['estimateDeliveryAt']) }} as estimatedeliveryat,
    {{ json_extract_scalar('delivery', ['estimateTimeDelivery'], ['estimateTimeDelivery']) }} as estimatetimedelivery,
    {{ json_extract_scalar('delivery', ['maxDeliveryDay_aibyte_transform'], ['maxDeliveryDay_aibyte_transform']) }} as maxdeliveryday_aibyte_transform,
    {{ json_extract_scalar('delivery', ['minDeliveryDay_aibyte_transform'], ['minDeliveryDay_aibyte_transform']) }} as mindeliveryday_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders') }} as table_alias
-- delivery at orders/delivery
where 1 = 1
and delivery is not null

