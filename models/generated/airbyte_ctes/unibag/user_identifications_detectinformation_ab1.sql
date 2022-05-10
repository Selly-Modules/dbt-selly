{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('user_identifications') }}
select
    _airbyte_user_identifications_hashid,
    {{ json_extract_scalar('detectinformation', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('detectinformation', ['dob'], ['dob']) }} as dob,
    {{ json_extract_scalar('detectinformation', ['doe'], ['doe']) }} as doe,
    {{ json_extract_scalar('detectinformation', ['sex'], ['sex']) }} as sex,
    {{ json_extract_scalar('detectinformation', ['home'], ['home']) }} as home,
    {{ json_extract_scalar('detectinformation', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('detectinformation', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('detectinformation', ['idProb'], ['idProb']) }} as idprob,
    {{ json_extract_scalar('detectinformation', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('detectinformation', ['dobProb'], ['dobProb']) }} as dobprob,
    {{ json_extract_scalar('detectinformation', ['doeProb'], ['doeProb']) }} as doeprob,
    {{ json_extract_scalar('detectinformation', ['sexProb'], ['sexProb']) }} as sexprob,
    {{ json_extract_scalar('detectinformation', ['typeNew'], ['typeNew']) }} as typenew,
    {{ json_extract_scalar('detectinformation', ['homeProb'], ['homeProb']) }} as homeprob,
    {{ json_extract_scalar('detectinformation', ['nameProb'], ['nameProb']) }} as nameprob,
    {{ json_extract_scalar('detectinformation', ['addressProb'], ['addressProb']) }} as addressprob,
    {{ json_extract_scalar('detectinformation', ['nationality'], ['nationality']) }} as nationality,
    {{ json_extract_scalar('detectinformation', ['overallScore'], ['overallScore']) }} as overallscore,
    {{ json_extract('table_alias', 'detectinformation', ['addressEntities'], ['addressEntities']) }} as addressentities,
    {{ json_extract_scalar('detectinformation', ['nationalityProb'], ['nationalityProb']) }} as nationalityprob,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_identifications') }} as table_alias
-- detectinformation at user-identifications/detectInformation
where 1 = 1
and detectinformation is not null

