{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tracking_product_shares_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('user'),
        adapter.quote('source'),
        adapter.quote('options'),
        'products',
        'createdat',
    ]) }} as _airbyte_tracking_product_shares_hashid,
    tmp.*
from {{ ref('tracking_product_shares_ab2') }} tmp
-- tracking_product_shares
where 1 = 1

