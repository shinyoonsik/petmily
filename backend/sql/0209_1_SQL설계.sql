-- schema 이름은 petmily
-- show create table petmily.files; 역으로 쿼리문 생성 명령어
use petmily;
DROP TABLE IF EXISTS `member`;
-- 회원 테이블
CREATE TABLE `member` (
  `user_id` int AUTO_INCREMENT PRIMARY KEY,
  `user_email` varchar(128),
  `user_nickname` varchar(20),
  `user_password` varchar(128) DEFAULT NULL,
  `user_name` varchar(20),
  `user_content` varchar(200),
  `user_birth` DATE NOT NULL, -- 1997-03-31 형태
  `user_gender` char(3) , -- 남자:M, 여자:W
  `create_date` datetime DEFAULT current_timestamp(), -- 이건 임의로 일단 냅둘까
  `certified` varchar(30) default null
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `pet`;
-- 동물 테이블
CREATE TABLE `pet` (
  `pet_id` int AUTO_INCREMENT PRIMARY KEY,
  `user_id` int DEFAULT NULL, -- member의 user_id
  `pet_name` varchar(20),
  `pet_kind` varchar(20) DEFAULT NULL,
  `pet_gender` char(3) DEFAULT NULL, -- 남자:M, 여자:W
  `pet_age` int DEFAULT 0,
  `pet_content` varchar(500) DEFAULT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  `file_name` varchar(300) COLLATE utf8mb4_0900_as_cs NOT NULL,
  `file_oriname` varchar(400) COLLATE utf8mb4_0900_as_cs NOT NULL,
  `file_url` varchar(500) COLLATE utf8mb4_0900_as_cs NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `follow`;
-- 팔로잉/팔로워 테이블
CREATE TABLE `follow` (
  `follow_id` int AUTO_INCREMENT PRIMARY KEY,
  `from_id` int, -- member의 user_id
  `to_id` int, -- member의 user_id
  `from_nickname` varchar(20),
  `to_nickname` varchar(20),
  `f4f` TINYINT(1) default false, -- f4f : 맞팔
  `follow_date` datetime NOT NULL DEFAULT NOW() COMMENT '등록일'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



DROP TABLE IF EXISTS `letter`;
-- 쪽지함 테이블
CREATE TABLE `letter` (
  `letter_id` int AUTO_INCREMENT PRIMARY KEY,
  `recv_id` int NOT NULL, -- member의 user_id
  `send_id` int NOT NULL, -- member의 user_id
  `letter_title` varchar(100),
  `letter_content` varchar(400),
  `send_date` datetime DEFAULT current_timestamp(),
  `recv_check` int DEFAULT 0 -- 0이면 안읽음, 1이면 읽음
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



DROP TABLE IF EXISTS `feed`;
-- 피드 테이블
CREATE TABLE `feed` (
  `feed_id` int AUTO_INCREMENT PRIMARY KEY,
  `user_id` int, -- member의 user_id
  `feed_date` datetime DEFAULT current_timestamp(),
  `feed_content` varchar(500) DEFAULT null
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `comment`;
-- 댓글 테이블
CREATE TABLE `comment` (
  `comment_id` int AUTO_INCREMENT PRIMARY KEY,
  `feed_id` int, -- feed의 feed_id
  `parentcomment_id` int DEFAULT NULL, -- 상위 댓글 
  `comment_content` varchar(400), -- 댓글 내용
  `writer_id` int , -- member의 user_id
  `comment_date` datetime DEFAULT current_timestamp(),
  `comment_isdeleted` char(2) DEFAULT 'N' -- Y이면 삭제된 게시글
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 기존에 likey테이블로 되어있으므로, 처음 실행시, DROP TABLE IF EXISTS `likey`를 실행
-- i4a403.p.ssafy.io  // AWS URL
DROP TABLE IF EXISTS `likely`;
-- 좋아요 테이블
CREATE TABLE `likely` (
  `like_id` int AUTO_INCREMENT PRIMARY KEY,
  `user_id` int, 
  `feed_id` int  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
   `f_id` int NOT NULL AUTO_INCREMENT,
   `user_id` int DEFAULT NULL,
   `feed_id` int DEFAULT NULL,
   `file_type` varchar(100) COLLATE utf8mb4_0900_as_cs NOT NULL,
   `file_name` varchar(300) COLLATE utf8mb4_0900_as_cs NOT NULL,
   `filter_name` varchar(100) COLLATE utf8mb4_0900_as_cs NOT NULL,
   `file_oriname` varchar(400) COLLATE utf8mb4_0900_as_cs NOT NULL,
   `file_url` varchar(500) COLLATE utf8mb4_0900_as_cs NOT NULL,
   PRIMARY KEY (`f_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
 
 -- 태그 내용들을 담은 테이블
 DROP TABLE IF EXISTS `tag`;
 CREATE TABLE `petmily`.`tag` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `feed_id` INT NULL,
  `tag_content` VARCHAR(200) NULL,
  `create_date` DATETIME NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_as_cs;
 
 -- pettag 추가 테이블
DROP TABLE IF EXISTS `pettag`;
 CREATE TABLE `pettag` (
   `pt_id` int NOT NULL AUTO_INCREMENT,
   `feed_id` int DEFAULT NULL,
   `pet_id` int DEFAULT NULL,
   `pet_name` varchar(200) COLLATE utf8mb4_0900_as_cs DEFAULT NULL,
   PRIMARY KEY (`pt_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_as_cs;
 
  -- friendtag 추가 테이블
DROP TABLE IF EXISTS `friendtag`;
 CREATE TABLE `friendtag` (
   `ft_id` int NOT NULL AUTO_INCREMENT,
   `feed_id` int DEFAULT NULL,
   `friend_id` int DEFAULT NULL,
   `friend_nickname` varchar(200) COLLATE utf8mb4_0900_as_cs DEFAULT NULL,
   PRIMARY KEY (`ft_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_as_cs;
 
 
 -- 귀찮으면 써먹으세요~~~!~~~~
 INSERT INTO member (user_email, user_nickname, user_password, user_name, user_content,user_birth, user_gender, certified)
VALUES ('lizzey1@naver.com', '윤식', 'asdfasdf1', '1번' ,'윤식이다','1995-01-01', 'W', 'Y');

INSERT INTO member (user_email, user_nickname, user_password, user_name, user_content,user_birth, user_gender, certified)
VALUES ('lizzey2@naver.com', '상훈', 'asdfasdf1', '2번' ,'상훈이다','1995-01-01', 'W', 'Y');

INSERT INTO member (user_email, user_nickname, user_password, user_name, user_content,user_birth, user_gender, certified)
VALUES ('lizzey3@naver.com', '서영', 'asdfasdf1', '3번' ,'서영이다','1995-01-01', 'W', 'Y');

INSERT INTO member (user_email, user_nickname, user_password, user_name, user_content,user_birth, user_gender, certified)
VALUES ('lizzey4@naver.com', '다윤', 'asdfasdf1', '4번' ,'다윤이다','1995-01-01', 'W', 'Y');

-- follow 테스트...
INSERT INTO follow (from_id, to_id, from_nickname, to_nickname,f4f)
VALUES (1, 2, '윤식' ,'상훈',0);
INSERT INTO follow (from_id, to_id, from_nickname, to_nickname,f4f)
VALUES (1, 3, '윤식' ,'서영',1);
INSERT INTO follow (from_id, to_id, from_nickname, to_nickname,f4f)
VALUES (1,4, '윤식' ,'다윤',1);
INSERT INTO follow (from_id, to_id, from_nickname, to_nickname,f4f)
VALUES (4,1, '다윤' ,'윤식',1);
INSERT INTO follow (from_id, to_id, from_nickname, to_nickname,f4f)
VALUES (3, 1, '서영' ,'윤식',1);
INSERT INTO follow (from_id, to_id, from_nickname, to_nickname,f4f)
VALUES (2,3, '상훈' ,'서영',1);
INSERT INTO follow (from_id, to_id, from_nickname, to_nickname,f4f)
VALUES (3,2, '서영' ,'상훈',1);
INSERT INTO follow (from_id, to_id, from_nickname, to_nickname,f4f)
VALUES (2,4, '상훈' ,'다윤',0);

--   -- 채팅 관련 테이블
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat` (
   `chat_id` int NOT NULL AUTO_INCREMENT,
	`room_id` int,
    `send_id` int,
    `send_nickname` varchar(20),
    `receive_id` int,
	`receive_nickname` varchar(20),
    `body` varchar(500),
	`isread` tinyint(1),
    `send_date` datetime DEFAULT current_timestamp(),
   PRIMARY KEY (`chat_id`) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--  
 -- 채팅방 관련 테이블(개인마다 메시지 보내는 게 채팅룸이라고 생각)
 DROP TABLE IF EXISTS `room`;
CREATE TABLE `room` (
   `room_id` int NOT NULL AUTO_INCREMENT,
   `my_id` int, -- member의 user_id
   `your_id` int,
   PRIMARY KEY (`room_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
 
  -- 가장 최근 채팅글 관련 테이블
 DROP TABLE IF EXISTS `recentchat`;
CREATE TABLE `recentchat` (
	`recentchat_id` int not null AUTO_INCREMENT,
   `room_id` int,
   `send_id` int, -- member의 user_id
    `send_nickname` varchar(20),
	`receive_id` int,
	`receive_nickname` varchar(20),
    `body` varchar(500),
    `chat_id` int,
    	`isread` tinyint(1),
    `create_date` datetime DEFAULT current_timestamp(),
   PRIMARY KEY (`recentchat_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
  -- 알림 관련 테이블
 DROP TABLE IF EXISTS `alert`;
CREATE TABLE `alert` (
   `alert_id` int NOT NULL AUTO_INCREMENT,
   `user_id` int, -- member의 user_id
   `create_time` datetime DEFAULT current_timestamp(),
   `from_id` int, -- member의 user_id : ~님이 언급했습니다~ 할때 "~님"의 아이디
   `from_nickname` varchar(20),
   `alert_content` varchar(500),
   PRIMARY KEY (`alert_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
 
 -- 다이어리 테이블
DROP TABLE IF EXISTS `diary`;
CREATE TABLE `diary` (
   `diary_id` int NOT NULL AUTO_INCREMENT,
   `user_id` int, -- member의 user_id
   `diary_title` varchar(100),
   `diary_year` int not null,
   `diary_month` int not null,
   `diary_day` int not null,
   `diary_content` varchar(500),
   `diary_feeling` varchar(20),
   `diary_weather` varchar(20),
   `diary_activity` varchar(20),
   `create_date` datetime DEFAULT current_timestamp(),
   PRIMARY KEY (`diary_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
 
 
 DROP TABLE IF EXISTS `diaryfile`;
CREATE TABLE `diaryfile` (
   `df_id` int NOT NULL AUTO_INCREMENT,
   `user_id` int DEFAULT NULL,
   `diary_id` int DEFAULT NULL,
   `file_type` varchar(100) COLLATE utf8mb4_0900_as_cs NOT NULL,
   `file_name` varchar(300) COLLATE utf8mb4_0900_as_cs NOT NULL,
   `file_oriname` varchar(400) COLLATE utf8mb4_0900_as_cs NOT NULL,
   `file_url` varchar(500) COLLATE utf8mb4_0900_as_cs NOT NULL,
   PRIMARY KEY (`df_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
 
DROP TABLE IF EXISTS `diarypettag`;
 CREATE TABLE `diarypettag` (
   `dpt_id` int NOT NULL AUTO_INCREMENT,
   `user_id` int not null,
   `diary_id` int NOT NULL,
   `pet_id` int NOT NULL,
   PRIMARY KEY (`dpt_id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_as_cs;
 
  -- 댓글 테이블
 DROP TABLE IF EXISTS `memo`;
 CREATE TABLE `petmily`.`memo` (
  `memo_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(200) NULL,
  `comment` VARCHAR(500) NULL,
  `create_date` DATETIME NULL DEFAULT current_timestamp(),
  `feed_id` INT NULL,
  PRIMARY KEY (`memo_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_as_cs;