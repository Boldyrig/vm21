-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 17 2019 г., 05:39
-- Версия сервера: 10.3.13-MariaDB
-- Версия PHP: 7.0.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `vmech`
--

-- --------------------------------------------------------

--
-- Структура таблицы `battle`
--

CREATE TABLE `battle` (
  `id` int(11) NOT NULL,
  `timeStamp` bigint(11) DEFAULT NULL,
  `defaultMoney` int(11) NOT NULL,
  `fieldX` int(11) NOT NULL,
  `fieldY` int(11) NOT NULL,
  `moneyTank` int(11) NOT NULL,
  `moneyBase` int(11) NOT NULL,
  `healthBase` int(11) NOT NULL,
  `updateTime` int(11) NOT NULL COMMENT 'сколько должно пройти времени до обновления сцены'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `battle`
--

INSERT INTO `battle` (`id`, `timeStamp`, `defaultMoney`, `fieldX`, `fieldY`, `moneyTank`, `moneyBase`, `healthBase`, `updateTime`) VALUES
(1, 1576549993275, 1200, 40, 20, 150, 10000, 1000, 10);

-- --------------------------------------------------------

--
-- Структура таблицы `booms`
--

CREATE TABLE `booms` (
  `id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `timeLife` int(11) NOT NULL,
  `type` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `building`
--

CREATE TABLE `building` (
  `id` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `x` int(11) NOT NULL DEFAULT 0,
  `y` int(11) NOT NULL DEFAULT 0,
  `hp` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `type` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `building`
--

INSERT INTO `building` (`id`, `team`, `x`, `y`, `hp`, `width`, `height`, `type`) VALUES
(134, 1, 14, 16, 720, 2, 2, 'base'),
(135, 2, 24, 2, 788, 2, 2, 'base');

-- --------------------------------------------------------

--
-- Структура таблицы `bullets`
--

CREATE TABLE `bullets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `direction` varchar(11) NOT NULL,
  `type` int(11) NOT NULL,
  `rangeBullet` int(11) NOT NULL,
  `moveTimeStamp` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `field`
--

CREATE TABLE `field` (
  `id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `hp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `field`
--

INSERT INTO `field` (`id`, `x`, `y`, `hp`) VALUES
(7906, 0, 0, 100),
(7907, 0, 1, 100),
(7908, 0, 3, 100),
(7909, 0, 6, 100),
(7910, 0, 7, 100),
(7911, 0, 9, 100),
(7912, 0, 15, 100),
(7913, 0, 18, 100),
(7914, 0, 19, 100),
(7915, 1, 2, 100),
(7916, 1, 4, 100),
(7917, 1, 7, 100),
(7918, 1, 9, 100),
(7919, 1, 13, 100),
(7920, 1, 14, 100),
(7921, 2, 0, 100),
(7922, 2, 2, 100),
(7923, 2, 3, 100),
(7924, 2, 5, 100),
(7925, 2, 8, 100),
(7926, 2, 9, 100),
(7927, 2, 11, 100),
(7928, 2, 14, 100),
(7929, 2, 19, 100),
(7930, 3, 2, 100),
(7931, 3, 6, 100),
(7932, 3, 7, 100),
(7933, 3, 8, 100),
(7934, 3, 11, 100),
(7935, 3, 12, 100),
(7936, 3, 16, 100),
(7937, 3, 18, 100),
(7938, 3, 19, 100),
(7939, 4, 0, 100),
(7940, 4, 4, 100),
(7941, 4, 7, 100),
(7942, 4, 11, 100),
(7943, 4, 12, 100),
(7944, 4, 13, 100),
(7945, 4, 17, 100),
(7946, 4, 19, 100),
(7947, 5, 1, 100),
(7948, 5, 6, 100),
(7949, 5, 7, 100),
(7950, 5, 10, 100),
(7951, 5, 14, 100),
(7952, 5, 15, 100),
(7953, 6, 2, 100),
(7954, 6, 7, 100),
(7955, 6, 12, 100),
(7956, 6, 14, 100),
(7957, 6, 17, 100),
(7958, 6, 18, 100),
(7959, 7, 1, 100),
(7963, 7, 7, 100),
(7964, 7, 11, 100),
(7965, 7, 13, 100),
(7966, 7, 17, 100),
(7967, 7, 19, 100),
(7968, 8, 0, 100),
(7969, 8, 1, 100),
(7974, 8, 8, 100),
(7975, 8, 10, 100),
(7976, 8, 11, 100),
(7977, 8, 12, 100),
(7978, 8, 13, 100),
(7979, 9, 0, 100),
(7982, 9, 8, 100),
(7983, 9, 9, 100),
(7984, 9, 10, 100),
(7985, 9, 14, 100),
(7986, 9, 18, 100),
(7987, 10, 0, 100),
(7992, 10, 10, 100),
(7993, 10, 12, 100),
(7994, 10, 17, 100),
(7995, 11, 0, 100),
(7999, 11, 7, 100),
(8000, 11, 13, 100),
(8001, 11, 14, 100),
(8002, 11, 16, 100),
(8003, 11, 18, 100),
(8004, 11, 19, 100),
(8005, 12, 1, 100),
(8006, 12, 2, 100),
(8008, 12, 7, 100),
(8009, 12, 10, 100),
(8010, 12, 12, 100),
(8011, 12, 13, 100),
(8012, 12, 14, 100),
(8014, 12, 18, 100),
(8015, 13, 1, 100),
(8016, 13, 3, 100),
(8017, 13, 4, 100),
(8018, 13, 7, 100),
(8019, 13, 8, 100),
(8021, 13, 13, 100),
(8022, 13, 14, 100),
(8023, 13, 16, 80),
(8024, 13, 17, 100),
(8025, 14, 2, 100),
(8026, 14, 3, 100),
(8027, 14, 5, 100),
(8028, 14, 6, 100),
(8031, 14, 14, 100),
(8032, 15, 1, 100),
(8033, 15, 3, 100),
(8034, 15, 5, 100),
(8037, 15, 14, 100),
(8038, 16, 1, 100),
(8039, 16, 7, 100),
(8042, 17, 0, 100),
(8043, 17, 6, 100),
(8044, 17, 7, 100),
(8045, 17, 8, 100),
(8048, 17, 16, 100),
(8049, 17, 17, 80),
(8051, 18, 1, 100),
(8052, 18, 2, 100),
(8053, 18, 4, 100),
(8054, 18, 6, 100),
(8055, 18, 8, 100),
(8059, 18, 16, 100),
(8060, 18, 18, 100),
(8061, 19, 2, 100),
(8062, 19, 5, 100),
(8063, 19, 7, 60),
(8064, 19, 9, 100),
(8065, 19, 10, 100),
(8067, 19, 17, 100),
(8068, 19, 18, 100),
(8069, 19, 19, 60),
(8070, 20, 1, 100),
(8071, 20, 4, 100),
(8072, 20, 5, 100),
(8073, 20, 6, 60),
(8074, 20, 9, 100),
(8075, 20, 16, 100),
(8076, 20, 19, 100),
(8078, 21, 1, 100),
(8079, 21, 5, 40),
(8080, 21, 10, 80),
(8082, 22, 2, 100),
(8083, 22, 11, 100),
(8085, 22, 17, 100),
(8086, 23, 1, 100),
(8094, 24, 2, 100),
(8097, 24, 8, 100),
(8101, 24, 18, 100),
(8102, 24, 19, 100),
(8103, 25, 1, 100),
(8106, 25, 17, 100),
(8107, 25, 18, 100),
(8108, 25, 19, 100),
(8109, 26, 1, 100),
(8110, 26, 2, 100),
(8112, 26, 9, 40),
(8113, 26, 10, 100),
(8114, 26, 12, 100),
(8115, 26, 15, 100),
(8116, 26, 18, 100),
(8117, 26, 19, 100),
(8122, 27, 16, 100),
(8123, 27, 18, 100),
(8124, 27, 19, 100),
(8125, 28, 10, 100),
(8126, 28, 13, 100),
(8127, 28, 16, 100),
(8128, 28, 17, 100),
(8129, 28, 18, 100),
(8130, 29, 2, 100),
(8131, 29, 3, 100),
(8132, 29, 6, 100),
(8133, 29, 7, 100),
(8134, 29, 10, 100),
(8135, 29, 13, 100),
(8136, 29, 17, 100),
(8137, 30, 2, 100),
(8138, 30, 3, 100),
(8139, 30, 5, 20),
(8140, 30, 6, 100),
(8141, 30, 7, 100),
(8142, 30, 8, 100),
(8143, 30, 12, 100),
(8144, 30, 13, 100),
(8145, 30, 19, 100),
(8146, 31, 2, 100),
(8147, 31, 4, 100),
(8148, 31, 5, 100),
(8149, 31, 6, 100),
(8150, 31, 8, 100),
(8151, 31, 12, 100),
(8152, 31, 17, 100),
(8153, 32, 5, 100),
(8154, 32, 13, 100),
(8155, 32, 14, 100),
(8156, 33, 0, 60),
(8157, 33, 2, 100),
(8158, 33, 3, 100),
(8159, 33, 4, 100),
(8160, 33, 10, 100),
(8161, 33, 14, 100),
(8162, 33, 17, 100),
(8163, 34, 3, 100),
(8164, 34, 4, 100),
(8165, 34, 6, 100),
(8166, 34, 8, 100),
(8167, 34, 9, 100),
(8168, 34, 11, 100),
(8169, 34, 13, 100),
(8170, 34, 15, 100),
(8171, 34, 18, 100),
(8172, 35, 2, 100),
(8173, 35, 3, 100),
(8174, 35, 4, 100),
(8175, 35, 5, 100),
(8176, 35, 6, 100),
(8177, 35, 12, 100),
(8178, 35, 15, 100),
(8179, 35, 16, 100),
(8180, 36, 0, 100),
(8181, 36, 1, 100),
(8182, 36, 2, 100),
(8183, 36, 6, 100),
(8184, 36, 13, 100),
(8185, 36, 19, 100),
(8186, 37, 7, 100),
(8187, 37, 8, 100),
(8188, 37, 14, 100),
(8189, 37, 15, 100),
(8190, 38, 0, 100),
(8191, 38, 9, 100),
(8192, 38, 10, 100),
(8193, 38, 11, 100),
(8194, 38, 13, 100),
(8195, 38, 15, 100),
(8196, 38, 16, 100),
(8197, 38, 19, 100),
(8198, 39, 0, 100),
(8199, 39, 6, 100),
(8200, 39, 17, 100),
(8201, 39, 19, 100);

-- --------------------------------------------------------

--
-- Структура таблицы `gun`
--

CREATE TABLE `gun` (
  `id` int(11) NOT NULL,
  `reloadTime` int(11) NOT NULL,
  `rangeFire` int(11) NOT NULL,
  `damage` int(11) NOT NULL,
  `speed` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  `title` varchar(16) NOT NULL,
  `image` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `gun`
--

INSERT INTO `gun` (`id`, `reloadTime`, `rangeFire`, `damage`, `speed`, `price`, `name`, `title`, `image`) VALUES
(1, 1000, 10, 20, 8, 300, 'GUN_LIGHT', '', 'Tanks/gun1.png'),
(2, 1500, 12, 40, 5, 500, 'GUN_HEAVY', '', 'Tanks/gun2.png');

-- --------------------------------------------------------

--
-- Структура таблицы `hull`
--

CREATE TABLE `hull` (
  `id` int(11) NOT NULL,
  `cargo` int(11) NOT NULL,
  `hp` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  `title` varchar(16) NOT NULL,
  `image` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `hull`
--

INSERT INTO `hull` (`id`, `cargo`, `hp`, `price`, `name`, `title`, `image`) VALUES
(1, 20, 40, 500, 'HULL_LIGHT', '', 'Tanks/light hull.png'),
(2, 30, 60, 750, 'HULL_HEAVY', '', 'Tanks/heavy hull.png');

-- --------------------------------------------------------

--
-- Структура таблицы `nuke`
--

CREATE TABLE `nuke` (
  `id` int(11) NOT NULL,
  `damage` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `image` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `nuke`
--

INSERT INTO `nuke` (`id`, `damage`, `price`, `name`, `image`) VALUES
(1, 1500, 15000, 'ядрена бомба!!!', 'Tanks/bomb.png');

-- --------------------------------------------------------

--
-- Структура таблицы `objects`
--

CREATE TABLE `objects` (
  `id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `result`
--

CREATE TABLE `result` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `killed_id` int(11) NOT NULL,
  `enemy` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `result`
--

INSERT INTO `result` (`id`, `user_id`, `killed_id`, `enemy`) VALUES
(69, 1, 1, 0),
(71, 1, 1, 0),
(72, 1, 1, 0),
(74, 1, 2, 1),
(75, 2, 2, 0),
(76, 2, 1, 1),
(77, 1, 2, 1),
(78, 1, 1, 0),
(79, 2, 1, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `shassis`
--

CREATE TABLE `shassis` (
  `id` int(11) NOT NULL,
  `speed` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  `title` varchar(16) NOT NULL,
  `image` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `shassis`
--

INSERT INTO `shassis` (`id`, `speed`, `price`, `name`, `title`, `image`) VALUES
(1, 250, 100, 'SHASSIS_LIGHT', '', 'Tanks/wheels.png'),
(2, 500, 200, 'SHASSIS_HEAVY', '', 'Tanks/caterpillar.png');

-- --------------------------------------------------------

--
-- Структура таблицы `sprite_map`
--

CREATE TABLE `sprite_map` (
  `id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `team` int(11) NOT NULL DEFAULT 0 COMMENT '0 - no team, 1 - red, 2 - blue',
  `width` int(11) NOT NULL DEFAULT 50,
  `height` int(11) NOT NULL DEFAULT 50
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `sprite_map`
--

INSERT INTO `sprite_map` (`id`, `name`, `x`, `y`, `team`, `width`, `height`) VALUES
(1, 'GRASS', 0, 0, 0, 150, 150),
(2, 'SHASSIS_LIGHT', 900, 150, 0, 150, 150),
(3, 'SHASSIS_HEAVY', 750, 150, 0, 150, 150),
(4, 'HULL_LIGHT_RED', 150, 300, 1, 150, 150),
(5, 'HULL_LIGHT_BLUE', 150, 150, 2, 150, 150),
(6, 'HULL_HEAVY_RED', 0, 300, 1, 150, 150),
(7, 'HULL_HEAVY_BLUE', 0, 150, 2, 150, 150),
(8, 'GUN_LIGHT_RED', 450, 300, 1, 150, 150),
(9, 'GUN_LIGHT_BLUE', 450, 150, 2, 150, 150),
(10, 'GUN_HEAVY_RED', 300, 300, 1, 150, 150),
(11, 'GUN_HEAVY_BLUE', 300, 150, 2, 150, 150),
(12, 'BOMB_RED', 600, 300, 1, 150, 150),
(13, 'BOMB_BLUE', 600, 150, 2, 150, 150),
(14, 'BULLET_LIGHT', 900, 300, 0, 150, 150),
(15, 'BULLET_HEAVY', 750, 300, 0, 150, 150),
(16, 'BASE_RED', 300, 450, 1, 300, 300),
(17, 'BASE_BLUE', 0, 450, 2, 300, 300),
(18, 'FIRE_1', 450, 0, 0, 150, 150),
(19, 'FIRE_2', 600, 0, 0, 150, 150),
(20, 'FIRE_3', 750, 0, 0, 150, 150),
(21, 'FIRE_4', 900, 0, 0, 150, 150),
(22, 'STONE_1', 150, 0, 0, 150, 150),
(23, 'DIRT', 600, 450, 0, 150, 150),
(24, 'RESOURCE', 750, 450, 0, 150, 150),
(25, 'STONE_2', 600, 600, 0, 150, 150),
(26, 'STONE_3', 750, 600, 0, 150, 150),
(27, 'LOOT', 750, 450, 0, 150, 150);

-- --------------------------------------------------------

--
-- Структура таблицы `tanks`
--

CREATE TABLE `tanks` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `x` int(11) NOT NULL DEFAULT 0,
  `y` int(11) NOT NULL DEFAULT 0,
  `direction` varchar(16) NOT NULL DEFAULT 'up',
  `reloadTimeStamp` bigint(11) NOT NULL DEFAULT 0,
  `hp` int(11) NOT NULL,
  `cargo` int(11) NOT NULL,
  `hullType` int(11) NOT NULL,
  `gunType` int(11) NOT NULL,
  `shassisType` int(11) NOT NULL,
  `moveTimeStamp` bigint(20) NOT NULL DEFAULT 0,
  `nuke` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tanks`
--

INSERT INTO `tanks` (`id`, `user_id`, `team`, `x`, `y`, `direction`, `reloadTimeStamp`, `hp`, `cargo`, `hullType`, `gunType`, `shassisType`, `moveTimeStamp`, `nuke`) VALUES
(794, 2, 2, 25, 6, 'up', 1576549982231, 20, 30, 2, 2, 1, 1576549977339, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `team`
--

CREATE TABLE `team` (
  `id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  `title` varchar(16) NOT NULL,
  `image` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `team`
--

INSERT INTO `team` (`id`, `name`, `title`, `image`) VALUES
(1, 'TEAM_RED', '', 'Team/red.png'),
(2, 'TEAM_BLUE', '', 'Team/blue.png');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(16) NOT NULL,
  `password` varchar(32) NOT NULL,
  `token` varchar(32) DEFAULT NULL,
  `money` int(11) NOT NULL DEFAULT 1200
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `token`, `money`) VALUES
(1, 'vasya', '4a2d247d0c05a4f798b0b03839d94cf0', '', 20000),
(2, 'petya', 'cec9aeba49c4225fc27cfc04914f3903', '', 20000),
(3, 'megaclen1', 'e5c127eeed73351142922b1eaeb36754', '2a29672ef466805a81d099b2f908c979', 20000);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `battle`
--
ALTER TABLE `battle`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `booms`
--
ALTER TABLE `booms`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `building`
--
ALTER TABLE `building`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `bullets`
--
ALTER TABLE `bullets`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `field`
--
ALTER TABLE `field`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `gun`
--
ALTER TABLE `gun`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `hull`
--
ALTER TABLE `hull`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `nuke`
--
ALTER TABLE `nuke`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `objects`
--
ALTER TABLE `objects`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `shassis`
--
ALTER TABLE `shassis`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `sprite_map`
--
ALTER TABLE `sprite_map`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tanks`
--
ALTER TABLE `tanks`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `battle`
--
ALTER TABLE `battle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `booms`
--
ALTER TABLE `booms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=936;

--
-- AUTO_INCREMENT для таблицы `building`
--
ALTER TABLE `building`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT для таблицы `bullets`
--
ALTER TABLE `bullets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=930;

--
-- AUTO_INCREMENT для таблицы `field`
--
ALTER TABLE `field`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8202;

--
-- AUTO_INCREMENT для таблицы `gun`
--
ALTER TABLE `gun`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `hull`
--
ALTER TABLE `hull`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `nuke`
--
ALTER TABLE `nuke`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `objects`
--
ALTER TABLE `objects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `result`
--
ALTER TABLE `result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT для таблицы `shassis`
--
ALTER TABLE `shassis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `sprite_map`
--
ALTER TABLE `sprite_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT для таблицы `tanks`
--
ALTER TABLE `tanks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=795;

--
-- AUTO_INCREMENT для таблицы `team`
--
ALTER TABLE `team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
