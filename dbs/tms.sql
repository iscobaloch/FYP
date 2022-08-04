-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 04, 2022 at 10:17 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tms`
--

-- --------------------------------------------------------

--
-- Table structure for table `about`
--

CREATE TABLE `about` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `about`
--

INSERT INTO `about` (`id`, `email`, `phone`) VALUES
(1, 'info@tms.com.pk', '+923058477006');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `email`) VALUES
(1, 'admin', '$pbkdf2-sha256$29000$ljJmDKFUCsG4d66VsvZeqw$ao47Dor9x/uDQahO5N1fZJzmS9dGyo7LPS7SEkWeVVo', 'info@tms.pk');

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `sender` int(11) NOT NULL,
  `message` varchar(2000) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`id`, `uid`, `sender`, `message`, `time`, `status`) VALUES
(1, 5, 1, 'hi', '2022-06-17 09:25:41', 1),
(2, 4, 1, 'hi', '2022-06-18 10:20:27', 1),
(3, 8, 8, 'hi', '2022-06-19 10:40:49', 1),
(4, 8, 1, 'hello', '2022-06-19 10:40:49', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblbooking`
--

CREATE TABLE `tblbooking` (
  `BookingId` int(11) NOT NULL,
  `PackageId` int(11) DEFAULT NULL,
  `UserId` int(100) DEFAULT NULL,
  `FromDate` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `Comment` mediumtext DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblbooking`
--

INSERT INTO `tblbooking` (`BookingId`, `PackageId`, `UserId`, `FromDate`, `city`, `Comment`, `RegDate`, `status`) VALUES
(4, 3, 9, '2022-06-22', 'Quettta', 'manage this for me', '2022-06-20 09:34:46', 1),
(5, 3, 8, '2022-06-21', 'quetta', 'arrange this tour for me', '2022-06-21 07:13:52', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblenquiry`
--

CREATE TABLE `tblenquiry` (
  `id` int(11) NOT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  `EmailId` varchar(100) DEFAULT NULL,
  `MobileNumber` char(10) DEFAULT NULL,
  `Subject` varchar(100) DEFAULT NULL,
  `Description` mediumtext DEFAULT NULL,
  `PostingDate` timestamp NULL DEFAULT current_timestamp(),
  `Status` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblenquiry`
--

INSERT INTO `tblenquiry` (`id`, `FullName`, `EmailId`, `MobileNumber`, `Subject`, `Description`, `PostingDate`, `Status`) VALUES
(4, 'Fayaz GN', 'fayazgn@gmail.com', '9233432232', 'Awaran Tour', 'ex[lain ', '2022-06-18 12:52:51', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblpages`
--

CREATE TABLE `tblpages` (
  `id` int(11) NOT NULL,
  `type` varchar(255) DEFAULT '',
  `detail` longtext DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblpages`
--

INSERT INTO `tblpages` (`id`, `type`, `detail`) VALUES
(1, 'terms', '										<p align=\"justify\"><font size=\"2\"><strong><font color=\"#990000\">(1) ACCEPTANCE OF TERMS</font><br><br></strong>Welcome to Yahoo! India. 1Yahoo Web Services India Private Limited Yahoo\", \"we\" or \"us\" as the case may be) provides the Service (defined below) to you, subject to the following Terms of Service (\"TOS\"), which may be updated by us from time to time without notice to you. You can review the most current version of the TOS at any time at: <a href=\"http://in.docs.yahoo.com/info/terms/\">http://in.docs.yahoo.com/info/terms/</a>. In addition, when using particular Yahoo services or third party services, you and Yahoo shall be subject to any posted guidelines or rules applicable to such services which may be posted from time to time. All such guidelines or rules, which maybe subject to change, are hereby incorporated by reference into the TOS. In most cases the guides and rules are specific to a particular part of the Service and will assist you in applying the TOS to that part, but to the extent of any inconsistency between the TOS and any guide or rule, the TOS will prevail. We may also offer other services from time to time that are governed by different Terms of Services, in which case the TOS do not apply to such other services if and to the extent expressly excluded by such different Terms of Services. Yahoo also may offer other services from time to time that are governed by different Terms of Services. These TOS do not apply to such other services that are governed by different Terms of Service. </font></p>\r\n<p align=\"justify\"><font size=\"2\">Welcome to Yahoo! India. Yahoo Web Services India Private Limited Yahoo\", \"we\" or \"us\" as the case may be) provides the Service (defined below) to you, subject to the following Terms of Service (\"TOS\"), which may be updated by us from time to time without notice to you. You can review the most current version of the TOS at any time at: </font><a href=\"http://in.docs.yahoo.com/info/terms/\"><font size=\"2\">http://in.docs.yahoo.com/info/terms/</font></a><font size=\"2\">. In addition, when using particular Yahoo services or third party services, you and Yahoo shall be subject to any posted guidelines or rules applicable to such services which may be posted from time to time. All such guidelines or rules, which maybe subject to change, are hereby incorporated by reference into the TOS. In most cases the guides and rules are specific to a particular part of the Service and will assist you in applying the TOS to that part, but to the extent of any inconsistency between the TOS and any guide or rule, the TOS will prevail. We may also offer other services from time to time that are governed by different Terms of Services, in which case the TOS do not apply to such other services if and to the extent expressly excluded by such different Terms of Services. Yahoo also may offer other services from time to time that are governed by different Terms of Services. These TOS do not apply to such other services that are governed by different Terms of Service. </font></p>\r\n<p align=\"justify\"><font size=\"2\">Welcome to Yahoo! India. Yahoo Web Services India Private Limited Yahoo\", \"we\" or \"us\" as the case may be) provides the Service (defined below) to you, subject to the following Terms of Service (\"TOS\"), which may be updated by us from time to time without notice to you. You can review the most current version of the TOS at any time at: </font><a href=\"http://in.docs.yahoo.com/info/terms/\"><font size=\"2\">http://in.docs.yahoo.com/info/terms/</font></a><font size=\"2\">. In addition, when using particular Yahoo services or third party services, you and Yahoo shall be subject to any posted guidelines or rules applicable to such services which may be posted from time to time. All such guidelines or rules, which maybe subject to change, are hereby incorporated by reference into the TOS. In most cases the guides and rules are specific to a particular part of the Service and will assist you in applying the TOS to that part, but to the extent of any inconsistency between the TOS and any guide or rule, the TOS will prevail. We may also offer other services from time to time that are governed by different Terms of Services, in which case the TOS do not apply to such other services if and to the extent expressly excluded by such different Terms of Services. Yahoo also may offer other services from time to time that are governed by different Terms of Services. These TOS do not apply to such other services that are governed by different Terms of Service. </font></p>\r\n										'),
(2, 'privacy', '										<span style=\"color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\">At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat</span>\r\n										'),
(3, 'aboutus', '<h1><strong>Welcome to TOUR &amp; TRAVEL AGENCY!!!</strong></h1>\r\n\r\n<p>Since then, our courteous and committed team members have always ensured a pleasant and enjoyable tour for the clients. This arduous effort has enabled Shreya Tour &amp; Travels to be recognized as a dependable Travel Solutions provider with three offices Delhi.&nbsp;We have got packages to suit the discerning traveler&#39;s budget and savor. Book your dream vacation online. Supported quality and proposals of our travel consultants, we have a tendency to welcome you to decide on from holidays packages and customize them according to your plan.</p>\r\n'),
(11, 'contact', '																				<span style=\"color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\">Address------J-890 Dwarka House New Delhi-110096</span>');

-- --------------------------------------------------------

--
-- Table structure for table `tbltourpackages`
--

CREATE TABLE `tbltourpackages` (
  `PackageId` int(11) NOT NULL,
  `PackageName` varchar(200) DEFAULT NULL,
  `PackageLocation` varchar(100) DEFAULT NULL,
  `PackagePrice` int(11) DEFAULT NULL,
  `PackageDetails` mediumtext DEFAULT NULL,
  `PackageImage` varchar(100) DEFAULT NULL,
  `Creationdate` timestamp NULL DEFAULT current_timestamp(),
  `Duration` int(11) NOT NULL,
  `Accommodation` int(11) NOT NULL,
  `Meal` int(11) NOT NULL,
  `Transport` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbltourpackages`
--

INSERT INTO `tbltourpackages` (`PackageId`, `PackageName`, `PackageLocation`, `PackagePrice`, `PackageDetails`, `PackageImage`, `Creationdate`, `Duration`, `Accommodation`, `Meal`, `Transport`) VALUES
(1, '3 DAYS TRIP TO NARAN KAGHAN', 'NARAN KAGHAN', 13000, '<p>Naran is a medium sized town situated in the upper Kaghan valley in KPK province of Pakistan at en elevation of 2500 m. Surrounded by green lush mountains, the landscape is elevated with grassy knolls and jagged waterfalls with dense forest clinging to the top the area if truly ablaze trout here is truly a treat between the months of late summer and winter. The neon blue ribbon of river Kunhar meanders its way through the valleys and the splattering sound of the fast flowing river makes you quiver.<br />\r\n<br />\r\nNaran is the place for outdoor leisure that attracts tourists from all around for fishing Trout and Mahasher. The bazaar is generally crowded with people and has a view of mall road like that of Murree at night. Naran is a one day Jeep Ride Trekking to the astounding Ansoo Lake. The temperature at Naran remains hot during the summer time and frequent snow falls during the winters keep the valley covered with snow giving away a spectacular view.<br />\r\n<br />\r\nSaiful Muluk is located in the Mansehra district of Khyber Pakhtunkhwa, about eight kilometers north of Naran, in the northern part of Kaghan valley. Malika Parbat, the highest peak in the valley is near the lake.<br />\r\n&nbsp;</p>\r\n', 'HqNNVRFhISqefZ1WzlvCvsU4KE0.jpg', '2022-06-20 05:59:16', 3, 1, 1, 1),
(2, '5 DAYS TRIP TO HUNZA KHUNJERAB PASS', 'HUNZA VALLEY ', 21500, '<p>Hunza is a mountainous valley in the Gilgit&ndash;Baltistan region of Pakistan. The Hunza is situated north/west of the Hunza River, at an elevation of around 2,500 meters (8,200 ft). The territory of Hunza is about 7,900 square kilometers (3,100 sq mi).<br />\r\n<br />\r\nAliabad is the main town while Baltit is a popular tourist destination because of the spectacular scenery of the surrounding mountains like Ultar Sar, Rakaposhi, Bojahagur Duanasir II, Ghenta Peak, Hunza Peak, Passu Peak, Diran Peak and Bublimotin (Ladyfinger Peak), all 6,000 meters (19,685 ft) or higher.<br />\r\n&nbsp;</p>\r\n\r\n<p>Hunza Tour Packages 2022</p>\r\n\r\n<p><br />\r\nHunza Khunjerab Pass Tour is best to catch all above mention attractions. For Hunza Valley Tour booking, fill booking form or direct call us.</p>\r\n', 'cq_Gf_FqwWtD68joEynar_TwYqs.jpg', '2022-06-20 06:12:16', 5, 1, 1, 1),
(3, 'TRIP TO MOOLA CHOTOK', 'MOOLA CHOTOK', 8500, '<p>Moola Chotok is a ravine hidden in the vast landscape of Baluchistan. This place denies the common traditional thinking about Baluchistan and confirms that Baluchistan is a land enclosing marvellous wonders of nature which are waiting to be unleashed, discovered and cherished. Pakistan has a high aptitude for tourism. Moola Chotok is such a memorable place that no one can deny its charm. It is heavenly, breathtaking and captivating. From its running waters to joyous landscape and serene atmosphere, this place has a lot to offer to the world. Weather and climate conditions serve as a hindrance in relishing the exquisite beauty of the astounding place; however, suitable measures can be taken to combat the extreme weather conditions. It is not indifferent to call it as the pearl of Baluchistan as it houses some of the biggest waterfalls of the province. In Moola Chotok one finds along with cascading waterfalls, deep blue pools and magnificent fish swirling in clear sparkly water.<br />\r\n<br />\r\nThis trip will take you from mountains, deep blue waters to the isolated gorge of Chutook. We have collaborated with the Tourism department of Moola Chotok district to make it possible. It will be 2 days and a 2-night trip which will bonfire, music, sky lanterns, exploration and much more. We have managed to celebrate new year night at the base camp of chutook. This trip is a 3rd Grade adventure trip and not suitable for kids under 15 years. The trip is good for hardcore travelers and adventure lovers.</p>\r\n', 'ps-dO8Gta8Kl1r4PXam9dkPn_v4.jpg', '2022-06-20 06:12:16', 2, 1, 1, 1),
(4, 'TRIP TO MUSHKPURI TOP', 'NATHIA GALI', 6000, '<p>Mushkpuri is the second highest hill of Galyat. It is located in the Hills of Nathiagali in District Abbottabad, Khyber Pakhtunkhwa, Pakistan, Trek to Mushkpuri Top and is the second highest hill of Galiyat at Dungagali-Ayubia Track, This track is also known as the pipeline track. A pipeline was laid to supply water to Murree, Pakistan&#39;s busiest hill station.<br />\r\n&nbsp;</p>\r\n\r\n<p>Mushkpuri Hiking Tour</p>\r\n\r\n<p><br />\r\nThis track follows the pipeline from Donga Gali to Ayubia, a distance of 4 kilometers. Mushkpuri or Moshpuri is a 2,800-metre-high (9,200 ft) mountain in the Nathiagali Hills, in the Abbottabad District of the Khyber Pakhtunkhwa province in northern Pakistan.<br />\r\n<br />\r\nIt is 90 kilometers (56 mi) north of Islamabad, just above Dunga Gali in the Nathiagali area of Ayubia National Park. Much of it the mountain is covered with Western Himalayan sub alpine conifer forests.<br />\r\n<br />\r\nMushkpuri Top distance from Islamabad = 2 h 23 min (81.6 km) via Kashmir Rd<br />\r\nMushkpuri Top distance from Rawalpindi = 2 h 53 min (94.1 km) via Kashmir Rd<br />\r\nMushkpuri Top distance from Lahore = 6 h 34 min (453.8 km) via Lahore-Islamabad Motorway/M-2</p>\r\n', 'wQPzyh0wdRlSydOXD7zEOLPKSPs.jpg', '2022-06-20 06:12:16', 1, 1, 1, 1),
(5, 'GORAKH HILL TOUR PACKAGE', 'KARACHI', 8000, '<p>Gorakh Hill Station, also known as the &lsquo;Murree&rdquo; of Sindh, is one of the most common and attractive tourist sites in Pakistan. Boundlessly beautiful and magical, Gorakh is much more than just the &lsquo;Murree&rsquo; of Sindh. Full of history and events from the past, it has been one of the main spots for historians from all over the world. The region is an excellent prospect for bird watchers and photographers.<br />\r\n&nbsp;</p>\r\n\r\n<h2>Gorakh Hill Tour Packages</h2>\r\n\r\n<p><br />\r\nSituated on one of the highest plateaus of Pakistan, this hill station is spread on a vast area of around 2500 acres. The chilly temperatures and a lot of rainfall make Gorakh Hill Station a site not to miss. Gorakh Hill Station got its name from its history. The difficult and uneven routes and paths make it an adventurous place to visit. Contact us for Gorakh Hill Travel packages 2022</p>\r\n', 'ppwX0WnZdWHTx0X9rw2CKYsmNwM.jpg', '2022-06-20 06:12:16', 2, 1, 1, 1),
(6, '3 DAYS TRIP TO SWAT KALAM', 'SWAT', 12000, '<p>Swat is known as the Switzerland of Pakistan. The river&nbsp;Swat&nbsp;is a clear water river, starting from the Ushu range of mountains to the spread of the valley of Swat. It is one of the greenest valleys of Northern Pakistan and is well connected to the rest of Pakistan. There are regular flights from Islamabad to Swat and back. One can also get here either from Peshawar (160 KMs) or Islamabad.(250 KMs). The valley of Swat is located in the middle of foothills of Hindukush mountain range. The main town of the valley is Mingora and Saidu Sharif. A swat is a place for leisure Lovers, Hikers, and archaeologists.<br />\r\n&nbsp;</p>\r\n\r\n<h3>Kalam</h3>\r\n\r\n<p><br />\r\nThere are many comfortable hotels where one can stay a while to relax. In Kalam upper Swat there are some very pleasant walks since the weather is pretty pleasant one can easily walk over the hills for hours and enjoy the unspoiled nature. The Swat is garden of Ashoka and was a prosperous land in the Buddhist times (2nd BC to 5 AD) There are at least over 100 archaeological sites in the valley less than 10% of the area excavated. One can explore some of those sites in a half day tour of Swat.<br />\r\n<br />\r\nKalam is a hill station in swat valley at an altitude of 2000 meters. But it seems far higher than the other popular hill station because you&#39;re surrounded by tall peaks as far as the eye can see. The most prominent peak is Falak Sar (5,918m), capped by pristine white snow at the top. Kalam is surrounded by lush green hills, thick forests and bestowed with mesmeric lakes, meadows, and waterfalls which are worth seen features of the landscape. It is the birthplace of Swat River. Kalam is a popular hill station with luxury hotels and Mall Road for shopping and walking around at night.</p>\r\n', 'Sw3WSOKoHX9Hr9WFZ27jejgFfL0.jpg', '2022-06-20 06:12:16', 3, 1, 1, 1),
(7, 'UMBRELLA WATERFALL TOUR', 'KHYBER PAKHTUNKHWA', 5600, '<p>Umbrella Waterfall is Hidden and Un-explored mesmerizing artwork of nature is located in the village Poona, Tehsil Havelian, Distt Abbotabad. The waterfall is located 27 Kilometers from Havelian. Most of you know what this place is! For those who don&rsquo;t know let me tell you this place is Umbrella Waterfall Tour in a village called Poona! Umbrella Waterfall such a beautiful showering waterfall wrapped in between the mountains. It was like an oyster in a pearl. We have different packages to Umbrella Waterfall Tour to Lahore Islamabad Karachi where ever you live. We provide quality services at very reasonable prices. The most scenic trek you will never forget. Umbrella Waterfall Tour and Trip Packages 2021-2022</p>\r\n', 'xrGfvhpl4aUVNVyCUeMIBJlyrlQ.jpg', '2022-06-20 06:12:16', 5, 1, 1, 0),
(8, 'TRIP TO KUMRAT VALLEY', 'KHYBER PAKHTUNKHWA', 13000, '<p>Kumrat Valley is the most scenic true gem of nature, words cannot truly describe the breathtaking beauty of this area, its gushing streams and splendid mountains. So the valley is now re surging as another one of Pakistan&rsquo;s tourist spots. Kumrat is a valley in the Upper Dir District, Khyber Pakhtunkhwa Pakistan almost 400km, 9 hours drive from the capital territory of Pakistan. Just opposite to the Gabral a Swat Kohistan area.<br />\r\n<br />\r\nKumrat Valley is one of the scenic valleys of KPK, and a picturesque spot for travelers. Even every summer season thousands of tourists from different areas of the country visit to Kumrat valley and enjoy the greenery and cool weather.<br />\r\n<br />\r\nThe climate is pleasant in summer like 20C but very cold in winter because of heavy snowfall about 3 to 11 feet and temperature fall down almost -4 to -10 C. Therefore best time to visit the place is in spring and summer.<br />\r\n&nbsp;</p>\r\n\r\n<p>Kumrat Valley Distance</p>\r\n\r\n<p><br />\r\n<strong>Kumrat Valley Distance From Lahore</strong><br />\r\n13 h 45 min (733 km) - via Lahore-Islamabad Motorway/M-2<br />\r\n<strong>Kumrat Valley Distance From Islamabad</strong><br />\r\n9 h 46 min (399 km) - via AH1/M-1, N-45 and Dir Road<br />\r\n<strong>Kumrat Valley Distance From Swat</strong><br />\r\n6 h 8 min (153 km) - via Bahrain Rd/N-95</p>\r\n', '5r6ugCsKoaInqoWn-I8Pa1dNGEM.jpg', '2022-06-20 06:12:16', 3, 1, 1, 1),
(9, 'TRIP TO KUND MALIR BEACH', 'KUND MALIR / BALOCHISTAN', 5000, '<p>Trip to Kund Malir Beach is a beach in Balochistan Pakistan. Located in Hingol National Park about 145 km. From Zero-Point on Makran Coastal Highway. The drive between Kund Malir and Ormara is considered to be scenic trip to kund malir beach. The area is part of Hingol National Park which is the largest in Pakistan.</p>\r\n', 'IVGrtFS4vdBX1d84dRgAlnedwgc.jpg', '2022-06-20 06:12:16', 2, 1, 1, 1),
(10, 'TRIP TO CHARNA ISLAND', 'KARACHI', 4500, '<p>Charna Island is located near Mubarak Goth Kiamari Town in Karachi Sindh Pakistan. It is 6 km away from Mubarak Village. Fishermen of Mubarak Goth go for fishing near the Charna Island.<br />\r\nCharna Island is a small island located in the Arabian Sea off the coast of Karachi Sindh Pakistan. It is situated 3.855 nautical miles northwest of a fishing settlement Mubarak Village. Mubarak Village Mubarak Goth. The boundary between the provinces of Balochistan and Sindh.<br />\r\n<br />\r\nCharna is approximately 1.2 km (0.75 mi) long and 0.5 km (0.31 mi) wide. Trip to Charna Island is also locally known as &quot;Cheerno.&quot; So, It is 6 km away from Mubarak Village. Fishers of Mubarak Goth go fishing near Charna Island Karachi. Similarly, there are many species of fish, crabs, and lobsters. So, anglers take boats to go Island from Mubarak Goth. Mubarak Goth is the second-largest fishermen locality in Karachi. Finally, Charna Island Karachi Packages 2020 2021 2022. Charna Island Booking Contact Number is 03111 977 977. Charna Island Open Now. Hurry Up! Book your slot now for a deep-water adventure. For Private Tours Make My Trip</p>\r\n\r\n<p><strong>Recommended Gear:</strong></p>\r\n\r\n<ul>\r\n	<li>Water bottle<br />\r\n	Sun Block and Sun glasses<br />\r\n	Trekking boots/Joggers/Comfortable Shoes/Slippers<br />\r\n	Back Pack<br />\r\n	T shirts for day trekking</li>\r\n</ul>\r\n', 'ZBOVzL9jaqsLRo-nPyXGzpmES60.jpg', '2022-06-20 06:12:16', 1, 1, 1, 1),
(11, 'TRIP TO NEELAM VALLEY & AZAD KASHMIR', 'AZAD KASHMIR', 6000, '<p>A 144 km long bow-shaped thickly forested region in&nbsp;<a href=\"https://www.getout.pk/pakistan/category/kashmir/\">Azad Kashmir</a>&nbsp;in Pakistan Administered Kashmir. It is named after the Neelum river, which flows through the length of the valley. The valley is situated in the north-east of Muzaffarabad, running parallel to Kaghan Valley. The two valleys are only separated by snow-covered peaks, some over 4,000 meters (13,000 ft) above sea level.<br />\r\n<br />\r\nThe Neelum valley is connected from Muzaffarabad by Neelam road, which leads up to Kel. The road condition from Muzaffarabad to Athmuqam is very good and suitable for any kind of transport. From Keran to Kel road condition is not well and not suitable for low floor vehicles.<br />\r\n<br />\r\nIn winters road onward Keran is blocked due to heavy snowfall and it is very difficult to reach upper parts of the valley. Vans service is only available from Muzaffarabad to Athmuqam after every 30 minutes. Buses run daily between Muzaffarabad and Kel in good weather. Jeeps and horses are available to reach remote areas of the valley.</p>\r\n\r\n<p><strong>Recommended Gear:</strong></p>\r\n\r\n<ul>\r\n	<li>Sun Block and Sun glasses</li>\r\n	<li>Hand wash/soap/sanitizer. wipes. tooth paste and all other necessities</li>\r\n	<li>Beanie (highly recommended)</li>\r\n	<li>Muffler (highly recommended)</li>\r\n	<li>Gloves (highly recommended)</li>\r\n	<li>Fleece/Sweaters</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n', 'ms8lY9mrSEw_WnIVYr6BRvcYPf4.jpg', '2022-06-20 06:12:16', 3, 1, 1, 1),
(12, 'PARASAILING IN KARACHI', 'KARACHI', 7000, '<p>Do you want to be higher than the tallest roller coaster in the world? One minute you are chilling on the beach in Karachi, next thing you know, you&rsquo;re 200 feet up in the sky! Parasailing, a breathtaking experience, allows the passenger to glide through the skies like never before, while enjoying the peace and serenity of Karachi. With a birds-eye view of the ocean, it is common to see dolphins, sea turtles and humpback whales. Experiencing a view of ocean life and the astonishing panoramic views will bring you to a whole new level of discovering Karachi. Parasailing is enjoyed world-wide with over three million riders per year!</p>\r\n\r\n<p><strong>Recommended Gear:</strong></p>\r\n\r\n<ul>\r\n	<li>Water bottle</li>\r\n	<li>Sun Block and Sun glasses</li>\r\n	<li>Trekking boots/Joggers</li>\r\n	<li>Comfortable Shoes/Slippers</li>\r\n	<li>Back Pack</li>\r\n	<li>T shirts for day trekking</li>\r\n</ul>\r\n', 'dbqAuq9oK2QvKDQmGEAzu4oirpA.jpg', '2022-06-20 06:54:54', 1, 0, 1, 1),
(13, 'TRIP TO SKARDU, SHIGAR, KHAPLU & DEOSAI', 'SKARDU', 16000, '<p>Explore magnificent Skardu, Shigar, Khaplu &amp; Deosai plains in July (07 Jul &ndash; 14 Jul, 2017)<br />\r\nDEPARTURE TIME From Lahore at 9:00 pm (Sharp)<br />\r\nRETURN TIME In Islamabad 11:00 pm, In Lahore 4:00 am next day<br />\r\nINCLUDED<br />\r\nTravel through private air conditioned vehicle Quality Meals (7 BF + 7D)<br />\r\n6 night&rsquo;s hotel stays as per plan on 3/4 pax sharing Jeep arrangment to Deosai Plains on 7/8 pax sharing<br />\r\nBBQ (1) &amp; Bonfire (1) Facilities of guide<br />\r\nBasic first aid kit. All tolls and taxes<br />\r\nNOT INCLUDED<br />\r\nExtras at hotels like hot / soft drinks / mineral water Entry tickets etc<br />\r\nInsurance and liability Any item not mentioned above<br />\r\nPick / Drop<br />\r\nTravel: Via Motorway<br />\r\nLahore: Pso Pump near Metro Cash and Carry, Thokar<br />\r\nIslamabad: Daewoo Terminal near Nust EME</p>\r\n\r\n<p><strong>Recommended Gear:</strong></p>\r\n\r\n<ul>\r\n	<li>Water bottle<br />\r\n	Gloves (highly recommended)<br />\r\n	Muffler (highly recommended)<br />\r\n	Beanie (highly recommended)<br />\r\n	Hand wash/soap/sanitizer</li>\r\n	<li>wipes</li>\r\n	<li>tooth paste and all other necessities<br />\r\n	Sun Block and Sun glasses</li>\r\n</ul>\r\n', 'PglvfBRne5MOHK1kPNgNIc1-IbE.jpg', '2022-06-20 06:54:54', 8, 1, 1, 1),
(14, 'TRIP TO ASTOLA ISLAND (CAMPING)', 'BALOCHISTAN', 15000, '<p><strong>T</strong>rip to Astola Island of the Seven Hills is a small uninhabited Pakistani island in the Arabian Sea approximately 25 km (16 mi) south of the nearest part of the coast and 39 km (24 mi) southeast of the fishing port of Pasni.<br />\r\nAstola is Pakistan&#39;s largest offshore island at approximately 6.7 km (4.2 mi) long with a maximum width of 2.3 km (1.4 mi) and an area of approximately 6.7 km2 (2.6 sq mi) trip to astola island.<br />\r\nThe highest point is 246 ft (75 m) above sea level. Administratively, the island is part of the Pasni subdistrict of Gwadar District in Balochistan province. The island can be accessed by motorized boats from Pasni, with a journey time of about 5 hours to reach the island.</p>\r\n\r\n<p><strong>Recommended Gear:</strong></p>\r\n\r\n<ul>\r\n	<li>Sun Block and Sun glasses<br />\r\n	Hand wash/soap/sanitizer</li>\r\n	<li>wipes</li>\r\n	<li>tooth paste and all other necessities<br />\r\n	Water bottle</li>\r\n</ul>\r\n', '_JetUP7DYV66lw0bSIE2hIwN21Y.jpg', '2022-06-20 06:54:54', 3, 1, 1, 1),
(15, 'KARACHI WATER SPORTS', 'KARACHI', 4000, '<p>Water Sports includes speed boating. Wake tubing knee boarding. This is the most thrilling and exciting package of Karachi Water Sports Club. Our speedboat ride is no less than. A roller coaster ride, Knee boarding involves balancing.<br />\r\nYour body on a thin board and wake tube is a doughnut-shaped. Tube attached to the speedboat which skids on the water at high speed. All these activities combined makes water frenzy a very exciting package.</p>\r\n\r\n<p><strong>Recommended Gear:</strong></p>\r\n\r\n<ul>\r\n	<li>Water bottle</li>\r\n	<li>Sun Block and Sun glasses</li>\r\n	<li>Trekking boots/Joggers</li>\r\n	<li>Comfortable Shoes/Slippers</li>\r\n	<li>Back Pack</li>\r\n	<li>T shirts for day trekking</li>\r\n</ul>\r\n', 'TQxEJZm7ojxZZWuFV4zBJ4QRQuU.jpg', '2022-06-20 06:54:54', 1, 1, 1, 1),
(16, '4 DAYS KEL ARANG KEL TAOBAT NEELUM VALLEY TRIP', 'Arang Kel Taobatt', 22000, '<p>We have ready made Arang Kel Taobatt Tour 4 Days Neelum Valley Azad Kashmir Trip Packages 2022. Neelum Valley a 144 km long bow-shaped thickly forested region in Pakistan Administered Kashmir. It is named after the Neelum river, which flows through the length of the valley. It is a remarkable opportunity to fulfill your wish to see Northern areas of Pakistan like Azad Kashmir. Thus, Kashmir &amp; Neelum Valley Tour Trip Travel Vacation and Holiday Packages has its own attraction among tourists. Azad Kashmir tourism is a piece of heaven on earth. around the country. Arang Kel Taobatt Azad Kashmir Tour Travel Guide will lead you fairy land of Azad Kashmir. So, In Kashmir Sightseeing Packages Sharda Kel Arang Kel Kutton Jagran Dhani Waterfall are the best tourists attractions and spots while visit the Azad Kashmir.<br />\r\n<br />\r\nKashmir Tour Package&nbsp;Make My Trip&nbsp;unforgettable and accelerates one&rsquo;s lust for more adventure accordingly. Kashmir Itinerary 3 4 5 days make your journey pleasurable and it leaves an everlasting effect upon the traveler&#39;s thoughts. Tour Operators in Kashmir Obviously, offer a rationale to plunge for it region time and again. Best of Kashmir Tour Package presents the most incredible panoramic picturesque spots in its lap. Kashmir Family Tours and Packages for Neelum Valley are the best option to spend good time.<br />\r\n<br />\r\nFurther more, Neelum Valley Vacation Package is connected from Muzaffarabad by Neelam road, which leads up to Kel. NAC are the best tour travel operators in Neelum Valley Azad Kashmir. Neelum Valley Azad Kashmir Tour Travel Guide is suitable for families and children. Neelum Valley Azad Kashmir Tour Trip Package from Lahore Karachi Islamabad Faisalabad Hyderabad available. Plan your tour according to your days, budget with us according to your 3 4 5 6 7 8 9 days itinerary as well. Kashmir Tour Package in December January February March like a white snowy scenery in Neelum Valley. On the other hand, April May June July August September October November are the best time to visit Neelum Valley. Similarly, We also have Kashmir Upcoming Group Public Tour Packages departure every Thursday and Wednesday Night from Lahore Islamabad Karachi.</p>\r\n\r\n<p><strong>Recommended Gear:</strong></p>\r\n\r\n<ul>\r\n	<li>Water bottle</li>\r\n	<li>Gloves (highly recommended)</li>\r\n	<li>Muffler (highly recommended)</li>\r\n	<li>Beanie (highly recommended)</li>\r\n	<li>Hand wash/soap/sanitizer. wipes. tooth paste and all other necessities</li>\r\n	<li>Sun Block and Sun glasses</li>\r\n</ul>\r\n', 'Tej3h9A5-70W9b40-ansHj5mAB0.jpg', '2022-06-20 06:54:54', 4, 1, 1, 1),
(17, '5 DAYS TRIP TO HUNZA KHUNJERAB PASS – GROUP TOUR', 'HUNZA KHUNJERAB PASS', 22500, '<p>Hunza Valley, in GB, is an attractive destination not only for locals but also for foreign tourists. We are offering a wide range of cheap &amp; reasonable Best Trip to cover all the main natural attractions of the Hunza. It is renowned not just for its sunny climate but also for the paradise of its dwellers, which is a source of interest for many visitors. In Addition, to the notable temptations of Hunza, there is always something exclusive that every tourist finds there for himself. We will cover all the main attractions of Hunza in 5 Days Trip to Hunza Valley<br />\r\n<br />\r\nIf you are looking for the best tour operators in Hunza Valley, So, we are here to serve you in better ways. Experienced team of Family Trip to Hunza Guides to make your tour memorable. Our road trip started mostly from Islamabad, Lahore. Pakistan&#39;s tourism industry is continuously growing. Plan your tour according to your days, budget with us.<br />\r\nPakistan are designed for your comfort and good memories. Guide will lead you with luxury services. We also have to Customize Your Tour option based on your requirements as 5, 6, 7 days Trip to Hunza and so on. People from all cities join us every week. For more details and private tour&nbsp;<a href=\"https://www.natureadventureclub.pk/make-my-trip\">Make My Trip</a></p>\r\n\r\n<p><strong>Recommended Gear:</strong></p>\r\n\r\n<ul>\r\n	<li>Trekking boots/Joggers/Comfortable Shoes/Slippers<br />\r\n	Back Pack<br />\r\n	Torches with extra batteries<br />\r\n	Waterproof lower and Jacket<br />\r\n	Thermals (both upper and lower)<br />\r\n	Fleece/Sweaters<br />\r\n	T shirts for day trekking<br />\r\n	Water bottle<br />\r\n	Socks</li>\r\n	<li>preferably woolen (4-6 pairs)<br />\r\n	Gloves (highly recommended)<br />\r\n	Muffler (highly recommended)<br />\r\n	Beanie (highly recommended)<br />\r\n	Hand wash/soap/sanitizer</li>\r\n	<li>wipes</li>\r\n	<li>tooth paste and all other necessities<br />\r\n	Sun Block and Sun glasses</li>\r\n</ul>\r\n', '_We1Mxcj7_W3NYVBLolJRy_8Hg0.jpg', '2022-06-20 06:54:54', 5, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblusers`
--

CREATE TABLE `tblusers` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `mobile` char(16) NOT NULL,
  `email` varchar(70) NOT NULL,
  `password` varchar(300) NOT NULL,
  `regdate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblusers`
--

INSERT INTO `tblusers` (`id`, `fullname`, `mobile`, `email`, `password`, `regdate`) VALUES
(8, 'Abdul Hahi', '03322501413', 'abdulhahi@gmail.com', '$pbkdf2-sha256$29000$pnTuPeecsxYi5JwTghBCSA$kq5TS/grdbtnBBzonEF7Ot0SAXOVIfD5JJjPP7bjDmI', '2022-06-19 10:27:56'),
(9, 'Rafiq Baloch', '923098163365', 'rafiqbaloch@gmail.com', '$pbkdf2-sha256$29000$l/IeA6D0fq8VAkCoNUZozQ$0vs//cQLwXS3tQQm6QJShsPS6R8gBR/O1SYip30fRoQ', '2022-06-20 09:34:46');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about`
--
ALTER TABLE `about`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblbooking`
--
ALTER TABLE `tblbooking`
  ADD PRIMARY KEY (`BookingId`);

--
-- Indexes for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblpages`
--
ALTER TABLE `tblpages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbltourpackages`
--
ALTER TABLE `tbltourpackages`
  ADD PRIMARY KEY (`PackageId`);

--
-- Indexes for table `tblusers`
--
ALTER TABLE `tblusers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `EmailId` (`email`),
  ADD KEY `EmailId_2` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `about`
--
ALTER TABLE `about`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tblbooking`
--
ALTER TABLE `tblbooking`
  MODIFY `BookingId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tblpages`
--
ALTER TABLE `tblpages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tbltourpackages`
--
ALTER TABLE `tbltourpackages`
  MODIFY `PackageId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tblusers`
--
ALTER TABLE `tblusers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
