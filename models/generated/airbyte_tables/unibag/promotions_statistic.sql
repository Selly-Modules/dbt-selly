{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotions_statistic_ab3') }}
select
    _airbyte_promotions_hashid,
    nmv,
    usertotal,
    quantitypendingtotal,
    quantitysuccesstotal,
    quantityrejectedtotal,
    commissionpendingtotal,
    commissionsuccesstotal,
    commissionrejectedtotal,
    quantitynotrejectedtotal,
    suppliercommissionpending,
    suppliercommissionsuccess,
    commissionnotrejectedtotal,
    suppliercommissionnotrejected,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_statistic_hashid
from {{ ref('promotions_statistic_ab3') }}
-- statistic at promotions/statistic from {{ ref('promotions') }}
where 1 = 1

