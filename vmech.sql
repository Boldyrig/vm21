-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 26 2019 г., 08:53
-- Версия сервера: 10.3.13-MariaDB
-- Версия PHP: 7.1.22

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
  `updateTime` int(11) NOT NULL COMMENT 'сколько должно пройти времени до обновления сцены',
  `rewardTank` int(11) NOT NULL,
  `rewardBase` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `battle`
--

INSERT INTO `battle` (`id`, `timeStamp`, `defaultMoney`, `fieldX`, `fieldY`, `updateTime`, `rewardTank`, `rewardBase`) VALUES
(1, 1574747525392, 1200, 20, 20, 50, 500, 10000);

-- --------------------------------------------------------

--
-- Структура таблицы `booms`
--

CREATE TABLE `booms` (
  `id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `timeLife` int(11) NOT NULL DEFAULT 5
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
(30, 1, 11, 1, 100, 2, 2, 'base'),
(31, 2, 7, 17, 100, 2, 2, 'base');

-- --------------------------------------------------------

--
-- Структура таблицы `bullets`
--

CREATE TABLE `bullets` (
  `id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `direction` varchar(11) NOT NULL,
  `type` int(11) NOT NULL,
  `rangeBullet` int(11) NOT NULL,
  `moveTimeStamp` bigint(20) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL
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
(297, 2, 0, 100),
(298, 4, 13, 100),
(299, 5, 1, 100),
(300, 5, 3, 100),
(301, 6, 8, 100),
(302, 7, 6, 100),
(303, 7, 12, 100),
(304, 7, 13, 100),
(305, 11, 9, 100),
(306, 12, 6, 100),
(307, 12, 13, 100),
(308, 12, 16, 100),
(309, 14, 4, 100),
(310, 15, 19, 100),
(311, 17, 0, 100),
(312, 17, 1, 100);

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
(1, 1000, 10, 20, 8, 300, 'GUN_LIGHT', '', 'Tanks/GUN_A_1.png'),
(2, 1500, 12, 300, 5, 500, 'GUN_HEAVY', '', 'Tanks/GUN_B_1.png');

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
(1, 20, 20, 500, 'HULL_LIGHT', '', 'Tanks/HULL_A_1.png'),
(2, 30, 30, 750, 'HULL_HEAVY', '', 'Tanks/HULL_B_1.png');

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
(1, 250, 100, 'SHASSIS_LIGHT', '', 'Tanks/chassis_A.png'),
(2, 500, 200, 'SHASSIS_HEAVY', '', 'Tanks/chassis_B.png');

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
(13, 'BOMB_BLUE', 450, 300, 2, 150, 150),
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
(26, 'STONE_3', 750, 600, 0, 150, 150);

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
  `moveTimeStamp` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(1, 'vasya', '4a2d247d0c05a4f798b0b03839d94cf0', '24b79a647cb5b23a9b6ff1a64a29aadf', 200),
(2, 'petya', 'cec9aeba49c4225fc27cfc04914f3903', '318bfaf735be74dd8259b6ddb2019d7e', 100),
(3, 'megaclen1', 'e5c127eeed73351142922b1eaeb36754', '', 300);

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
-- Индексы таблицы `objects`
--
ALTER TABLE `objects`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT для таблицы `building`
--
ALTER TABLE `building`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT для таблицы `bullets`
--
ALTER TABLE `bullets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=817;

--
-- AUTO_INCREMENT для таблицы `field`
--
ALTER TABLE `field`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=313;

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
-- AUTO_INCREMENT для таблицы `objects`
--
ALTER TABLE `objects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `shassis`
--
ALTER TABLE `shassis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `sprite_map`
--
ALTER TABLE `sprite_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT для таблицы `tanks`
--
ALTER TABLE `tanks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=381;

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
