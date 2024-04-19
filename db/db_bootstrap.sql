CREATE DATABASE if not exists Cosign;

grant all privileges on Cosign.* to 'webapp'@'%';
flush privileges;

use Cosign;

create table if not exists User (
    user_id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (user_id),
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20),
    email VARCHAR(50),
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
    name varchar(60),
    address varchar(50)
);

create table if not exists Managers (
    user_id int NOT NULL,
    label_id int,
    PRIMARY KEY (user_id, label_id),
    CONSTRAINT fk_manager_01 FOREIGN KEY (user_id)
                                           REFERENCES User(user_id)
                                            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_label_01  FOREIGN KEY (label_id)
                                           REFERENCES Labels(label_id)
                                            ON DELETE CASCADE ON UPDATE CASCADE
);

create table if not exists Artists (
    artist_id int NOT NULL,
    manager_id int NOT NULL,
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
    contract_label_id int,
    contract_manager_id int,
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
    genre varchar(30),
    playtime varchar(50) default '0',
    CONSTRAINT fk_song_artist FOREIGN KEY (song_id)
                                 REFERENCES Artists(artist_id)
                                 ON DELETE cascade ON UPDATE cascade
);

create table if not exists Creatives (
    creative_id int NOT NULL,
    CONSTRAINT fk_creative_id FOREIGN KEY (creative_id)
                       REFERENCES User(user_id)
                       ON DELETE cascade ON UPDATE cascade
);

create table if not exists Portfolios (
    portfolio_id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (portfolio_id),
    author_id int NOT NULL,
    title varchar(75),
    views int,
    CONSTRAINT fk_portfolio_author FOREIGN KEY (author_id)
                                      REFERENCES Creatives(creative_id)
                                      ON DELETE cascade ON UPDATE cascade
);

create table if not exists Services (
    service_id int NOT NULL AUTO_INCREMENT,
    creative_id int NOT NULL,
    title varchar(75),
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
                                    ON DELETE cascade ON UPDATE cascade,
    CONSTRAINT fk_feedback_music FOREIGN KEY (music_id)
                                    REFERENCES Music(song_id)
                                    ON DELETE cascade ON UPDATE cascade
);

SELECT * FROM Music;

-- insert into User (user_id, first_name, last_name, email, social_media, bio) values (1, 'Hi', 'Burling', 'hburling0@unesco.org', '@CDFnBi', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.'); --
-- insert into User (user_id, first_name, last_name, email, social_media, bio) values (2, 'Olivero', 'Neaverson', 'oneaverson1@arizona.edu', '@VRdnzv', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.
-- Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.'); --
insert into User (user_id, first_name, last_name, email, social_media, bio) values (3, 'Elva', 'Hamor', 'ehamor2@berkeley.edu', '@GtDeuiqLE', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (4, 'Wash', 'Enbury', 'wenbury3@networkadvertising.org', '@hqcbWVQeSE', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (5, 'Therese', 'Betteridge', 'tbetteridge4@yale.edu', '@aFbTf', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (6, 'Gerry', 'Spaight', 'gspaight5@nps.gov', '@TokKmmtQKn', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (7, 'Vinson', 'Hynson', 'vhynson6@amazonaws.com', '@syLBSvVYZB', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (8, 'Babbie', 'Chatenet', 'bchatenet7@histats.com', '@TVKLO', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (9, 'Ellissa', 'Marl', 'emarl8@upenn.edu', '@QoEadZh', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (10, 'Terrance', 'Attwool', 'tattwool9@wufoo.com', '@OWzgUw', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (11, 'Meggi', 'Franzelini', 'mfranzelinia@live.com', '@lOpIhzOByR', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (12, 'Lazar', 'Belvin', 'lbelvinb@histats.com', '@NLPnRrDFmL', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (13, 'Ines', 'Skirven', 'iskirvenc@sakura.ne.jp', '@jaZidKd', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (14, 'Thalia', 'Hasser', 'thasserd@yellowbook.com', '@gquFCrV', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (15, 'Lilllie', 'Ding', 'ldinge@weebly.com', '@jJETSMIEcf', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (16, 'Luci', 'Gaynsford', 'lgaynsfordf@merriam-webster.com', '@fyTLfhi', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (17, 'Janot', 'Segrott', 'jsegrottg@chronoengine.com', '@nCsHmsL', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (18, 'Judd', 'Flori', 'jflorih@vk.com', '@jrluv', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (19, 'Dedie', 'Benner', 'dbenneri@vimeo.com', '@tWFVwYHxyb', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (20, 'Laurie', 'Sergean', 'lsergeanj@flavors.me', '@uUhaN', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (21, 'Cherish', 'Guidi', 'cguidik@imgur.com', '@XmLNNvjjV', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (22, 'Harlin', 'Dorow', 'hdorowl@purevolume.com', '@VAHnEHhXI', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (23, 'Reena', 'Greatbach', 'rgreatbachm@accuweather.com', '@DKyAmNyLlT', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (24, 'Denney', 'MacCollom', 'dmaccollomn@alibaba.com', '@QkyDs', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (25, 'Rozanna', 'Starrs', 'rstarrso@google.co.jp', '@JnLiOvHvi', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (26, 'Benedicta', 'Heaney`', 'bheaneyp@addthis.com', '@kZrVoeaPH', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (27, 'Bat', 'Jacox', 'bjacoxq@webnode.com', '@lBFGFYdGM', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (28, 'Lorain', 'Hebblewaite', 'lhebblewaiter@weibo.com', '@hbXbpuQ', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (29, 'Lyman', 'Yukhnin', 'lyukhnins@blog.com', '@IGtYcPO', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (30, 'Danika', 'Laneham', 'dlanehamt@merriam-webster.com', '@JLVioqS', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (31, 'Uriel', 'Allsop', 'uallsopu@tumblr.com', '@eUEMI', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (32, 'Pen', 'Merioth', 'pmeriothv@t.co', '@ItgroXZe', 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (33, 'Ange', 'Shedden', 'asheddenw@over-blog.com', '@VBwGNJJzP', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (34, 'Nap', 'Ziemen', 'nziemenx@cocolog-nifty.com', '@nJYdI', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (35, 'Geri', 'Roly', 'grolyy@census.gov', '@OZDoBDisF', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (36, 'Deirdre', 'Elsegood', 'delsegoodz@jigsy.com', '@abbRs', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.

Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (37, 'Jose', 'Topham', 'jtopham10@webmd.com', '@FmCzBa', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (38, 'Stuart', 'Demchen', 'sdemchen11@seesaa.net', '@pGEykyvi', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (39, 'Bee', 'Sorsby', 'bsorsby12@bbc.co.uk', '@GNtQHvFb', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into User (user_id, first_name, last_name, email, social_media, bio) values (40, 'Sayre', 'Allridge', 'sallridge13@histats.com', '@mtWwXKZGw', 'In congue. Etiam justo. Etiam pretium iaculis justo.');

insert into Labels (label_id, name, address) values (1, 'Gottlieb LLC', '371 Lerdahl Pass');
insert into Labels (label_id, name, address) values (2, 'Schroeder, Kuhlman and Ratke', '90 Burrows Crossing');
insert into Labels (label_id, name, address) values (3, 'Pagac-Hoeger', '69 Shasta Street');
insert into Labels (label_id, name, address) values (4, 'Von-Schroeder', '514 Marcy Parkway');
insert into Labels (label_id, name, address) values (5, 'Rempel-Kreiger', '9 Annamark Circle');
insert into Labels (label_id, name, address) values (6, 'Rosenbaum, Beahan and Simonis', '4024 Grim Park');
insert into Labels (label_id, name, address) values (7, 'Gleason, Towne and Witting', '0 Carpenter Alley');
insert into Labels (label_id, name, address) values (8, 'Hirthe, Lynch and Purdy', '93 Fairfield Center');
insert into Labels (label_id, name, address) values (9, 'Ledner LLC', '8 Scofield Junction');
insert into Labels (label_id, name, address) values (10, 'Langworth and Sons', '76757 Gina Hill');

insert into Managers (user_id, label_id) values (21, 1);
insert into Managers (user_id, label_id) values (22, 2);
insert into Managers (user_id, label_id) values (23, 3);
insert into Managers (user_id, label_id) values (24, 4);
insert into Managers (user_id, label_id) values (25, 5);
insert into Managers (user_id, label_id) values (26, 6);
insert into Managers (user_id, label_id) values (27, 7);
insert into Managers (user_id, label_id) values (28, 8);
insert into Managers (user_id, label_id) values (29, 9);
insert into Managers (user_id, label_id) values (30, 10);

insert into Artists (artist_id, manager_id, label_id, number_fans) values (1, 21, 1, 964697);
insert into Artists (artist_id, manager_id, label_id, number_fans) values (2, 22, 2, 518872);
insert into Artists (artist_id, manager_id, label_id, number_fans) values (3, 23, 3, 5472832);
insert into Artists (artist_id, manager_id, label_id, number_fans) values (4, 24, 4, 2746222);
insert into Artists (artist_id, manager_id, label_id, number_fans) values (5, 25, 5, 4872646);
insert into Artists (artist_id, manager_id, label_id, number_fans) values (6, 26, 6, 4534823);
insert into Artists (artist_id, manager_id, label_id, number_fans) values (7, 27, 7, 927220);
insert into Artists (artist_id, manager_id, label_id, number_fans) values (8, 28, 8, 8497321);
insert into Artists (artist_id, manager_id, label_id, number_fans) values (9, 29, 9, 4759206);
insert into Artists (artist_id, manager_id, label_id, number_fans) values (10, 30, 10, 9764729);

insert into Contracts (contract_id, contract_artist_id, contract_label_id, contract_manager_id) values (1, 1, 1, 21);
insert into Contracts (contract_id, contract_artist_id, contract_label_id, contract_manager_id) values (2, 2, 2, 22);
insert into Contracts (contract_id, contract_artist_id, contract_label_id, contract_manager_id) values (3, 3, 3, 23);
insert into Contracts (contract_id, contract_artist_id, contract_label_id, contract_manager_id) values (4, 4, 4, 24);
insert into Contracts (contract_id, contract_artist_id, contract_label_id, contract_manager_id) values (5, 5, 5, 25);
insert into Contracts (contract_id, contract_artist_id, contract_label_id, contract_manager_id) values (6, 6, 6, 26);
insert into Contracts (contract_id, contract_artist_id, contract_label_id, contract_manager_id) values (7, 7, 7, 27);
insert into Contracts (contract_id, contract_artist_id, contract_label_id, contract_manager_id) values (8, 8, 8, 28);
insert into Contracts (contract_id, contract_artist_id, contract_label_id, contract_manager_id) values (9, 9, 9, 29);
insert into Contracts (contract_id, contract_artist_id, contract_label_id, contract_manager_id) values (10, 10, 10, 30);

insert into Creatives (creative_id) values (11);
insert into Creatives (creative_id) values (12);
insert into Creatives (creative_id) values (13);
insert into Creatives (creative_id) values (14);
insert into Creatives (creative_id) values (15);
insert into Creatives (creative_id) values (16);
insert into Creatives (creative_id) values (17);
insert into Creatives (creative_id) values (18);
insert into Creatives (creative_id) values (19);
insert into Creatives (creative_id) values (20);

-- insert into Feedback (feedback_id, item_id, user_id, rating) values (1, 1, 1, 6);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (2, 2, 2, 8);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (3, 3, 3, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (4, 4, 4, 10);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (5, 5, 5, 1);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (6, 6, 6, 10);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (7, 7, 7, 4);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (8, 8, 8, 7);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (9, 9, 9, 3);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (10, 10, 10, 4);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (11, 11, 11, 3);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (12, 12, 12, 8);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (13, 13, 13, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (14, 14, 14, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (15, 15, 15, 9);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (16, 16, 16, 8);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (17, 17, 17, 1);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (18, 18, 18, 4);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (19, 19, 19, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (20, 20, 20, 10);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (21, 21, 21, 7);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (22, 22, 22, 6);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (23, 23, 23, 10);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (24, 24, 24, 1);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (25, 25, 25, 6);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (26, 26, 26, 7);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (27, 27, 27, 8);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (28, 28, 28, 3);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (29, 29, 29, 1);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (30, 30, 30, 5);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (31, 31, 31, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (32, 32, 32, 9);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (33, 33, 33, 10);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (34, 34, 34, 6);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (35, 35, 35, 7);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (36, 36, 36, 9);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (37, 37, 37, 5);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (38, 38, 38, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (39, 39, 39, 4);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (40, 40, 40, 10);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (41, 41, 41, 4);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (42, 42, 42, 3);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (43, 43, 43, 6);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (44, 44, 44, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (45, 45, 45, 8);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (46, 46, 46, 4);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (47, 47, 47, 5);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (48, 48, 48, 3);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (49, 49, 49, 1);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (50, 50, 50, 10);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (51, 51, 51, 6);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (52, 52, 52, 10);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (53, 53, 53, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (54, 54, 54, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (55, 55, 55, 3);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (56, 56, 56, 5);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (57, 57, 57, 4);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (58, 58, 58, 1);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (59, 59, 59, 8);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (60, 60, 60, 9);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (61, 61, 61, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (62, 62, 62, 4);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (63, 63, 63, 10);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (64, 64, 64, 6);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (65, 65, 65, 4);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (66, 66, 66, 7);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (67, 67, 67, 6);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (68, 68, 68, 2);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (69, 69, 69, 8);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (70, 70, 70, 9);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (71, 71, 71, 3);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (72, 72, 72, 1);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (73, 73, 73, 6);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (74, 74, 74, 8);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (75, 75, 75, 8);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (76, 76, 76, 9);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (77, 77, 77, 1);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (78, 78, 78, 7);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (79, 79, 79, 6);
-- insert into Feedback (feedback_id, item_id, user_id, rating) values (80, 80, 80, 8);

insert into Music (song_id, artist_id, genre, playtime) values (1, 1, 'Reggae', '4:30');
insert into Music (song_id, artist_id, genre, playtime) values (2, 2, 'Hip Hop', '3:00');
insert into Music (song_id, artist_id, genre, playtime) values (3, 3, 'Pop', '2.15');
insert into Music (song_id, artist_id, genre, playtime) values (4, 4, 'Pop', '2:15');
insert into Music (song_id, artist_id, genre, playtime) values (5, 5, 'R&B', '3:45');
insert into Music (song_id, artist_id, genre, playtime) values (6, 6, 'Pop', '3:00');
insert into Music (song_id, artist_id, genre, playtime) values (7, 7, 'Rock', '3:45');
insert into Music (song_id, artist_id, genre, playtime) values (8, 8, 'Rock', '3:45');
insert into Music (song_id, artist_id, genre, playtime) values (9, 9, 'Metal', '3:00');
insert into Music (song_id, artist_id, genre, playtime) values (10, 10, 'Metal', '4:30');

-- insert into Portfolios (portfolio_id, author_id, title, views) values (1, 11, 'Light of Day', 93020880);
-- insert into Portfolios (portfolio_id, author_id, title, views) values (2, 12, 'Going My Way', 853530499);
-- insert into Portfolios (portfolio_id, author_id, title, views) values (3, 13, 'Signs', 70289852);
-- insert into Portfolios (portfolio_id, author_id, title, views) values (4, 14, 'Lotta 2: Lotta flyttar hemifrån', 762544173);
-- insert into Portfolios (portfolio_id, author_id, title, views) values (5, 15, 'Point of No Return', 314545126);
-- insert into Portfolios (portfolio_id, author_id, title, views) values (6, 16, 'Mysterious Mr. Moto', 210397893);
-- insert into Portfolios (portfolio_id, author_id, title, views) values (7, 17, 'Happy', 765856519);
-- insert into Portfolios (portfolio_id, author_id, title, views) values (8, 18, 'Wings of Hope (Julianes Sturz in den Dschungel)', 682757268);
-- insert into Portfolios (portfolio_id, author_id, title, views) values (9, 19, 'Salt', 705381679);
-- insert into Portfolios (portfolio_id, author_id, title, views) values (10, 20, 'Sky Fighters (Les Chevaliers Du Ciel)', 547243036);

-- insert into Services (service_id, creative_id, title, price) values (21, 21, 'Country Bears, The', 235.86);
-- insert into Services (service_id, creative_id, title, price) values (22, 22, 'Sherlock Holmes Faces Death', 902.54);
-- insert into Services (service_id, creative_id, title, price) values (23, 23, 'Wartorn: 1861-2010', 993.57);
-- insert into Services (service_id, creative_id, title, price) values (24, 24, 'Pornorama', 330.88);
-- insert into Services (service_id, creative_id, title, price) values (25, 25, 'Tigger Movie, The', 991.11);
-- insert into Services (service_id, creative_id, title, price) values (26, 26, 'Two for the Money', 433.39);
-- insert into Services (service_id, creative_id, title, price) values (27, 27, 'Happy Accidents', 885.46);
-- insert into Services (service_id, creative_id, title, price) values (28, 28, 'Hans Christian Andersen', 371.19);
-- insert into Services (service_id, creative_id, title, price) values (29, 29, 'Left Behind: The Movie', 402.11);
-- insert into Services (service_id, creative_id, title, price) values (30, 30, 'AM1200', 36.14);
