{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_useragent_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'ip',
        adapter.quote('version'),
        'platform',
    ]) }} as _airbyte_useragent_hashid,
    tmp.*
from {{ ref('orders_useragent_ab2') }} tmp
-- useragent at orders/userAgent
where 1 = 1

