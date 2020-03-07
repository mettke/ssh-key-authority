-- This file should undo anything in `up.sql`
IF EXISTS (
    SELECT NULL 
    FROM information_schema.TABLES
    WHERE
        TABLE_SCHEMA = DATABASE() AND
        TABLE_NAME   = 'migration'
)
THEN
    DROP TABLE `migration`;
END IF
