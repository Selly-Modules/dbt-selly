{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('social_posts') }}
select
    _airbyte_social_posts_hashid,
    {{ json_extract_scalar('sharestatistic', ['totalShare'], ['totalShare']) }} as totalshare,
    {{ json_extract_scalar('sharestatistic', ['totalShareFromSocialPost'], ['totalShareFromSocialPost']) }} as totalsharefromsocialpost,
    {{ json_extract_scalar('sharestatistic', ['totalShareFromProductDetail'], ['totalShareFromProductDetail']) }} as totalsharefromproductdetail,
    {{ json_extract_scalar('sharestatistic', ['totalUniqueShareFromSocialPost'], ['totalUniqueShareFromSocialPost']) }} as totaluniquesharefromsocialpost,
    {{ json_extract_scalar('sharestatistic', ['totalUniqueShareFromProductDetail'], ['totalUniqueShareFromProductDetail']) }} as totaluniquesharefromproductdetail,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('social_posts') }} as table_alias
-- sharestatistic at social-posts/shareStatistic
where 1 = 1
and sharestatistic is not null

