{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('session_deliveries_request_to') }}
select
    _airbyte_to_hashid,
    {{ json_extract_scalar(adapter.quote('location'), ['address'], ['address']) }} as address,
    {{ json_extract_scalar(adapter.quote('location'), ['wardCode'], ['wardCode']) }} as wardcode,
    {{ json_extract_scalar(adapter.quote('location'), ['districtCode'], ['districtCode']) }} as districtcode,
    {{ json_extract_scalar(adapter.quote('location'), ['provinceCode'], ['provinceCode']) }} as provincecode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries_request_to') }} as table_alias
-- location at session-deliveries/request/to/location
where 1 = 1
and {{ adapter.quote('location') }} is not null

