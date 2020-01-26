-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3307
-- Время создания: Дек 24 2019 г., 08:51
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
  `updateTime` int(11) NOT NULL COMMENT 'сколько должно пройти времени до обновления сцены',
  `aiTeamCount` int(11) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `battle`
--

INSERT INTO `battle` (`id`, `timeStamp`, `defaultMoney`, `fieldX`, `fieldY`, `moneyTank`, `moneyBase`, `healthBase`, `updateTime`, `aiTeamCount`) VALUES
(1, 1577166677201, 1200, 40, 20, 150, 10000, 1000, 10, 4);

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
(174, 1, 29, 16, 1030, 2, 2, 'base'),
(175, 2, 9, 2, 1000, 2, 2, 'base');

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

--
-- Дамп данных таблицы `bullets`
--

INSERT INTO `bullets` (`id`, `user_id`, `x`, `y`, `direction`, `type`, `rangeBullet`, `moveTimeStamp`) VALUES
(3656, NULL, 16, 10, 'left', 1, 2, 0),
(3657, NULL, 22, 9, 'left', 2, 8, 0),
(3658, NULL, 15, 10, 'right', 1, 10, 0);

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
(14177, 0, 2, 100),
(14178, 0, 4, 100),
(14179, 1, 0, 100),
(14180, 1, 1, 100),
(14181, 1, 2, 100),
(14182, 1, 4, 100),
(14183, 1, 6, 100),
(14184, 1, 7, 100),
(14185, 1, 12, 100),
(14186, 1, 13, 100),
(14187, 1, 15, 100),
(14188, 1, 16, 100),
(14189, 2, 4, 100),
(14190, 2, 6, 100),
(14191, 2, 13, 100),
(14192, 2, 15, 100),
(14193, 3, 1, 100),
(14194, 3, 6, 100),
(14195, 3, 7, 100),
(14196, 3, 8, 100),
(14197, 3, 9, 100),
(14198, 3, 13, 100),
(14199, 3, 14, 100),
(14200, 3, 15, 100),
(14201, 3, 16, 100),
(14202, 4, 1, 100),
(14203, 4, 3, 100),
(14204, 4, 7, 100),
(14205, 4, 8, 100),
(14206, 4, 15, 100),
(14207, 5, 2, 100),
(14208, 5, 5, 100),
(14209, 5, 6, 100),
(14210, 5, 9, 100),
(14211, 5, 11, 100),
(14212, 5, 12, 100),
(14213, 5, 13, 100),
(14214, 5, 14, 100),
(14215, 6, 1, 100),
(14216, 6, 5, 100),
(14217, 6, 11, 100),
(14218, 6, 12, 100),
(14219, 6, 14, 100),
(14220, 6, 17, 100),
(14221, 7, 1, 100),
(14222, 7, 8, 100),
(14223, 7, 9, 100),
(14224, 7, 10, 100),
(14225, 7, 13, 100),
(14226, 7, 15, 100),
(14227, 7, 18, 100),
(14228, 8, 8, 100),
(14229, 8, 9, 100),
(14230, 8, 11, 100),
(14231, 8, 13, 100),
(14232, 8, 18, 100),
(14233, 9, 2, 100),
(14234, 9, 7, 100),
(14235, 9, 8, 100),
(14236, 9, 14, 100),
(14237, 9, 17, 100),
(14238, 9, 18, 100),
(14239, 9, 19, 100),
(14240, 10, 2, 100),
(14241, 10, 4, 60),
(14242, 10, 17, 100),
(14243, 11, 0, 100),
(14244, 11, 3, 100),
(14245, 11, 6, 100),
(14246, 11, 11, 100),
(14247, 11, 18, 100),
(14248, 12, 2, 100),
(14249, 12, 3, 100),
(14250, 12, 12, 20),
(14251, 13, 1, 100),
(14253, 13, 8, 20),
(14254, 13, 11, 100),
(14256, 13, 18, 100),
(14257, 14, 1, 100),
(14258, 14, 2, 100),
(14259, 14, 3, 100),
(14261, 14, 11, 80),
(14265, 15, 8, 40),
(14274, 17, 0, 100),
(14275, 17, 3, 100),
(14280, 17, 19, 100),
(14281, 18, 3, 100),
(14288, 19, 0, 100),
(14292, 19, 18, 100),
(14293, 20, 3, 100),
(14296, 21, 0, 100),
(14297, 21, 1, 100),
(14298, 21, 2, 100),
(14300, 22, 2, 100),
(14301, 22, 4, 100),
(14303, 22, 15, 60),
(14304, 22, 16, 100),
(14305, 22, 17, 60),
(14306, 23, 1, 100),
(14310, 23, 15, 100),
(14311, 23, 16, 100),
(14312, 23, 19, 100),
(14313, 24, 0, 100),
(14314, 24, 1, 100),
(14315, 24, 4, 40),
(14316, 24, 5, 80),
(14317, 24, 6, 100),
(14320, 24, 15, 100),
(14321, 24, 16, 100),
(14322, 24, 19, 100),
(14323, 25, 1, 100),
(14324, 25, 4, 100),
(14325, 25, 11, 100),
(14327, 26, 10, 60),
(14329, 26, 15, 100),
(14331, 27, 2, 100),
(14332, 27, 10, 100),
(14333, 27, 11, 20),
(14334, 27, 16, 100),
(14335, 28, 4, 100),
(14336, 28, 5, 100),
(14338, 28, 10, 100),
(14340, 29, 5, 100),
(14341, 29, 7, 100),
(14342, 29, 16, 100),
(14343, 30, 2, 100),
(14344, 30, 7, 100),
(14345, 30, 18, 100),
(14346, 31, 3, 100),
(14347, 31, 5, 100),
(14348, 31, 17, 100),
(14349, 32, 0, 100),
(14350, 32, 1, 100),
(14351, 32, 5, 100),
(14352, 32, 9, 100),
(14353, 32, 14, 100),
(14354, 32, 15, 100),
(14355, 32, 18, 100),
(14356, 33, 8, 100),
(14357, 33, 12, 100),
(14358, 33, 14, 100),
(14359, 33, 16, 100),
(14360, 34, 2, 100),
(14361, 34, 4, 100),
(14362, 34, 5, 100),
(14363, 34, 8, 100),
(14364, 34, 9, 100),
(14365, 34, 11, 100),
(14366, 34, 13, 100),
(14367, 34, 14, 100),
(14368, 34, 17, 100),
(14369, 35, 1, 100),
(14370, 35, 2, 100),
(14371, 35, 7, 100),
(14372, 35, 9, 100),
(14373, 35, 17, 100),
(14374, 36, 0, 100),
(14375, 36, 1, 100),
(14376, 36, 2, 100),
(14377, 36, 3, 100),
(14378, 36, 4, 100),
(14379, 36, 6, 100),
(14380, 36, 7, 100),
(14381, 36, 8, 100),
(14382, 36, 10, 100),
(14383, 36, 11, 100),
(14384, 36, 12, 100),
(14385, 36, 16, 100),
(14386, 36, 17, 100),
(14387, 36, 19, 100),
(14388, 37, 0, 100),
(14389, 37, 10, 100),
(14390, 37, 15, 100),
(14391, 38, 0, 100),
(14392, 38, 3, 100),
(14393, 38, 5, 100),
(14394, 38, 16, 100),
(14395, 38, 17, 100),
(14396, 38, 18, 100),
(14397, 39, 1, 100),
(14398, 39, 2, 100),
(14399, 39, 7, 100),
(14400, 39, 10, 100),
(14401, 39, 11, 100),
(14402, 39, 13, 100),
(14403, 39, 15, 100),
(14404, 39, 16, 100);

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
(477, 21, 12, 20, 1),
(523, 19, 8, 1, 1),
(536, 19, 5, 13, 1),
(607, 21, 10, 2, 1),
(616, 21, 4, 2, 1),
(617, 17, 4, 18, 1),
(620, 16, 4, 17, 1),
(623, 20, 6, 11, 1),
(624, 21, 4, 7, 1),
(640, 21, 9, 12, 1),
(647, 19, 9, 1, 1),
(651, 20, 9, 13, 1),
(669, 12, 15, 3, 1),
(685, 19, 13, 20, 1),
(711, 21, 13, 16, 1),
(716, 21, 13, 10, 1),
(718, 23, 13, 12, 1),
(744, 19, 11, 16, 1),
(752, 21, 9, 4, 1),
(777, 18, 7, 17, 1),
(785, 21, 7, 2, 1),
(812, 17, 10, 16, 1),
(819, 20, 12, 6, 1),
(828, 17, 13, 12, 1),
(834, 20, 14, 7, 1),
(841, 18, 14, 11, 1),
(870, 21, 18, 3, 1),
(874, 20, 18, 16, 1),
(876, 16, 14, 3, 1),
(877, 21, 14, 8, 1),
(878, 15, 14, 18, 1),
(879, 18, 17, 5, 1),
(880, 13, 14, 15, 1),
(881, 20, 9, 5, 1),
(885, 21, 9, 4, 1),
(886, 21, 5, 11, 1),
(890, 22, 5, 12, 1),
(895, 23, 6, 5, 1),
(897, 14, 5, 11, 1),
(898, 23, 5, 6, 1),
(899, 17, 7, 14, 1),
(928, 15, 11, 16, 1),
(936, 23, 9, 19, 1),
(937, 23, 7, 8, 1),
(941, 16, 10, 2, 1),
(956, 23, 7, 6, 1),
(968, 24, 7, 9, 1),
(973, 22, 10, 15, 1),
(977, 16, 10, 10, 1),
(981, 24, 9, 19, 1),
(982, 16, 10, 2, 1);

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
(82, 1, 1, 0),
(83, 1, 1, 0),
(84, 1, 1, 0);

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
(1339, 1, 1, 31, 18, 'up', 0, 40, 20, 1, 1, 1, 0, 1),
(1870, NULL, 2, 15, 10, 'right', 1577166677385, 40, 12, 1, 1, 2, 1577166677325, NULL),
(1873, NULL, 1, 26, 9, 'left', 1577166677038, 40, 20, 1, 2, 2, 1577166676443, NULL),
(1874, NULL, 1, 24, 10, 'left', 1577166676826, 40, 11, 1, 1, 1, 1577166676728, NULL),
(1875, NULL, 2, 15, 9, 'down', 1577166675812, 40, 18, 1, 1, 1, 1577166675762, NULL),
(1876, NULL, 1, 27, 9, 'left', 0, 60, 30, 2, 1, 1, 1577166676462, NULL),
(1877, NULL, 2, 15, 2, 'down', 0, 60, 30, 2, 2, 2, 1577166676987, NULL),
(1878, NULL, 1, 25, 14, 'up', 0, 40, 20, 1, 1, 1, 1577166677272, NULL),
(1879, NULL, 2, 8, 6, 'right', 0, 60, 30, 2, 2, 2, 1577166677219, NULL),
(1880, NULL, 1, 26, 16, 'left', 0, 40, 20, 1, 2, 2, 1577166676997, NULL),
(1881, NULL, 2, 9, 6, 'right', 0, 60, 30, 2, 2, 1, 1577166677167, NULL),
(1882, NULL, 1, 28, 15, 'up', 0, 60, 30, 2, 1, 1, 1577166677283, NULL),
(1883, NULL, 2, 7, 6, 'down', 0, 40, 20, 1, 2, 2, 1577166677406, NULL);

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
(1, 'vasya', '4a2d247d0c05a4f798b0b03839d94cf0', 'ebff81ee94af4443813d474bc39514ae', 68812),
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3158;

--
-- AUTO_INCREMENT для таблицы `building`
--
ALTER TABLE `building`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;

--
-- AUTO_INCREMENT для таблицы `bullets`
--
ALTER TABLE `bullets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3659;

--
-- AUTO_INCREMENT для таблицы `field`
--
ALTER TABLE `field`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14405;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=985;

--
-- AUTO_INCREMENT для таблицы `result`
--
ALTER TABLE `result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1884;

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
