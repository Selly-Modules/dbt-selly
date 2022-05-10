{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotions_options_bonus_ab3') }}
select
    _airbyte_options_hashid,
    {{ adapter.quote('type') }},
    {{ adapter.quote('value') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_bonus_hashid
from {{ ref('promotions_options_bonus_ab3') }}
-- bonus at promotions/options/bonus from {{ ref('promotions_options') }}
where 1 = 1

