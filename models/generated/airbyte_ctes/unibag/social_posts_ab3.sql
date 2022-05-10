{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('social_posts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        array_to_string('tags'),
        boolean_to_string('ispin'),
        adapter.quote('order'),
        'title',
        'author',
        array_to_string('cities'),
        array_to_string('photos'),
        'reason',
        'status',
        array_to_string('videos'),
        adapter.quote('content'),
        boolean_to_string('istimer'),
        'startat',
        array_to_string('products'),
        'createdat',
        boolean_to_string('hasupdate'),
        object_to_string('statistic'),
        'updatedat',
        array_to_string('categories'),
        boolean_to_string('fromsystem'),
        'contributor',
        'publishedat',
        'searchstring',
        'updatedcount',
        object_to_string('sharestatistic'),
        boolean_to_string('enablenotificationforcontributor'),
    ]) }} as _airbyte_social_posts_hashid,
    tmp.*
from {{ ref('social_posts_ab2') }} tmp
-- social_posts
where 1 = 1

