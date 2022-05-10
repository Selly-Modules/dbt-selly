{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('social_posts_sharestatistic_ab1') }}
select
    _airbyte_social_posts_hashid,
    cast(totalshare as {{ dbt_utils.type_float() }}) as totalshare,
    cast(totalsharefromsocialpost as {{ dbt_utils.type_float() }}) as totalsharefromsocialpost,
    cast(totalsharefromproductdetail as {{ dbt_utils.type_float() }}) as totalsharefromproductdetail,
    cast(totaluniquesharefromsocialpost as {{ dbt_utils.type_float() }}) as totaluniquesharefromsocialpost,
    cast(totaluniquesharefromproductdetail as {{ dbt_utils.type_float() }}) as totaluniquesharefromproductdetail,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('social_posts_sharestatistic_ab1') }}
-- sharestatistic at social-posts/shareStatistic
where 1 = 1

