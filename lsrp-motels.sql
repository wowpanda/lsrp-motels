INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('motels_bed_black_money', 'Motels Black Money Bed', 0),
('motels_black_money', 'Motels Black Money ', 0);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('motels', 'Motels Inventory', 0),
('motels_bed', 'Motels Bed Inventory', 0);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('motels', 'Motels Datastore', 0),
('motels_bed', 'Motels Bed Datastore', 0);

CREATE TABLE `lsrp_motels` (
  `id` bigint(255) NOT NULL,
  `ident` varchar(50) NOT NULL,
  `motel_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `lsrp_motels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `motel_id` (`motel_id`),
  ADD KEY `ident` (`ident`);
  
ALTER TABLE `lsrp_motels` MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE users ADD last_motel VARCHAR(50) NULL, ADD last_motel_room VARCHAR(50) NULL;