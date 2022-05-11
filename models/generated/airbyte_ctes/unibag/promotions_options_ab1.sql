{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('promotions') }}
select
    _airbyte_promotions_hashid,
    {{ json_extract('table_alias', adapter.quote('options'), ['bonus'], ['bonus']) }} as bonus,
    {{ json_extract_array(adapter.quote('options'), ['milestones'], ['milestones']) }} as milestones,
    {{ json_extract_array(adapter.quote('options'), ['supplierMilestones'], ['supplierMilestones']) }} as suppliermilestones,
    {{ json_extract_scalar(adapter.quote('options'), ['transactionMinValue'], ['transactionMinValue']) }} as transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotions') }} as table_alias
-- options at promotions/options
where 1 = 1
and {{ adapter.quote('options') }} is not null
