-- This file should undo anything in `up.sql`
ALTER TABLE `public_key` 
    DROP COLUMN `upload_date`;

ALTER TABLE `public_key` 
    DROP COLUMN `active`;
