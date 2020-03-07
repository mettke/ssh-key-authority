-- Your SQL goes here
CREATE TABLE IF NOT EXISTS `migration` (
`id` int(10) unsigned NOT NULL,
`name` text NOT NULL,
`applied` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
