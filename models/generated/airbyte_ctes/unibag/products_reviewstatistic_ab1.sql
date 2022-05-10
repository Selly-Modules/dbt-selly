{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('products') }}
select
    _airbyte_products_hashid,
    {{ json_extract_scalar('reviewstatistic', ['total'], ['total']) }} as total,
    {{ json_extract_scalar('reviewstatistic', ['totalReview'], ['totalReview']) }} as totalreview,
    {{ json_extract_scalar('reviewstatistic', ['totalScore1'], ['totalScore1']) }} as totalscore1,
    {{ json_extract_scalar('reviewstatistic', ['totalScore2'], ['totalScore2']) }} as totalscore2,
    {{ json_extract_scalar('reviewstatistic', ['totalScore3'], ['totalScore3']) }} as totalscore3,
    {{ json_extract_scalar('reviewstatistic', ['totalScore4'], ['totalScore4']) }} as totalscore4,
    {{ json_extract_scalar('reviewstatistic', ['totalScore5'], ['totalScore5']) }} as totalscore5,
    {{ json_extract_scalar('reviewstatistic', ['scoreAverage'], ['scoreAverage']) }} as scoreaverage,
    {{ json_extract_scalar('reviewstatistic', ['totalHasMedia'], ['totalHasMedia']) }} as totalhasmedia,
    {{ json_extract_scalar('reviewstatistic', ['totalHasContent'], ['totalHasContent']) }} as totalhascontent,
    {{ json_extract_scalar('reviewstatistic', ['scoreAverageWeekTotal'], ['scoreAverageWeekTotal']) }} as scoreaverageweektotal,
    {{ json_extract_scalar('reviewstatistic', ['scoreAverageYearTotal'], ['scoreAverageYearTotal']) }} as scoreaverageyeartotal,
    {{ json_extract_scalar('reviewstatistic', ['scoreAverageMonthTotal'], ['scoreAverageMonthTotal']) }} as scoreaveragemonthtotal,
    {{ json_extract_scalar('reviewstatistic', ['scoreAverageTwoMonthTotal'], ['scoreAverageTwoMonthTotal']) }} as scoreaveragetwomonthtotal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products') }} as table_alias
-- reviewstatistic at products/reviewStatistic
where 1 = 1
and reviewstatistic is not null

