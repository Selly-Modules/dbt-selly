{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('promotions') }}
select
    _airbyte_promotions_hashid,
    {{ json_extract_scalar('conditionforuser', ['gender'], ['gender']) }} as gender,
    {{ json_extract_scalar('conditionforuser', ['applyFor'], ['applyFor']) }} as applyfor,
    {{ json_extract_array('conditionforuser', ['segments'], ['segments']) }} as segments,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotions') }} as table_alias
-- conditionforuser at promotions/conditionForUser
where 1 = 1
and conditionforuser is not null

