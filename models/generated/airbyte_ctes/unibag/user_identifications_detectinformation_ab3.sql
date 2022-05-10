{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_identifications_detectinformation_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_user_identifications_hashid',
        adapter.quote('id'),
        'dob',
        'doe',
        'sex',
        'home',
        adapter.quote('name'),
        adapter.quote('type'),
        'idprob',
        'address',
        'dobprob',
        'doeprob',
        'sexprob',
        'typenew',
        'homeprob',
        'nameprob',
        'addressprob',
        'nationality',
        'overallscore',
        object_to_string('addressentities'),
        'nationalityprob',
    ]) }} as _airbyte_detectinformation_hashid,
    tmp.*
from {{ ref('user_identifications_detectinformation_ab2') }} tmp
-- detectinformation at user-identifications/detectInformation
where 1 = 1

