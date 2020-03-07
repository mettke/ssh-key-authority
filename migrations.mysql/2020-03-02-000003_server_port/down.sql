-- This file should undo anything in `up.sql`
ALTER TABLE `server` 
    DROP COLUMN `port`;
