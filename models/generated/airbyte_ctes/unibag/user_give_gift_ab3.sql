{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_give_gift_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'gift',
        adapter.quote('user'),
        'title',
        'givegift',
        'createdat',
        'updatedat',
        boolean_to_string('iscompleted'),
        'notificationcontent',
    ]) }} as _airbyte_user_give_gift_hashid,
    tmp.*
from {{ ref('user_give_gift_ab2') }} tmp
-- user_give_gift
where 1 = 1

