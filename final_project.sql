-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 28, 2021 at 02:06 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `final_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `body_size`
--

CREATE TABLE `body_size` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `create_at` text NOT NULL,
  `update_at` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `body_size`
--

INSERT INTO `body_size` (`id`, `name`, `create_at`, `update_at`) VALUES
(1, 'ไม่ระบุ', '', ''),
(2, 'เล็ก', '', ''),
(3, 'กลาง', '', ''),
(4, 'ใหญ่', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name_category` text NOT NULL,
  `create_at` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name_category`, `create_at`) VALUES
(1, 'ทั่วไป', ''),
(2, 'กิจกรรม', ''),
(3, 'ปัญหา', '');

-- --------------------------------------------------------

--
-- Table structure for table `category_news`
--

CREATE TABLE `category_news` (
  `id` int(11) NOT NULL,
  `news_category` text NOT NULL,
  `create_at` text NOT NULL,
  `update_at` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category_news`
--

INSERT INTO `category_news` (`id`, `news_category`, `create_at`, `update_at`) VALUES
(4, 'ทั่วไป', '', ''),
(5, 'ประกาศ', '', ''),
(6, 'กิจกรรม', '', ''),
(7, 'สูญหาย', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `category_pets`
--

CREATE TABLE `category_pets` (
  `id` int(11) NOT NULL,
  `name_category` text NOT NULL,
  `create_at` text NOT NULL,
  `update_at` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category_pets`
--

INSERT INTO `category_pets` (`id`, `name_category`, `create_at`, `update_at`) VALUES
(7, 'หมา', '', ''),
(8, 'แมว', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `comments` text NOT NULL,
  `author_post` text NOT NULL,
  `user_email` text NOT NULL,
  `post_id` text NOT NULL,
  `comments_date` text NOT NULL,
  `isSeen` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`id`, `comments`, `author_post`, `user_email`, `post_id`, `comments_date`, `isSeen`) VALUES
(1, 'สวยมาก', 'admin', 'ooooo', '1', '10:30', '0'),
(2, 'popteen', 'ooooo', 'poptype', '2', '11:26', '1'),
(3, 'popteen', 'ooooo', 'poptype', '2', '11:26', '1'),
(4, 'lover', 'ooooo', 'ooooo', '2', '05:12', '1'),
(5, 'asdasdw', 'poptype', 'ooooo', '1', '08:41', '0'),
(6, 'loveer', 'ooooo', 'ooooo', '2', '09:07', '1'),
(7, 'mklmkl', 'ooooo', 'ooooo', '2', '10:58', '1'),
(8, 'what', 'admin', 'ooooo', '10', '10:59', '0'),
(9, 'พี่', 'admin', 'ooooo', '10', '10:06', '0'),
(10, 'love', 'ooooo', 'ooooo', '2', '07:11', '1'),
(11, 'สง', 'alluser', 'alluser', '12', '09:36', '0');

-- --------------------------------------------------------

--
-- Table structure for table `commentspets`
--

CREATE TABLE `commentspets` (
  `id` int(11) NOT NULL,
  `comments` text NOT NULL,
  `author_pets` text NOT NULL,
  `user_email` text NOT NULL,
  `pets_id` text NOT NULL,
  `comments_date` text NOT NULL,
  `isSeen` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `commentspets`
--

INSERT INTO `commentspets` (`id`, `comments`, `author_pets`, `user_email`, `pets_id`, `comments_date`, `isSeen`) VALUES
(1, 'น่ารักมาก', 'ooooo', 'poptype', '2', '23/04/2021', '0'),
(2, 'น่ารักมากๆ', 'ooooo', 'ooooo', '', '03:56', '0'),
(3, 'เคยเจอ', 'ooooo', 'ooooo', '7', '03:59', '0'),
(4, 'ภภ', 'poptype', 'ooooo', '2', '07:01', '0'),
(5, 'zz', 'ooooo', 'alluser', '8', '09:34', '0'),
(6, 'asd', 'ooooo', 'alluser', '3', '06:26', '0');

-- --------------------------------------------------------

--
-- Table structure for table `gender_pets`
--

CREATE TABLE `gender_pets` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `create_at` text NOT NULL,
  `update_at` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `gender_pets`
--

INSERT INTO `gender_pets` (`id`, `name`, `create_at`, `update_at`) VALUES
(1, 'ไม่ระบุ', '', ''),
(2, 'ผู้', '', ''),
(3, 'เมีย', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `image_pets`
--

CREATE TABLE `image_pets` (
  `id` int(11) NOT NULL,
  `pathimage` text NOT NULL,
  `id_pets` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `image_pets`
--

INSERT INTO `image_pets` (`id`, `pathimage`, `id_pets`) VALUES
(1, 'pel.jpg', '1'),
(2, 'pexels-maud-slaats-2326936.jpg', '1'),
(3, 'pexels-maud-slaats-2326936.jpg', '2'),
(4, 'pel.jpg', '2'),
(6, 'pet1.jpeg', '3'),
(7, 'cat2.jpeg', '3'),
(8, 'pel.jpg', '4'),
(9, 'cat3.jpeg', '3'),
(10, 'pel.jpg', '5'),
(197, 'JPEG_20210422_025222_532041574253987501.jpg', '6'),
(198, 'JPEG_20210423_002050_1606479645740623460.jpg', '6'),
(199, 'JPEG_20210423_002050_1606479645740623460.jpg', '7'),
(200, 'JPEG_20210422_025222_532041574253987501.jpg', '7'),
(201, 'JPEG_20210422_025414_3085619239932887246.jpg', '7'),
(202, 'JPEG_20210422_025228_1441792618732111183.jpg', '8'),
(203, 'JPEG_20210423_002050_1606479645740623460.jpg', '8'),
(204, 'JPEG_20210422_025228_1441792618732111183.jpg', '9'),
(205, 'JPEG_20210422_025222_532041574253987501.jpg', '9'),
(206, 'JPEG_20210423_002050_1606479645740623460.jpg', '9'),
(207, 'JPEG_20210422_025414_3085619239932887246.jpg', '9'),
(229, 'JPEG_20210428_105725_2458332930422234177.jpg', '11');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `msg_id` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `incoming_msg_id` int(255) NOT NULL,
  `outgoing_msg_id` int(255) NOT NULL,
  `msg` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`msg_id`, `pid`, `incoming_msg_id`, `outgoing_msg_id`, `msg`) VALUES
(1, 3, 1583452248, 1111, 'สวัสดีครับ'),
(2, 3, 1111, 1583452248, 'สวัสดีครับ สนรับน้องไปเลี้ยงหรอครับ'),
(3, 3, 1583452248, 1111, 'แถวหลังมอ'),
(4, 3, 1111, 1583452248, 'น้องนิสัยเป็นยังไงครับ'),
(5, 7, 1583452248, 1111, 'สวัสดีครับ'),
(6, 7, 1111, 1583452248, 'สวัสดีครับ สนรับน้องไปเลี้ยงหรอครับ'),
(7, 7, 1583452248, 1111, 'แถวหลังมอ'),
(8, 7, 1111, 1583452248, 'น้องนิสัยเป็นยังไงครับ');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `admin_id` text NOT NULL,
  `title` text NOT NULL,
  `body` text NOT NULL,
  `category_news` text NOT NULL,
  `update_at` text NOT NULL,
  `created_at` text NOT NULL,
  `pathImagenews` text NOT NULL,
  `Views` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `admin_id`, `title`, `body`, `category_news`, `update_at`, `created_at`, `pathImagenews`, `Views`) VALUES
(1, '4', 'หมาหายหลังมอ', 'หายที่7-11 ตัวใหญ่มากกกก', 'สูญหาย', '', '17/04/2021', 'pop.jpeg', 50),
(2, '4', 'บริจาค', 'บริจาคให้มูลนิธิ โอนเลขที่', 'ทั่วไป', '', '17/04/2021', 'ollll.jpeg', 10),
(3, '4', 'หมาหายหลังมอ', 'หายที่7-11 ตัวใหญ่มา', 'สูญหาย', '22/04/2021 08:14', '17/04/2021', 'image_picker2382238504852554026.jpg', 300),
(4, '4', 'บริจาคให้องกร', 'หลังจากที่ นักร้องดัง โดม จารุวัฒน์ หรือ โดม เดอะสตาร์ ได้ออกมาเปิดเผยว่าตนเองติดเชื้อโควิด-19 และกำลังเข้ารับการรักษาตัว เมื่อวันที่ 12 เม.ย. ที่ผ่านมา และจากนั้นวันที่ 15 เม.ย. 2564 โดม ได้โพสต์แจ้งอาการว่ามีไข้ขึ้นสูงมากจนน่าตกใจ และทำการรักษาตัวต่อไป', 'กิจกรรม', '', '17/04/2021', 'golden-retriever-dog-breed-info.jpeg', 130);

-- --------------------------------------------------------

--
-- Table structure for table `petss`
--

CREATE TABLE `petss` (
  `id` int(11) NOT NULL,
  `id_user` text NOT NULL,
  `id_adopt` text NOT NULL,
  `namepets` text NOT NULL,
  `detailspets` text NOT NULL,
  `genderpets` text NOT NULL,
  `category_pets` text NOT NULL,
  `sterillzationpets` text NOT NULL,
  `vaccinepets` text NOT NULL,
  `bodysize` text NOT NULL,
  `typebreed` text NOT NULL,
  `lat` text NOT NULL,
  `lone` text NOT NULL,
  `statuspets` text NOT NULL,
  `create_at` text NOT NULL,
  `update_at` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `petss`
--

INSERT INTO `petss` (`id`, `id_user`, `id_adopt`, `namepets`, `detailspets`, `genderpets`, `category_pets`, `sterillzationpets`, `vaccinepets`, `bodysize`, `typebreed`, `lat`, `lone`, `statuspets`, `create_at`, `update_at`) VALUES
(1, '1', '', 'หมีหวาน', 'ไม่มีเวลาเลี้ยงดู น้องชอบการวิ่งเล่นมาก หากเพื่อนท่านไหนมีพื้นที่ว่างๆ สามารถติดต่อเอาน้องไปเลี้ยงได้นะคะ', 'ผู้', 'หมา', 'ไม่ระบุ', '8 เดือน', 'กลาง', 'เคน คอร์โซ่', '16.4321933', '102.82362', 'ยังไม่มีผู้รับเลี้ยง', '22/04/2021 ', ''),
(2, '2', '', 'ดำ', 'น้องสีนี่ตั้งแต่เกิด สนใจติดต่อมาเลยยยย', 'ผู้', 'หมา', 'ไม่ระบุ', '6 เดือน', 'กลาง', 'ชิบะ อินุ', '16.4591619', '102.8225225', 'ยังไม่มีผู้รับเลี้ยง', '22/04/2021 ', ''),
(3, '1', '', 'กวาง', 'เป็นหมาจร น้องน่าสงสารมาก', 'ผู้', 'แมว', 'ไม่ระบุ', '6 เดือน', 'กลาง', 'เคน คอร์โซ่', '16.4321933', '102.82362', 'ยังไม่มีผู้รับเลี้ยง', '22/04/2021 ', ''),
(4, '2', '', 'Moshi', 'ต้องการคน มีพื้นที่กว้างๆให้เขาได้วิ่งเล่น ขอคนสนใจน้องจริงๆครับ', 'เมีย', 'หมา', 'ยังไม่ทำ', '6 เดือน', 'ใหญ่', 'เคน คอร์โซ่', '16.4321933', '102.82362', 'ยังไม่มีผู้รับเลี้ยง', '22/04/2021 ', ''),
(5, '3', '', 'หมูตูบ', 'พบอยู่หลังแถวหอพัก Np pack น่าสงสารมีใครสนใจมั้ย', 'ผู้', 'หมา', 'ทำหมันแล้ว', '8 เดือน', 'กลาง', 'คอลลี่', '16.4321933', '102.82362', 'ยังไม่มีผู้รับเลี้ยง', '22/04/2021 ', ''),
(6, '1', '', 'เก้ง', 'เราทำงาน ทุกวันเลย ไม่มีเวลาดูแลน้อง แล้วก็น้องซนมาก ทำให้ข้าวของพังไปหมด ใครอยากได้ไปเลี้ยงลองๆยื่นมาค่ะ', 'เมีย', 'แมว', 'ไม่ระบุ', '8 เดือน', 'เล็ก', 'เคน คอร์โซ่', '16.4321933', '102.82362', 'ยังไม่มีผู้รับเลี้ยง', '22/04/2021 ', ''),
(7, '1', '', 'แพนด้า', 'เหมือนชื่อเลย มันซนมาก กินก็เยอะเลี้ยงไม่ไหว', 'ผู้', 'แมว', 'ยังไม่ทำ', '12 เดือน', 'ไม่ระบุ', 'ไม่ระบุ', '16.4321933', '102.82362', 'ยังไม่มีผู้รับเลี้ยง', '22/04/2021 ', ''),
(8, '1', '', 'ตั้น', 'งง', 'ผู้', 'หมา', 'ทำหมันแล้ว', 'ไม่ระบุ', 'ไม่ระบุ', 'ไม่ระบุ', '16.68756', '102.8552067', 'ยังไม่มีผู้รับเลี้ยง', '23/04/2021 ', ''),
(9, '23', '', 'xxx', 'com', 'ไม่ระบุ', 'หมา', 'ไม่ระบุ', 'ไม่ระบุ', 'ใหญ่', 'ไม่ระบุ', '16.68756', '102.8552067', 'ยังไม่มีผู้รับเลี้ยง', '23/04/2021 ', ''),
(11, '1', '', 'dfgdf', 'dfsgfg', 'ไม่ระบุ', 'หมา', 'ไม่ระบุ', '8 เดือน', 'เล็ก', 'คอลลี่', '16.4744683', '102.8230317', 'ยังไม่มีผู้รับเลี้ยง', '28/04/2021 ', '');

-- --------------------------------------------------------

--
-- Table structure for table `post_likes`
--

CREATE TABLE `post_likes` (
  `id` int(11) NOT NULL,
  `user_email` text NOT NULL,
  `post_id` text NOT NULL,
  `isLike` text NOT NULL,
  `like_date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `post_likes`
--

INSERT INTO `post_likes` (`id`, `user_email`, `post_id`, `isLike`, `like_date`) VALUES
(1, 'ooooo', '1', '1', '17/04/2021'),
(3, 'poptype', '1', '1', '19/04/2021'),
(4, 'ooooo', '10', '1', '22/04/2021'),
(5, 'ooooo', '2', '1', '22/04/2021'),
(6, 'ooooo', '11', '1', '23/04/2021'),
(7, 'alluser', '12', '1', '23/04/2021'),
(8, 'poptype', '2', '1', '25/04/2021');

-- --------------------------------------------------------

--
-- Table structure for table `post_table`
--

CREATE TABLE `post_table` (
  `id` int(11) NOT NULL,
  `title_post` text NOT NULL,
  `body_post` text NOT NULL,
  `category_name` text NOT NULL,
  `post_date` text NOT NULL,
  `comments_post` text NOT NULL,
  `total_Like` text NOT NULL,
  `create_date` text NOT NULL,
  `author_post` text NOT NULL,
  `image_post` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `post_table`
--

INSERT INTO `post_table` (`id`, `title_post`, `body_post`, `category_name`, `post_date`, `comments_post`, `total_Like`, `create_date`, `author_post`, `image_post`) VALUES
(2, 'เล่มเก่ามาก', 'เดี๋ยวก็ดีขึ้น', 'ทั่วไป', '17/04/2021', '0', '2', '17/04/2021', 'ooooo', 'image_picker678655702401777518.jpg'),
(9, 'กลม', 'งง งงมาก', 'ปัญหา', '22/04/2021 07:57', '0', '0', '17/04/2021', 'admin', 'image_picker5037700544719633158.jpg'),
(10, 'qweqwe', 'weqwe', 'กิจกรรม', '', '0', '1', '22/04/2021 ', 'admin', 'image_picker5906234401979474116.jpg'),
(11, 'งง', 'เกมเกมป', 'ปัญหา', '', '0', '1', '23/04/2021 ', 'ooooo', 'image_picker1650807312675214672.jpg'),
(12, 'นานนาน', 'whal', 'ปัญหา', '', '0', '1', '23/04/2021 ', 'alluser', 'image_picker5049347842169845249.jpg'),
(13, 'เกม', 'เนื้อหาเนื้อหาป', 'กิจกรรม', '', '0', '0', '23/04/2021 ', 'alluser', 'image_picker5913225881186151042.jpg'),
(14, 'klkl', 'k;;', 'ปัญหา', '', '0', '0', '28/04/2021 ', 'ooooo', 'image_picker8363008043649667918.jpg'),
(15, 'sawwww', 'adcsa', 'กิจกรรม', '', '0', '0', '28/04/2021 ', 'ooooo', 'image_picker5117765253243531467.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `sterillzation_pets`
--

CREATE TABLE `sterillzation_pets` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `create_at` text NOT NULL,
  `update_at` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sterillzation_pets`
--

INSERT INTO `sterillzation_pets` (`id`, `name`, `create_at`, `update_at`) VALUES
(1, 'ไม่ระบุ', '', ''),
(2, 'ทำหมันแล้ว', '', ''),
(3, 'ยังไม่ทำ', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `type_breed`
--

CREATE TABLE `type_breed` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `create_at` text NOT NULL,
  `update_at` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_admin`
--

CREATE TABLE `user_admin` (
  `id` int(11) NOT NULL,
  `unique_id` int(255) NOT NULL,
  `username` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `gender` text NOT NULL,
  `pathImage` text NOT NULL,
  `phone` text NOT NULL,
  `status` text NOT NULL,
  `status_online` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_admin`
--

INSERT INTO `user_admin` (`id`, `unique_id`, `username`, `email`, `password`, `gender`, `pathImage`, `phone`, `status`, `status_online`) VALUES
(1, 1111, 'ooooo', 'gaa@sss.com', '123456789', 'ชาย', 'image_picker1687620143033578825.jpg', '09188909891', 'User', 'Active now'),
(2, 2222, 'poptype', 'ool@ooo.com', '123456789', 'ชาย', 'user28204.jpg', '09898767895', 'User', 'Active now'),
(3, 4444, 'dennis', 'test@gmail.com', '123456789', 'หญิง', 'cm7.jpeg', '06567898765', 'User', 'Active now'),
(4, 5555, 'admin', 'Admin@admin.com', '123456789', 'ไม่ระบุ', 'cm7.jpeg', '09089009823', 'Admin', 'Active now'),
(23, 1583452248, 'alluser', 'userall@all.com', '123456789', 'ไม่ระบุ', 'user68308.jpg', '09889098909', 'User', 'Active now'),
(24, 407732225, 'tooee', 'te@et.com', '123456789', 'หญิง', 'user84648.jpg', '09809980987', 'User', 'Active now');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `body_size`
--
ALTER TABLE `body_size`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_news`
--
ALTER TABLE `category_news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_pets`
--
ALTER TABLE `category_pets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commentspets`
--
ALTER TABLE `commentspets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gender_pets`
--
ALTER TABLE `gender_pets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `image_pets`
--
ALTER TABLE `image_pets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`msg_id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `petss`
--
ALTER TABLE `petss`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_likes`
--
ALTER TABLE `post_likes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_table`
--
ALTER TABLE `post_table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sterillzation_pets`
--
ALTER TABLE `sterillzation_pets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `type_breed`
--
ALTER TABLE `type_breed`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_admin`
--
ALTER TABLE `user_admin`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `body_size`
--
ALTER TABLE `body_size`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `category_news`
--
ALTER TABLE `category_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `category_pets`
--
ALTER TABLE `category_pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `commentspets`
--
ALTER TABLE `commentspets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `gender_pets`
--
ALTER TABLE `gender_pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `image_pets`
--
ALTER TABLE `image_pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=230;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `msg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `petss`
--
ALTER TABLE `petss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `post_likes`
--
ALTER TABLE `post_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `post_table`
--
ALTER TABLE `post_table`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `sterillzation_pets`
--
ALTER TABLE `sterillzation_pets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `type_breed`
--
ALTER TABLE `type_breed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_admin`
--
ALTER TABLE `user_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
