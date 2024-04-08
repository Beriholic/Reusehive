
CREATE DATABASE reusehive;
USE reusehive;

CREATE TABLE user(
    id BIGINT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    gender TINYINT COMMENT '性别 男1 女0' NOT NULL,
    grade VARCHAR(20) COMMENT '年级' NOT NULL,
    academy VARCHAR(20) COMMENT '学院' NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    social_info VARCHAR(255) COMMENT '社交信息',
    avatar_img VARCHAR(255),
    back_img VARCHAR(255),
    INDEX (name)
);
CREATE TABLE user_pwd(
    uid BIGINT PRIMARY KEY ,
    password VARCHAR(255),
    FOREIGN KEY (uid) REFERENCES user(id)
);

CREATE TABLE item(
    id BIGINT,
    uid BIGINT,
    back_img VARCHAR(255),

    PRIMARY KEY (id,uid),

    name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    prices DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (uid) REFERENCES user(id)
);

CREATE TABLE manager(
    id BIGINT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE manager_pwd(
    id BIGINT PRIMARY KEY ,
    password VARCHAR(255),

    FOREIGN KEY (id) REFERENCES manager(id)
);

CREATE TABLE purchase_info(
    id BIGINT ,
    uid BIGINT ,
    item_id BIGINT,
    create_time DATETIME NOT NULL,
    prices DECIMAL(10,2) NOT NULL COMMENT '交易成功的价格',
    type TINYINT NOT NULL COMMENT '状态信息: 0交易中 1交易结束',

    PRIMARY KEY (id,uid,item_id),
    FOREIGN KEY (uid) REFERENCES user(id),
    FOREIGN KEY (item_id) REFERENCES item(id)
);


CREATE TABLE `message` (
                           `id` bigint NOT NULL,
                           `create_time` datetime,
                           `content` text NOT NULL,
                           `tousername` text,
                           `fromusername` text,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
