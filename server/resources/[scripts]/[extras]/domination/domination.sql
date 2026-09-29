CREATE TABLE `dominations` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`faction` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`coords` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`sprayObj` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`color` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`createdAt` DATETIME NULL DEFAULT current_timestamp(),
	`active` BIT(1) NULL DEFAULT b'1',
	`endedAt` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=21
;

CREATE TABLE `dominations_disputes` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`territoryId` INT(11) NOT NULL,
	`attacker` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`defender` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_general_ci',
	`startedAt` DATETIME NOT NULL DEFAULT current_timestamp(),
	`winner` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`reason` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`finishedAt` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=56
;