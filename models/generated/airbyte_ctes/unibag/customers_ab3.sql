{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'info',
        adapter.quote('name'),
        adapter.quote('user'),
        'email',
        'phone',
        adapter.quote('source'),
        array_to_string(adapter.quote('location')),
        'createdat',
        boolean_to_string('isdeleted'),
        'statistic',
        'updatedat',
        'searchstring',
    ]) }} as _airbyte_customers_hashid,
    tmp.*
from {{ ref('customers_ab2') }} tmp
-- customers
where 1 = 1

