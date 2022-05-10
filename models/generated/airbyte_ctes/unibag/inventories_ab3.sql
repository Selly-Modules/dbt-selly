{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('inventories_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'code',
        adapter.quote('name'),
        'slug',
        boolean_to_string('active'),
        object_to_string('contact'),
        object_to_string('partner'),
        'checksum',
        object_to_string(adapter.quote('location')),
        object_to_string('supplier'),
        'createdat',
        'updatedat',
        'minimumvalue',
        'searchstring',
        object_to_string('paymentmethods'),
        boolean_to_string('canissueinvoice'),
        array_to_string('deliverymethods'),
        boolean_to_string('canautosendemail'),
        'invoicedeliverymethod',
        boolean_to_string('doessupportsellyexpress'),
        array_to_string('prioritydeliveryservicecodes'),
    ]) }} as _airbyte_inventories_hashid,
    tmp.*
from {{ ref('inventories_ab2') }} tmp
-- inventories
where 1 = 1

