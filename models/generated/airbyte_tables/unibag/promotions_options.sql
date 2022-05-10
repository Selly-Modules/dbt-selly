{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotions_options_ab3') }}
select
    _airbyte_promotions_hashid,
    bonus,
    milestones,
    suppliermilestones,
    transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_options_hashid
from {{ ref('promotions_options_ab3') }}
-- options at promotions/options from {{ ref('promotions') }}
where 1 = 1

