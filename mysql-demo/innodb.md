## InnoDB configuration items
show variables like 'innodb_data_file_path';
+-----------------------+------------------------+
| Variable_name         | Value                  |
+-----------------------+------------------------+
| innodb_data_file_path | ibdata1:12M:autoextend |
+-----------------------+------------------------+
1 row in set (0.00 sec)


show variables like 'innodb_file_per_table';
+-----------------------+-------+
| Variable_name         | Value |
+-----------------------+-------+
| innodb_file_per_table | ON    |
+-----------------------+-------+
1 row in set (0.00 sec)



show variables like '%innodb%';
+------------------------------------------+------------------------+
| Variable_name                            | Value                  |
+------------------------------------------+------------------------+
| innodb_adaptive_flushing                 | ON                     |
| innodb_adaptive_flushing_lwm             | 10                     |
| innodb_adaptive_hash_index               | ON                     |
| innodb_adaptive_hash_index_parts         | 8                      |
| innodb_adaptive_max_sleep_delay          | 150000                 |
| innodb_api_bk_commit_interval            | 5                      |
| innodb_api_disable_rowlock               | OFF                    |
| innodb_api_enable_binlog                 | OFF                    |
| innodb_api_enable_mdl                    | OFF                    |
| innodb_api_trx_level                     | 0                      |
| innodb_autoextend_increment              | 64                     |
| innodb_autoinc_lock_mode                 | 2                      |
| innodb_buffer_pool_chunk_size            | 134217728              |
| innodb_buffer_pool_dump_at_shutdown      | ON                     |
| innodb_buffer_pool_dump_now              | OFF                    |
| innodb_buffer_pool_dump_pct              | 25                     |
| innodb_buffer_pool_filename              | ib_buffer_pool         |
| innodb_buffer_pool_instances             | 1                      |
| innodb_buffer_pool_load_abort            | OFF                    |
| innodb_buffer_pool_load_at_startup       | ON                     |
| innodb_buffer_pool_load_now              | OFF                    |
| innodb_buffer_pool_size                  | 134217728              |
| innodb_change_buffer_max_size            | 25                     |
| innodb_change_buffering                  | all                    |
| innodb_checksum_algorithm                | crc32                  |
| innodb_cmp_per_index_enabled             | OFF                    |
| innodb_commit_concurrency                | 0                      |
| innodb_compression_failure_threshold_pct | 5                      |
| innodb_compression_level                 | 6                      |
| innodb_compression_pad_pct_max           | 50                     |
| innodb_concurrency_tickets               | 5000                   |
| innodb_data_file_path                    | ibdata1:12M:autoextend |
| innodb_data_home_dir                     |                        |
| innodb_deadlock_detect                   | ON                     |
| innodb_dedicated_server                  | OFF                    |
| innodb_default_row_format                | dynamic                |
| innodb_directories                       |                        |
| innodb_disable_sort_file_cache           | OFF                    |
| innodb_doublewrite                       | ON                     |
| innodb_fast_shutdown                     | 1                      |
| innodb_file_per_table                    | ON                     |
| innodb_fill_factor                       | 100                    |
| innodb_flush_log_at_timeout              | 1                      |
| innodb_flush_log_at_trx_commit           | 1                      |
| innodb_flush_method                      | fsync                  |
| innodb_flush_neighbors                   | 0                      |
| innodb_flush_sync                        | ON                     |
| innodb_flushing_avg_loops                | 30                     |
| innodb_force_load_corrupted              | OFF                    |
| innodb_force_recovery                    | 0                      |
| innodb_fsync_threshold                   | 0                      |
| innodb_ft_aux_table                      |                        |
| innodb_ft_cache_size                     | 8000000                |
| innodb_ft_enable_diag_print              | OFF                    |
| innodb_ft_enable_stopword                | ON                     |
| innodb_ft_max_token_size                 | 84                     |
| innodb_ft_min_token_size                 | 3                      |
| innodb_ft_num_word_optimize              | 2000                   |
| innodb_ft_result_cache_limit             | 2000000000             |
| innodb_ft_server_stopword_table          |                        |
| innodb_ft_sort_pll_degree                | 2                      |
| innodb_ft_total_cache_size               | 640000000              |
| innodb_ft_user_stopword_table            |                        |
| innodb_io_capacity                       | 200                    |
| innodb_io_capacity_max                   | 2000                   |
| innodb_lock_wait_timeout                 | 50                     |
| innodb_log_buffer_size                   | 16777216               |
| innodb_log_checksums                     | ON                     |
| innodb_log_compressed_pages              | ON                     |
| innodb_log_file_size                     | 50331648               |
| innodb_log_files_in_group                | 2                      |
| innodb_log_group_home_dir                | ./                     |
| innodb_log_spin_cpu_abs_lwm              | 80                     |
| innodb_log_spin_cpu_pct_hwm              | 50                     |
| innodb_log_wait_for_flush_spin_hwm       | 400                    |
| innodb_log_write_ahead_size              | 8192                   |
| innodb_lru_scan_depth                    | 1024                   |
| innodb_max_dirty_pages_pct               | 90.000000              |
| innodb_max_dirty_pages_pct_lwm           | 10.000000              |
| innodb_max_purge_lag                     | 0                      |
| innodb_max_purge_lag_delay               | 0                      |
| innodb_max_undo_log_size                 | 1073741824             |
| innodb_monitor_disable                   |                        |
| innodb_monitor_enable                    |                        |
| innodb_monitor_reset                     |                        |
| innodb_monitor_reset_all                 |                        |
| innodb_old_blocks_pct                    | 37                     |
| innodb_old_blocks_time                   | 1000                   |
| innodb_online_alter_log_max_size         | 134217728              |
| innodb_open_files                        | 4000                   |
| innodb_optimize_fulltext_only            | OFF                    |
| innodb_page_cleaners                     | 1                      |
| innodb_page_size                         | 16384                  |
| innodb_print_all_deadlocks               | OFF                    |
| innodb_print_ddl_logs                    | OFF                    |
| innodb_purge_batch_size                  | 300                    |
| innodb_purge_rseg_truncate_frequency     | 128                    |
| innodb_purge_threads                     | 4                      |
| innodb_random_read_ahead                 | OFF                    |
| innodb_read_ahead_threshold              | 56                     |
| innodb_read_io_threads                   | 4                      |
| innodb_read_only                         | OFF                    |
| innodb_redo_log_encrypt                  | OFF                    |
| innodb_replication_delay                 | 0                      |
| innodb_rollback_on_timeout               | OFF                    |
| innodb_rollback_segments                 | 128                    |
| innodb_sort_buffer_size                  | 1048576                |
| innodb_spin_wait_delay                   | 6                      |
| innodb_stats_auto_recalc                 | ON                     |
| innodb_stats_include_delete_marked       | OFF                    |
| innodb_stats_method                      | nulls_equal            |
| innodb_stats_on_metadata                 | OFF                    |
| innodb_stats_persistent                  | ON                     |
| innodb_stats_persistent_sample_pages     | 20                     |
| innodb_stats_transient_sample_pages      | 8                      |
| innodb_status_output                     | OFF                    |
| innodb_status_output_locks               | OFF                    |
| innodb_strict_mode                       | ON                     |
| innodb_sync_array_size                   | 1                      |
| innodb_sync_spin_loops                   | 30                     |
| innodb_table_locks                       | ON                     |
| innodb_temp_data_file_path               | ibtmp1:12M:autoextend  |
| innodb_temp_tablespaces_dir              | ./#innodb_temp/        |
| innodb_thread_concurrency                | 0                      |
| innodb_thread_sleep_delay                | 10000                  |
| innodb_tmpdir                            |                        |
| innodb_undo_directory                    | ./                     |
| innodb_undo_log_encrypt                  | OFF                    |
| innodb_undo_log_truncate                 | ON                     |
| innodb_undo_tablespaces                  | 2                      |
| innodb_use_native_aio                    | ON                     |
| innodb_version                           | 8.0.13                 |
| innodb_write_io_threads                  | 4                      |
+------------------------------------------+------------------------+

## InnoDB tablespace
find / -iname "*.ibd"
/var/lib/mysql/mysql.ibd
/var/lib/mysql/mysql/t2.ibd
/var/lib/mysql/sys/sys_config.ibd
