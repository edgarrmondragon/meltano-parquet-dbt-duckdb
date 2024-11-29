# Meltano, Apache Parquet, dbt and duckdb

## Instructions

### Prerequisites

- [uv](https://docs.astral.sh/uv/getting-started/installation/)

### Steps

1. Clone this repository and `cd` into it
2. Run `uv tool install --python python3.13 --with-requirements=requirements.txt meltano`
2. Run `meltano install`
3. Run `meltano run --full-refresh tap-fedidb target-parquet`
4. Run `meltano run dbt-duckdb:build`
5. Confirm the data is loaded by running `duckdb -markdown output/warehouse.duckdb -c "table accounts limit 10"`:

    |   username   |           domain            | followers_count |
    |--------------|-----------------------------|----------------:|
    | Mastodon     | mastodon.social             | 822815          |
    | georgetakei  | universeodon.com            | 430871          |
    | Gargron      | mastodon.social             | 354368          |
    | rbreich      | masto.ai                    | 276880          |
    | neilhimself  | mastodon.social             | 267148          |
    | FediTips     | social.growyourown.services | 222148          |
    | janboehm     | edi.social                  | 192805          |
    | taylorlorenz | mastodon.social             | 185200          |
    | arstechnica  | mastodon.social             | 170302          |
    | stux         | mstdn.social                | 141953          |

6. You can also confirm the compiled query with `meltano invoke dbt-duckdb compile --select "accounts"`:

    ```sql
    with accounts as (
    select
        username,
        domain,
        followers_count
    from '/path/to/project/output/popular_accounts/popular_accounts-*.gz.parquet'
    where followers_count > 1000
    order by followers_count desc
    )
    ```
