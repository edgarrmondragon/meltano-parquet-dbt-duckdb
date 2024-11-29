with accounts as (
    select
        username,
        domain,
        followers_count
    from {{ source('fedidb', 'popular_accounts') }}
    where followers_count > 1000
    order by followers_count desc
)

select * from accounts
