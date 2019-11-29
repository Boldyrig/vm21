-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 29 2019 г., 13:44
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
  `updateTime` int(11) NOT NULL COMMENT 'сколько должно пройти времени до обновления сцены'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `battle`
--

INSERT INTO `battle` (`id`, `timeStamp`, `defaultMoney`, `fieldX`, `fieldY`, `updateTime`) VALUES
(1, 1575024085775, 1200, 20, 20, 50);

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
(56, 1, 18, 11, 100, 2, 2, 'base'),
(57, 2, 0, 7, 100, 2, 2, 'base');

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
(1538, 0, 3, 100),
(1539, 0, 10, 100),
(1540, 0, 11, 100),
(1541, 0, 16, 100),
(1542, 0, 17, 100),
(1543, 0, 19, 100),
(1544, 1, 2, 100),
(1545, 1, 3, 100),
(1546, 1, 5, 100),
(1547, 1, 6, 100),
(1548, 1, 7, 100),
(1549, 1, 11, 100),
(1550, 1, 13, 100),
(1551, 1, 16, 100),
(1552, 2, 0, 100),
(1553, 2, 4, 100),
(1554, 2, 9, 100),
(1555, 2, 10, 100),
(1556, 2, 11, 100),
(1557, 2, 14, 100),
(1558, 2, 15, 100),
(1559, 2, 16, 100),
(1560, 3, 1, 100),
(1561, 3, 5, 100),
(1562, 3, 7, 100),
(1563, 3, 12, 100),
(1564, 3, 17, 100),
(1565, 4, 0, 100),
(1566, 4, 3, 100),
(1567, 4, 10, 100),
(1568, 4, 11, 100),
(1569, 4, 13, 100),
(1570, 4, 14, 100),
(1571, 4, 15, 100),
(1572, 4, 16, 100),
(1573, 4, 19, 100),
(1574, 5, 1, 100),
(1575, 5, 2, 100),
(1576, 5, 3, 100),
(1577, 5, 5, 100),
(1578, 5, 9, 100),
(1579, 5, 13, 100),
(1580, 5, 16, 100),
(1581, 5, 17, 100),
(1582, 6, 1, 100),
(1583, 6, 4, 100),
(1584, 6, 6, 100),
(1585, 6, 8, 100),
(1586, 6, 9, 100),
(1587, 6, 11, 100),
(1588, 6, 14, 100),
(1589, 6, 16, 100),
(1590, 6, 18, 100),
(1591, 6, 19, 100),
(1592, 7, 3, 100),
(1593, 7, 4, 100),
(1594, 7, 7, 100),
(1595, 7, 12, 100),
(1596, 7, 14, 100),
(1597, 7, 16, 100),
(1598, 8, 0, 100),
(1599, 8, 3, 100),
(1600, 8, 4, 100),
(1601, 8, 7, 100),
(1602, 8, 8, 100),
(1603, 8, 10, 100),
(1604, 8, 12, 100),
(1605, 8, 13, 100),
(1606, 8, 14, 100),
(1607, 8, 15, 100),
(1608, 8, 18, 100),
(1609, 9, 1, 100),
(1610, 9, 2, 100),
(1611, 9, 7, 100),
(1612, 9, 9, 100),
(1613, 9, 10, 100),
(1614, 9, 15, 100),
(1615, 9, 18, 100),
(1616, 10, 1, 100),
(1617, 10, 4, 100),
(1618, 10, 5, 100),
(1619, 10, 8, 100),
(1620, 10, 9, 100),
(1621, 10, 10, 100),
(1622, 10, 13, 100),
(1623, 10, 14, 100),
(1624, 10, 15, 100),
(1625, 10, 16, 100),
(1626, 10, 18, 100),
(1627, 10, 19, 100),
(1628, 11, 0, 100),
(1629, 11, 1, 100),
(1630, 11, 2, 100),
(1631, 11, 13, 100),
(1632, 12, 1, 100),
(1633, 12, 7, 100),
(1634, 12, 10, 100),
(1635, 12, 12, 100),
(1636, 12, 16, 100),
(1637, 12, 19, 100),
(1638, 13, 0, 100),
(1639, 13, 1, 100),
(1640, 13, 5, 100),
(1641, 13, 7, 100),
(1642, 13, 11, 100),
(1643, 13, 12, 100),
(1644, 13, 13, 100),
(1645, 13, 14, 100),
(1646, 13, 18, 100),
(1647, 14, 2, 100),
(1648, 14, 5, 100),
(1649, 14, 6, 100),
(1650, 14, 8, 100),
(1651, 14, 10, 100),
(1652, 14, 12, 100),
(1653, 14, 13, 100),
(1654, 14, 18, 100),
(1655, 14, 19, 100),
(1656, 15, 8, 100),
(1657, 15, 10, 100),
(1658, 15, 14, 100),
(1659, 15, 15, 100),
(1660, 15, 18, 100),
(1661, 15, 19, 100),
(1662, 16, 0, 100),
(1663, 16, 3, 100),
(1664, 16, 4, 100),
(1665, 16, 10, 100),
(1666, 16, 11, 100),
(1667, 16, 12, 100),
(1668, 16, 13, 100),
(1669, 16, 16, 100),
(1670, 17, 0, 100),
(1671, 17, 1, 100),
(1672, 17, 3, 100),
(1673, 17, 5, 100),
(1674, 17, 6, 100),
(1675, 17, 13, 100),
(1676, 17, 14, 100),
(1677, 17, 15, 100),
(1678, 17, 19, 100),
(1679, 18, 1, 100),
(1680, 18, 2, 100),
(1681, 18, 3, 100),
(1682, 18, 4, 100),
(1683, 18, 7, 100),
(1684, 18, 9, 100),
(1685, 18, 11, 100),
(1686, 18, 12, 100),
(1687, 18, 14, 100),
(1688, 18, 15, 100),
(1689, 18, 19, 100),
(1690, 19, 0, 100),
(1691, 19, 6, 100),
(1692, 19, 9, 100),
(1693, 19, 15, 100),
(1694, 19, 16, 100),
(1695, 19, 19, 100);

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
(1, 'vasya', '4a2d247d0c05a4f798b0b03839d94cf0', '94613963e5b4e8f15d70d704e29b9164', 700),
(2, 'petya', 'cec9aeba49c4225fc27cfc04914f3903', '94e5f625b8e7d036527930acf90d93b3', 276100),
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=498;

--
-- AUTO_INCREMENT для таблицы `building`
--
ALTER TABLE `building`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT для таблицы `bullets`
--
ALTER TABLE `bullets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1157;

--
-- AUTO_INCREMENT для таблицы `field`
--
ALTER TABLE `field`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1696;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=423;

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
