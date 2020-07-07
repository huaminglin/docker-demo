# Demo PostgreSQL Lock

## select for update

sudo docker exec postgres-lock-demo_client_1 bash -c /sql/select_for_update.sh

Conclusion:

"SELECT FOR UPDATE" doesn't block normal select

"SELECT FOR UPDATE" doesn't block "SELECT FOR UPDATE" on different row

"SELECT FOR UPDATE" does block "SELECT FOR UPDATE" on the same row

```update sql
The FOR UPDATE lock mode is also acquired by any DELETE on a row, and also by an UPDATE that modifies the values on certain columns.
Currently, the set of columns considered for the UPDATE case are those that have a unique index on them that can be used in a foreign key (so partial indexes and expressional indexes are not considered),
but this may change in the future.
```

The above document mention update on columns which have a unique index on them.

But from the demo, the update without unique index is blocked too.

In seems "for update lock" is required no matter what kind of a column is updated.

## select for and options

sudo docker exec postgres-lock-demo_client_1 bash -c /sql/select_for_option.sh

select for update NOWAIT

SET lock_timeout TO 1000

select for update skip locked

## FK CASCADE needs additional locks on related table

sudo docker exec postgres-lock-demo_client_1 bash -c /sql/select_for_fk.sh

If "ON UPDATE CASCADE ON DELETE CASCADE" is enabled for column definition: "currency_id int REFERENCES t_currency (id)", 
these two kinds of operations(delete the currency or change currency to use a different id) will need to update t_account.

"update t_currency set id=3 where id = 1" will tirgger "update t_account set currency_id=3 where currency_id=1".

"delete t_currency where id = 1" will tirgger "delete t_account where currency_id=1".

So when the row in t_account is locked, the update on t_currency might be blocked.

If "ON UPDATE CASCADE ON DELETE CASCADE" is disabled for column definition, update on t_currency will never need a lock on t_account.
