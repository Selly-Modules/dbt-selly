{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('suppliers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'tax',
        object_to_string('bank'),
        object_to_string('logo'),
        adapter.quote('name'),
        boolean_to_string('active'),
        object_to_string('balance'),
        'checksum',
        'checksum_1',
        object_to_string(adapter.quote('location')),
        array_to_string('contracts'),
        'createdat',
        array_to_string('documents'),
        object_to_string('statistic'),
        'updatedat',
        array_to_string('categories'),
        array_to_string('inventories'),
        'identifycode',
        'searchstring',
        array_to_string('reconciledays'),
        'contractnumber',
        object_to_string('reviewstatistic'),
        'contractsignedat',
        array_to_string('emailforinvoices'),
        'contractexpiredat',
        boolean_to_string('sendinvoicerequesteveryday'),
    ]) }} as _airbyte_suppliers_hashid,
    tmp.*
from {{ ref('suppliers_ab2') }} tmp
-- suppliers
where 1 = 1

