-- Your SQL goes here
UPDATE `public_key` SET `fingerprint_sha256` = null where `fingerprint_sha256` IN (
    SELECT `fingerprint_sha256` FROM `public_key` GROUP BY `fingerprint_sha256` HAVING COUNT(*) > 1
);

IF NOT EXISTS (
    SELECT NULL 
    FROM information_schema.TABLE_CONSTRAINTS
    WHERE
        CONSTRAINT_SCHEMA = DATABASE() AND
        CONSTRAINT_NAME   = 'public_key_fingerprint' AND
        CONSTRAINT_TYPE   = 'UNIQUE'
)
THEN
    ALTER TABLE `public_key` 
        ADD CONSTRAINT `public_key_fingerprint` UNIQUE (`fingerprint_sha256`);
END IF;

IF NOT EXISTS (
    SELECT NULL 
    FROM information_schema.COLUMNS
    WHERE
        TABLE_SCHEMA = DATABASE() AND
        TABLE_NAME   = 'public_key' AND
        COLUMN_NAME   = 'upload_date'
)
THEN
    ALTER TABLE `public_key` 
        ADD COLUMN `upload_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
END IF;

IF NOT EXISTS (
    SELECT NULL 
    FROM information_schema.COLUMNS
    WHERE
        TABLE_SCHEMA = DATABASE() AND
        TABLE_NAME   = 'public_key' AND
        COLUMN_NAME   = 'active'
)
THEN
    ALTER TABLE `public_key` 
        ADD COLUMN `active` BOOLEAN NOT NULL DEFAULT TRUE;
END IF;
