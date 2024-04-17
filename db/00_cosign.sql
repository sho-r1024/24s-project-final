DROP SCHEMA IF EXISTS `cosign` ;
CREATE SCHEMA IF NOT EXISTS `cosign` DEFAULT CHARACTER SET latin1 ;
USE `cosign` ;

create table if not exists User (
    user_id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (user_id),
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(10),
    email VARCHAR(30),
	social_media VARCHAR(50),
	bio text
);

create table if not exists Feed (
    user_id int NOT NULL,
    spotlight boolean,
    followed boolean,
    search boolean,
    PRIMARY KEY (user_id),
    CONSTRAINT fk_user_01 FOREIGN KEY (user_id)
                                        REFERENCES User(user_id)
                                        ON DELETE CASCADE ON UPDATE CASCADE

);

create table if not exists Labels (
    label_id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (label_id),
    name varchar(20),
    address varchar(50)
);

create table if not exists Managers (
    user_id int NOT NULL,
    label_id int NOT NULL,
    PRIMARY KEY (user_id, label_id),
    CONSTRAINT fk_user_01 FOREIGN KEY (user_id)
                                           REFERENCES User(user_id)
                                            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_label_01  FOREIGN KEY (label_id)
                                           REFERENCES Labels(label_id)
                                            ON DELETE CASCADE ON UPDATE CASCADE
);

create table if not exists Artists (
    artist_id int NOT NULL,
    manager_id int NOT NULl,
    label_id int,
    PRIMARY KEY (artist_id),
    number_fans int DEFAULT 0,
    CONSTRAINT fk_user_id FOREIGN KEY (artist_id)
                                REFERENCES User(user_id)
                                ON DELETE cascade ON UPDATE cascade,
    CONSTRAINT fk_label_id FOREIGN KEY (label_id)
                                REFERENCES Labels(label_id)
                                ON DELETE set null ON UPDATE cascade,
    CONSTRAINT fk_manager_id FOREIGN KEY (manager_id)
                                REFERENCES Managers(user_id)
                                ON DELETE cascade ON UPDATE cascade
);

create table if not exists Contracts (
    contract_id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (contract_id),
    contract_date DATETIME default current_timestamp,
    contract_artist_id int NOT NULL,
    contract_label_id int NOT NULL,
    contract_manager_id int NOT NULL,
    CONSTRAINT fk_artist_id FOREIGN KEY (contract_artist_id)
                                REFERENCES Artists(artist_id)
                                ON DELETE cascade ON UPDATE cascade,
    CONSTRAINT fk_contract_label_id FOREIGN KEY (contract_label_id)
                                REFERENCES Labels(label_id)
                                ON DELETE cascade ON UPDATE cascade,
    CONSTRAINT fk_contract_manager_id FOREIGN KEY (contract_manager_id)
                                REFERENCES Managers(user_id)
                                ON DELETE cascade ON UPDATE cascade
);

create table if not exists Music (
    song_id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (song_id),
    artist_id INT NOT NULL,
    genre varchar(15),
    playtime int DEFAULT 0,
    CONSTRAINT fk_song_artist FOREIGN KEY (song_id)
                                 REFERENCES Artists(artist_id)
                                 ON DELETE cascade ON UPDATE cascade
);

create table Creatives (
    creative_id int NOT NULL,
    CONSTRAINT fk_creative_id FOREIGN KEY (creative_id)
                       REFERENCES User(user_id)
                       ON DELETE cascade ON UPDATE cascade
);

create table if not exists Portfolios (
    portfolio_id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (portfolio_id),
    author_id int NOT NULL,
    title varchar(50),
    views int,
    CONSTRAINT fk_portfolio_author FOREIGN KEY (author_id)
                                      REFERENCES Creatives(creative_id)
                                      ON DELETE cascade ON UPDATE cascade
);

create table if not exists Services (
    service_id int NOT NULL AUTO_INCREMENT,
    creative_id int NOT NULL,
    title varchar(50),
    PRIMARY KEY (service_id),
    price decimal(18, 2) DEFAULT 0,
    CONSTRAINT fk_service_giver FOREIGN KEY (creative_id)
                                        REFERENCES Creatives(creative_id)
                                        ON DELETE CASCADE ON UPDATE CASCADE
);

create table if not exists Feedback (
    feedback_id int NOT NULL AUTO_INCREMENT,
    music_id int NOT NULL,
    user_id int,
    rating int,
    check(rating >= 1 and rating <= 100),
    PRIMARY KEY (feedback_id),
    CONSTRAINT fk_reviewer FOREIGN KEY (user_id)
                                    REFERENCES User(user_id)
                                    ON DELETE cascade ON UPDATE cascade
    CONSTRAINT fk_feedback_music FOREIGN KEY (music_id)
                                    REFERENCES Music(music_id)
                                    ON DELETE cascade ON UPDATE cascade
);









