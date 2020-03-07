-- MariaDB dump 10.17  Distrib 10.4.12-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ska-db
-- ------------------------------------------------------
-- Server version	10.4.12-MariaDB-1:10.4.12+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_entity_id` int(10) unsigned NOT NULL,
  `dest_entity_id` int(10) unsigned NOT NULL,
  `grant_date` datetime NOT NULL,
  `granted_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `source_entity_id_dest_entity_id` (`source_entity_id`,`dest_entity_id`),
  KEY `FK_access_entity_2` (`dest_entity_id`),
  KEY `FK_access_entity_3` (`granted_by`),
  CONSTRAINT `FK_access_entity` FOREIGN KEY (`source_entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_access_entity_2` FOREIGN KEY (`dest_entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_access_entity_3` FOREIGN KEY (`granted_by`) REFERENCES `entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access`
--

LOCK TABLES `access` WRITE;
/*!40000 ALTER TABLE `access` DISABLE KEYS */;
INSERT INTO `access` VALUES (1,4,6,'2019-04-22 13:22:40',2);
/*!40000 ALTER TABLE `access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `access_option`
--

DROP TABLE IF EXISTS `access_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_option` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `access_id` int(10) unsigned NOT NULL,
  `option` enum('command','from','environment','no-agent-forwarding','no-port-forwarding','no-pty','no-X11-forwarding','no-user-rc') NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_id_option` (`access_id`,`option`),
  CONSTRAINT `FK_access_option_access` FOREIGN KEY (`access_id`) REFERENCES `access` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_option`
--

LOCK TABLES `access_option` WRITE;
/*!40000 ALTER TABLE `access_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `access_request`
--

DROP TABLE IF EXISTS `access_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_entity_id` int(10) unsigned NOT NULL,
  `dest_entity_id` int(10) unsigned NOT NULL,
  `request_date` datetime NOT NULL,
  `requested_by` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `source_entity_id_dest_entity_id` (`source_entity_id`,`dest_entity_id`),
  KEY `FK_access_request_entity_2` (`dest_entity_id`),
  KEY `FK_access_request_entity_3` (`requested_by`),
  CONSTRAINT `FK_access_request_entity` FOREIGN KEY (`source_entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_access_request_entity_2` FOREIGN KEY (`dest_entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_access_request_entity_3` FOREIGN KEY (`requested_by`) REFERENCES `entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_request`
--

LOCK TABLES `access_request` WRITE;
/*!40000 ALTER TABLE `access_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity`
--

DROP TABLE IF EXISTS `entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('user','server account','group') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity`
--

LOCK TABLES `entity` WRITE;
/*!40000 ALTER TABLE `entity` DISABLE KEYS */;
INSERT INTO `entity` VALUES (1,'user'),(2,'user'),(3,'user'),(4,'group'),(5,'server account'),(6,'group');
/*!40000 ALTER TABLE `entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_admin`
--

DROP TABLE IF EXISTS `entity_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_admin` (
  `entity_id` int(10) unsigned NOT NULL,
  `admin` int(10) unsigned NOT NULL,
  PRIMARY KEY (`entity_id`,`admin`),
  KEY `FK_entity_admin_entity_2` (`admin`),
  CONSTRAINT `FK_entity_admin_entity` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_entity_admin_entity_2` FOREIGN KEY (`admin`) REFERENCES `entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_admin`
--

LOCK TABLES `entity_admin` WRITE;
/*!40000 ALTER TABLE `entity_admin` DISABLE KEYS */;
INSERT INTO `entity_admin` VALUES (4,2);
/*!40000 ALTER TABLE `entity_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_event`
--

DROP TABLE IF EXISTS `entity_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned NOT NULL,
  `actor_id` int(10) unsigned DEFAULT NULL,
  `date` datetime NOT NULL,
  `details` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_entity_event_entity_id` (`entity_id`),
  KEY `FK_entity_event_actor_id` (`actor_id`),
  CONSTRAINT `FK_entity_event_actor_id` FOREIGN KEY (`actor_id`) REFERENCES `entity` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_entity_event_entity_id` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_event`
--

LOCK TABLES `entity_event` WRITE;
/*!40000 ALTER TABLE `entity_event` DISABLE KEYS */;
INSERT INTO `entity_event` VALUES (1,2,1,'2019-04-22 13:20:58','{\"action\":\"User add\"}'),(2,3,1,'2019-04-22 13:21:04','{\"action\":\"User add\"}'),(3,4,1,'2019-04-22 13:21:13','{\"action\":\"Group add\"}'),(4,4,1,'2019-04-22 13:21:13','{\"action\":\"Administrator add\",\"value\":\"user:rainbow\"}'),(5,2,2,'2019-04-22 13:21:57','{\"action\":\"Pubkey add\",\"value\":\"6e:ef:f4:2d:1a:60:b5:fa:13:92:bc:93:fd:98:e1:00\"}'),(6,6,2,'2019-04-22 13:22:14','{\"action\":\"Group add\"}'),(7,6,2,'2019-04-22 13:22:14','{\"action\":\"Member add\",\"value\":\"account:root@test.example.com\"}'),(8,5,1,'2019-04-22 13:22:16','{\"action\":\"Setting update\",\"value\":\"sync success\",\"oldvalue\":\"not synced yet\",\"field\":\"Sync status\"}'),(9,6,2,'2019-04-22 13:22:40','{\"action\":\"Access add\",\"value\":\"group:admin\"}'),(10,4,2,'2019-04-22 13:23:25','{\"action\":\"Member add\",\"value\":\"user:rainbow\"}');
/*!40000 ALTER TABLE `entity_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `entity_id` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `system` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `FK_group_entity` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES (4,'admin',1,0),(6,'accounts-root',1,1);
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_event`
--

DROP TABLE IF EXISTS `group_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group` int(10) unsigned NOT NULL,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `date` datetime NOT NULL,
  `details` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_group_event_group` (`group`),
  KEY `FK_group_event_entity` (`entity_id`),
  CONSTRAINT `FK_group_event_entity` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_group_event_group` FOREIGN KEY (`group`) REFERENCES `group` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_event`
--

LOCK TABLES `group_event` WRITE;
/*!40000 ALTER TABLE `group_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_member`
--

DROP TABLE IF EXISTS `group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group` int(10) unsigned NOT NULL,
  `entity_id` int(10) unsigned NOT NULL,
  `add_date` datetime NOT NULL,
  `added_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_entity_id` (`group`,`entity_id`),
  KEY `FK_group_member_entity` (`entity_id`),
  KEY `FK_group_member_entity_2` (`added_by`),
  CONSTRAINT `FK_group_member_entity` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_group_member_entity_2` FOREIGN KEY (`added_by`) REFERENCES `entity` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_group_member_group` FOREIGN KEY (`group`) REFERENCES `group` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_member`
--

LOCK TABLES `group_member` WRITE;
/*!40000 ALTER TABLE `group_member` DISABLE KEYS */;
INSERT INTO `group_member` VALUES (1,6,5,'2019-04-22 13:22:14',2),(2,4,2,'2019-04-22 13:23:25',2);
/*!40000 ALTER TABLE `group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration`
--

DROP TABLE IF EXISTS `migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration` (
  `id` int(10) unsigned NOT NULL,
  `name` text NOT NULL,
  `applied` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` VALUES (1,'Add migration support','2019-04-22 13:19:58'),(2,'Initial setup, converted to migration','2019-04-22 13:20:01'),(3,'Add port number field','2019-04-22 13:20:01'),(4,'Add local usermanagment','2019-04-22 13:20:02'),(5,'Add key deprication to public key','2019-04-22 13:20:02'),(6,'Add additional ssh key access options','2019-04-22 13:20:02');
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_key`
--

DROP TABLE IF EXISTS `public_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `public_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned NOT NULL,
  `type` varchar(30) NOT NULL,
  `keydata` mediumtext NOT NULL,
  `comment` mediumtext NOT NULL,
  `keysize` int(11) DEFAULT NULL,
  `fingerprint_md5` char(47) DEFAULT NULL,
  `fingerprint_sha256` varchar(50) DEFAULT NULL,
  `randomart_md5` text DEFAULT NULL,
  `randomart_sha256` text DEFAULT NULL,
  `upload_date` datetime NOT NULL DEFAULT current_timestamp(),
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `public_key_fingerprint` (`fingerprint_sha256`),
  KEY `FK_public_key_entity` (`entity_id`),
  CONSTRAINT `FK_public_key_entity` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_key`
--

LOCK TABLES `public_key` WRITE;
/*!40000 ALTER TABLE `public_key` DISABLE KEYS */;
INSERT INTO `public_key` VALUES (1,2,'ssh-rsa','AAAAB3NzaC1yc2EAAAADAQABAAACAQC3/aRJAhxgH8zkw5yj/U8wOViPmn+yplS+I5laZ59357tFe+jcvGazr9EsSb4HeTkcC1ykSvFexqAz6D9i6bUug6Tqhrk+VoJsLQm6zCt8bSdMBPwHvUUzToVWVhdYD2MPPo6BnaWHCJhkh/FgQ3ymEvt06Vr81knN7spXhKe7/lc2MjDaVgZQ8ubRcpKO+lMVyU12Q09lHIgEJzInCLQSGwxVsVlVzHpueaNrkOom0+3h7GuLU98NoebC1Q6vtW+YhskT5nEmjDEt6F3KIw+hrb4VBcWbVkkXpmr2huzUlTBZqw5y8IGHGml02iOTr3udi12ru9sWkJF7D7p21z272mT05rJBzQcSbEwwoBr9tNyVNDdrCfLX/yZESPeX8JcOCOOefSzbFGWXkhs4EO4q6fT8xtVS2mDz/fm0Nd9h5wipMQOE2YARx8pEqNjbvY0NGDbUnqD5qj/fEdErp0DzhLpKyuX5HHil14dxBpjsxlo1CKGtr1j3QWsKlFM7snpdRoWsPqpTjqwRIUW/znjEaAkbuZs35gIqOr42clzfe9C20CjyvZZ1RvedcSCmzZsiyJzzWdOQ+KYJwsQXrHI1D1WII2oDa/DOI4RFZbPPpmQdGR1MgNPuJNo6+DE0GVZJb7R3f7xKDEOv+ScRnVfYiMpokeSG1nRUgCPpJy10Bw==','test@ska-demo.itmettke.de',4096,'6e:ef:f4:2d:1a:60:b5:fa:13:92:bc:93:fd:98:e1:00','dhS/m1bOqLMF3Icg8qeS7Xz2b4XwshhDY+/1OpP9X1A','+---[RSA 4096]----+\n|                 |\n|                 |\n|          .      |\n|         . .     |\n|      E.S..      |\n|       ++o.      |\n|        ==+.     |\n|       .+*o*..   |\n|         oO+o..  |\n+------[MD5]------+','+---[RSA 4096]----+\n|          .      |\n|           o     |\n|      . . o .   E|\n|       o ++o.o . |\n|        So=o+o+. |\n|       + +o.oO+..|\n|      o o  =*+o=.|\n|       +  =+o = +|\n|        ooo+.oo+=|\n+----[SHA256]-----+','2019-04-22 13:21:57',1);
/*!40000 ALTER TABLE `public_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_key_dest_rule`
--

DROP TABLE IF EXISTS `public_key_dest_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `public_key_dest_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `public_key_id` int(10) unsigned NOT NULL,
  `account_name_filter` varchar(50) NOT NULL,
  `hostname_filter` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_public_key_dest_rule_public_key` (`public_key_id`),
  CONSTRAINT `FK_public_key_dest_rule_public_key` FOREIGN KEY (`public_key_id`) REFERENCES `public_key` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_key_dest_rule`
--

LOCK TABLES `public_key_dest_rule` WRITE;
/*!40000 ALTER TABLE `public_key_dest_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `public_key_dest_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `public_key_signature`
--

DROP TABLE IF EXISTS `public_key_signature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `public_key_signature` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `public_key_id` int(10) unsigned NOT NULL,
  `signature` blob NOT NULL,
  `upload_date` datetime NOT NULL,
  `fingerprint` varchar(50) NOT NULL,
  `sign_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_public_key_signature_public_key` (`public_key_id`),
  CONSTRAINT `FK_public_key_signature_public_key` FOREIGN KEY (`public_key_id`) REFERENCES `public_key` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `public_key_signature`
--

LOCK TABLES `public_key_signature` WRITE;
/*!40000 ALTER TABLE `public_key_signature` DISABLE KEYS */;
/*!40000 ALTER TABLE `public_key_signature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server`
--

DROP TABLE IF EXISTS `server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) DEFAULT NULL,
  `hostname` varchar(150) NOT NULL,
  `ip_address` varchar(64) DEFAULT NULL,
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `key_management` enum('none','keys','other','decommissioned') NOT NULL DEFAULT 'keys',
  `authorization` enum('manual','automatic LDAP','manual LDAP') NOT NULL DEFAULT 'manual',
  `use_sync_client` enum('no','yes') NOT NULL DEFAULT 'no',
  `sync_status` enum('not synced yet','sync success','sync failure','sync warning') NOT NULL DEFAULT 'not synced yet',
  `configuration_system` enum('unknown','cf-sysadmin','puppet-devops','puppet-miniops','puppet-tvstore','none') NOT NULL DEFAULT 'unknown',
  `custom_keys` enum('not allowed','allowed') NOT NULL DEFAULT 'not allowed',
  `rsa_key_fingerprint` char(32) DEFAULT NULL,
  `port` int(10) unsigned NOT NULL DEFAULT 22,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`),
  KEY `ip_address` (`ip_address`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server`
--

LOCK TABLES `server` WRITE;
/*!40000 ALTER TABLE `server` DISABLE KEYS */;
INSERT INTO `server` VALUES (1,NULL,'test.example.com',NULL,0,'keys','manual','no','sync success','unknown','not allowed',NULL,22);
/*!40000 ALTER TABLE `server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_account`
--

DROP TABLE IF EXISTS `server_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_account` (
  `entity_id` int(10) unsigned NOT NULL,
  `server_id` int(10) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sync_status` enum('not synced yet','sync success','sync failure','sync warning','proposed') NOT NULL DEFAULT 'not synced yet',
  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `server_id_name` (`server_id`,`name`),
  KEY `FK_server_account_server` (`server_id`),
  CONSTRAINT `FK_server_account_entity` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_server_account_server` FOREIGN KEY (`server_id`) REFERENCES `server` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_account`
--

LOCK TABLES `server_account` WRITE;
/*!40000 ALTER TABLE `server_account` DISABLE KEYS */;
INSERT INTO `server_account` VALUES (5,1,'root','sync success',1);
/*!40000 ALTER TABLE `server_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_admin`
--

DROP TABLE IF EXISTS `server_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_admin` (
  `server_id` int(10) unsigned NOT NULL,
  `entity_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`server_id`,`entity_id`),
  KEY `FK_server_admin_entity` (`entity_id`),
  CONSTRAINT `FK_server_admin_entity` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_server_admin_server` FOREIGN KEY (`server_id`) REFERENCES `server` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_admin`
--

LOCK TABLES `server_admin` WRITE;
/*!40000 ALTER TABLE `server_admin` DISABLE KEYS */;
INSERT INTO `server_admin` VALUES (1,4);
/*!40000 ALTER TABLE `server_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_event`
--

DROP TABLE IF EXISTS `server_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(10) unsigned NOT NULL,
  `actor_id` int(10) unsigned DEFAULT NULL,
  `date` datetime NOT NULL,
  `details` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_server_log_server` (`server_id`),
  KEY `FK_server_event_actor_id` (`actor_id`),
  CONSTRAINT `FK_server_event_actor_id` FOREIGN KEY (`actor_id`) REFERENCES `entity` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_server_log_server` FOREIGN KEY (`server_id`) REFERENCES `server` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_event`
--

LOCK TABLES `server_event` WRITE;
/*!40000 ALTER TABLE `server_event` DISABLE KEYS */;
INSERT INTO `server_event` VALUES (1,1,2,'2019-04-22 13:22:14','{\"action\":\"Server add\"}'),(2,1,2,'2019-04-22 13:22:14','{\"action\":\"Account add\",\"value\":\"root\"}'),(3,1,2,'2019-04-22 13:22:14','{\"action\":\"Administrator add\",\"value\":\"group:admin\"}'),(4,1,1,'2019-04-22 13:22:15','{\"action\":\"Setting update\",\"value\":\"172.29.0.2\",\"oldvalue\":null,\"field\":\"Ip address\"}'),(5,1,1,'2019-04-22 13:22:15','{\"action\":\"Setting update\",\"value\":\"F85CFE3722AFBB4622E6D2738659B04C\",\"oldvalue\":null,\"field\":\"Rsa key fingerprint\"}'),(6,1,1,'2019-04-22 13:22:16','{\"action\":\"Sync status change\",\"value\":\"Synced successfully\"}'),(7,1,1,'2019-04-22 13:22:16','{\"action\":\"Setting update\",\"value\":\"sync success\",\"oldvalue\":\"not synced yet\",\"field\":\"Sync status\"}');
/*!40000 ALTER TABLE `server_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_ldap_access_option`
--

DROP TABLE IF EXISTS `server_ldap_access_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_ldap_access_option` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(10) unsigned NOT NULL,
  `option` enum('command','from','environment','no-agent-forwarding','no-port-forwarding','no-pty','no-X11-forwarding','no-user-rc') NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `server_id_option` (`server_id`,`option`),
  CONSTRAINT `FK_server_ldap_access_option_server` FOREIGN KEY (`server_id`) REFERENCES `server` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_ldap_access_option`
--

LOCK TABLES `server_ldap_access_option` WRITE;
/*!40000 ALTER TABLE `server_ldap_access_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_ldap_access_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_note`
--

DROP TABLE IF EXISTS `server_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_note` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(10) unsigned NOT NULL,
  `entity_id` int(10) unsigned DEFAULT NULL,
  `date` datetime NOT NULL,
  `note` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_server_note_server` (`server_id`),
  KEY `FK_server_note_user` (`entity_id`),
  CONSTRAINT `FK_server_note_entity` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_server_note_server` FOREIGN KEY (`server_id`) REFERENCES `server` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_note`
--

LOCK TABLES `server_note` WRITE;
/*!40000 ALTER TABLE `server_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sync_request`
--

DROP TABLE IF EXISTS `sync_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sync_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `server_id` int(10) unsigned NOT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `processing` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `server_id_account_name` (`server_id`,`account_name`),
  CONSTRAINT `FK_sync_request_server` FOREIGN KEY (`server_id`) REFERENCES `server` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sync_request`
--

LOCK TABLES `sync_request` WRITE;
/*!40000 ALTER TABLE `sync_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `sync_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `entity_id` int(10) unsigned NOT NULL,
  `uid` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `superior_entity_id` int(10) unsigned DEFAULT NULL,
  `auth_realm` enum('LDAP','local','external') NOT NULL DEFAULT 'LDAP',
  `active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `admin` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `developer` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `force_disable` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `csrf_token` binary(128) DEFAULT NULL,
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `uid` (`uid`),
  CONSTRAINT `FK_user_entity` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'keys-sync','Synchronization script','',NULL,'local',1,1,0,0,'062b84768356235762aa2fd7644f537c26376576de6dd2981b148107781df82e8c02267d12469206a9d81eaeade2c0e2f33f32ae847e4273106ca86928ef3441'),(2,'rainbow','Rain Bow','rainbow@localhost',NULL,'local',1,1,0,0,'21e1458206ae77367a3cbd93cd5f772d68d5db4619b9fffe72ba5424f11b1964b38b672ec473bee019bd4d237aae32e201afe0b6e03647cb8ed3fb880c7941a2'),(3,'proceme','Proce Me','proceme@localhost',NULL,'local',1,0,0,0,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_alert`
--

DROP TABLE IF EXISTS `user_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_alert` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `entity_id` int(10) unsigned NOT NULL,
  `class` varchar(15) NOT NULL,
  `content` mediumtext NOT NULL,
  `escaping` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `FK_user_alert_entity` (`entity_id`),
  CONSTRAINT `FK_user_alert_entity` FOREIGN KEY (`entity_id`) REFERENCES `entity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_alert`
--

LOCK TABLES `user_alert` WRITE;
/*!40000 ALTER TABLE `user_alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_alert` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-02 14:27:00
