{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_info_supplier_ab3') }}
select
    _airbyte_info_hashid,
    {{ adapter.quote('id') }},
    _id,
    {{ adapter.quote('name') }},
    searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_supplier_hashid
from {{ ref('products_info_supplier_ab3') }}
-- supplier at products/info/supplier from {{ ref('products_info') }}
where 1 = 1

