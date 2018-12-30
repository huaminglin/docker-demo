
## Demo general log for MySQL
my-log.cnf:
log-error=/var/log/mysqld.log
general_log=on
general_log_file=/var/log/mysql.general.log

docker-compose exec server find / -iname "*.log"
/var/log/yum.log
/var/log/mysqld.log
/usr/lib/rpm/rpm.log

docker-compose exec server cat /var/log/mysqld.log
2018-12-26T07:52:08.909003Z 0 [ERROR] [MY-011263] [Server] Could not use /var/log/mysql.general.log for logging (error 13 - Permission denied). Turning logging off for the server process. To turn it on again: fix the cause, then either restart the query logging by using "SET GLOBAL GENERAL_LOG=ON" or restart the MySQL server.
Conclusion: /var/log/mysql.general.log must be an existing file.

## Query mysql log configuration
docker-compose exec server mysql -pdemo mysql -e "show variables like \"%log%\""
mysql: [Warning] Using a password on the command line interface can be insecure.
+--------------------------------------------+---------------------------------------------+
| Variable_name                              | Value                                       |
+--------------------------------------------+---------------------------------------------+
| activate_all_roles_on_login                | OFF                                         |
| back_log                                   | 151                                         |
| binlog_cache_size                          | 32768                                       |
| binlog_checksum                            | CRC32                                       |
| binlog_direct_non_transactional_updates    | OFF                                         |
| binlog_error_action                        | ABORT_SERVER                                |
| binlog_expire_logs_seconds                 | 2592000                                     |
| binlog_format                              | ROW                                         |
| binlog_group_commit_sync_delay             | 0                                           |
| binlog_group_commit_sync_no_delay_count    | 0                                           |
| binlog_gtid_simple_recovery                | ON                                          |
| binlog_max_flush_queue_time                | 0                                           |
| binlog_order_commits                       | ON                                          |
| binlog_row_image                           | FULL                                        |
| binlog_row_metadata                        | MINIMAL                                     |
| binlog_row_value_options                   |                                             |
| binlog_rows_query_log_events               | OFF                                         |
| binlog_stmt_cache_size                     | 32768                                       |
| binlog_transaction_dependency_history_size | 25000                                       |
| binlog_transaction_dependency_tracking     | COMMIT_ORDER                                |
| expire_logs_days                           | 0                                           |
| general_log                                | OFF                                         |
| general_log_file                           | /var/log/mysql.general.log                  |
| innodb_api_enable_binlog                   | OFF                                         |
| innodb_flush_log_at_timeout                | 1                                           |
| innodb_flush_log_at_trx_commit             | 1                                           |
| innodb_log_buffer_size                     | 16777216                                    |
| innodb_log_checksums                       | ON                                          |
| innodb_log_compressed_pages                | ON                                          |
| innodb_log_file_size                       | 50331648                                    |
| innodb_log_files_in_group                  | 2                                           |
| innodb_log_group_home_dir                  | ./                                          |
| innodb_log_spin_cpu_abs_lwm                | 80                                          |
| innodb_log_spin_cpu_pct_hwm                | 50                                          |
| innodb_log_wait_for_flush_spin_hwm         | 400                                         |
| innodb_log_write_ahead_size                | 8192                                        |
| innodb_max_undo_log_size                   | 1073741824                                  |
| innodb_online_alter_log_max_size           | 134217728                                   |
| innodb_print_ddl_logs                      | OFF                                         |
| innodb_redo_log_encrypt                    | OFF                                         |
| innodb_undo_log_encrypt                    | OFF                                         |
| innodb_undo_log_truncate                   | ON                                          |
| log_bin                                    | ON                                          |
| log_bin_basename                           | /var/lib/mysql/binlog                       |
| log_bin_index                              | /var/lib/mysql/binlog.index                 |
| log_bin_trust_function_creators            | OFF                                         |
| log_bin_use_v1_row_events                  | OFF                                         |
| log_error                                  | /var/log/mysqld.log                         |
| log_error_services                         | log_filter_internal; log_sink_internal      |
| log_error_suppression_list                 |                                             |
| log_error_verbosity                        | 2                                           |
| log_output                                 | FILE                                        |
| log_queries_not_using_indexes              | OFF                                         |
| log_slave_updates                          | ON                                          |
| log_slow_admin_statements                  | OFF                                         |
| log_slow_slave_statements                  | OFF                                         |
| log_statements_unsafe_for_binlog           | ON                                          |
| log_throttle_queries_not_using_indexes     | 0                                           |
| log_timestamps                             | UTC                                         |
| max_binlog_cache_size                      | 18446744073709547520                        |
| max_binlog_size                            | 1073741824                                  |
| max_binlog_stmt_cache_size                 | 18446744073709547520                        |
| max_relay_log_size                         | 0                                           |
| relay_log                                  | 752be2af3665-relay-bin                      |
| relay_log_basename                         | /var/lib/mysql/752be2af3665-relay-bin       |
| relay_log_index                            | /var/lib/mysql/752be2af3665-relay-bin.index |
| relay_log_info_file                        | relay-log.info                              |
| relay_log_info_repository                  | TABLE                                       |
| relay_log_purge                            | ON                                          |
| relay_log_recovery                         | OFF                                         |
| relay_log_space_limit                      | 0                                           |
| slow_query_log                             | OFF                                         |
| slow_query_log_file                        | /var/lib/mysql/752be2af3665-slow.log        |
| sql_log_bin                                | ON                                          |
| sql_log_off                                | OFF                                         |
| sync_binlog                                | 1                                           |
| sync_relay_log                             | 10000                                       |
| sync_relay_log_info                        | 10000                                       |
+--------------------------------------------+---------------------------------------------+

## docker-compose exec server tail -f /var/log/mysql.general.log
2018-12-26T09:10:09.488565Z	   11 Query	show variables like "%general%"
2018-12-26T09:10:09.492109Z	   11 Quit	
2018-12-26T09:10:12.818395Z	   12 Connect	healthchecker@localhost on  using Socket
2018-12-26T09:10:12.819086Z	   12 Quit	
