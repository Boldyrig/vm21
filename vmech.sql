-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 09 2019 г., 17:20
-- Версия сервера: 5.6.41
-- Версия PHP: 5.5.38

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
  `updateTime` int(11) NOT NULL COMMENT 'сколько должно пройти времени до обновления сцены'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `battle`
--

INSERT INTO `battle` (`id`, `timeStamp`, `defaultMoney`, `fieldX`, `fieldY`, `moneyTank`, `moneyBase`, `updateTime`) VALUES
(1, 1575901181174, 1200, 20, 20, 150, 10000, 10);

-- --------------------------------------------------------

--
-- Структура таблицы `booms`
--

CREATE TABLE `booms` (
  `id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `timeLife` int(11) NOT NULL DEFAULT '5'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `building`
--

CREATE TABLE `building` (
  `id` int(11) NOT NULL,
  `team` int(11) NOT NULL,
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `hp` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `type` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `building`
--

INSERT INTO `building` (`id`, `team`, `x`, `y`, `hp`, `width`, `height`, `type`) VALUES
(60, 1, 0, 0, 50, 2, 2, 'base'),
(61, 2, 14, 14, 50, 2, 2, 'base');

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
  `moveTimeStamp` bigint(20) NOT NULL DEFAULT '0'
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
(1854, 0, 0, 100),
(1855, 0, 2, 100),
(1856, 0, 6, 100),
(1857, 0, 9, 100),
(1858, 0, 11, 100),
(1859, 0, 15, 100),
(1860, 0, 18, 100),
(1861, 0, 19, 100),
(1862, 1, 0, 100),
(1863, 1, 1, 100),
(1864, 1, 3, 100),
(1865, 1, 4, 100),
(1866, 1, 6, 100),
(1867, 1, 7, 100),
(1868, 1, 8, 100),
(1869, 1, 10, 100),
(1870, 1, 11, 100),
(1871, 1, 16, 100),
(1872, 1, 18, 100),
(1873, 1, 19, 100),
(1874, 2, 1, 100),
(1875, 2, 2, 100),
(1877, 2, 7, 80),
(1878, 2, 9, 100),
(1879, 2, 13, 100),
(1880, 2, 16, 100),
(1881, 2, 18, 100),
(1882, 2, 19, 100),
(1883, 3, 1, 100),
(1884, 3, 3, 100),
(1885, 3, 4, 100),
(1886, 3, 5, 100),
(1887, 3, 7, 100),
(1888, 3, 8, 100),
(1889, 3, 12, 100),
(1890, 3, 13, 100),
(1891, 3, 16, 100),
(1892, 3, 17, 100),
(1893, 4, 0, 100),
(1894, 4, 1, 100),
(1895, 4, 2, 90),
(1896, 4, 12, 100),
(1897, 4, 13, 100),
(1898, 4, 14, 100),
(1899, 4, 17, 100),
(1900, 4, 18, 100),
(1901, 5, 5, 100),
(1902, 5, 6, 100),
(1903, 5, 7, 100),
(1904, 5, 8, 100),
(1905, 5, 10, 100),
(1906, 5, 14, 100),
(1907, 5, 16, 100),
(1908, 5, 18, 100),
(1909, 6, 1, 100),
(1910, 6, 3, 100),
(1911, 6, 4, 100),
(1912, 6, 7, 100),
(1913, 6, 12, 100),
(1914, 6, 13, 100),
(1915, 6, 17, 100),
(1916, 7, 1, 100),
(1917, 7, 3, 100),
(1918, 7, 7, 100),
(1919, 7, 8, 100),
(1920, 7, 9, 100),
(1921, 7, 10, 100),
(1922, 7, 18, 100),
(1923, 8, 1, 100),
(1924, 8, 4, 100),
(1925, 8, 5, 100),
(1926, 8, 8, 100),
(1927, 8, 12, 100),
(1928, 8, 17, 100),
(1929, 9, 0, 100),
(1930, 9, 1, 100),
(1931, 9, 4, 100),
(1932, 9, 9, 100),
(1933, 9, 11, 100),
(1934, 9, 13, 100),
(1935, 9, 14, 100),
(1936, 10, 0, 100),
(1937, 10, 1, 100),
(1938, 10, 3, 100),
(1939, 10, 4, 100),
(1940, 10, 9, 100),
(1941, 10, 13, 100),
(1942, 10, 14, 100),
(1943, 10, 16, 100),
(1944, 11, 3, 100),
(1945, 11, 6, 100),
(1946, 11, 7, 100),
(1947, 11, 8, 100),
(1948, 11, 11, 100),
(1949, 11, 12, 100),
(1950, 11, 15, 100),
(1951, 11, 16, 100),
(1952, 11, 17, 100),
(1953, 12, 2, 100),
(1954, 12, 5, 100),
(1955, 12, 6, 100),
(1956, 12, 7, 100),
(1957, 12, 12, 100),
(1958, 12, 14, 100),
(1959, 12, 16, 100),
(1960, 12, 19, 100),
(1961, 13, 1, 100),
(1962, 13, 7, 100),
(1963, 13, 8, 100),
(1964, 13, 9, 100),
(1965, 13, 12, 100),
(1966, 13, 13, 100),
(1967, 13, 14, 100),
(1968, 13, 16, 100),
(1969, 14, 1, 100),
(1970, 14, 4, 100),
(1971, 14, 6, 100),
(1972, 14, 8, 100),
(1973, 14, 15, 100),
(1974, 14, 17, 100),
(1975, 15, 0, 100),
(1976, 15, 1, 100),
(1977, 15, 2, 100),
(1978, 15, 4, 100),
(1979, 15, 6, 100),
(1980, 15, 9, 100),
(1981, 15, 17, 100),
(1982, 15, 18, 100),
(1983, 15, 19, 100),
(1984, 16, 0, 100),
(1985, 16, 1, 100),
(1986, 16, 6, 100),
(1987, 16, 8, 100),
(1988, 16, 9, 100),
(1989, 16, 14, 100),
(1990, 16, 19, 100),
(1991, 17, 3, 100),
(1992, 17, 4, 100),
(1993, 17, 5, 100),
(1994, 17, 6, 100),
(1995, 17, 7, 100),
(1996, 17, 8, 100),
(1997, 17, 11, 100),
(1998, 17, 14, 100),
(1999, 17, 15, 100),
(2000, 17, 16, 100),
(2001, 17, 18, 100),
(2002, 18, 3, 100),
(2003, 18, 6, 100),
(2004, 18, 7, 100),
(2005, 18, 12, 100),
(2006, 18, 13, 100),
(2007, 18, 14, 100),
(2008, 18, 15, 100),
(2009, 18, 18, 100),
(2010, 19, 0, 100),
(2011, 19, 9, 100),
(2012, 19, 10, 100);

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
(1, 1000, 10, 10, 8, 300, 'GUN_LIGHT', '', 'Tanks/gun1.png'),
(2, 1500, 12, 20, 5, 500, 'GUN_HEAVY', '', 'Tanks/gun2.png');

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
(1, 20, 20, 500, 'HULL_LIGHT', '', 'Tanks/heavy hull.png'),
(2, 30, 30, 750, 'HULL_HEAVY', '', 'Tanks/light hull.png');

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
  `Id` int(11) NOT NULL,
  `name` varchar(16) NOT NULL,
  `frags` int(11) NOT NULL,
  `teamkiller` int(11) NOT NULL,
  `death` int(11) NOT NULL
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
  `team` int(11) NOT NULL DEFAULT '0' COMMENT '0 - no team, 1 - red, 2 - blue',
  `width` int(11) NOT NULL DEFAULT '50',
  `height` int(11) NOT NULL DEFAULT '50'
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
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `direction` varchar(16) NOT NULL DEFAULT 'up',
  `reloadTimeStamp` bigint(11) NOT NULL DEFAULT '0',
  `hp` int(11) NOT NULL,
  `cargo` int(11) NOT NULL,
  `hullType` int(11) NOT NULL,
  `gunType` int(11) NOT NULL,
  `shassisType` int(11) NOT NULL,
  `moveTimeStamp` bigint(20) NOT NULL DEFAULT '0',
  `nuke` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tanks`
--

INSERT INTO `tanks` (`id`, `user_id`, `team`, `x`, `y`, `direction`, `reloadTimeStamp`, `hp`, `cargo`, `hullType`, `gunType`, `shassisType`, `moveTimeStamp`, `nuke`) VALUES
(539, 1, 1, 0, 1, 'up', 0, 20, 20, 1, 1, 1, 0, 0),
(540, 3, 1, 4, 7, 'down', 1575900306192, 20, 20, 1, 1, 1, 1575900312664, 0);

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
  `money` int(11) NOT NULL DEFAULT '1200'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `token`, `money`) VALUES
(1, 'vasya', '4a2d247d0c05a4f798b0b03839d94cf0', 'c0e99b804b68fb5e2e3017ab7dc444cd', 8150),
(2, 'petya', 'cec9aeba49c4225fc27cfc04914f3903', '474e8c801944e9f8ad3ff57a33f65262', 233800),
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
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `name` (`name`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT для таблицы `building`
--
ALTER TABLE `building`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT для таблицы `bullets`
--
ALTER TABLE `bullets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `field`
--
ALTER TABLE `field`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2013;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `result`
--
ALTER TABLE `result`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=541;

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
