-- Your SQL goes here
IF NOT EXISTS (
    SELECT NULL 
    FROM information_schema.COLUMNS
    WHERE
        TABLE_SCHEMA = DATABASE() AND
        TABLE_NAME   = 'server' AND
        COLUMN_NAME   = 'port'
)
THEN
    ALTER TABLE `server` 
        ADD COLUMN `port` int(10) unsigned NOT NULL DEFAULT 22;
END IF
