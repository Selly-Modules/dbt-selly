{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('promotions_statistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_promotions_hashid',
        'nmv',
        'usertotal',
        'quantitypendingtotal',
        'quantitysuccesstotal',
        'quantityrejectedtotal',
        'commissionpendingtotal',
        'commissionsuccesstotal',
        'commissionrejectedtotal',
        'quantitynotrejectedtotal',
        'suppliercommissionpending',
        'suppliercommissionsuccess',
        'commissionnotrejectedtotal',
        'suppliercommissionnotrejected',
    ]) }} as _airbyte_statistic_hashid,
    tmp.*
from {{ ref('promotions_statistic_ab2') }} tmp
-- statistic at promotions/statistic
where 1 = 1

