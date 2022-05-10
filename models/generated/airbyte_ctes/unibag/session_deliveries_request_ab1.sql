{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('session_deliveries') }}
select
    _airbyte_session_deliveries_hashid,
    {{ json_extract('table_alias', 'request', ['to'], ['to']) }} as {{ adapter.quote('to') }},
    {{ json_extract('table_alias', 'request', ['from'], ['from']) }} as {{ adapter.quote('from') }},
    {{ json_extract_array('request', ['items'], ['items']) }} as items,
    {{ json_extract_scalar('request', ['checksum'], ['checksum']) }} as checksum,
    {{ json_extract_scalar('request', ['codAmount'], ['codAmount']) }} as codamount,
    {{ json_extract_scalar('request', ['orderCode'], ['orderCode']) }} as ordercode,
    {{ json_extract_scalar('request', ['restockAt'], ['restockAt']) }} as restockat,
    {{ json_extract_scalar('request', ['isPreorder'], ['isPreorder']) }} as ispreorder,
    {{ json_extract_scalar('request', ['totalAmount'], ['totalAmount']) }} as totalamount,
    {{ json_extract_scalar('request', ['paymentMethod'], ['paymentMethod']) }} as paymentmethod,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries') }} as table_alias
-- request at session-deliveries/request
where 1 = 1
and request is not null

