-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3307
-- Время создания: Дек 14 2019 г., 14:23
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
  `moneyTank` int(11) NOT NULL,
  `moneyBase` int(11) NOT NULL,
  `healthBase` int(11) NOT NULL,
  `updateTime` int(11) NOT NULL COMMENT 'сколько должно пройти времени до обновления сцены'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `battle`
--

INSERT INTO `battle` (`id`, `timeStamp`, `defaultMoney`, `fieldX`, `fieldY`, `moneyTank`, `moneyBase`, `healthBase`, `updateTime`) VALUES
(1, 1576322588106, 1200, 20, 20, 150, 10000, 100, 10);

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
(66, 1, 12, 1, 1000, 2, 2, 'base'),
(67, 2, 6, 17, 440, 2, 2, 'base');

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
(2336, 0, 0, 100),
(2337, 0, 1, 100),
(2338, 0, 4, 100),
(2339, 0, 6, 100),
(2340, 0, 11, 100),
(2341, 0, 12, 100),
(2342, 0, 13, 100),
(2343, 0, 16, 100),
(2344, 0, 17, 100),
(2345, 0, 18, 100),
(2346, 1, 1, 100),
(2347, 1, 3, 100),
(2348, 1, 4, 100),
(2349, 1, 5, 100),
(2350, 1, 8, 100),
(2351, 1, 9, 100),
(2352, 1, 10, 100),
(2353, 1, 12, 100),
(2354, 1, 15, 100),
(2355, 1, 16, 100),
(2356, 1, 17, 100),
(2357, 1, 18, 100),
(2358, 1, 19, 100),
(2359, 2, 0, 100),
(2360, 2, 1, 100),
(2361, 2, 2, 100),
(2362, 2, 4, 100),
(2363, 2, 6, 100),
(2364, 2, 7, 100),
(2365, 2, 11, 100),
(2366, 2, 13, 100),
(2367, 2, 14, 100),
(2368, 2, 16, 100),
(2369, 2, 18, 100),
(2370, 3, 0, 100),
(2371, 3, 1, 100),
(2372, 3, 6, 100),
(2373, 3, 7, 100),
(2374, 3, 9, 100),
(2375, 3, 10, 100),
(2376, 3, 13, 100),
(2377, 3, 14, 100),
(2378, 3, 18, 100),
(2379, 4, 3, 100),
(2380, 4, 5, 100),
(2381, 4, 6, 100),
(2382, 4, 9, 100),
(2383, 4, 10, 100),
(2384, 4, 11, 100),
(2385, 4, 15, 100),
(2386, 4, 17, 100),
(2387, 5, 0, 100),
(2388, 5, 11, 100),
(2389, 5, 12, 100),
(2390, 5, 14, 100),
(2391, 5, 15, 100),
(2392, 5, 17, 100),
(2393, 6, 0, 100),
(2394, 6, 1, 100),
(2395, 6, 3, 100),
(2396, 6, 6, 100),
(2397, 6, 7, 100),
(2398, 6, 9, 100),
(2400, 6, 19, 100),
(2401, 7, 3, 100),
(2402, 7, 4, 100),
(2403, 7, 6, 100),
(2404, 7, 7, 100),
(2405, 7, 8, 100),
(2406, 7, 10, 100),
(2407, 7, 12, 100),
(2408, 7, 13, 100),
(2409, 8, 3, 100),
(2410, 8, 4, 100),
(2411, 8, 7, 100),
(2412, 8, 9, 100),
(2413, 8, 13, 100),
(2414, 8, 16, 100),
(2415, 8, 17, 100),
(2416, 8, 18, 100),
(2417, 8, 19, 100),
(2418, 9, 2, 100),
(2419, 9, 5, 100),
(2420, 9, 10, 100),
(2421, 9, 11, 100),
(2422, 9, 12, 100),
(2423, 9, 13, 100),
(2424, 9, 14, 100),
(2425, 9, 18, 100),
(2426, 9, 19, 100),
(2427, 10, 2, 100),
(2428, 10, 8, 100),
(2429, 10, 10, 100),
(2430, 10, 13, 100),
(2432, 10, 16, 100),
(2433, 10, 17, 100),
(2434, 10, 19, 100),
(2435, 11, 4, 100),
(2436, 11, 5, 100),
(2437, 11, 8, 100),
(2438, 11, 15, 100),
(2439, 11, 16, 100),
(2440, 11, 17, 100),
(2441, 11, 18, 100),
(2442, 12, 0, 100),
(2443, 12, 3, 100),
(2444, 12, 5, 100),
(2445, 12, 13, 100),
(2446, 12, 14, 100),
(2447, 12, 16, 100),
(2448, 12, 19, 100),
(2449, 13, 1, 100),
(2450, 13, 5, 100),
(2451, 13, 6, 100),
(2452, 13, 9, 100),
(2453, 13, 10, 100),
(2454, 13, 11, 100),
(2455, 13, 13, 100),
(2456, 13, 14, 100),
(2457, 13, 17, 100),
(2458, 13, 18, 100),
(2459, 13, 19, 100),
(2460, 14, 1, 100),
(2461, 14, 3, 100),
(2462, 14, 6, 100),
(2463, 14, 7, 100),
(2464, 14, 9, 100),
(2465, 14, 14, 100),
(2466, 15, 0, 100),
(2467, 15, 3, 100),
(2468, 15, 5, 100),
(2469, 15, 14, 100),
(2470, 15, 15, 100),
(2471, 15, 16, 100),
(2472, 15, 18, 100),
(2473, 15, 19, 100),
(2474, 16, 1, 100),
(2475, 16, 3, 100),
(2476, 16, 6, 100),
(2477, 16, 10, 100),
(2478, 16, 11, 100),
(2479, 16, 13, 100),
(2480, 16, 16, 100),
(2481, 16, 17, 100),
(2482, 16, 18, 100),
(2483, 17, 0, 100),
(2484, 17, 1, 100),
(2485, 17, 6, 100),
(2486, 17, 8, 100),
(2487, 17, 12, 100),
(2488, 17, 14, 100),
(2489, 17, 16, 100),
(2490, 17, 17, 100),
(2491, 18, 5, 100),
(2492, 18, 8, 100),
(2493, 18, 9, 100),
(2494, 18, 12, 100),
(2495, 18, 14, 100),
(2496, 18, 15, 100),
(2497, 18, 18, 100),
(2498, 18, 19, 100),
(2499, 19, 0, 100),
(2500, 19, 1, 100),
(2501, 19, 2, 100),
(2502, 19, 3, 100),
(2503, 19, 9, 100),
(2504, 19, 12, 100),
(2505, 19, 13, 100),
(2506, 19, 17, 100);

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
(1, 20, 40, 500, 'HULL_LIGHT', '', 'Tanks/heavy hull.png'),
(2, 30, 60, 750, 'HULL_HEAVY', '', 'Tanks/light hull.png');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `result`
--

INSERT INTO `result` (`id`, `user_id`, `killed_id`, `enemy`) VALUES
(13, 1, 2, 0),
(14, 2, 1, 1),
(15, 1, 2, 1),
(16, 1, 2, 1);

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
(590, 1, 2, 10, 0, 'down', 1576322504604, 20, 20, 1, 1, 1, 1576322514894, 0);

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
(1, 'vasya', '4a2d247d0c05a4f798b0b03839d94cf0', '1be2eefc882b9aaa84154684ffa7c823', -18880),
(2, 'petya', 'cec9aeba49c4225fc27cfc04914f3903', 'ffead37def3c60445ff92db8958e4c6f', 217732),
(3, 'megaclen1', 'e5c127eeed73351142922b1eaeb36754', '2a29672ef466805a81d099b2f908c979', -9700);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=302;

--
-- AUTO_INCREMENT для таблицы `building`
--
ALTER TABLE `building`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT для таблицы `bullets`
--
ALTER TABLE `bullets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=314;

--
-- AUTO_INCREMENT для таблицы `field`
--
ALTER TABLE `field`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2507;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT для таблицы `result`
--
ALTER TABLE `result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=591;

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
