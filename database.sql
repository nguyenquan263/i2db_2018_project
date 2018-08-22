/*
MySQL Backup
Source Server Version: 5.5.5
Source Database: i2db
Date: 14-Aug-18 22:42:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `answers`
-- ----------------------------
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `ANSWER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ANSWER_CONTENT` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL,
  `QUESTION_ID` int(11) NOT NULL,
  `IS_TRUE` tinyint(1) NOT NULL,
  `HAS_IMAGE` tinyint(1) NOT NULL,
  PRIMARY KEY (`ANSWER_ID`),
  KEY `FK_ANSWERS_RELATIONS_QUESTION` (`QUESTION_ID`),
  CONSTRAINT `FK_ANSWERS_RELATIONS_QUESTION` FOREIGN KEY (`QUESTION_ID`) REFERENCES `questions` (`QUESTION_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Table structure for `answer_images`
-- ----------------------------
DROP TABLE IF EXISTS `answer_images`;
CREATE TABLE `answer_images` (
  `ANSWER_IMAGE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ANSWER_IMAGE_NAME` varchar(30) COLLATE utf8_vietnamese_ci NOT NULL,
  `ANSWER_ID` int(11) NOT NULL,
  PRIMARY KEY (`ANSWER_IMAGE_ID`),
  KEY `FK_ANSWER_I_RELATIONS_ANSWERS` (`ANSWER_ID`),
  CONSTRAINT `FK_ANSWER_I_RELATIONS_ANSWERS` FOREIGN KEY (`ANSWER_ID`) REFERENCES `answers` (`ANSWER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Table structure for `contests`
-- ----------------------------
DROP TABLE IF EXISTS `contests`;
CREATE TABLE `contests` (
  `CONTEST_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CONTEST_NAME` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `STATUS` tinyint(1) NOT NULL,
  PRIMARY KEY (`CONTEST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Table structure for `makers`
-- ----------------------------
DROP TABLE IF EXISTS `makers`;
CREATE TABLE `makers` (
  `MAKER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MAKER_NAME` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `MAKER_IMAGE` varchar(30) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `USERNAME` varchar(20) COLLATE utf8_vietnamese_ci NOT NULL,
  `PASSWORD` varchar(20) COLLATE utf8_vietnamese_ci NOT NULL,
  PRIMARY KEY (`MAKER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Table structure for `questions`
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `QUESTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `QUESTION_CONTENT` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `SCORE` int(11) NOT NULL,
  `EXPLANATION` varchar(3000) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `HAS_IMAGE` tinyint(1) NOT NULL,
  `HAS_MULTIPLE_ANSWER` tinyint(1) NOT NULL,
  `TEST_ID` int(11) NOT NULL,
  PRIMARY KEY (`QUESTION_ID`),
  KEY `FK_QUESTION_RELATIONS_TESTS` (`TEST_ID`),
  CONSTRAINT `FK_QUESTION_RELATIONS_TESTS` FOREIGN KEY (`TEST_ID`) REFERENCES `tests` (`TEST_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Table structure for `question_images`
-- ----------------------------
DROP TABLE IF EXISTS `question_images`;
CREATE TABLE `question_images` (
  `QUESTION_IMAGE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `QUESTION_IMAGE_NAME` varchar(30) COLLATE utf8_vietnamese_ci NOT NULL,
  `QUESTION_ID` int(11) NOT NULL,
  PRIMARY KEY (`QUESTION_IMAGE_ID`),
  KEY `FK_QUESTION_RELATIONS_QUESTION` (`QUESTION_ID`),
  CONSTRAINT `FK_QUESTION_RELATIONS_QUESTION` FOREIGN KEY (`QUESTION_ID`) REFERENCES `questions` (`QUESTION_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Table structure for `selections`
-- ----------------------------
DROP TABLE IF EXISTS `selections`;
CREATE TABLE `selections` (
  `SELECTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ANSWER_ID` int(11) NOT NULL,
  `TAKING_ID` int(11) NOT NULL,
  PRIMARY KEY (`SELECTION_ID`),
  KEY `FK_SELECTIO_RELATIONS_TAKINGS` (`TAKING_ID`),
  KEY `FK_SELECTIO_RELATIONS_ANSWERS` (`ANSWER_ID`),
  CONSTRAINT `FK_SELECTIO_RELATIONS_ANSWERS` FOREIGN KEY (`ANSWER_ID`) REFERENCES `answers` (`ANSWER_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_SELECTIO_RELATIONS_TAKINGS` FOREIGN KEY (`TAKING_ID`) REFERENCES `takings` (`TAKING_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Table structure for `takers`
-- ----------------------------
DROP TABLE IF EXISTS `takers`;
CREATE TABLE `takers` (
  `TAKER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TAKER_NAME` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `TAKER_IMAGE` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL,
  `USERNAME` varchar(20) COLLATE utf8_vietnamese_ci NOT NULL,
  `PASSWORD` varchar(20) COLLATE utf8_vietnamese_ci NOT NULL,
  PRIMARY KEY (`TAKER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Table structure for `takings`
-- ----------------------------
DROP TABLE IF EXISTS `takings`;
CREATE TABLE `takings` (
  `TAKING_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TAKER_ID` int(11) NOT NULL,
  `TEST_ID` int(11) NOT NULL,
  `TAKING_TIME` int(11) DEFAULT NULL,
  `TOTAL_SCORE` int(11) DEFAULT NULL,
  PRIMARY KEY (`TAKING_ID`),
  KEY `FK_TAKINGS_RELATIONS_TAKERS` (`TAKER_ID`),
  KEY `FK_TAKINGS_RELATIONS_TESTS` (`TEST_ID`),
  CONSTRAINT `FK_TAKINGS_RELATIONS_TAKERS` FOREIGN KEY (`TAKER_ID`) REFERENCES `takers` (`TAKER_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TAKINGS_RELATIONS_TESTS` FOREIGN KEY (`TEST_ID`) REFERENCES `tests` (`TEST_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Table structure for `tests`
-- ----------------------------
DROP TABLE IF EXISTS `tests`;
CREATE TABLE `tests` (
  `TEST_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TEST_NAME` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  `CONTEST_ID` int(11) NOT NULL,
  `TEST_TYPE_ID` int(11) NOT NULL,
  `MAKER_ID` int(11) NOT NULL,
  `DURATION` int(11) NOT NULL,
  PRIMARY KEY (`TEST_ID`),
  KEY `FK_TESTS_RELATIONS_CONTESTS` (`CONTEST_ID`),
  KEY `FK_TESTS_RELATIONS_TEST_TYP` (`TEST_TYPE_ID`),
  KEY `FK_TESTS_RELATIONS_MAKERS` (`MAKER_ID`),
  CONSTRAINT `FK_TESTS_RELATIONS_CONTESTS` FOREIGN KEY (`CONTEST_ID`) REFERENCES `contests` (`CONTEST_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TESTS_RELATIONS_MAKERS` FOREIGN KEY (`MAKER_ID`) REFERENCES `makers` (`MAKER_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_TESTS_RELATIONS_TEST_TYP` FOREIGN KEY (`TEST_TYPE_ID`) REFERENCES `test_types` (`TEST_TYPE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Table structure for `test_types`
-- ----------------------------
DROP TABLE IF EXISTS `test_types`;
CREATE TABLE `test_types` (
  `TEST_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TEST_TYPE_NAME` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL,
  PRIMARY KEY (`TEST_TYPE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `answers` VALUES ('1','NO CHANGE','1','1','0'), ('2','dogs or cats are','1','1','0'), ('3','dogs and cats are','1','0','0'), ('4','dogs and cats is','1','0','0'), ('5','NO CHANGE','2','0','0'), ('6','one','2','0','0'), ('7','they','2','0','0'), ('8','he or she','2','1','0'), ('9','NO CHANGE','3','0','0'), ('10','you','3','1','0'), ('11','he or she','3','0','0'), ('12','people','3','0','0'), ('13','NO CHANGE','4','0','0'), ('14','the lamp was knocked over and smashed.','4','0','0'), ('15','we knocked over the lamp and it smashed','4','1','0'), ('16','nobody knew the lamp would be knocked over and smashed','4','0','0'), ('17','NO CHANGE','5','0','0'), ('18','and I have always admired Mark.','5','0','0'), ('19','is Mark, whom I have always admired.','5','0','0'), ('20','Mark is someone I have always admired.','5','1','0'), ('21','Noun','6','1','0'), ('22','Verb','6','0','0'), ('23','Phrase noun','6','0','0'), ('24','Preposition','6','0','0'), ('25','Voice','7','1','0'), ('26','Tone','7','0','0'), ('27','Opinion','7','0','0'), ('28','Appearance','7','0','0'), ('29','gave  ','8','1','0'), ('30','had given','8','0','0'), ('31','is giving','8','0','0'), ('32','be given','8','0','0'), ('33',' are you making','9','1','0'), ('34','had been made','9','0','0'), ('35','made','9','0','0'), ('36','Was coming','9','0','0'), ('37','Is someonecoming','9','1','0'), ('38','be','10','0','0'), ('39','had being','10','0','0'), ('40','is being','10','0','0'), ('41','has never been ','10','1','0'), ('42','was','10','0','0'), ('43','Vietnamese  ','11','0','0'), ('44','American','11','0','0'), ('45','Singapore','11','1','0'), ('46','Japanese','11','0','0'), ('47','season','12','0','0'), ('48','seasons','12','1','0'), ('49','people','12','0','0'), ('50','students','12','0','0'), ('51','go','13','0','0'), ('52','be going','13','0','0'), ('53','went','13','1','0'), ('54','had gone','13','0','0'), ('55','travelled','14','1','0'), ('56','is traveling','14','0','0'), ('57','had been travelled ','14','0','0'), ('58','being','15','0','0'), ('59','has been','15','1','0'), ('60','was ','15','0','0'), ('61','is being','15','0','0'), ('62','go','16','0','0'), ('63','went','16','1','0'), ('64','gone','16','0','0'), ('65','be going','16','0','0'), ('66','has been','17','1','0'), ('67','being','17','0','0'), ('68','was','17','0','0'), ('69','is being','17','0','0'), ('70','had die','18','0','0'), ('71','died','18','1','0'), ('72','had died','18','0','0'), ('73','die','18','0','0'), ('74','for','19','0','0'), ('75','about','19','0','0'), ('76','from','19','1','0'), ('77','at','19','0','0'), ('78','fewer','20','0','0'), ('79','much','20','0','0'), ('80','more','20','0','0'), ('81','many','20','1','0'), ('82','Singapore','21','1','0'), ('83','American','21','0','0'), ('84','Vietnamese','21','0','0'), ('85','Japanese','21','0','0'), ('86','given','22','0','0'), ('87','had given','22','0','0'), ('88','gave','22','1','0'), ('89','is giving','22','0','0'), ('90','more intelligent','23','0','0'), ('91','most intelligent','23','1','0'), ('92','less intelligent','23','0','0'), ('93','intelligent','23','0','0'), ('94','Hong Kong','24','1','0'), ('95','Vietnam','24','0','0'), ('96','Thai','24','0','0'), ('97','American','24','1','0'), ('98','Japan','24','0','0'), ('99','NOUN','25','1','0'), ('100','VERB','25','0','0');
INSERT INTO `answers` VALUES ('101','PREPOSITION','25','0','0'), ('102','ADJECTIVE','25','0','0'), ('103','built','26','0','0'), ('104','had been built','26','0','0'), ('105','was built','26','0','0'), ('106','has started','27','0','0'), ('107','start','27','0','0'), ('108','is starting','27','0','0'), ('109','had started','27','0','0'), ('110','A. village','28','0','0'), ('111','B. prevent','28','1','0'), ('113','C. earthquake','28','0','0'), ('114',' D. shelter','28','0','0'), ('115','A. NO CHANGE','29','0','0'), ('116','B. Mark is someone I have always admired','29','1','0'), ('122','C. is Mark, whom I have always admired.','29','0','0'), ('123','D. and I have always admired Mark','29','0','0'), ('124','led','30','1','0'), ('125','caused','30','0','0'), ('126','let','30','0','0'), ('127','result','30','0','0'), ('128','Someone has stolen my bicycle','31','1','0'), ('130','My bicycle has dissappeared somewhere','31','1','0'), ('131','I am sad beacuse of my bicycle','31','0','0'), ('132','Some one stole my bicycle','31','0','0'), ('133','had left','32','1','0'), ('134','leaves','32','0','0'), ('135','led','32','0','0'), ('136','Someone has stolen my bicycle','33','1','0'), ('137','Some one stole my bicycle','33','0','0'), ('138','I am sad beacuse of my bicycle','33','0','0'), ('139','My bicycle has dissappeared somewhere','33','1','0'), ('140','caused','34','0','0'), ('141','let','34','0','0'), ('142','led','34','1','0'), ('143','result','34','0','0'), ('144','was built','35','1','0'), ('145','had been built','35','0','0'), ('146','build','35','0','0'), ('147','is building','35','0','0'), ('148','A. NO CHANGE','36','0','0'), ('149','B. Mark is someone I have always admired','36','0','0'), ('150','C. is Mark, whom I have always admired.','36','0','0'), ('151','D. and I have always admired Mark','36','0','0'), ('152','leaves','37','0','0'), ('153','had left','37','0','0'), ('154','left','37','0','0'), ('155','A. village','38','0','0'), ('156','B.present','38','0','0'), ('157','C.shelter','38','0','0'), ('158','D.earthquake','38','0','0'), ('159','is starting','39','0','0'), ('160','had started','39','1','0'), ('161','starts','39','0','0'), ('162','a small program that is dynamically downloaded over the Web','40','1','0'), ('163','a small device','40','0','0'), ('164','like a tablet','40','0','0'), ('165','the class','41','1','0'), ('166','method','41','0','0'), ('167','function','41','0','0'), ('168','argument','41','0','0'), ('169','element','41','0','0'), ('170','64 bits','42','0','0'), ('171','32 bits','42','1','0'), ('172','16 bits','42','0','0'), ('173','long a = 100%9','43','0','0'), ('174','int a= 100/9','43','0','0'), ('175','int a=100%9','43','0','0'), ('176','long a=100/9','43','0','0'), ('177','//','44','1','0'), ('178','/*','44','1','0'), ('179','--','44','0','0'), ('180','**','44','0','0'), ('181','a small program that is dynamically downloaded over the Web','45','1','0'), ('182','a small device','45','0','0'), ('183','like a tablet','45','0','0'), ('184','the class','46','1','0'), ('185','method','46','0','0'), ('186','function','46','0','0'), ('187','argument','46','0','0'), ('211','none','46','0','0');
INSERT INTO `contests` VALUES ('1','English for beginners','0'), ('2','Midterm General English Contest','0'), ('3','Final General English Contest','0'), ('4','Java Basic','0'), ('5','Mathematic for beginners','0'), ('6','Primary Entrance Contest','0'), ('7','Secondary Entrance Contest','0'), ('8','Kid English Talent Contest','0'), ('9','Kid Math Talent Contest','0'), ('10','Ring Golden Bell','0');
INSERT INTO `makers` VALUES ('1','Nguyen Thuy Kim Lien','kimlien.png','lienntk','123abc'), ('2','Kim Lien','avatar2.jpg','Lien123','222abc'), ('3','NgocLan','avatar3.jpg','Lan123','333abc'), ('4','Thao Anh','avatar4.png','ThaoAnh123','444abc'), ('5','Binh Hung','avatar5','Hung123','55abc'), ('6','Corabel Fullard','LobortisSapien.xls','cfullard0','YLP72cH1po'), ('7','Joyce Skoyles','Interdum.doc','jskoyles1','aRBU2o'), ('8','Shaw Dowden','LigulaNecSem.avi','sdowden2','4KssUM881TY'), ('9','Tommie Standring','Nonummy.xls','tstandring3','aGjdBE'), ('10','Broddy Fero','NislUtVolutpat.tiff','bfero4','g7mK415'), ('11','Erhard MacCrann','NislAeneanLectus.ppt','emaccrann5','kp3Wpgwg'), ('12','Sky Ludlow','PulvinarSedNisl.tiff','sludlow6','iFrB9SUoJ1D'), ('13','Carlee Phoenix','OrciNullamMolestie.mp3','cphoenix7','zpF1a0QasX'), ('14','Quinlan Pere','CongueVivamus.avi','qpere8','e2nogoSGWB'), ('15','Ax Meegan','Eu.jpeg','ameegan9','3Pmbjjj');
INSERT INTO `questions` VALUES ('1','The evidence that hyenas are more closely related to mongooses than they are to either <b>dogs or cats is</b> both surprising and indisputable.','20','A is correct because the subject of the sentence is evidence, which is singular, and so the main verb is is. Even though that is a relative pronoun rather than a preposition, this is essentially the same as the prepositional-phrase trick. A clause between the main subject and verb of the sentence can be removed. Just skip over it when analyzing the sentence.\r\n\r\nB is incorrect because are is plural and so does not agree with evidence.\r\n\r\nC is incorrect because are is plural and so does not agree with evidence and also because either takes or, not and.\r\n\r\nD is incorrect because either takes or, not and.','0','1','1'), ('2','If any college student wants to make sure of joining a rock band at school, <b>you</b> would be wise to learn bass or drums because singers and guitarists are a dime a dozen.','20','D is correct because the main subject of the sentence, college student, is third-person singular. So the sentence needs the third-person singular pronoun(s) he or she.\r\n\r\nA is incorrect. Although the informal second-person pronoun you is often used in hypothetical examples, in this particular sentence, it does not agree with the third-person college student, which is the subject.\r\n\r\nB is incorrect because the formal pronoun one needs to be used consistently. If college student has already been established as the subject, then it cannot simply suddenly be replaced with one later in the sentence.\r\n\r\nC. is incorrect. Although people frequently use they as a gender-neutral third-person singular pronoun when speaking, it is still considered incorrect by most authorities. TIP: It is definitely wrong on the ACT test!','0','0','1'), ('3','You should always be on the lookout for new opportunities, but <b>one</b> should also avoid burning bridges if possible.','20','B is correct because the sentence is in the second person (you) and so should not deviate from this. Constructions like one or like he or she may be more formal than the second person, but consistency is more important than formality.\r\n\r\nA is incorrect because one does not match the initial you.\r\n\r\nC is incorrect because he or she does not match the initial you.\r\n\r\nD is incorrect because people does not match the initial you.','0','0','1'), ('4','While playing kickball in the living room, <b>the lamp got knocked over and smashed.','20','C is correct because this is a dangling-modifier question. Since the sentence begins with the independent descriptive word phrase While playing kickball in the living room, the noun or nouns that describe who were playing kickball need to come immediately after that comma. Only choice C, which begins the independent clause with the first-person plural pronoun we, provides an acceptable answer.\r\n\r\nA is incorrect because this would imply that the lamp itself was playing kickball in the living room.\r\n\r\nB is incorrect because this would imply that the lamp itself was playing kickball in the living room. (The distinction between got and was in choices A and B is a red herring.)\r\n\r\nD is incorrect because this would imply that nobody was playing kickball in the living room when obviously somebody must have been.','0','0','1'), ('5','As the first of my friends to own a home, <b>I have always admired Mark.','20','D is correct because the dependent descriptive phrase As the first of my friends to own a home, is referring to Mark. So the noun Mark must come immediately after the comma.\r\n\r\nA is incorrect because this would imply that the speaker (I), rather than Mark is the first of the friends to own a home.\r\n\r\nB is incorrect because the first clause is not an independent one. So a comma plus a conjunction is not necessary before the second.\r\n\r\nC is incorrect. Although this would be acceptable if the comma after home were omitted, the comma is still in the wrong place.','0','0','1'), ('6','A person, place, thing, or idea','20','Noun is correct, Single noun','0','0','2'), ('7','A description of a writer\'s personality','20',NULL,'0','0','2'), ('8','She (give)_______ me a book last month','20','answer: gave, key word: last month','0','0','2'), ('9','Why you (make)_______ a cake? Someone (come)_________ to tea?','20','2 answers, the action is happening','0','1','2'), ('10','Tom (never be)_________ to Hanoi.','20','','0','0','2'), ('11','Where is Tony from? ~ He is from____________.','20','name of country: a noun, not use adj','0','0','3'), ('12','There are four______________ in my country: spring, summer, autumn and winter','20','answer: seasons, plural noun','0','0','3'), ('13','In the early 1800s, onlyBritain (go)_________ though the industrial revolution','20',NULL,'0','0','3'), ('14',' My wife andI (travel)___________ to Mexico by air last summer','20','answer: travelled, key word: last summer','0','0','3'), ('15','Jane (be)_________ here since last week.','20','\"has been\" is correct, key word: since','0','0','3'), ('16','In the early 1800s, onlyBritain (go)_________ though the industrial revolution','20',NULL,'0','0','4'), ('17','Jane (be)_________ here since last week.','20','\"has been\" is correct, key word: since','0','0','4'), ('18','His father (die)__________ of cancer at the age of 60.','20',NULL,'0','0','4'), ('19','He looks different___________ his father.','20','answer: from, different + from + someone/something','0','0','4'), ('20','Ba has__________ days off than Mr. Trung.','20',NULL,'0','0','4'), ('21','Where is Tony from? ~ He is from____________.','20','name of country: a noun, not use adj','0','0','5'), ('22','She (give)_______ me a book last month','20','answer: gave, key word: last month','0','0','5'), ('23','My brother is the__________ in my family.','20','answer: most intelligent, Superlative - long adj','0','0','5'), ('24','Pantene is a _________ girl','20','answer: Hong Kong, American','0','1','5'), ('25','A person, place, thing, or idea','20','Noun is correct, Single noun','0','0','5'), ('26','Our school (built) _________________ a long time ago.','10','answer: was built, key word: a long time ago, passive verb','0','0','6'), ('27','By the time we came to the cinema, the film (start) ________________.','10','answer: had started, completed past verb','0','0','6'), ('28','Choose differet stress patterns: A.village             B. prevent               C. earthquake              D. shelter','10','answer: B.prevent, 2nd stress','0','0','6'), ('29','As the first of my friends to own a home, <b>I have always admired Mark.','10','C is incorrect. Although this would be acceptable if the comma after home were omitted, the comma is still in the wrong place.','0','0','6'), ('30','Environmental pollution has _____ to lots of health problems.','20','answer: led, lead-led-led, lead + to + result','0','0','6'), ('31','My bicycle had been stolen','30','answer: Someone has stolen my bicycle/ My bycycle has dissappeared somewhere','0','1','6'), ('32','He (leave)____ his house when he was 18','10','answer: had left, completed happening is the past','0','0','6'), ('33','My bicycle had been stolen','30','answer: Someone has stolen my bicycle/ My bycycle has dissappeared somewhere','0','1','7'), ('34','Environmental pollution has _____ to lots of health problems.','20','answer: led, lead-led-led, lead + to + result','0','0','7'), ('35','Our school (built) _________________ a long time ago.','10','answer: was built, key word: a long time ago, passive verb','0','0','7'), ('36','As the first of my friends to own a home, <b>I have always admired Mark','10','C is incorrect. Although this would be acceptable if the comma after home were omitted, the comma is still in the wrong place.','0','0','7'), ('37','answer: had left, completed happening is the past','10','answer: had left, completed happening is the past','0','0','7'), ('38','Choose differet stress patterns: A.village             B. prevent               C.shelter               D. earthquake','10','answer: B.prevent, 2nd stress','0','0','7'), ('39','By the time we came to the cinema, the film (start) ________________','10','answer: had started, completed past verb','0','0','7'), ('40','What is an applet?','10','answer: a small program that is dynamically downloaded over the Web','0','0','8'), ('41','What is the basic unit of encapsulation in Java?','20',NULL,'0','0','8'), ('42','what is the size of float?','20','answer: 32 bits','0','0','8'), ('43','how do you calculate the reminder of 100 / 9 ?','20','answer: int a = 100%9, reminder of divide: %','0','0','8'), ('44','comment','30','answer: /* (for mul-ti comment) and // (for single line comment)','0','1','8'), ('45','What is an applet?','20','answer: a small program that is dynamically downloaded over the Web','0','0','9'), ('46','an array of characters','20',NULL,'0','0','9'), ('47','String','10',NULL,'0','0','9'), ('51','What is the basic unit of encapsulation in Java?','20',NULL,'0','0','9'), ('52','what is the size of float?','30','answer: 60 bits','1','0','9');
INSERT INTO `selections` VALUES ('1','1','1'), ('2','8','1'), ('3','9','1'), ('4','15','1'), ('5','20','1'), ('6','2','1'), ('8','19','1');
INSERT INTO `takers` VALUES ('1','Kristian Alyutin','Diam.tiff','kalyutin0','opCLnl'), ('2','Emanuel Celiz','Viverra.mp3','eceliz1','zfij42WLp'), ('3','Ingemar Martynikhin','NislDuisAc.avi','imartynikhin2','9qsQSlvX28'), ('4','Carrol Beamiss','SitAmetSem.mpeg','cbeamiss3','NxdbjYqhu1'), ('5','Cloe Woolager','VariusInteger.gif','cwoolager4','wXCOoZ'), ('6','Glyn Berrane','UtBlanditNon.txt','gberrane5','OwpJMyqYwQv'), ('7','Rand Vader','Mattis.ppt','rvader6','QEQ2bP7rS2'), ('8','Marlow Muress','AtIpsum.tiff','mmuress7','vaOFWULR'), ('9','Brianne Pettiward','Suscipit.jpeg','bpettiward8','kfeFJyLXX3R'), ('10','Halli Ganforthe','Ut.xls','hganforthe9','AdwMMNdawE');
INSERT INTO `takings` VALUES ('1','1','1','1',NULL);
INSERT INTO `tests` VALUES ('1','English for beginners 1','1','1','1','15'), ('2','English for beginners 2','1','1','1','15'), ('3','Midterm General English 001','2','2','1','45'), ('4','Midterm General English 002','2','2','2','45'), ('5','Midterm General English 003','2','2','2','45'), ('6','Final General English GE01','3','3','3','60'), ('7','Final General English GE02','3','3','3','60'), ('8','Java Basic Test 001','4','4','6','20'), ('9','Java Basic Test 002','4','4','6','20'), ('10','Mathematic for beginners 1','5','5','9','30'), ('11','Mathematic for beginners 2','5','5','9','30'), ('12','Primary Entrance Contest 01','6','6','10','45'), ('13','Primary Entrance Contest 02','6','6','10','45'), ('14','Secondary Entrance Contest 01','7','7','13','45'), ('15','Secondary Entrance Contest 02','7','7','13','45'), ('16','Secondary Entrance Contest 03','7','7','13','45'), ('17','Kid English Talent Contest K01','8','8','12','20'), ('18','Kid English Talent Contest K02','8','8','14','20'), ('19','Kid Math Talent Contest K01','8','8','15','20'), ('20','Kid Math Talent Contest K02','9','9','7','20'), ('21',' Kid Math Talent Contest K03','9','9','6','20'), ('22',' Ring Golden Bell R01','10','10','8','25'), ('23','Ring Golden Bell R02','10','10','8','25'), ('24','Ring Golden Bell R03','10','10','8','25');
INSERT INTO `test_types` VALUES ('1','English - Beginners'), ('2','GE - Midterm'), ('3','GE - Final'), ('4','Java'), ('5','Math - Beginners'), ('6','Primary Entrance'), ('7','Secondary Entrance'), ('8','English - Kid'), ('9','Math - Kid'), ('10','General knowledge - Ring Golden Bell');
