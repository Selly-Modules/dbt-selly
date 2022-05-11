{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('membership_orders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('user'),
        'status',
        adapter.quote('percent'),
        'targetid',
        'createdat',
        'updatedat',
        'commission',
        boolean_to_string('isrejected'),
        'membershipname',
        'membershiplevel',
        'membershippromotion'
    ]) }} as _airbyte_membership_orders_hashid,
    tmp.*
from {{ ref('membership_orders_ab2') }} tmp
-- membership_orders
where 1 = 1

