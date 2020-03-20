CREATE TABLE IF NOT EXISTS room
(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    num INTEGER NOT NULL UNIQUE ,
    section INTEGER NOT NULL,
    floor INTEGER NOT NULL
);

# open data via https://www.yit-moscow.ru/siteassets/--/zhk-aalto/17.10.18/plany-zhilykh-etazhei.pdf
INSERT INTO room (num, floor, section)
VALUES
       (1,  2,  1), (2 , 2, 1) , (3, 2, 1)  , (4, 2, 1)  , (5, 2, 1)  , (6, 2, 1),
       (7,  3,  1), (8 , 3, 1) , (9, 3, 1)  , (10, 3, 1) , (11, 3, 1) , (12, 3, 1),
       (13, 4,  1), (14, 4, 1) , (15, 4, 1) , (16, 4, 1) , (17, 4, 1) , (18, 4, 1),
       (19, 5,  1), (20, 5, 1) , (21, 5, 1) , (22, 5, 1) , (23, 5, 1) , (24, 5, 1),
       (25, 6,  1), (26, 6, 1) , (27, 6, 1) , (28, 6, 1) , (29, 6, 1) , (30, 6, 1),
       (31, 7,  1), (32, 7, 1) , (33, 7, 1) , (34, 7, 1) , (35, 7, 1) , (36, 7, 1),
       (37, 8,  1), (38, 8, 1) , (39, 8, 1) , (40, 8, 1) , (41, 8, 1) , (42, 8, 1),
       (43, 9,  1), (44, 9, 1) , (45, 9, 1) , (46, 9, 1) , (47, 9, 1) , (48, 9, 1),
       (49, 10, 1), (50, 10, 1), (51, 10, 1), (52, 10, 1), (53, 10, 1), (54, 10, 1),
       (55, 11, 1), (56, 11, 1), (57, 11, 1), (58, 11, 1), (59, 11, 1), (60, 11, 1),
       (61, 12, 1), (62, 12, 1), (63, 12, 1), (64, 12, 1), (65, 12, 1), (66, 12, 1),
       (67, 13, 1), (68, 13, 1), (69, 13, 1), (70, 13, 1), (71, 13, 1), (72, 13, 1),
       (73, 14, 1), (74, 14, 1), (75, 14, 1), (76, 14, 1), (77, 14, 1), (78, 14, 1),

       (79,  2, 2), (80 , 2, 2), (81,  2, 2), (82,  2, 2), (83,  2, 2), (84, 2, 2) , (85, 2, 2) , (86, 2, 2) , (87, 2, 2) , (88, 2, 2) ,
       (89,  3, 2), (90 , 3, 2), (91,  3, 2), (92,  3, 3), (93,  3, 3), (94, 3, 3) , (95, 3, 2) , (96, 3, 2) , (97, 3, 2) , (98, 3, 2) ,
       (99,  4, 2), (100, 4, 2), (101, 4, 2), (102, 4, 4), (103, 4, 4), (104, 4, 4), (105, 4, 2), (106, 4, 2), (107, 4, 2), (108, 4, 2),
       (109, 5, 2), (110, 5, 2), (111, 5, 2), (112, 5, 5), (113, 5, 5), (114, 5, 5), (115, 5, 2), (116, 5, 2), (117, 5, 2), (118, 5, 2),
       (119, 6, 2), (120, 6, 2), (121, 6, 2), (122, 6, 6), (123, 6, 6), (124, 6, 6), (125, 6, 2), (126, 6, 2), (127, 6, 2), (128, 6, 2),

       (129, 2, 3), (130, 2, 3), (131, 2, 3), (132, 2, 2), (133, 2, 2), (134, 2, 2), (135, 2, 3),
       (136, 3, 3), (137, 3, 3), (138, 3, 3), (139, 3, 3), (140, 3, 3), (141, 3, 3), (142, 3, 3),
       (143, 4, 3), (144, 4, 3), (145, 4, 3), (146, 4, 4), (147, 4, 4), (148, 4, 4), (149, 4, 3),
       (150, 5, 3), (151, 5, 3), (152, 5, 3), (153, 5, 3), (154, 5, 3), (155, 5, 3), (156, 5, 3),
       (157, 6, 3), (158, 6, 3), (159, 6, 3), (160, 6, 3), (161, 6, 3), (162, 6, 3), (163, 6, 3),
       (164, 7, 3), (165, 2, 3), (166, 2, 3), (167, 2, 3), (168, 2, 3), (169, 2, 3), (170, 2, 3),
       (171, 8, 3), (172, 3, 3), (173, 3, 3), (174, 3, 3), (175, 3, 3), (176, 3, 3), (177, 3, 3);

CREATE TABLE IF NOT EXISTS person
(
    id INTEGER PRIMARY KEY,
    tg_login TEXT,
    phone TEXT,
    email TEXT,
    fio TEXT,
    role INTEGER  # 0 - default, 1 - admin
);

CREATE TABLE IF NOT EXISTS person_room
(
    id INTEGER PRIMARY KEY,
    person_id INTEGER,
    room_id INTEGER
)
