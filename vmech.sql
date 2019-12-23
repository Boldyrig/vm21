-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 23 2019 г., 19:58
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
(1, 1577117279037, 1200, 40, 20, 150, 10000, 1000, 10);

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
(138, 1, 17, 16, 768, 2, 2, 'base'),
(139, 2, 21, 2, 1021, 2, 2, 'base');

-- --------------------------------------------------------

--
-- Структура таблицы `bullets`
--

CREATE TABLE `bullets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
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
(8534, 0, 0, 100),
(8535, 0, 3, 100),
(8536, 0, 5, 100),
(8537, 0, 6, 100),
(8538, 0, 7, 100),
(8539, 0, 8, 100),
(8540, 0, 12, 100),
(8541, 0, 13, 100),
(8542, 1, 0, 100),
(8543, 1, 2, 100),
(8544, 1, 3, 100),
(8545, 1, 5, 100),
(8546, 1, 9, 100),
(8547, 1, 11, 100),
(8548, 1, 12, 100),
(8549, 1, 13, 100),
(8550, 1, 18, 100),
(8551, 1, 19, 100),
(8552, 2, 2, 100),
(8553, 2, 3, 100),
(8554, 2, 10, 100),
(8555, 2, 13, 100),
(8556, 2, 15, 100),
(8557, 3, 0, 100),
(8558, 3, 2, 100),
(8559, 3, 4, 100),
(8560, 3, 8, 100),
(8561, 3, 9, 100),
(8562, 3, 10, 100),
(8563, 3, 11, 100),
(8564, 3, 12, 100),
(8565, 3, 14, 100),
(8566, 3, 15, 100),
(8567, 4, 0, 100),
(8568, 4, 2, 100),
(8569, 4, 3, 100),
(8570, 4, 5, 100),
(8571, 4, 7, 100),
(8572, 4, 8, 100),
(8573, 4, 11, 100),
(8574, 4, 12, 100),
(8575, 4, 13, 100),
(8576, 4, 17, 100),
(8577, 4, 18, 100),
(8578, 4, 19, 100),
(8579, 5, 1, 100),
(8580, 5, 8, 100),
(8581, 5, 10, 100),
(8582, 5, 14, 100),
(8583, 6, 6, 100),
(8584, 6, 13, 100),
(8585, 6, 18, 100),
(8586, 6, 19, 100),
(8587, 7, 1, 100),
(8588, 7, 7, 100),
(8589, 7, 9, 100),
(8590, 7, 11, 100),
(8591, 7, 12, 100),
(8592, 7, 15, 100),
(8593, 8, 2, 100),
(8594, 8, 3, 100),
(8595, 8, 4, 100),
(8596, 8, 5, 100),
(8597, 8, 10, 100),
(8598, 8, 14, 100),
(8599, 8, 16, 100),
(8600, 8, 17, 100),
(8601, 9, 2, 100),
(8602, 9, 7, 100),
(8603, 9, 9, 100),
(8604, 9, 10, 100),
(8605, 9, 15, 100),
(8606, 9, 16, 100),
(8607, 9, 17, 100),
(8608, 9, 19, 100),
(8609, 10, 4, 80),
(8610, 10, 6, 100),
(8611, 10, 8, 100),
(8612, 10, 10, 100),
(8613, 11, 0, 100),
(8614, 11, 1, 100),
(8615, 11, 8, 100),
(8616, 12, 0, 100),
(8617, 12, 1, 100),
(8618, 12, 5, 100),
(8619, 12, 7, 100),
(8620, 12, 9, 100),
(8621, 12, 12, 100),
(8622, 12, 14, 100),
(8623, 12, 15, 100),
(8624, 12, 18, 100),
(8625, 13, 2, 100),
(8626, 13, 4, 100),
(8627, 13, 9, 100),
(8628, 13, 10, 100),
(8629, 13, 11, 100),
(8630, 13, 13, 100),
(8631, 13, 17, 100),
(8632, 13, 19, 100),
(8633, 14, 0, 100),
(8634, 14, 2, 100),
(8635, 14, 3, 100),
(8637, 14, 16, 100),
(8638, 14, 18, 100),
(8639, 15, 1, 100),
(8640, 15, 6, 100),
(8641, 15, 10, 100),
(8642, 15, 11, 100),
(8643, 15, 15, 100),
(8644, 15, 16, 100),
(8645, 15, 17, 100),
(8646, 15, 18, 100),
(8647, 15, 19, 100),
(8648, 16, 1, 100),
(8649, 16, 3, 100),
(8650, 16, 5, 100),
(8651, 16, 6, 100),
(8652, 16, 8, 100),
(8653, 16, 10, 100),
(8654, 16, 11, 100),
(8655, 16, 12, 100),
(8656, 16, 16, 100),
(8657, 16, 18, 100),
(8658, 16, 19, 100),
(8659, 17, 0, 100),
(8660, 17, 5, 100),
(8661, 17, 6, 100),
(8662, 17, 11, 100),
(8663, 17, 12, 80),
(8664, 17, 17, 100),
(8665, 17, 19, 100),
(8666, 18, 5, 80),
(8667, 18, 10, 100),
(8668, 18, 12, 100),
(8669, 18, 13, 100),
(8670, 18, 14, 100),
(8671, 18, 17, 100),
(8672, 18, 18, 100),
(8673, 18, 19, 100),
(8674, 19, 1, 80),
(8675, 19, 2, 80),
(8676, 19, 4, 100),
(8677, 19, 6, 100),
(8678, 19, 7, 100),
(8679, 19, 14, 80),
(8681, 19, 16, 100),
(8682, 19, 17, 100),
(8683, 19, 18, 100),
(8684, 19, 19, 100),
(8686, 20, 3, 100),
(8687, 20, 4, 100),
(8688, 20, 7, 100),
(8689, 20, 9, 80),
(8691, 20, 16, 80),
(8692, 20, 17, 100),
(8693, 21, 0, 80),
(8694, 21, 3, 100),
(8695, 21, 4, 100),
(8696, 21, 6, 80),
(8700, 22, 0, 100),
(8701, 22, 1, 100),
(8702, 22, 6, 100),
(8703, 22, 9, 60),
(8706, 23, 1, 100),
(8707, 23, 4, 100),
(8708, 23, 5, 100),
(8709, 23, 6, 100),
(8710, 23, 10, 100),
(8711, 23, 12, 100),
(8712, 23, 15, 100),
(8713, 23, 19, 100),
(8714, 24, 1, 100),
(8715, 24, 2, 100),
(8716, 24, 4, 100),
(8717, 24, 12, 100),
(8718, 24, 14, 100),
(8719, 24, 16, 100),
(8720, 25, 0, 100),
(8721, 25, 6, 100),
(8722, 25, 7, 100),
(8723, 25, 9, 100),
(8724, 25, 10, 100),
(8727, 26, 5, 100),
(8728, 26, 7, 100),
(8729, 26, 9, 100),
(8730, 26, 16, 100),
(8731, 26, 17, 100),
(8732, 26, 19, 100),
(8733, 27, 1, 100),
(8734, 27, 3, 100),
(8735, 27, 6, 100),
(8736, 27, 12, 100),
(8737, 27, 16, 100),
(8738, 27, 17, 100),
(8739, 28, 1, 100),
(8740, 28, 2, 100),
(8741, 28, 4, 100),
(8742, 28, 6, 100),
(8743, 28, 8, 40),
(8744, 28, 10, 100),
(8745, 28, 14, 100),
(8746, 28, 16, 100),
(8747, 28, 17, 100),
(8748, 28, 18, 100),
(8749, 29, 1, 100),
(8750, 29, 6, 100),
(8751, 29, 7, 100),
(8752, 29, 9, 100),
(8753, 29, 12, 100),
(8754, 29, 13, 100),
(8755, 29, 15, 100),
(8756, 29, 17, 100),
(8757, 29, 18, 100),
(8758, 30, 5, 100),
(8759, 30, 11, 60),
(8760, 30, 14, 100),
(8761, 30, 16, 100),
(8762, 30, 17, 100),
(8763, 31, 0, 100),
(8764, 31, 1, 100),
(8765, 31, 2, 100),
(8766, 31, 3, 100),
(8767, 31, 5, 100),
(8768, 31, 6, 100),
(8769, 31, 10, 80),
(8770, 31, 11, 100),
(8771, 31, 12, 100),
(8772, 31, 18, 100),
(8773, 31, 19, 100),
(8774, 32, 1, 100),
(8775, 32, 6, 100),
(8776, 32, 7, 100),
(8777, 32, 8, 100),
(8778, 32, 15, 100),
(8779, 32, 19, 100),
(8780, 33, 6, 100),
(8781, 33, 7, 100),
(8782, 33, 10, 100),
(8783, 33, 11, 100),
(8784, 33, 13, 100),
(8785, 33, 15, 100),
(8786, 34, 1, 100),
(8787, 34, 6, 100),
(8788, 34, 7, 100),
(8789, 34, 8, 100),
(8790, 34, 11, 100),
(8791, 34, 12, 100),
(8792, 34, 15, 100),
(8793, 34, 18, 100),
(8794, 35, 2, 100),
(8795, 35, 4, 100),
(8796, 35, 7, 100),
(8797, 35, 9, 100),
(8798, 35, 10, 100),
(8799, 35, 12, 100),
(8800, 35, 16, 100),
(8801, 35, 17, 100),
(8802, 35, 18, 100),
(8803, 36, 0, 100),
(8804, 36, 1, 100),
(8805, 36, 4, 100),
(8806, 36, 5, 100),
(8807, 36, 6, 100),
(8808, 36, 10, 100),
(8809, 36, 14, 100),
(8810, 36, 16, 100),
(8811, 36, 19, 100),
(8812, 37, 1, 100),
(8813, 37, 2, 100),
(8814, 37, 3, 100),
(8815, 37, 4, 100),
(8816, 37, 7, 100),
(8817, 37, 12, 100),
(8818, 37, 17, 100),
(8819, 38, 0, 100),
(8820, 38, 1, 100),
(8821, 38, 6, 100),
(8822, 38, 7, 100),
(8823, 38, 9, 100),
(8824, 38, 11, 100),
(8825, 38, 15, 100),
(8826, 38, 19, 100),
(8827, 39, 0, 100),
(8828, 39, 2, 100),
(8829, 39, 3, 100),
(8830, 39, 8, 100),
(8831, 39, 9, 100),
(8832, 39, 10, 100);

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

--
-- Дамп данных таблицы `objects`
--

INSERT INTO `objects` (`id`, `x`, `y`, `count`, `type`) VALUES
(142, 21, 1, 16, 1);

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
(79, 2, 1, 1),
(80, 1, 2, 1),
(81, 1, 1, 0),
(82, 1, 1, 0);

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
  `user_id` int(11) DEFAULT NULL,
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
(973, NULL, 1, 18, 7, 'left', 1577117129067, 20, 0, 2, 1, 1, 1577117128028, NULL),
(976, 1, 1, 22, 15, 'up', 1577117278170, 40, 20, 1, 1, 1, 1577117268611, 0);

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
(1, 'vasya', '4a2d247d0c05a4f798b0b03839d94cf0', '', 97494),
(2, 'petya', 'cec9aeba49c4225fc27cfc04914f3903', '', 14950),
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1324;

--
-- AUTO_INCREMENT для таблицы `building`
--
ALTER TABLE `building`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT для таблицы `bullets`
--
ALTER TABLE `bullets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1763;

--
-- AUTO_INCREMENT для таблицы `field`
--
ALTER TABLE `field`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8833;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT для таблицы `result`
--
ALTER TABLE `result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=977;

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
