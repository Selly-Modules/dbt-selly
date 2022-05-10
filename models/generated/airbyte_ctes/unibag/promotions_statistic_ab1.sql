{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('promotions') }}
select
    _airbyte_promotions_hashid,
    {{ json_extract_scalar('statistic', ['nmv'], ['nmv']) }} as nmv,
    {{ json_extract_scalar('statistic', ['userTotal'], ['userTotal']) }} as usertotal,
    {{ json_extract_scalar('statistic', ['quantityPendingTotal'], ['quantityPendingTotal']) }} as quantitypendingtotal,
    {{ json_extract_scalar('statistic', ['quantitySuccessTotal'], ['quantitySuccessTotal']) }} as quantitysuccesstotal,
    {{ json_extract_scalar('statistic', ['quantityRejectedTotal'], ['quantityRejectedTotal']) }} as quantityrejectedtotal,
    {{ json_extract_scalar('statistic', ['commissionPendingTotal'], ['commissionPendingTotal']) }} as commissionpendingtotal,
    {{ json_extract_scalar('statistic', ['commissionSuccessTotal'], ['commissionSuccessTotal']) }} as commissionsuccesstotal,
    {{ json_extract_scalar('statistic', ['commissionRejectedTotal'], ['commissionRejectedTotal']) }} as commissionrejectedtotal,
    {{ json_extract_scalar('statistic', ['quantityNotRejectedTotal'], ['quantityNotRejectedTotal']) }} as quantitynotrejectedtotal,
    {{ json_extract_scalar('statistic', ['supplierCommissionPending'], ['supplierCommissionPending']) }} as suppliercommissionpending,
    {{ json_extract_scalar('statistic', ['supplierCommissionSuccess'], ['supplierCommissionSuccess']) }} as suppliercommissionsuccess,
    {{ json_extract_scalar('statistic', ['commissionNotRejectedTotal'], ['commissionNotRejectedTotal']) }} as commissionnotrejectedtotal,
    {{ json_extract_scalar('statistic', ['supplierCommissionNotRejected'], ['supplierCommissionNotRejected']) }} as suppliercommissionnotrejected,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotions') }} as table_alias
-- statistic at promotions/statistic
where 1 = 1
and statistic is not null

