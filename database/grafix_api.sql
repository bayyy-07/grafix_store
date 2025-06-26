-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2025 at 03:14 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grafix_api`
--

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `produk_id` int(11) NOT NULL,
  `name` varchar(138) NOT NULL,
  `kategori` varchar(13) NOT NULL,
  `price` int(13) NOT NULL,
  `storage` varchar(13) NOT NULL,
  `color` varchar(13) NOT NULL,
  `brand` varchar(13) NOT NULL,
  `spec` varchar(35) NOT NULL,
  `jumlah` int(11) DEFAULT 1,
  `image` varchar(85) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keranjang`
--

INSERT INTO `keranjang` (`id`, `user_id`, `produk_id`, `name`, `kategori`, `price`, `storage`, `color`, `brand`, `spec`, `jumlah`, `image`, `created_at`) VALUES
(12, 4, 14, 'Huawei MateBook D14 i5 12G 8/512GB', '', 0, '256GB/8GB', 'Blue', '', '', 1, 'huaweimatebookd1412g.jpg', '2025-05-01 19:26:51'),
(19, 4, 5, 'Oppo Find X8 Pro', '', 19999000, '256GB/8GB', 'Blue', '', '', 3, 'oppofindx8.jpg', '2025-05-06 10:35:00'),
(20, 1, 16, 'Huawei Matebook X Pro 2022 16/1TB', '', 32999000, '256GB/8GB', 'Blue', '', '', 1, 'huaweimatebookxpro2022.jpg', '2025-05-07 13:32:58'),
(23, 2, 16, 'Huawei Matebook X Pro 2022 16/1TB', '', 32999000, '256GB/8GB', 'Blue', '', '', 1, 'huaweimatebookxpro2022.jpg', '2025-05-12 11:11:57'),
(26, 2, 15, 'Huawei MateBook X Pro 2021', '', 30999000, '256GB/8GB', 'Blue', '', '', 1, 'huaweixpro2021.jpg', '2025-05-16 13:00:49'),
(39, 6, 10, 'Samsung Galaxy Z Flip 6', '', 14499000, '256GB/8GB', 'Blue', '', '', 1, 'zflip6.jpg', '2025-06-11 21:47:06'),
(40, 7, 1, 'Xiaomi 14T ', '', 6999000, '256GB/8GB', 'Blue', '', '', 1, 'xiaomi14t.jpg', '2025-06-12 09:36:23'),
(41, 7, 2, 'Vivo X Fold 3', '', 26999000, '256GB/8GB', 'Blue', '', '', 1, 'vivoxfold3.jpg', '2025-06-12 14:55:32');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id`, `nama`, `email`, `password`) VALUES
(1, 'Muhammad Bayu', 'muhammadbayu7812@gmail.com', '$2y$10$HxYLByYGxH0emh7KX/H0b.HhTvAmofvlXya3m6GQOuzBkavmLy.R2'),
(2, 'Hilal', 'hilal7812@gmail.com', '$2y$10$8CgNT4uSjdJw2AsQm4X/mOgU6dJr2LJSHT9AGBUG3m.WJitJNtS3q'),
(3, 'bayu', 'bayu7812@gmail.com', '$2y$10$fRKmClqpvEzcwkfjMLpE1.UJ6A3UpH9B1o0ifsdkSyyral8.Io3re'),
(4, 'bayyy', 'mbs7812@gmail.com', '$2y$10$bti35YlKdracbMx3mCVm1u3Pw6YHJlu/ObAzT.bYDmKUbxFAy2/ni'),
(5, 'syauqie', 'syauqi7812@gmail.com', '$2y$10$f/iCDLiCgsdWIM6Nvs943uFGOQAbPK8Lq018UrvlCXKNCmtlPSCEy'),
(6, 'Roger', 'roger7812@gmail.com', '$2y$10$SxUD3AHg59I5H5wWQE2uJu5CCovXsTrisapw10Dk1Wx1YziZOQ3e.'),
(7, 'hilal', 'hilalanam123@gmail.com', '$2y$10$TGTSrveGpj0rYvi8yLR5mu89Y1pQoq7h1br3lfN4jW/Ucgoh/VjvO');

-- --------------------------------------------------------

--
-- Table structure for table `member_token`
--

CREATE TABLE `member_token` (
  `id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `auth_key` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member_token`
--

INSERT INTO `member_token` (`id`, `member_id`, `auth_key`) VALUES
(1, 1, 'rVvCzBNIRnNmmNSgklF0auvMStkwUmO4Hn9FOGPRFuwagy5jZ56VZR8Y57lvZmVBcR6YnEdzMAskTqK5epQp6WqPCVbXBZfwB8rO'),
(2, 1, 'YHjmMRRVXMPfLjc2n4JKSBOoFolXpoNDFxW0LRLP13FVF748Zo2hguSaNA0xeyKWdRDWMxZzfhJ6G00VAnMdFIU8KtXKVm4EpYR3'),
(3, 1, 'ILItU6kxlNN8uBVUTCxTQqQPcFGXcumxt3WZTN1JTQw76rXZjTyjdpVXgPrqjUsfdRwZw4fnBkl17JTTZHdTU0h0wkn5xzNI3gzK'),
(4, 1, 'lQRuNVPpFsMnKmrjMrPBISUFWemfSGgPvwfOl3KxI0xivil52cSVcowZJ5LkDbcqhpL3GN7psVgJMjgvFWAcMmFV0Pj8qsVnB2TS'),
(5, 1, 'kPDUyRmvgShh7nxwFqSCOTC0CAiKHhzwvQZJNCTR5IJhchIlx0miI6wjIHLgbHcgcPsSDdA0gnC4msLDuORAMVbw8XKRGBhkaWdr'),
(6, 1, 'YVzTCUwxBWYkPoiJ5o96ZEdvYT7EVizRL5w1dahjNFaHpPBN8ttX7KSXfPEZ5a5NbDabehsR3Odhj5rI6r4fv5YC25Hxa8d78meh'),
(7, 1, 'bbIzMFZ4RL4JsUiLyvdyGKXCxfSpJ92yx4zZbqXwjX0RgSjTH9EUvMJYV3xopHZBiHMLuztHDIflfJJGgEClM9aaRr9n9MA0AMqt'),
(8, 1, 'bRSlGF579MZRpzYoScB9mGHlge7GQnsd7MkkMTAegHXjSlhhA3FVdT5buusueP36VR0IaF5n41odpicrue8kSPKvBhfxTlktzhtn'),
(9, 1, 'W6ZEYdo4IFbHdZtLheKwYLVJs7XJAtSfkRlkheNa12tm7JPyVm6F4tx43GnaIzyUHqan2isI4DdNn58z4toIlYFxUtooj3fZQesl'),
(10, 1, 'fuZUo317eGfdKoqSasx1KJ2XSffUKnqBsN0EsVv7TUJt3awkHWzDn5CyQOtrsG4tFZnAlACKoVqwlzIWyfZEdTSPYBPVyIe8NFY7'),
(11, 1, 'rUS4KoKp01dgAO5xzUVOKzQToYWKDH2HOuyADpLFtWXLmiEoCsDg8iuNmqF2nhODnNxtH4RRuhbtBqXFhAKtAmzOks0hdvkw68vo'),
(12, 1, 'S0dtLFt0nYNGx6V2IyIxwUcOEbdZsjwwzkRfK0XMPSaxvTBsITvu5qy9qIuZJ4feoJ666VYN7q44toYqVJtWrsJFl5g8MwekGimg'),
(13, 1, 'fzZZlsXdjRVnX6sb9nt1yULyPUkPKIlLEvEGphjzALhQ09W4LBVvivQKjWDVeq0ICiGY3O5R8Dw2wcN4YPXJhcxfdXwaKzjKCOSX'),
(14, 1, 'x5fxd6PTN84l0gPyzk7yqE6TKS1SV5G4KwteTbq4xNHGeR8d6nV2NlCNltY7ePHjz0fhxsnvpRlVvQZ9KBX5mOYwYnzhL3YE4rpI'),
(15, 3, 'mJje1AEVBp42kgafLG96LMCe1WO4aapkA2E8BMN4GEwdgb65tlqiCq120RNsIk5rmu0Clf8MOGj5a8uyL6UVsKiLD0w1I5HivbBB'),
(16, 1, 'NdfiUijTHrJjtLnpCg0orrNwv3UjwYr8xR83jI0IGs3xZGNE9NQaRVSvcAHg5fj5S8kxJlmGPxML01tR8blXpwSp1FxZC4bsPxbg'),
(17, 1, 'FIF2s7UM0bwEZ8CRuL1Qoz4juzTO39a4I4O9qsFrmahMDy2uZz2VgkHcP7k44Uu4xqccJybdamCGMITbgKrBaAiVs17hV49vqbn0'),
(18, 1, 'HhdYc7f2IuLRBoo5hqwUJkaBFfezBHZzViwB7dB39AMdVGxd0fKjasQ2Cpo1UVMUgzOCIrOwlZpz8uHsWdLBz3LOP8OLl0XIysek'),
(19, 1, 'zzUbwqerNESn0ZKjUK3ZdZKfSuhx4NsytM8B3c5x3Z7jFLHcYQoDgznZprX9FJj0zyu1lRIihUhZK4qWC4WKNlIIzecDRK3tdHeN'),
(20, 4, 'sC6latWnsNEoHtRNBBolXdxdJirnTsm6xHX9xP1Ks3uS7Q9ZaaVEWQ2raiwDUEhtHmYMQdrnredk7XPwFr6b7sa41503i9wbCLoY'),
(21, 1, 'pn9vZ9ImXJsWSjstuC0wfrVSViawuJaUsvXGpmM8uOkcgY9us02FVjllYYwRVYGzjt0esUwAX6EtCF0nASXJ6UcFJeNlI32FRxk8'),
(22, 1, 'hhFBBWgCTlESJeg55nWAVmhplD9YPbzGEsQi99YIYYnlzurQJ7RAKx9qPXobKUkmJ8fSSLIKmtDQdLYszDngGtyhrzPt9cvsKInW'),
(23, 4, 'Siies8aRdqFmOoVrgvE3nUVfTx6gGTPVK3laHL8CZC3IdN4v5nLXOeOqJZad8ne5lsj7Q8PtRNtsETmvVGio6xFC8JwulnocW3wV'),
(24, 1, '17YyY2kEpSFWJQm12jSbMkWGvfadAuhHd9KNQyxksSNCCbsRt9od9qSiwoY2ZTRGgSBRoI30HaQou6eLNNtcYmVDJC2gjOneq0my'),
(25, 1, 'UecOYnMjlTZQzIDP7vzufMUNTf0HQ6hs6UsmBPCrkQ5QzcLAexBFzNVQMdpC3sBhSA5DoA0yHScVqQVIuwlEp2Z0YormHLG55V2W'),
(26, 1, 'FwNnqrYYUVRWHSMTM03gNGTigopWzzUtjvihzPq4DHtNG6hwKMQF7w9Kgu0Q93Sjvy0lpeG1HNzwBJk1LMXIqeHVmmkgF4tlhosw'),
(27, 1, 'JSHaQvNLsb3RAXwnu1jDmaikcr2FB3ekCYNmlhjf7vxJDThjC38OBXzNbAK3KlrFBBPQRibwec2CrNRZsA2UF2os9TcTg7M98X97'),
(28, 1, '3tHv68589KyCEEBWoyzoxpIRztWFbX3ZKugKcH38gZaaKZrC61AajdNS9krBK6Eanll4HYRPO1mqgcUcPdpueD2Cic1Gp3Gw5Zp3'),
(29, 1, 'lQP2PmR1Y2mVtB73fPT45gYnd6jMor3VLU5X72Cq6fcxKSqHJVrTbyXLMMU717hbxnguXx0C1TR4yXPbLT4FlWjp74aPGTTfYLRn'),
(30, 1, 'oEZKnw8127wTloL2RwpRFkt0M04VAp7qszZq1UzuxApblDrBtMkFvdcGIkDBovHElFsCShBxXKHDBr8eZy07DrNMLjA9WKyowIDC'),
(31, 1, '2smYDIpAsdtKFhAglNEcgVTgnRQS0zNrP03gmZRAtyBm0l47orVBqZeLd7bzuFYilOoPy5GiAfbzvBikjqyIqcFh4VmHTnX5lVHe'),
(32, 1, '00v4rCbVTBIVRkjCbPistaNA1LUUDprKdwUwsJxCiX5CV9ev3rYydH3PMNCvM6cNrk3KrXjK6fMZVunim9aG5fYUEqpbMwtVhgxn'),
(33, 1, 'mBzRiHXnvi62f74oqoUkqhHq37jILpAwywlSnXnKredgJ378XCRGbomUkRJUX5r7jMS9DSmSBOQgaYj3RigJM94bNNUu8en6Cgqf'),
(34, 1, 'yQgfCgbcB1cPgeAFA0DyVmXyHzaaWkopOEgx2bu0XQdB4xr67MBNhEkiDlR0TX3ptFPV3O5H44mgJbmCA0VZ9W0JTx32MgmxXJgt'),
(35, 1, 'WDNyT0vneb0BVqtNjznWGfYtFBbW0rtWqCTSWGSDOWC4QEg4rm0BOko0EJ2RoFc5kwl3eeYbWPV8A6XuZkoaQig5XQ7l9TdCIIoH'),
(36, 1, 'cAV18zI0GnUwTREk8x85d9fxeouXGbBw6lNgK2HPP6Yrx55gWRhHFeQEEdDdI1D0QiavQlYZc0AOh2U2KcZ8XsHSc76zi4Wnv4oo'),
(37, 1, 'kNv5TwDCNMm2rMidWX9vfSzEKxRZjg2wMRBC9y2il9bzwQheadVwk8mZ40uBp4KLq34jalgimqiFkpiTO6rXL3tVJlDvSl8fkd8k'),
(38, 1, '2rg5sjj2k02xQ2HHbmyxJv6rHcUgKVJmoeURtGAHM9Lv7pjLpZYlz8PnwRjMBWWJdWHfYEfygNjfTgMGdsi7hQs4ncAbC4n1KYDX'),
(39, 1, 'smdwG7xD4p37JalrLxGTP5m6BFHTR4H4PuBfMJfPuZUVxRrbF5ybmve0SnVlyyQY2Qhn3tVTh47s4c6yzTm2Teh8P3z8JvwDXCDQ'),
(40, 1, '3Oe8KgiEY68fXDAKcG4NE9KarhtyNPedps9zFmzcVyC7aF50V7LwfjTx1Kd1AowWqNNSkSTVUkHOClpe6YYaXXxq9MGRaYyfItSt'),
(41, 1, 'QXOHIAhZ21WM0MsTm40Tdih4dQLXRawNMCKByCtwALHCABJoa5bDeuC9GqEkQMNDRaoJVwV9GRiV12tcfLCLNpOJ2x7uyAU93x78'),
(42, 1, 'ThGK9p8C5XpXvfdrM5qipWe2HZxJ0pMtfmGkdO4FjnJwf8oLYNI2lg4ggaGFZ3mwsKGjJ4vd3HL8aF8UMHJ8ABuNAxLMVxSUPCiJ'),
(43, 4, '4LnHHxW4fMRjdOJ0EYGwHyg16h6zjdZVs45RKGKbyxYFNIHtRxB4XBRgzaxKlqa6a1TBMbfHxoxfLQyOuTnkGPWAF5qbhuLRiNcj'),
(44, 1, '7Ep0nKCxNWaJopQRArrbvGsRRiqZ3X3fup1qI6B1Wmc5ZA9qSG3FR832bjmftGcdqWEggBZWqS0sxVSUhYY17hjE3rsE5x53buXJ'),
(45, 1, 'dnTwcdM6YXKSqTLKa9oPRmbCxOqPzzwxv1brngRCxmAbrx6hh19TKHLWcAlYkvhLfae2X36vwgTSlsZ1JFfyKDRzgBGfhV2MjuRF'),
(46, 1, 'zzZf3JH6gaCau7QJu4ssflNVJU0HexUtG5V2Danf57hlrvEi8qr3SqqyCRQ2H0b1DmUrYLQmj9PBaXUYKh8SXDhpZMaI7qUD5DLd'),
(47, 1, 'V6LwUpBQeecrPfzSMLEaLQXRYXHtaL3ZTqHi88XliIAMnm8cJRe2Zqo4OkC0DopAq2OKrqhRIk6Sh4smLVOQn4d3xsRkQN09huif'),
(48, 1, '7MM7TQ9tOoNz0KzoeSag0oGJG6TZYdPPt79J87QRkIEExSxVheAw1AMpBM9rWDshlTIfnXKyGxVmCw9x9d3Vk2kIErF1S2huTSgk'),
(49, 1, 'EYAwmtDpCFGCoPcBHGjywhtunIFCeqjy8QvPZVhfPXZBZX2DUQHFywNMGJu8CpQGK5uYZKqdXIQCeqjlZWsSQxdUfVYJWZPWEpnX'),
(50, 4, 'RpZYUy4ZYJXB9yabOaapshebZwrpleMJWQR5SlIpOCifpchDqFZZ0F1fzhTRdXHEi8lzr7Mb2SDacTWWMMzv2koiKCsEqRB5YTuk'),
(51, 1, '7rXCAAMVINawuuroZIuZHosYODQDdRh4w0Tvo30F2YGuKduku8br3KuQVZy0tU7KS3pKDnTClZON0xDAcq15UOtPsvpWAo1uE4f9'),
(52, 4, 'SDrgAzXLcNTTQioYfW7d6NlYBbxzG8SNtIuMYBTqhaem16q4o20E4td1NPj0U2dRrbgmXsvCRogtWm87pUwWWV6o4TKtwVX8uH1l'),
(53, 4, 'q3K9qOcv7RL9ftSyVJUbtROWeH7QIdBUeTMk7J9rNKO9v7FNgfQRhLXVBpxmzsDhNoot3TOIN9WGgK88mv875gRe0g5vwDANC3fD'),
(54, 1, 'U8kBO7iv9uEW67onFtNSDPZis0mCNePjou8Y8XaBRK8OyFRyohT0IHvA68R1OouIRVdDJitLEYYUuefLBhn55xgzOvGEOtnbHCi7'),
(55, 1, '2nrd5vBsNPkgYB05AyDBcwJBfYzzOPHKTGuh8T9Euo4bLHXwvlOv6DWMa7glsa6VrNZUCeAKzZ4MuyA9oM0WKirqyPtrJ1mXs4L0'),
(56, 1, 'jdKsmoQ3MEiaFyvhcpuwPKzQ8b7nDXqs0VJ0vfN7EmEGjLN494yjQYKT2ge5JYHNJFzXPns8fIUYVVublNmZoLCtmE2u5tkKvjTz'),
(57, 4, 'vgBidIlCPhp44WWSAJsVlMaPrnzj3PKJxHrIgQB0RH9aTLBw6CpOqcmHDGvqQc8SYi86iYE5tPbPIkFzlq767BS3geQwH7TV5UZW'),
(58, 1, 'VQueV3k0fHmqXxoRtHAbyYB819KBdaOFR9HRM5NIechlykL8MDAQRWmjGpK1Q8DobNhuo8Myib2dtBs42G5zxxKq5Q9RsGvR0HKI'),
(59, 4, 'eIcJ7WtXYjHwsFCwUAZOGOjr42tQaJb9Y1WmebSu4S91ECvqpYmO8vrQpMvTElFHCQhAx9a16vlbVoAot2PgYcKZ6csN6HXhr3iy'),
(60, 1, 'zxr2CdA9sb1WekgHg44ligJlHYYDrVwN30kxjlNt4VD3mdliEhgLv4RwkG8owruDAIn4LhUFYQf2N64nJoxsGJqXnwQG9xXGOEJg'),
(61, 4, 'QYLECZP3SkacdqRYs98FroA11QAk28V37fqBMd7kXwDQ1YjnG1zLdCCcdLbCTM73zyGaKPKOHHUpw2yxXBd67z8zXYq17EEJEncl'),
(62, 1, 'VnwJI8falkNqZUQPVyiFqrYzOUIT6ow9AbzOUBVz8vDWEBFGj9oEbnLGDffVO3flvLtFuLiYv8u9MxZmumfzMXXxo6lNaah7ItlV'),
(63, 4, 'BfzEwxEJG1EjtU6DRHyAgrXG8puHlrbvpUkeORWCg336tHxUSliQ1rkaJID0YUQmtNwDkyhwaiX3epSGPhFJuJILjOdqAqJ9AtgQ'),
(64, 4, 'BRYW3RCR90USQzYRRTOR2s8OkpphrFoNfxNDtdm2yliAkbIkfTQBgdefG1AgUK0Jg9vpbXT5AdZ5BgxvhpOydkPkDPXRP5idx7dw'),
(65, 4, '3WkzDiBqCOUJop4yyBTrKE0mNOG8rTM1RTvWUK2TrUVlfRIBUzjIpPu3EQAMvn3v4WBIDyqHzhhhS513MuV5V2lmloG5br2hynea'),
(66, 4, 'B9qhSmTFp8ctdDT4SwKVgxTj7EfNEXZHBnPcVDVqxGaMrTDNQJPCSstaFAmrDpQEJwX8hkhnZYxDkp9bQcXavWJozFClufMwtlA4'),
(67, 1, 'FBDypv2vpEVfrKNXinJt0faplcIGBf1vncKALOnOmSajbXA5WqS1BUPhtxxilzLm812UpGMpqGLNjGe9mxptOdwl29sk2ryNiELl'),
(68, 4, 'LXZujuoKRYwV2vYW0aqV19AlftrY3Tds8RVKrM0FYGaV7Sza9c9GxsQfM0hJlILnqHGSGsneUUcaBajMgDDlBU9fTPqJyvsYtKaH'),
(69, 1, 'MDU8ANZFn9DEjU3CIyVSsJ2miRdElfQfu36otQhSDIrxlzEQ9snEiLZBxkxIQAP63r1oX6tlQV3WwvAulnpktB9hHdSsHYf9uySx'),
(70, 1, 'iAXuwU3ehtXORX8QhCzd2HjgXrOXF4t37wwi4q29ybaEPfCZ4c1z3qizDzBiNHYtrwUShdFVF77mUxIW3hQivVT2OcxE6HLoYnC4'),
(71, 4, '1yODZw2IeHgRwgMI1py51Ly4TpdAXJa51hsg4oSZmLxEAgeZmh9vFi2nhgUypI4DLtrV9f4gAT4yP5Etk7pwvDTylm8iOpHF5yH6'),
(72, 4, 'kTYJrRbTFbGoYqIq8PNX4irOunpmHweNyiViF7IbTHEPrIcxKDaj3xm0FBgqK8X2DIxyM5ZIm0fe7S3xggpzYnIYLXssjrZyAMOD'),
(73, 4, 'OkFJ98xKDUaB4NfUzY1DWDJIM9o52QZ2peFDkghEsjZdYx0SJ5ICoNk76aqvvWLfATW8wflnhfwszr5xGQRgLPALdzImHII7VXSs'),
(75, 4, 'W2stkMltR36EewDJzQ4KX6cdwbB8lD4mLh6B1UROc5aZ4doQGjtGQFGAHirLGdR5zkQ2ZPoAdmT06eDEADKB0lkqVMGMvBaglRrb'),
(76, 4, 'gWoGWnd7YMbVPfnl7F6XtJ4uiRT00MN4PQfi3sVYUYCyCrWNnZw3DWzDlORd9NgjBTn39EBy0dqx9rJfqAQlzzBc1GQvqtLWsyRE'),
(77, 4, 'G2FtIwEmZGO7gK1uqLKAxpNagLKsySNmNE8gNzVzV1kLDnxnnYZ4mQfVANFiJtQOu8vPaSudrCHeetWKRUX30sNdmxEAnhHoKuAT'),
(78, 1, 'RkTW1vG18XMerUvhTmVgxYFjhFb2alD1fUPtEYl6Rnhe67x0Wpn7aFJAtDSgkb73pvmpmicYgatfV8XUYU7d5q6NN7Vnq0K7C6ve'),
(79, 1, 'xyJs1dhSsBddZ7oSIo3aTAqqIgqsPuACGGiOYPOnlXobFdqHa7l91Sf4o0G0IB0RdP5V2g4UQ4EzQMT518VdoDRkjmFoBtuiNubR'),
(80, 4, 'ordQxD462WJpHtr3NGYEANRjVIKFunVo3sQS4p6SPHkxlglEqbTEr2OAvDcwYu4EJyW2NDTrH9BWeWs4OGgCVFqxUsxNbrEY6EoO'),
(81, 4, 'OR5wdPcHy30eP6w196Kgc2nwD7FJSaVhY3bwK70DxcCVLHj19MZAfI5ZWXVyUktdp8qBJd2AGhMI5DZoWyaBWaCUryZL6wQIE0LU'),
(82, 4, 'nmRVKd2h8o5TAfL5tKpRDHBLdSz0GCTXsHPN68fOPxg7ffAlqWA5kDzdn9MBR4xzrLHSRP2dFpBpeafu9rn9JsPgdK4a8EZkjGET'),
(83, 1, '75m7lIaC0b5l9fB0gF3XanoQFTySyn6EIzDryAd9pz0ysfb6EAKfbdNCNUUtUdW49hwkWDghNlAoyZCzBNaKZUW3HlGYnxwGAAyO'),
(84, 1, 'QBMTKPv7WLnbUHtNpKmAfFUNi76Wt480LmNm9Ji4dU5jsmnnJzFML2dLHtzT8T7Q1SEhhHT3EjPqgXk3O60ThiGeRZveLEw33SB3'),
(85, 1, 'e1vrlCgGerzBeKnT0bd5qpS8JU0bF0piF4xIZQI1IVi06bYST8NF0RlzsvxPrN7RL2vq5i9VpoEJnNevzEV7WHe4SXZ2x3Npk8YM'),
(86, 1, 'GfYhNGTtn6lCO2NZ1QGzJzKYB4R4vwl3T4d8anIygEIfg34DB4JT1uVeUrwkmfpcbbcLI4MbrjGb0eKapsLgdPe3jYfUNCNIMqU1'),
(87, 1, '7UU8EMDSiMBBHrfKlXMGh7AcDvVruhly4kZL76BlJgLkKPoEggylGmz2MKWFpsEss3sk57pjV5GFvFeI4XV58evu1T0VzrN77yNi'),
(88, 4, 'CuXD4Z1mbtqyF6iECNaZ8HGiXwWPwVDf9nx9jHk3lkoe5BUKLkmnFeY8tHKJPdQ2NerFdeDjI3o0CFUeBThehoqIkg0hbM7cgvaV'),
(89, 1, '9GmutnZ0BkZsdxomLD8NaOQgxq3KUAgSSeoP8YnYZvH6XDQNOD2riNcTASzNJbwRixR0YqGJf2ZUMVe0X8U7ijP5Y2gh5yb6Dbzw'),
(90, 4, 'qgwcOZJo3sjnfihNSuca01qOL7y9bvWgJ5yDtl39g41FbbwN1DNvQQb37Gy11d9R1e14mRdPBbMppLL3MkflRxoH6LLs3QvOGT3K'),
(91, 4, 'ZcomTpLY6DEReWvB1qdyGn9jetfJki7dgPdhA5Eyv4V5aPbd6Co0A4SgXLAUYdtNfeNPE8E8ex1sQfE5m1lpBouFIqek7FZkIYCF'),
(92, 1, 'RP1sUSbMtQ7n0wMYCwrzEtvtpn7YB7bSTPNgLtO9HLIOUCuvSDeP7QvPhe4svqyRxIDZRJ8kOP2f3MyPz0Xt4xlsxhrzYZVxPuZz'),
(93, 1, 'wXpX3WeP4KVJL9hnklgj6LILJLx05PGljgyK7BXaIOKqMvsTWeJYLeSyuNbvuGJnMHSFOMc29ICMkbtQzSZHC9q2ZXLbL5R981kb'),
(94, 4, 'aRCrWKZJ6zCmXwno3ClqPEbD4n5jJbZ7uFT88s8cGaXPrbLQ7rtXYub7cSSAyJ5QRXNv8CHiBlUWn1ssyE4vHpL3iZrdjCH7U6Eb'),
(95, 1, 'J2MFzpeEwyR2hbo0YZ1xMWSmKt9S2Hyfv0zDVdkKmjLgCCsPDVu28TwWyV41mHH05eEJECBvKKZevmQBiBjQ3RjJ375ZnpAySiK6'),
(96, 1, 'JXbxjcaPKVlu7yf7fFWru4slJvgnDrOjgSzZ7mCybw3chBsm1qfny1DgTswvx7tBGXdOUrAW5ArRv85br6GcNRAJ80P4GuHr1XC3'),
(97, 1, 'goW2rfDzTHk01XALdbaAjMhz7hAyuPkroMBWclEVsmhvpuZv31r9qEFDFbeEhD0IcugR3brqcpsWbSWYVnC9RxLE6wQNKTQHDbuT'),
(98, 4, 'UXpCH7sdpG7UAIQ4hCzSjnJDCfBFgneOPf9zxi3mI1Ftgmuakh0eb717uOAeVHP1WMYqLuHH2GFvOow8J2czq1MxfJfYGiMxqVTL'),
(99, 4, '3wlZOVsFw2Uaz4jxCeOpKMAMBTzpoGv8s7DVvR5airZb3HBQ3IQi2EaowQmqEmdp7aFqgblvfvUQdDf5MHZOh79haM8azgMPYU2D'),
(100, 4, 'MYewuxPFZE34utJCDPLYnVlOITqeaM1yTGEMEPhcMksgp0MV2U1dxmtVg6csDyvAEX9Qe7tTq44GptXuKoPbIKaDA13rk5cNkBSN'),
(101, 1, 'Om5tJNz4onjsch6PBv0NHATS5BWad7zEA1YfigDQso9leGCmASCWfbYbN3m3x1ZtTfwvOZ6FGI6ajJn8fXEwkD9plCUYE3h1vduH'),
(102, 1, 'D9hvq3ywuV8OiCxWxqvoWwCCPJFax4MnLJZ2Eve0jju0vCmzEjpvOUIeulw7PTjr2zd5gkIHEEFXdVuGCtLQNywPk7hIIdxatVX6'),
(103, 1, 'Gi23rcZtP7jvkuf4Ohu05ZQJ5NEm5dARs6ZDuGYhDsJ4kI53dTnj22ry2xXLgTixjsOMt8mF5dYoAqD9ztXQfI0bHctQ3Cx5zzlu'),
(104, 1, 'BsNoECMk4F4t7GJ7lXLG5XFCx1njWtQGRxQyiLX0nFFwyiHHscCWtY9Zwu09qFawwke5PFnxeVOlxOAij6WohdVduk5jA8PWx5tf'),
(105, 1, '5WuP8cgnyQoh2CWvaGZPxsrfVg9A5YG3A38nUqJTZNLGnhJ9eU9dldkKcUZ78rovEnTM5I67fByT1EQHoN44tI5iDrunS7rb9H0h'),
(106, 1, 'kuyuP4TPZS5lID4RCj7yCLQOudnYVrmBUvBFHuwQgg8yCtZGYyWAc7tHGFt2b2ZryI3CamPe8PFrDDo2fHDF0VActqu4P9wCI7S8'),
(107, 1, '4E3XHo0xTLkTSMfYF9SWcxruO9qlmfrqrOyDUWkhydAZuhVNBtcBttBYP1C3AGdOesqWXjMAzkwPNqjn0AJcDbzr9QhCjQjR8Inh'),
(108, 1, 'hkoyAVAJmWMOqBfByseMJDfHHAjlSesqWzOUA8TkRHcR5VmiaGPxnusTWxPFDTAAAfzVuXW4LVT7dJDQ2nwKJ7FhtU5RgmO8l2YR'),
(109, 1, 'BzOLNtQmWds0Gytlb6nC3Shw6ktjuluvbQfc5h8EeH5smcECdP0pKUGE5JUuicbYITUqnQISjF36IjA63q0p0ad1FVrcaHltyr8Q'),
(110, 1, '4Ex0kuwERau2k8eqgCmvq92Rmrql56KmoQaE2XwsSsvFXNsep5SxKMZ54LxbHFdjZLcy77qP05cwNmDaSiuFUAksx0ZbO9J3PRls'),
(111, 1, '18hyGVfykEAvjZXTJPEEHIoOBAYJm1BohdgUXbb8ac4CSWwFcb2PJLkBDGL5ukyHGbPwlV1ghjQtfOwchVOTIVv8HJyv48worITF'),
(112, 1, 'xoB3acEFJlQStD46S1HfYNyxurtMZDFbJUHadYtvl2UoS6FYt2CbFxbtLZvtU70Rw60ydiP1iOLHm3XMSX7jyaSe2neeOCygfCkJ'),
(113, 1, '0CPoBcq1Nn42mjOFhGO9JIlJ7AuWi1JESAsl5uxwtlk7kWKCx7dDXD57bmBvxEj2Ec7shF8uiYu2e8Y7kdobgWB3s3RoRScDvY3R'),
(114, 2, 'LufuVU0YQvdLvuoRwRLTn4jHBTxZ8bwGDwJvRqGafJQ5CALVQC3aY9kL0qSmHPhggF1RXzHU3J5bcCFWWQJQuAt1pjXiAw8sCu9P'),
(115, 1, 'tgFz4sjfPYyCVpubmHxkSKwPPP0SDN3InveeEJvu4JAzG0gD6iXvQGRypbt2aTpvNSSuc2GWCMAgDHJjg0KzyaKOFAFYviantb0M'),
(116, 1, 'y3e7mQtBgMzS2Ls8zArvASqvZdUxGmxgomyWRCN29sHGg7At15SxokCavwxH4qR1InJ7V1iQOCjsd9TmHCoejURBVX7xvCPedCCU'),
(117, 1, 'MVUAlrOHyXBoqkLIxD7JkrVrlgoB97BTZ2H96McQsbUVMu4xuWoQTzt8VExjoKmCgZgkqZisr7Qku1YBwUHhUy1KxUTujUcq8Tt5'),
(118, 1, '75tdvDTJD0IcWJjn6irrTZutkTHWmFJC1CHeXYxqhQmAnHilvZJRZLc7wAJpZLrzL0wZbxzMOT5PAfV4SvmuielSdYXWbmszDKMv'),
(119, 2, '4z4QmYP7y3FdJ5euzazhGlF5QaUtNVJ6vXPTwuUSlI2wBuNdba7xWKstOr0cBxFBHATHLghOrQcSPOfs91IvFQzNYiCaleI0xBwS'),
(120, 1, 'wFysdSVh69nYFLDCnHlNXr1vM5k8gXFUphgGR6ABksarpbbdeWw6271Eu4ZchFvbboFQ0vRKdj6zEzgDumAYLSeA5CMpt5vlsbes'),
(121, 2, 'UrrAqtF47orN0isQ7wy454jflTAmXCuNOImvCDcGuDRyV0BFSlXVedUdBUyrJUgw13IRId7EdCETNQHu1PGqWOYpNGpGTNB2r9v5'),
(122, 2, 'Ii0Hb5dawsfqNr4BJWI8j0Nk19xYjXqFvO9zbWhI4VCjujuxWM9J6NQpNDjf2qNOv79u8qwYE79MFbGMMowxWBgzgCL8YVt13fzD'),
(123, 2, 'rEm0Al6nHrof0Xhgrz7NR83HnnyS3oJok5Njat5wgexyxewua0Tpi40b9egFrcyj7HIvTverUSGp1i0x5zcmbiey4tBkLgijIEZG'),
(124, 1, '9qG5Goxp4pEE7DS6bs1uGAmEv92aBturT19E1wFKD21ROQY5TylbQbHnnEP8ClLME2zoqZv1jWtfDgBLs5fOE70Y0VKVMH4Kdab9'),
(125, 1, 'QqJx60HD9ncppAunHh5SrQsa4dnAAOyEITj55XO5xwKlJFdhb3WPdCmxJ1uP9vmy094yJDtKvxBZce2ARSAadzvaF9EkYnxJyfzN'),
(126, 1, 'Rg9uOW2Nny7SvDUwCwjUWSrfll9DHIcXIiManadyde6L7Z0MVufM0q9QAlL9qH3bvDLAdNdrpBOkrSMz71PXwULJXwnMQ8IxhLc6'),
(127, 2, 'MzY3sBX46pDcSxsXOlL0b8Dd9alx9hVwUiimYBvRxdfrhnHAGLK39Z2nAonkJB4sBBKlEeW55FJXj60kYxMXPgkF0qp10vYxeBzS'),
(128, 3, 'ASL8UWaNwx9YV5JppquVi9d3IEjlLewHcIsEV4nGey5Se0PVPauTeyWJNTBHm8JSlSBAjiwsZUV2L72A99moXVFw6Tc4Lm2OFI6f'),
(129, 1, 'Jzoy6K0f4hDnk50bc9fAOYAJdHl3W8WSsL8CJoTMgKbIFsfzfapfkqmUz6vP12wBBHcklWGsuxbcvVbzDS4r0NaQmaSwNu0U6N79'),
(130, 1, '8VtIPeu9dVp7GWbsZEv3e6zXVW3YcoKOOOkMXscNl03J3mceYDNdOUQoXjurdGBhHnTufjMw6zqq98RHVHh7Bng9pSSXhQSE1d57'),
(131, 1, 'PmlQpX806IHELQGuC1e2FOMAw8VVd4iX7xnhNk9RqbTyLMfkWcfYFjtSbm5RuzxZMfeoGPXioM2xsdo2WV3ofnSjVKVKwJ2ap8cK'),
(132, 1, 'p7A2ABDyUlvz2qb4KJ82xh3hzKEwOODcIixtSQIMTTqqkY0weiWlyANDKOo1haLXqUG81NP1zSOwFb7NaRzTFkWCgQZ5zotWiqAP'),
(133, 2, '5jHMO9wl6UIovINe7DjL6jdeO3nVfa7TLfVwd7hqGMx8A2sNMB4AnlsvO0PrNnQ4rwep8TNwWybPRaNAfMTClTroJ5cUv6kVGMf0'),
(134, 1, 'yeHwtkKwHEjYdzwfPshGiYkWDNgbuBhfG4oUIZjLBISfDDKALUYEHZexjQ7tZH4XhnE8S1PhmFX5iUC59AA6tyHUrtzf9lpALFqs'),
(135, 1, 'u36ZA4PyvwnU73nzp6k02DGfTBUflQXTMHB3e8KUiAMXN1Cyvwq2NFAYlSkEnPOOkfKrBfmhPeAcq3EvkjcKXL6Da5OHJpfvaUrn'),
(136, 1, 'HliZqgndpMbe1uFLVbVr7qRw7q4Lf6bcy96Kc4C4tSh5oeetL5eDXwOZVrm3AJgtUo5SaYn2htuS0TQTO9e6uyRcIWQ49JeN5yJ4'),
(137, 1, '2UD8yFEFqSCWLqRGRX4sqlaaceZOHSC4SywDcBbJmxSWqBvxE2MW8gMbIq06jYHqCMkimbZGZ743ZPXCFpdA1AGifYjV6UZXH30W'),
(138, 2, 'ulJQHJfEJJLOgkutsIceNUEUbhV8R8OFxHa5kJU3duSCtjlTkp4PxeSJEQyvPVMg3JBLjFuXxDTsca8q8gjUQot1aXmrbRWQQ3Gk'),
(139, 1, 'M6BenHf0vbKKDNqVeyMsuFfhfQfd8bI2hZm2YGfWw4y4NPFz4SyFnegijplhQwkDEYi3gOuri0bRITqH8uBFnoTBucSeUOglGl63'),
(140, 1, 'vr4UmoxynGkC2bj5yBbvJAUblkKKkd4r6O57o10EQuGOPBORFc2446hOgwkx0gRow0q5ZkQNFUGztqM1ImWAPJ1q1E6XkZ0NpzVb'),
(141, 1, 'VaC6XjkoIPLjyKyO2cqZyDnv9e1GgD9yyhJBj9fzFBpxNM3xK24UzfA2Q0rPdUCHhPkM19XAnzOkLiUimOW2ZWCgBreCfsH7eNZF'),
(142, 1, 'avhSd7TX64hePuafBNZVREKbRCLeRay9QdJ2VaO7IFGmynXsnDCvQEV04TxQ0FM1kZrBC2pDsSVOToNTR0dYFeuiAupIk5X5FNz2'),
(143, 1, 'bfQdOvpdLIbpFpEqMo9Vv29J2o52ildDR3QgSBZUgLIDBotnUkmLR45lYTmJPFnXFYRB8nRuIRXQCoAcWmLZElWOPeggU6aRX7JC'),
(144, 2, 'fyBQJHo6vWcShmxrPzEJMUUel2SoInDMjBF00419jxhfRBWo4goixGags5qp1CzXUVBoBkw1Q5T9qqg8Aqd2GiSOaKuCE0Yrrd8F'),
(145, 1, 'i489aLLGSYoDp04yELnaf9KKp3Phl0eH3q748xfP0jSZM8i2qq1mREtuSpMIVaGREHMOVUi1iEKfHoTQnIDkCVSPAuJ9ZyM4ce3J'),
(146, 1, 'KBIHeJaXWpcrYYxY4TgdK1IotXXrPtxFTRaP7a3EHAM2IXn6IdL1SITMk7Hxo77Bs5K1iB4LRNuEArjlMZIkSpQD5vqZDgU0Mc1r'),
(147, 1, 'AbRUGMz8ZV5zux5VXTAR1SWNvjvOxyG0waNa9CiRQ3hR43biE7iE71WPfLlhTdWoxOrhgX7VU2oomvAxE01lxjiEdeCfEyNV7ix0'),
(148, 1, 'vqJtVkDo63zTs0IWvjwYSrxYFM9sWHZ4eflAw79GFLaH5zg4Qn53yMX2qDqa0hk9y8at8KACMeLiCombw4w2E7eaILNxzr8ctGqj'),
(149, 5, '8WS6McBZcJ2jQoW14Ic1uMAQCyHFuTNr6kTzUmH9DjlqikuSNllvBygYFEZ5FfLckk1Vo7poIX9HBs6ztp5wy8KXporMesCmrGq6'),
(150, 1, 'M05kkdepbiILeAcFZKGTyvd2DPFwTwu7Z85hqNQqI8D6J7EDCXlvc36f2xxQLufueDIBAc5H4t3SuUY2M7EjZi3ZOSuUc2EY1buj'),
(151, 2, 'bAIoWWpFXaKFri2AaLpDvGm7bBTZV3cpPXUMq9DfTpscnMJPgVCCXIPrfXiA0cQW6hhZVV6xeTRcQfOkS5OMaUpvSQGD7QM9th7H'),
(152, 1, 'IJsx7FBueMKbIOqaugNykkFx1afMoR7my8GJVJBill3Lt5VJgxmO8UoqbyosydKmnzcjb0cq1D4tPHsn5ZleHPQ8rdy0TNBtg83x'),
(153, 1, 'c35Jbo3V6dMIWfPKrmEN3W5BY3SaZAC0XIOl3TzJFdIajo7nXCFHYQVPnEVRvBRApPgSQUvHZLquDjG4CV5MSO4g3Ii4wdF1dDoi'),
(154, 6, 'qf1UFzgan8qPBF8PfM4a4hFBhbS99esynbi1TZzWeVKhB2NCgdpNiNvlBwHqiu5z48LM4p95wHEnKfDtUcqJyZmWI1M927hagbfa'),
(155, 7, '0VH1wtzguf4AR3Hkjr1XkdwOm14TSV2Kqf5FU102eNAfEAroy8jc9FybJvjhkLFqlfbgWwe7ur9V6lqmMXnkNjXCqcgRrI2pxrH0'),
(156, 7, 'ZAGpl4euW3vGxAYz9GyR6pC90wgoBiXQrdOF6EryeDscownFqjxs04NcaVhZCZQn09mRVEve1ovjElAawFmiC2gQ9dD7lTpZBSS9'),
(157, 1, 'hExJjsxkiYQGu3lpOkFLoiPktKoOqAM59Mt6a2QmyrQiLxvoTkSlm8Pcv5p4Yfwp7EpxDXRpkZEWsT5kG3WFBDNvuoSabuH0T0sw');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` int(3) NOT NULL,
  `name` varchar(128) NOT NULL,
  `kategori` varchar(13) NOT NULL,
  `brand` varchar(13) NOT NULL,
  `spec` varchar(600) NOT NULL,
  `price` int(12) NOT NULL,
  `image` varchar(128) NOT NULL,
  `storage` varchar(15) NOT NULL,
  `color` varchar(15) NOT NULL,
  `rating` varchar(2) NOT NULL,
  `front_camera` varchar(30) NOT NULL,
  `back_camera` varchar(30) NOT NULL,
  `processor` varchar(50) NOT NULL,
  `ukuran_layar` varchar(10) NOT NULL,
  `kamera_wideangle` varchar(10) NOT NULL,
  `kamera_telephoto` varchar(10) NOT NULL,
  `kamera_depth` varchar(10) NOT NULL,
  `sistem_operasi` varchar(50) NOT NULL,
  `baterai` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id`, `name`, `kategori`, `brand`, `spec`, `price`, `image`, `storage`, `color`, `rating`, `front_camera`, `back_camera`, `processor`, `ukuran_layar`, `kamera_wideangle`, `kamera_telephoto`, `kamera_depth`, `sistem_operasi`, `baterai`) VALUES
(1, 'Xiaomi 14T ', 'Handphone', 'Xiaomi', 'Ukuran layar: 6.67 inch, AMOLED, 2712 x 1220 pixel, 144Hz\r\nMemori: RAM 12 GB, ROM 512 GB\r\nSistem operasi: Android 14, HyperOS 1.05\r\nCPU: Mediatek Dimensity 8300 Ultra (4 nm)\r\nGPU: Mali-G615 MC6\r\nNetwork : 5G\r\nKamera Belakang : Triple 50 MP, f/1.7, 23mm (wide); 50 MP, f/1.9, 50mm (telephoto); 12 MP, f/2.2, 15mm (ultrawide)\r\nKamera Depan : 32 MP, f/2.0, 25mm (wide)\r\nSIM: Dual SIM (Nano-SIM + Nano-SIM)\r\nBaterai: 5000 mAh, 67W wired\r\nBerat: 195 gr\r\nGaransi Resmi', 6999000, 'xiaomi14t.jpg', '12GB/512GB', 'Gold', '5', '32 MP', '50 MP', 'Mediatek Dimensity 8300 Ultra (4 nm)', '6.67 Inch', '12 MP', '50 MP', '-', 'Android 14, HyperOS 1.05', '5000 mAh'),
(2, 'Vivo X Fold 3', 'Handphone', 'Vivo', 'Ukuran Layar Utama: 8,03 inch AMOLED 2200 x 2480 Pixel 120Hz\r\nUkuran Layar Cover: 6,53 inch AMOLED 1172 x 2748 Pixel 120Hz\r\nMemori: RAM 16 GB, ROM 512 GB\r\nSistem operasi: Android 14, Funtouch OS 14\r\nCPU: Qualcomm Snapdragon 8 Gen 2 (4 nm)\r\nGPU : Adreno 740\r\nNetwork : 5G\r\nKamera Belakang: Triple 50 MP, f/1.75, 23mm (wide), 50 MP, f/1.85, 70mm (periscope telephoto) & 50 MP, f/2.0, 119˚ (ultrawide)\r\nKamera Depan: 32 MP, f/2.4, (wide)\r\nKamera Cover: 32 MP, f/2.4, (wide)\r\nSIM: Dual SIM (Nano-SIM)\r\nBaterai: 5500 mAh, 80W wired\r\nBerat: 219 gram\r\nGaransi Resmi', 26999000, 'vivoxfold3.jpg', '16GB/512GB', 'Black', '5', '32 MP', '50 MP', 'Qualcomm Snapdragon 8 Gen 2 (4 nm)', '8.03 Inch', '50 MP', '50 MP', '-', 'Android 14, Funtouch OS 14', '5500 mAh'),
(3, 'Vivo X200 Pro', 'Handphone', 'Vivo', 'Ukuran layar: 6.78 inch, AMOLED, 2800 x 1260 pixel, 120Hz\r\nMemori: RAM 12 GB, ROM 256 GB\r\nSistem Operasi: Android 15, Funtouch 15\r\nCPU: Mediatek Dimensity 9400 (3 nm)\r\nGPU: Immortalis-G925\r\nNetwork : 5G\r\nKamera Belakang: Triple Camera 50 MP, f/1.6, 23mm (wide), 200 MP, f/2.6, 70mm (periscope telephoto), 50 MP, f/2.0, 15mm, 119˚ (ultrawide)\r\nKamera Depan : 32 MP, f/2.0, 20mm (ultrawide)\r\nSIM: Dual SIM (Nano-SIM)\r\nBaterai: 6000 mAh, 90W wired 30W wireless\r\nBerat: 197 gr\r\nGaransi Resmi', 17999000, 'vivox200pro.jpg', '12GB/256GB', 'Gold', '5', '32 MP', '50 MP', 'Mediatek Dimensity 9400 (3 nm)', '6.78 Inch', '50 MP', '200 MP', '-', 'Android 15, Funtouch 15', '6000 mAh'),
(4, 'Apple iPhone 16', 'Handphone', 'Apple', 'Ukuran layar: 6.1 inch, Super Retina XDR OLED Ceramic Shield Glass, 2556 x 1179 pixel, 60Hz\r\nMemori: RAM 8 GB, ROM 128 GB\r\nSistem Operasi: iOS 18\r\nCPU: Apple A18 (3 nm)\r\nNetwork : 5G\r\nKamera Belakang: Dual 48 MP, f/1.6, 26mm (wide), 12 MP, f/2.2, 13mm, 120˚ (ultrawide)\r\nKamera Depan : 12 MP, f/1.9\r\nSIM: Dual SIM (Nano-SIM & eSIM)\r\nBaterai: 3561 mAh, 25w PD 2.0\r\nBerat: 170 gr\r\nGaransi Resmi', 12499000, 'iphone16.jpg', '128GB', 'Blue', '5', '12 MP', '48 MP', 'Apple A18', '6.1 Inch', '12 MP', '-', '-', 'iOS 18', '3561 mAh'),
(5, 'Oppo Find X8 Pro', 'Handphone', 'Oppo', 'Ukuran layar: 6.78 inch, AMOLED, 2780 x 1264 pixel, 120Hz\r\nMemori: RAM 16 GB, ROM 512 GB\r\nSistem Operasi: Android 15, ColorOS 15\r\nCPU: Mediatek Dimensity 9400 (3 nm)\r\nGPU: Immortalis-G925\r\nNetwork : 5G\r\nKamera Belakang: Quad 50 MP, f/1.6, 23mm (wide), 50 MP, f/2.6, 73mm (periscope telephoto), 50 MP, f/4.3, 135mm (periscope telephoto), 50 MP, f/2.0, 15mm, 120˚ (ultrawide)\r\nKamera Depan : 32 MP, f/2.4, 21mm (ultrawide)\r\nSIM: Dual SIM (Nano-SIM + eSIM)\r\nBaterai: 5910 mAh, 80W wired 50W wireless\r\nBerat: 215 gr\r\nGaransi Resmi', 19999000, 'oppofindx8.jpg', '16GB/512GB', 'White', '5', '32 MP', '50 MP', 'Mediatek Dimensity 9400 (3 nm)', '6.78 Inch', '50 MP', '50 MP', '50 MP', 'Android 15, ColorOS 15', '5910mAh'),
(6, 'Oppo Find N3 Fold', 'Handphone', 'Oppo', 'Ukuran Layar Utama: 7,82 inch OLED 2268 x 2440 Pixel 120Hz\r\nUkuran Layar Cover: 6,31 inch OLED 1116 x 2484 Pixel 120Hz\r\nMemori: RAM 16 GB, ROM 512 GB\r\nSistem Operasi: Android 14, ColorOS 14\r\nCPU: Qualcomm Snapdragon 8 Gen 2 (4 nm)\r\nGPU: Adreno 740\r\nNetwork : 5G\r\nKamera Belakang: Triple 48 MP, f/1.7, 24mm (wide), 64 MP, f/2.6, 70mm (telephoto), 48 MP, f/2.2, 14mm, 114˚ (ultrawide)\r\nKamera Depan : 32 MP, f/2.4, 22mm (ultrawide)\r\nSIM: Dual SIM (Nano-SIM + eSIM)\r\nBaterai: 4805 mAh, 67W wired\r\nBerat: 239 gr\r\nGaransi Resmi', 16750000, 'oppon3fold.jpg', '16GB/512GB', 'Black', '5', '32 MP', '48 MP', 'Qualcomm Snapdragon 8 Gen 2 (4 nm)', '7.82 Inch', '48 MP', '64 MP', '-', 'Android 14, ColorOS 14', '4805 mAh'),
(7, 'Tecno Phantom V Flip', 'Handphone', 'Tecno', 'Ukuran layar Utama : 6.9 inch, AMOLED, 1080 x 2640 pixel, 120Hz\r\nUkuran layar Cover : 1.32 inch, AMOLED, 466 x 466 pixel, 60Hz\r\nMemori: RAM 8 GB, ROM 256 GB\r\nSistem Operasi: Android 13, HIOS 13.5\r\nCPU: Mediatek Dimensity 8050 (6 nm)\r\nGPU: Mali-G77 MC9\r\nNetwork : 5G\r\nKamera belakang: Dual 64 MP, f/1.7, 25mm (wide); 13 MP, f/2.2, (ultrawide)\r\nKamera depan: 32 MP, f/2.45, 24mm (wide)\r\nSIM: Single SIM (Nano-SIM)\r\nBaterai: 4000 mAh, 45W wired\r\nBerat: 194 gr\r\nGaransi Resmi', 4999000, 'panthomvflip.jpg', '8GB/256GB', 'Purple', '5', '32 MP', '64 MP', 'Mediatek Dimensity 8050 (6 nm)', '6.9 Inch', '13 MP', '-', '-', 'Android 13, HIOS 13.5', '4000 mAh'),
(8, 'Tecno Camon 20 Premier', 'Handphone', 'Tecno', 'Ukuran layar: 6.67 inch, 1080 x 2400 pixels, AMOLED, 120Hz\r\nMemori: RAM 8 GB, ROM 256 GB\r\nSistem operasi: Android 13, HIOS 13\r\nCPU: Mediatek Dimensity 8050 (6 nm)\r\nGPU: Mali-G77 MC9\r\nNetwork : 5G\r\nKamera belakang: Triple 50 MP, f/1.8, (wide); 108 MP, f/2.2, 13mm, 115˚(ultrawide); 2 MP, f/2.4, (depth)\r\nKamera depan: 32 MP, f/2.5, 24mm (wide)\r\nSIM: Dual SIM (Nano-SIM, dual stand-by)\r\nBaterai: 5000 mAh, 45W wired\r\nBerat: 193 gram\r\nGaransi Resmi', 5499000, 'camon20premiere.jpg', '8GB/256GB', 'Blue', '5', '32 MP', '50 MP', 'Mediatek Dimensity 8050 (6 nm)', '6.67 Inch', '108 MP', '-', '2 MP', 'Android 13, HIOS 13', '5000 mAh'),
(9, 'Apple iPhone 15 Pro Max', 'Handphone', 'Apple', 'Ukuran layar: 6.7 inch, OLED, 2556 x 1179 pixel, 120Hz\r\nMemori: RAM 8 GB, ROM 512 GB\r\nSistem Operasi: iOS 18\r\nCPU: Apple A18 (3 nm)\r\nNetwork : 5G\r\nKamera Belakang: Triple 48 MP, f/1.78 24 mm(main), 12 MP, f/2.8, 120mm (periscope telephoto), 12 MP, f/2.2, 120˚ (ultrawide)\r\nKamera Depan : 12 MP, f/1.9 23mm\r\nSIM: Dual SIM (Nano-SIM & eSIM)\r\nBaterai: 4441 mAh, 15w PD 2.0\r\nBerat: 221 gr\r\nGaransi Resmi', 22999000, 'iphone15promax.jpg', '512GB', 'Titanium', '5', '12 MP', '48 MP', 'Apple A17 Pro', '6.7 Inch', '12 MP', '12 MP', '-', 'iOS 18', '4441 mAh'),
(10, 'Samsung Galaxy Z Flip 6', 'Handphone', 'Samsung', 'Ukuran layar Utama : 6.7 inch, AMOLED, 2640 x 1080 pixel, 120Hz\r\nUkuran layar Cover : 3.4 inch, Super AMOLED, 720 x 748 pixel, 60Hz\r\nMemori: RAM 12 GB, ROM 256 GB\r\nSistem Operasi: Android 15, One UI 7.0\r\nCPU: Qualcomm Snapdragon 8 Gen 3 (4 nm)\r\nGPU: Adreno 750\r\nNetwork : 5G\r\nKamera belakang: Dual 50 MP, f/1.8, 23mm (wide); 12 MP, f/2.2, 13 mm, 123˚ (ultrawide)\r\nKamera depan: 10 MP, f/2.2, 23mm (wide)\r\nSIM: Dual SIM (Nano-SIM + eSIM)\r\nBaterai: 4000 mAh, 25W wired, 15W wireless\r\nBerat: 187 gr\r\nGaransi Resmi', 14499000, 'zflip6.jpg', '12GB/256GB', 'Blue', '5', '10 MP', '50 MP', 'Qualcomm Snapdragon 8 Gen 3 (4 nm)', '6.7 Inch', '12 MP', '-', '-', 'Android 15, One UI 7.0', '4000 mAh'),
(11, 'Samsung Galaxy S25 Ultra', 'Handphone', 'Samsung', 'Ukuran layar: 6.9 inch, AMOLED, 1440 x 3120 pixel, 120Hz\r\nMemori: RAM 12 GB, ROM 256 GB\r\nSistem Operasi: Android 15, OneUI 7.0\r\nCPU: Snapdragon 8 Elite (3 nm)\r\nGPU: Adreno 830\r\nNetwork : 5G\r\nKamera Belakang: Quad 200 MP, f/1.7, 24mm (wide), 50 MP, f/3.4, 111mm (periscope telephoto), 10 MP, f/2.4, 67mm (telephoto), 50 MP, f/1.9, 120˚ (ultrawide)\r\nKamera Depan : 32 MP, f/2.4, 21mm (ultrawide)\r\nSIM: Dual SIM (Nano-SIM + Nano-SIM)\r\nBaterai: 5000 mAh, 45W wired 15W wireless\r\nBerat: 218 gr\r\nGaransi Resmi', 22999000, 's25ultra.jpg', '12GB/256GB', 'Silver', '5', '12 MP', '200 MP', 'Qualcomm Snapdragon Elite (3 nm)', '6.9 Inch', '50 MP', '50 MP', '10 MP', 'Android 15, OneUI 7.0', '5000 mAh'),
(12, 'Xiaomi Redmi Note 14 Pro Plus', 'Handphone', 'Xiaomi', 'Ukuran layar: 6.67 inch, AMOLED, 1220 x 2712 pixel, 120Hz\r\nMemori: RAM 8 GB, ROM 256 GB\r\nSistem Operasi: Android 14, HyperOS 1.02\r\nCPU: Qualcomm Snapdragon 7s Gen 3 (4 nm)\r\nGPU: Adreno 710\r\nNetwork : 5G\r\nKamera Belakang: Triple 50 MP, f/1.6, 24mm (wide), 50 MP, f/2.0, 60mm (telephoto), 8 MP, f/2.2, 15mm, 120˚ (ultrawide)\r\nKamera Depan : 20 MP, f/2.2, 21mm (wide)\r\nSIM: Dual SIM (Nano-SIM + Nano-SIM)\r\nBaterai: 6200 mAh, 90W wired\r\nBerat: 205 gr\r\nGaransi Resmi', 5999000, 'note14pro+.jpg', '8GB/256GB', 'Purple', '5', '20 MP', '50 MP', 'Qualcomm Snapdragon 7s Gen 3 (4 nm)', '6.67 Inch', '8 MP', '50 MP', '-', 'Android 14, HyperOS 1.02', '6200 mAh'),
(13, 'Huawei MateBook D14 i5 13G\r\n', 'Laptop', 'Huawei', 'Ukuran layar: 14 inch, 1920 × 1200 pixel, IPS, 300 nits\r\nMemori: RAM 16 GB LPDDR4X, ROM SSD 512 GB NVMe PCIe\r\nSistem Operasi : Windows 11 Home\r\nProsesor: 13th Gen Intel Core i5-13420H\r\nGPU: Intel UHD Graphics\r\nKamera Depan : 1MP (720p HD)\r\nBaterai : 56 Wh, Charger USB-C 65W\r\nBerat: 1.39 kg\r\nGaransi Resmi', 8999000, 'huaweimatebookd1413g.jpg', '16GB/512GB', 'Silver', '5', '1 MP (720p HD)', '-', 'Intel Core i5-13420H', '14 Inch', '-', '-', '-', 'Windows 11 Home', '56 Wh'),
(14, 'Huawei MateBook D14 i5 12G', 'Laptop', 'Huawei', 'Ukuran layar: 14 inch, 1920 × 1200 pixel, IPS, 300 nits\r\nMemori: RAM 8 GB LPDDR4X, ROM SSD 512 GB NVMe PCIe\r\nSistem Operasi : Windows 11 Home\r\nProsesor: 12th Gen Intel Core i5-12450H\r\nGPU: Intel Iris Xe Graphics\r\nKamera Depan : 1MP (720p HD)\r\nBaterai : 56 Wh, Charger USB-C 65W\r\nBerat: 1.39 kg\r\nGaransi Resmi', 10499000, 'huaweimatebookd1412g.jpg', '8GB/512GB', 'Silver', '5', '1 MP (720p HD)', '-', 'Intel Core i5-12450H', '14 Inch', '-', '-', '-', 'Windows 11 Home', '56 Wh'),
(15, 'Huawei MateBook X Pro 2021', 'Laptop', 'Huawei', 'Ukuran layar: 13.9 inch, 3000 × 2000 pixel, Touchscreen, 450 nits\r\nMemori: RAM 16 GB LPDDR4X, ROM SSD 1 TB NVMe PCIe\r\nSistem Operasi : Windows 10 Home\r\nProsesor: 11th Gen Intel Core i7-1165G7\r\nGPU: Nvidia Geforce MX250\r\nKamera Depan : 1MP (720p HD)\r\nBaterai : 56 Wh, Charger USB-C 65W\r\nBerat: 1.33 kg\r\nGaransi Resmi', 30999000, 'huaweixpro2021.jpg', '16GB/1TB', 'Grey', '5', '1 MP (720p HD)', '-', 'Intel Core i7-1165G7', '13.9 Inch', '-', '-', '-', 'Windows 10 Home', '56 Wh'),
(16, 'Huawei Matebook X Pro 2022', 'Laptop', 'Huawei', 'Ukuran layar: 14.2 inch, 3120 × 2080 pixel, LTPS, Touchscreen, 500 nits, 90 Hz\r\nMemori: RAM 16 GB LPDDR4X, ROM SSD 1 TB NVMe PCIe\r\nSistem Operasi : Windows 11 Home\r\nProsesor: 12th Gen Intel Core i7-1260P\r\nGPU: Intel Iris Xe Graphics\r\nKamera Depan : 1MP (720p HD)\r\nBaterai : 60 Wh, Charger USB-C 90W\r\nBerat: 1.26 kg\r\nGaransi Resmi\r\n', 32999000, 'huaweimatebookxpro2022.jpg', '16GB/1TB', 'Blue', '5', '1 MP (720p HD)', '', 'Intel Core i7-1260P', '14.2 Inch', '', '', '', 'Windows 11 Home', '60 Wh'),
(17, 'LG QNED SMART TV 98 INCH', 'Television', 'LG', 'Ukuran: 98 Inch\r\nWarna: Hitam\r\nBerat: 61,2 Kg\r\nSistem Operasi: webOS 24\r\nFitur: Α8 AI SOUND PRO\r\nAudio Input & Output: Ya\r\nBuilt-In I/O - AV In: Ya\r\nBuilt-In I/O - HDMI/HDCP Input: Ya\r\nBuilt-In I/O - LAN: Ya\r\nBuilt-In I/O - PC Audio Input: Ya\r\nBuilt-In Speaker: Ya\r\nBuilt-In I/O - USB 2.0: Ya\r\nTipe Layar: 4K QNED\r\nResolusi Max: 4K ULTRA HD (3,840 X 2,160)\r\nKonsumsi Daya: 366 W\r\nDimensi : 2182mm x 1258mm x 110mm\r\nSistem Speaker: 2.2 CH\r\nSistem Surround : Α8 AI SOUND PRO (VIRTUAL 9.1.2)\r\nVoltase: 100-240V 50-60Hz', 44899000, 'lg98inch.jpeg', '-', 'Black', '5', '-', '-', '-', '98 Inch', '-', '-', '-', 'webOS 24', '-'),
(18, 'LG UHD SMART TV 55 INCH', 'Television', 'LG', 'Ukuran: 55 Inch\r\nWarna: Hitam\r\nBerat: 14 Kg\r\nSistem Operasi: webOS 23\r\nFitur: a5 AI Processor 4K Gen 6\r\nAudio Input & Output: Ya\r\nBuilt-In I/O - AV In: Ya\r\nBuilt-In I/O - HDMI/HDCP Input: Ya\r\nBuilt-In I/O - LAN: Ya\r\nBuilt-In I/O - PC Audio Input: Ya\r\nBuilt-In Speaker: Ya\r\nBuilt-In I/O - USB 2.0: Ya\r\nTipe Layar: 4K UHD\r\nResolusi Max: 4K ULTRA HD (3,840 X 2,160)\r\nKonsumsi Daya: 101 W\r\nDimensi : 1235mm x 715mm x 57mm\r\nSistem Speaker: 2.0 CH\r\nSistem Surround : AI SOUND (Virtual 5.1 Up-mix)\r\nVoltase: AC 100 - 240V 50-60Hz', 6899000, 'lg55inch.jpeg', '-', 'Black', '5', '-', '-', '-', '55 Inch', '-', '-', '-', 'webOS 23', '-'),
(19, 'LG QNED SMART TV 65 INCH', 'Television', 'LG', 'Ukuran: 65 Inch\r\nWarna: Hitam\r\nBerat: 22,5 Kg\r\nSistem Operasi: webOS 24\r\nFitur: a5 AI Processor 4K Gen 7\r\nAudio Input & Output: Ya\r\nBuilt-In I/O - AV In: Ya\r\nBuilt-In I/O - HDMI/HDCP Input: Ya\r\nBuilt-In I/O - LAN: Ya\r\nBuilt-In I/O - PC Audio Input: Ya\r\nBuilt-In Speaker: Ya\r\nBuilt-In I/O - USB 2.0: Ya\r\nTipe Layar: 4K QNED\r\nResolusi Max: 4K ULTRA HD (3,840 X 2,160)\r\nKonsumsi Daya: 175 W\r\nDimensi: 1456mm x 840mm x 30mm\r\nSistem Speaker: 2.0 CH\r\nSistem Surround: AI SOUND PRO (Virtual 9.1.2 Up-mix)\r\nVoltase: AC 100-240V 50-60Hz', 13599000, 'lg65inchqned.jpeg', '-', 'Black', '5', '-', '-', '-', '65 Inch', '-', '-', '-', 'webOS 24', '-'),
(20, 'LG UHD SMART TV 86 INCH', 'Television', 'LG', 'Ukuran: 86 Inch\r\nWarna: Hitam\r\nBerat: 45,2 Kg\r\nSistem Operasi: webOS 24\r\nFitur: α5 AI Processor 4K Gen7\r\nAudio Input & Output: Ya\r\nBuilt-In I/O - AV In: Ya\r\nBuilt-In I/O - HDMI/HDCP Input: Ya\r\nBuilt-In I/O - LAN: Ya\r\nBuilt-In I/O - PC Audio Input: Ya\r\nBuilt-In Speaker: Ya\r\nBuilt-In I/O - USB 2.0: Ya\r\nTipe Layar: 4K UHD\r\nResolusi Max: 4K ULTRA HD (3,840 X 2,160)\r\nKonsumsi Daya: 279 W\r\nDimensi : 1927mm x 1104mm x 60mm\r\nSistem Speaker: 2.0 CH\r\nSistem Surround : AI SOUND PRO (VIRTUAL 9.1.2 Up-mix)\r\nVoltase: 100-240V 50-60Hz', 29999000, 'lg86inch.jpeg', '-', 'Black', '5', '-', '-', '-', '86 Inch', '-', '-', '-', 'webOS 24', '-');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `id` int(13) NOT NULL,
  `user_id` int(13) NOT NULL,
  `no_seri` varchar(35) NOT NULL,
  `perangkat` varchar(35) NOT NULL,
  `merek_perangkat` varchar(128) NOT NULL,
  `pelayanan` varchar(35) NOT NULL,
  `jenis_kerusakan` varchar(35) NOT NULL,
  `detail_kerusakan` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `user_id`, `no_seri`, `perangkat`, `merek_perangkat`, `pelayanan`, `jenis_kerusakan`, `detail_kerusakan`) VALUES
(1, 3, 'k781231', 'TV', 'LG', 'Garansi', 'Layar retak', 'Layar Retak'),
(2, 3, 'KA7812313', 'Smartphone', 'LG', 'Perbaikan', 'Servis baterai', 'Baterai Bocor'),
(3, 3, 'KA7812313', 'Smartphone', 'Samsung', 'Perbaikan', 'Layar retak', 'Layar retak Dan tidak bisa digunakan lagi'),
(4, 1, '21423423', 'Laptop', 'HJJHKJHK', 'Garansi', 'Servis baterai', 'SDFSDF'),
(5, 1, '2342121141', 'Laptop', 'Huawei', 'Garansi', 'Servis baterai', 'Baterai bocor'),
(6, 1, '213124121', 'Laptop', 'Huawei', 'Garansi', 'Servis baterai', 'Baterai bocor, ketika digunakan baterai sangat boros'),
(7, 1, '6889668876', 'Smartphone', 'lenovo', 'Garansi', 'Layar retak', 'layar retak'),
(8, 6, '4635646', 'Smartphone', 'Samsung', 'Perbaikan', 'Tombol tidak berfungsi', 'Tombol rusak'),
(9, 7, '9880312002362054', 'Smartphone', 'Samsung', 'Garansi', 'Layar retak', 'rusak'),
(10, 7, '128272827', 'Laptop', 'Samsung', 'Perbaikan', 'Kamera tidak berfungsi', 'rusak');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_token`
--
ALTER TABLE `member_token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_token_ibfk_1` (`member_id`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `member_token`
--
ALTER TABLE `member_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` int(13) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `member_token`
--
ALTER TABLE `member_token`
  ADD CONSTRAINT `member_token_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
