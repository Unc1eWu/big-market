# ************************************************************
# Sequel Ace SQL dump
# Version 20064
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.0.32)
# Database: big-market
# Generation Time: 2024-04-10 05:03:52 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE database if NOT EXISTS `big-market` default character set utf8mb4 collate utf8mb4_0900_ai_ci;
use `big-market`;
# Dump of table strategy
# ------------------------------------------------------------

DROP TABLE IF EXISTS `strategy`;

CREATE TABLE `strategy` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `strategy_id` int NOT NULL COMMENT '抽奖策略id',
  `strategy_desc` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '抽奖策略描述',
  `rule_models` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '策略模型',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '策略更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `strategy` WRITE;
/*!40000 ALTER TABLE `strategy` DISABLE KEYS */;

INSERT INTO `strategy` (`id`, `strategy_id`, `strategy_desc`, `rule_models`, `create_time`, `update_time`)
VALUES
	(1,10001,'抽奖策略A',NULL,'2024-04-10 10:36:52','2024-04-10 10:36:52');

/*!40000 ALTER TABLE `strategy` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table strategy_award
# ------------------------------------------------------------

DROP TABLE IF EXISTS `strategy_award`;

CREATE TABLE `strategy_award` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `strategy_id` int NOT NULL COMMENT '策略id',
  `award_id` int NOT NULL COMMENT '抽奖奖品id',
  `award_title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '抽奖奖品标题',
  `award_subtitle` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '抽奖奖品副标题',
  `award_count` int NOT NULL COMMENT '奖品库存总量',
  `award_count-surplus` int NOT NULL COMMENT '奖品库存剩余',
  `award_rate` decimal(6,4) NOT NULL COMMENT '奖品中奖概率',
  `rule_models` varchar(256) DEFAULT NULL COMMENT '规则模型，rule配置规则记录',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `strategy_award` WRITE;
/*!40000 ALTER TABLE `strategy_award` DISABLE KEYS */;

INSERT INTO `strategy_award` (`id`, `strategy_id`, `award_id`, `award_title`, `award_subtitle`, `award_count`, `award_count-surplus`, `award_rate`, `rule_models`, `sort`, `create_time`, `update_time`)
VALUES
	(1,10001,101,'随机积分',NULL,80000,80000,80.0000,'rule_random',1,'2024-04-10 10:45:45','2024-04-10 11:16:05'),
	(2,10001,102,'5次使用',NULL,10000,10000,10.0000,NULL,2,'2024-04-10 10:47:20','2024-04-10 10:54:23'),
	(3,10001,103,'10次使用',NULL,5000,5000,5.0000,NULL,3,'2024-04-10 10:48:55','2024-04-10 10:49:06'),
	(4,10001,104,'20次使用',NULL,4000,4000,4.0000,NULL,4,'2024-04-10 10:49:29','2024-04-10 10:49:29'),
	(5,10001,105,'增加GPT-4对话模型',NULL,600,600,0.6000,NULL,5,'2024-04-10 10:49:29','2024-04-10 10:51:02'),
	(6,10001,106,'增加DALL-E-2画图模型','抽奖1次后解锁',200,200,0.2000,NULL,6,'2024-04-10 10:49:29','2024-04-10 10:55:09'),
	(7,10001,107,'增加DALL-E-3画图模型','抽奖2次后解锁',199,199,0.1999,'rule_lock,rule_luck_award',6,'2024-04-10 10:49:29','2024-04-10 11:16:49'),
	(8,10001,108,'解锁全部模型','抽奖6次后解锁',1,1,0.0001,NULL,6,'2024-04-10 10:49:29','2024-04-10 11:16:50');

/*!40000 ALTER TABLE `strategy_award` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table strategy_rule
# ------------------------------------------------------------

DROP TABLE IF EXISTS `strategy_rule`;

CREATE TABLE `strategy_rule` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `strategy_id` int NOT NULL COMMENT '策略id',
  `award_id` int DEFAULT NULL COMMENT '抽奖id',
  `rule_type` int NOT NULL DEFAULT '0' COMMENT '抽奖规则类型【1-策略规则，2-奖品规则】',
  `rule_model` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '抽奖规则类型【rule_lock】',
  `rule_value` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '抽奖规则比值',
  `rule_desc` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '抽奖规则描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `strategy_rule` WRITE;
/*!40000 ALTER TABLE `strategy_rule` DISABLE KEYS */;

INSERT INTO `strategy_rule` (`id`, `strategy_id`, `award_id`, `rule_type`, `rule_model`, `rule_value`, `rule_desc`, `create_time`, `update_time`)
VALUES
	(1,10001,101,2,'rule_random','1,1000','随机积分策略','2024-04-10 10:57:06','2024-04-10 10:57:06'),
	(2,10001,107,2,'rule_lock','1','抽奖一次后解锁','2024-04-10 11:12:25','2024-04-10 11:13:10'),
	(3,10001,108,2,'rule_lock','2','抽奖两次后解锁','2024-04-10 11:12:25','2024-04-10 11:13:11'),
	(4,10001,109,2,'rule_lock','6','抽奖六次后解锁','2024-04-10 11:12:25','2024-04-10 11:13:49'),
	(5,10001,107,2,'rule_luck_award','1,1000','随机积分兜底','2024-04-10 11:12:25','2024-04-10 11:18:48'),
	(6,10001,NULL,1,'rule_weight','6000:102,103,104,105,106,107,108,109','随机积分兜底','2024-04-10 11:12:25','2024-04-10 11:20:26'),
	(7,10001,NULL,1,'rule_blacklist','1','黑名单用户，1积分兜底','2024-04-10 11:12:25','2024-04-10 11:20:26');

/*!40000 ALTER TABLE `strategy_rule` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
