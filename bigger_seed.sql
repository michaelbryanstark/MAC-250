USE team_netflix;

SOURCE team_netflix.sql;

-- Subscriptions
INSERT INTO
    subscription (
        id,
        subscription_type,
        subscription_price,
        subscription_duration
    )
VALUES (1, 'premium', 20.00, 1),
    (2, 'basic', 10.00, 1);

-- Accounts
INSERT INTO
    account (
        id,
        email,
        password,
        phone_number,
        subscription_id,
        account_created
    )
VALUES (
        101,
        'emma.rivera@gmail.com',
        'pass1011',
        '917-555-0101',
        1,
        '2026-10-20 09:15:00'
    ),
    (
        102,
        'michael.starkb@gmail.com',
        '0000',
        '917-854-4008',
        1,
        '2026-10-28 10:30:00'
    ),
    (
        103,
        'john.doe@gmail.com',
        '1234534368',
        '999-888-9988',
        2,
        '2026-10-28 11:45:00'
    ),
    (
        104,
        'sarah.chen@gmail.com',
        'pass1044',
        '212-555-0104',
        2,
        '2026-10-29 08:05:00'
    ),
    (
        105,
        'david.okafor@gmail.com',
        'pass1055',
        '646-555-0105',
        1,
        '2026-10-29 14:20:00'
    ),
    (
        106,
        'lily.nguyen@gmail.com',
        'pass1066',
        '718-555-0106',
        2,
        '2026-10-30 16:40:00'
    ),
    (
        107,
        'carlos.mendez@gmail.com',
        'pass1077',
        '347-555-0107',
        1,
        '2026-10-30 19:10:00'
    ),
    (
        108,
        'aisha.khan@gmail.com',
        'pass1088',
        '929-555-0108',
        2,
        '2026-10-31 12:00:00'
    ),
    (
        109,
        'tom.baker@gmail.com',
        'pass1099',
        '917-555-0109',
        1,
        '2026-11-01 07:50:00'
    ),
    (
        110,
        'priya.patel@gmail.com',
        'pass1100',
        '212-555-0110',
        2,
        '2026-11-02 21:25:00'
    );

-- Profiles
INSERT INTO
    profile (
        account_id,
        profile_id,
        profile_name,
        profile_picture,
        is_kid_profile
    )
VALUES (
        101,
        1,
        'Emma',
        'avatar_red.png',
        FALSE
    ),
    (
        102,
        2,
        'Michael',
        'avatar_blue.png',
        FALSE
    ),
    (
        102,
        3,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        103,
        4,
        'John',
        'avatar_green.png',
        FALSE
    ),
    (
        104,
        5,
        'Sarah',
        'avatar_purple.png',
        FALSE
    ),
    (
        105,
        6,
        'David',
        'avatar_orange.png',
        FALSE
    ),
    (
        106,
        7,
        'Lily',
        'avatar_cat.png',
        TRUE
    ),
    (
        107,
        8,
        'Carlos',
        'avatar_yellow.png',
        FALSE
    ),
    (
        108,
        9,
        'Aisha',
        'avatar_teal.png',
        FALSE
    ),
    (
        109,
        10,
        'Tom',
        'avatar_gray.png',
        FALSE
    );

-- Films (duration in minutes)
INSERT INTO
    film (id, title, duration, genre)
VALUES (1, 'Inception', 148, 'Sci-Fi'),
    (
        2,
        'The Dark Knight',
        152,
        'Action'
    ),
    (
        3,
        'Pulp Fiction',
        154,
        'Crime'
    ),
    (4, 'Titanic', 195, 'Romance'),
    (
        5,
        'Parasite',
        132,
        'Thriller'
    ),
    (
        6,
        'The Wolf of Wall Street',
        180,
        'Comedy'
    ),
    (7, 'Get Out', 104, 'Horror'),
    (8, 'Whiplash', 106, 'Drama'),
    (
        9,
        'Interstellar',
        169,
        'Sci-Fi'
    ),
    (
        10,
        'Fight Club',
        139,
        'Drama'
    );

-- TV shows (duration = typical episode length in minutes)
INSERT INTO
    tv_show (id, title, duration, genre)
VALUES (
        1,
        'Breaking Bad',
        47,
        'Crime'
    ),
    (
        2,
        'Stranger Things',
        51,
        'Sci-Fi'
    ),
    (
        3,
        'The Mandalorian',
        40,
        'Sci-Fi'
    ),
    (
        4,
        'The Queen''s Gambit',
        55,
        'Drama'
    ),
    (5, 'The Crown', 58, 'Drama'),
    (6, 'Ozark', 60, 'Crime'),
    (7, 'Narcos', 50, 'Crime'),
    (
        8,
        'Squid Game',
        55,
        'Thriller'
    );

-- Actors
INSERT INTO
    actor (id, first_name, last_name)
VALUES (1, 'Leonardo', 'DiCaprio'),
    (2, 'Christian', 'Bale'),
    (3, 'Samuel L.', 'Jackson'),
    (4, 'Song', 'Kang-ho'),
    (5, 'Daniel', 'Kaluuya'),
    (6, 'Miles', 'Teller'),
    (7, 'Matthew', 'McConaughey'),
    (8, 'Brad', 'Pitt'),
    (9, 'Bryan', 'Cranston'),
    (10, 'Millie', 'Bobby Brown'),
    (11, 'Pedro', 'Pascal'),
    (12, 'Anya', 'Taylor-Joy'),
    (13, 'Claire', 'Foy'),
    (14, 'Jason', 'Bateman'),
    (15, 'Wagner', 'Moura'),
    (16, 'Lee', 'Jung-jae');

-- Directors
INSERT INTO
    director (id, first_name, last_name)
VALUES (1, 'Christopher', 'Nolan'),
    (2, 'Quentin', 'Tarantino'),
    (3, 'James', 'Cameron'),
    (4, 'Bong', 'Joon-ho'),
    (5, 'Martin', 'Scorsese'),
    (6, 'Jordan', 'Peele'),
    (7, 'Damien', 'Chazelle'),
    (8, 'David', 'Fincher'),
    (9, 'Vince', 'Gilligan'),
    (10, 'Matt', 'Duffer'),
    (11, 'Jon', 'Favreau'),
    (12, 'Scott', 'Frank'),
    (13, 'Peter', 'Morgan'),
    (14, 'Jason', 'Bateman'),
    (15, 'Jose', 'Padilha'),
    (16, 'Hwang', 'Dong-hyuk');

-- Film <-> Actor
INSERT INTO
    film_actors (actor_id, film_id)
VALUES (1, 1), -- DiCaprio, Inception
    (2, 2), -- Bale, The Dark Knight
    (3, 3), -- Jackson, Pulp Fiction
    (1, 4), -- DiCaprio, Titanic
    (4, 5), -- Song Kang-ho, Parasite
    (1, 6), -- DiCaprio, Wolf of Wall Street
    (5, 7), -- Kaluuya, Get Out
    (6, 8), -- Teller, Whiplash
    (7, 9), -- McConaughey, Interstellar
    (8, 10);
-- Pitt, Fight Club

-- TV show <-> Actor
INSERT INTO
    tv_actors (actor_id, tv_show_id)
VALUES (9, 1), -- Cranston, Breaking Bad
    (10, 2), -- Millie Bobby Brown, Stranger Things
    (11, 3), -- Pascal, The Mandalorian
    (12, 4), -- Taylor-Joy, The Queen's Gambit
    (13, 5), -- Foy, The Crown
    (14, 6), -- Bateman, Ozark
    (15, 7), -- Moura, Narcos
    (16, 8);
-- Lee Jung-jae, Squid Game

-- Film <-> Director
INSERT INTO
    film_directors (director_id, film_id)
VALUES (1, 1),
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (5, 6),
    (6, 7),
    (7, 8),
    (1, 9),
    (8, 10);

-- TV show <-> Director
INSERT INTO
    tv_directors (director_id, tv_show_id)
VALUES (9, 1),
    (10, 2),
    (11, 3),
    (12, 4),
    (13, 5),
    (14, 6),
    (15, 7),
    (16, 8);

-- Watched (exactly one of film_id / tv_show_id is set per row)
INSERT INTO
    watched (
        account_id,
        is_watched,
        film_id,
        tv_show_id
    )
VALUES (101, TRUE, 1, NULL),
    (101, TRUE, NULL, 2),
    (102, TRUE, 2, NULL),
    (102, TRUE, NULL, 1),
    (103, TRUE, 3, NULL),
    (104, TRUE, NULL, 4),
    (105, TRUE, 9, NULL),
    (106, TRUE, NULL, 3),
    (107, TRUE, 5, NULL),
    (108, TRUE, NULL, 8);

-- Liked (exactly one of film_id / tv_show_id is set per row)
INSERT INTO
    liked (
        account_id,
        is_liked,
        film_id,
        tv_show_id
    )
VALUES (101, TRUE, 1, NULL),
    (101, TRUE, NULL, 2),
    (102, TRUE, 2, NULL),
    (102, FALSE, NULL, 1),
    (103, TRUE, 3, NULL),
    (104, TRUE, NULL, 4),
    (105, TRUE, 9, NULL),
    (106, FALSE, NULL, 3),
    (107, TRUE, 5, NULL),
    (108, TRUE, NULL, 8);

-- =====================================================
-- Additional seed data
-- =====================================================

-- Subscriptions (more)
INSERT INTO
    subscription (
        id,
        subscription_type,
        subscription_price,
        subscription_duration
    )
VALUES (3, 'standard', 15.00, 1),
    (4, 'basic annual', 100.00, 12),
    (
        5,
        'premium annual',
        200.00,
        12
    );

-- Accounts (more)
INSERT INTO
    account (
        id,
        email,
        password,
        phone_number,
        subscription_id,
        account_created
    )
VALUES (
        111,
        'olivia.johnson@gmail.com',
        'pass11117',
        '973-555-0111',
        1,
        '2026-11-03 12:07:00'
    ),
    (
        112,
        'liam.lopez@gmail.com',
        'pass11261',
        '917-555-0112',
        2,
        '2026-11-03 14:17:00'
    ),
    (
        113,
        'noah.lee@gmail.com',
        'pass11353',
        '212-555-0113',
        1,
        '2026-11-03 13:08:00'
    ),
    (
        114,
        'ava.king@gmail.com',
        'pass11423',
        '646-555-0114',
        5,
        '2026-11-03 18:47:00'
    ),
    (
        115,
        'mason.hill@gmail.com',
        'pass11541',
        '718-555-0115',
        3,
        '2026-11-03 16:37:00'
    ),
    (
        116,
        'sophia.turner@gmail.com',
        'pass11634',
        '347-555-0116',
        1,
        '2026-11-03 18:01:00'
    ),
    (
        117,
        'ethan.murphy@gmail.com',
        'pass11734',
        '929-555-0117',
        5,
        '2026-11-03 21:14:00'
    ),
    (
        118,
        'isabella.bailey@gmail.com',
        'pass11878',
        '201-555-0118',
        5,
        '2026-11-04 01:01:00'
    ),
    (
        119,
        'lucas.martinez@gmail.com',
        'pass11967',
        '973-555-0119',
        5,
        '2026-11-04 01:45:00'
    ),
    (
        120,
        'mia.jackson@gmail.com',
        'pass12027',
        '917-555-0120',
        4,
        '2026-11-04 04:14:00'
    ),
    (
        121,
        'logan.young@gmail.com',
        'pass12164',
        '212-555-0121',
        1,
        '2026-11-04 07:17:00'
    ),
    (
        122,
        'amelia.nelson@gmail.com',
        'pass12233',
        '646-555-0122',
        2,
        '2026-11-04 10:51:00'
    ),
    (
        123,
        'elijah.evans@gmail.com',
        'pass12345',
        '718-555-0123',
        3,
        '2026-11-04 12:27:00'
    ),
    (
        124,
        'harper.morris@gmail.com',
        'pass12469',
        '347-555-0124',
        2,
        '2026-11-04 11:09:00'
    ),
    (
        125,
        'james.reed@gmail.com',
        'pass12541',
        '929-555-0125',
        1,
        '2026-11-04 16:21:00'
    ),
    (
        126,
        'evelyn.davis@gmail.com',
        'pass12619',
        '201-555-0126',
        1,
        '2026-11-04 14:24:00'
    ),
    (
        127,
        'benjamin.moore@gmail.com',
        'pass12766',
        '973-555-0127',
        3,
        '2026-11-04 18:54:00'
    ),
    (
        128,
        'abigail.hall@gmail.com',
        'pass12880',
        '917-555-0128',
        1,
        '2026-11-04 21:16:00'
    ),
    (
        129,
        'henry.baker@gmail.com',
        'pass12922',
        '212-555-0129',
        5,
        '2026-11-05 00:29:00'
    ),
    (
        130,
        'ella.phillips@gmail.com',
        'pass13016',
        '646-555-0130',
        3,
        '2026-11-04 22:59:00'
    ),
    (
        131,
        'jack.stewart@gmail.com',
        'pass13193',
        '718-555-0131',
        2,
        '2026-11-05 00:35:00'
    ),
    (
        132,
        'grace.peterson@gmail.com',
        'pass13279',
        '347-555-0132',
        3,
        '2026-11-05 07:40:00'
    ),
    (
        133,
        'owen.miller@gmail.com',
        'pass13311',
        '929-555-0133',
        1,
        '2026-11-05 07:12:00'
    ),
    (
        134,
        'chloe.taylor@gmail.com',
        'pass13421',
        '201-555-0134',
        2,
        '2026-11-05 06:42:00'
    ),
    (
        135,
        'daniel.walker@gmail.com',
        'pass13540',
        '973-555-0135',
        1,
        '2026-11-05 12:18:00'
    ),
    (
        136,
        'zoe.adams@gmail.com',
        'pass13631',
        '917-555-0136',
        1,
        '2026-11-05 15:14:00'
    ),
    (
        137,
        'wyatt.carter@gmail.com',
        'pass13762',
        '212-555-0137',
        4,
        '2026-11-05 14:17:00'
    ),
    (
        138,
        'nora.edwards@gmail.com',
        'pass13872',
        '646-555-0138',
        3,
        '2026-11-05 18:53:00'
    ),
    (
        139,
        'leo.cooper@gmail.com',
        'pass13971',
        '718-555-0139',
        3,
        '2026-11-05 17:23:00'
    ),
    (
        140,
        'hazel.garcia@gmail.com',
        'pass14037',
        '347-555-0140',
        2,
        '2026-11-05 19:42:00'
    ),
    (
        141,
        'marcus.thomas@gmail.com',
        'pass14161',
        '929-555-0141',
        1,
        '2026-11-06 00:59:00'
    ),
    (
        142,
        'maya.lewis@gmail.com',
        'pass14217',
        '201-555-0142',
        2,
        '2026-11-06 01:40:00'
    ),
    (
        143,
        'andre.green@gmail.com',
        'pass14331',
        '973-555-0143',
        2,
        '2026-11-06 03:46:00'
    ),
    (
        144,
        'tessa.roberts@gmail.com',
        'pass14458',
        '917-555-0144',
        3,
        '2026-11-06 03:29:00'
    ),
    (
        145,
        'victor.collins@gmail.com',
        'pass14510',
        '212-555-0145',
        5,
        '2026-11-06 05:59:00'
    ),
    (
        146,
        'rosa.morgan@gmail.com',
        'pass14659',
        '646-555-0146',
        3,
        '2026-11-06 07:43:00'
    ),
    (
        147,
        'kenji.brown@gmail.com',
        'pass14743',
        '718-555-0147',
        1,
        '2026-11-06 13:49:00'
    ),
    (
        148,
        'yuki.anderson@gmail.com',
        'pass14868',
        '347-555-0148',
        1,
        '2026-11-06 11:52:00'
    ),
    (
        149,
        'omar.clark@gmail.com',
        'pass14946',
        '929-555-0149',
        3,
        '2026-11-06 17:20:00'
    ),
    (
        150,
        'fatima.scott@gmail.com',
        'pass15064',
        '201-555-0150',
        2,
        '2026-11-06 15:04:00'
    ),
    (
        151,
        'diego.mitchell@gmail.com',
        'pass15199',
        '973-555-0151',
        3,
        '2026-11-06 21:36:00'
    ),
    (
        152,
        'camila.parker@gmail.com',
        'pass15281',
        '917-555-0152',
        4,
        '2026-11-06 19:41:00'
    ),
    (
        153,
        'ravi.rogers@gmail.com',
        'pass15394',
        '212-555-0153',
        4,
        '2026-11-06 22:56:00'
    ),
    (
        154,
        'anika.williams@gmail.com',
        'pass15472',
        '646-555-0154',
        2,
        '2026-11-06 22:16:00'
    ),
    (
        155,
        'hugo.wilson@gmail.com',
        'pass15529',
        '718-555-0155',
        5,
        '2026-11-07 01:47:00'
    ),
    (
        156,
        'ines.harris@gmail.com',
        'pass15634',
        '347-555-0156',
        3,
        '2026-11-07 05:16:00'
    ),
    (
        157,
        'felix.wright@gmail.com',
        'pass15747',
        '929-555-0157',
        3,
        '2026-11-07 09:37:00'
    ),
    (
        158,
        'greta.campbell@gmail.com',
        'pass15837',
        '201-555-0158',
        2,
        '2026-11-07 08:14:00'
    ),
    (
        159,
        'jamal.torres@gmail.com',
        'pass15917',
        '973-555-0159',
        1,
        '2026-11-07 11:31:00'
    ),
    (
        160,
        'keisha.cook@gmail.com',
        'pass16084',
        '917-555-0160',
        1,
        '2026-11-07 14:03:00'
    ),
    (
        161,
        'olivia.williams@gmail.com',
        'pass16179',
        '212-555-0161',
        2,
        '2026-11-07 12:40:00'
    ),
    (
        162,
        'liam.wilson@gmail.com',
        'pass16217',
        '646-555-0162',
        3,
        '2026-11-07 19:43:00'
    ),
    (
        163,
        'noah.harris@gmail.com',
        'pass16350',
        '718-555-0163',
        3,
        '2026-11-07 19:04:00'
    ),
    (
        164,
        'ava.wright@gmail.com',
        'pass16417',
        '347-555-0164',
        4,
        '2026-11-07 20:38:00'
    ),
    (
        165,
        'mason.campbell@gmail.com',
        'pass16516',
        '929-555-0165',
        5,
        '2026-11-07 23:16:00'
    ),
    (
        166,
        'sophia.torres@gmail.com',
        'pass16684',
        '201-555-0166',
        1,
        '2026-11-08 03:00:00'
    ),
    (
        167,
        'ethan.cook@gmail.com',
        'pass16771',
        '973-555-0167',
        5,
        '2026-11-08 04:56:00'
    ),
    (
        168,
        'isabella.johnson@gmail.com',
        'pass16874',
        '917-555-0168',
        3,
        '2026-11-08 06:17:00'
    ),
    (
        169,
        'lucas.lopez@gmail.com',
        'pass16977',
        '212-555-0169',
        3,
        '2026-11-08 04:18:00'
    ),
    (
        170,
        'mia.lee@gmail.com',
        'pass17030',
        '646-555-0170',
        1,
        '2026-11-08 07:29:00'
    ),
    (
        171,
        'logan.king@gmail.com',
        'pass17117',
        '718-555-0171',
        2,
        '2026-11-08 12:56:00'
    ),
    (
        172,
        'amelia.hill@gmail.com',
        'pass17275',
        '347-555-0172',
        2,
        '2026-11-08 13:48:00'
    ),
    (
        173,
        'elijah.turner@gmail.com',
        'pass17320',
        '929-555-0173',
        1,
        '2026-11-08 15:58:00'
    ),
    (
        174,
        'harper.murphy@gmail.com',
        'pass17433',
        '201-555-0174',
        2,
        '2026-11-08 19:40:00'
    ),
    (
        175,
        'james.bailey@gmail.com',
        'pass17518',
        '973-555-0175',
        5,
        '2026-11-08 21:40:00'
    ),
    (
        176,
        'evelyn.martinez@gmail.com',
        'pass17686',
        '917-555-0176',
        2,
        '2026-11-08 21:12:00'
    ),
    (
        177,
        'benjamin.jackson@gmail.com',
        'pass17718',
        '212-555-0177',
        2,
        '2026-11-08 22:48:00'
    ),
    (
        178,
        'abigail.young@gmail.com',
        'pass17896',
        '646-555-0178',
        5,
        '2026-11-09 01:49:00'
    ),
    (
        179,
        'henry.nelson@gmail.com',
        'pass17940',
        '718-555-0179',
        3,
        '2026-11-09 05:00:00'
    ),
    (
        180,
        'ella.evans@gmail.com',
        'pass18061',
        '347-555-0180',
        1,
        '2026-11-09 05:01:00'
    ),
    (
        181,
        'jack.morris@gmail.com',
        'pass18125',
        '929-555-0181',
        2,
        '2026-11-09 09:23:00'
    ),
    (
        182,
        'grace.reed@gmail.com',
        'pass18282',
        '201-555-0182',
        2,
        '2026-11-09 07:03:00'
    ),
    (
        183,
        'owen.davis@gmail.com',
        'pass18341',
        '973-555-0183',
        1,
        '2026-11-09 13:36:00'
    ),
    (
        184,
        'chloe.moore@gmail.com',
        'pass18484',
        '917-555-0184',
        4,
        '2026-11-09 10:46:00'
    ),
    (
        185,
        'daniel.hall@gmail.com',
        'pass18586',
        '212-555-0185',
        5,
        '2026-11-09 17:04:00'
    ),
    (
        186,
        'zoe.baker@gmail.com',
        'pass18615',
        '646-555-0186',
        2,
        '2026-11-09 18:08:00'
    ),
    (
        187,
        'wyatt.phillips@gmail.com',
        'pass18789',
        '718-555-0187',
        5,
        '2026-11-09 20:30:00'
    ),
    (
        188,
        'nora.stewart@gmail.com',
        'pass18820',
        '347-555-0188',
        5,
        '2026-11-09 19:16:00'
    ),
    (
        189,
        'leo.peterson@gmail.com',
        'pass18963',
        '929-555-0189',
        3,
        '2026-11-10 01:38:00'
    ),
    (
        190,
        'hazel.miller@gmail.com',
        'pass19094',
        '201-555-0190',
        5,
        '2026-11-09 23:59:00'
    ),
    (
        191,
        'marcus.taylor@gmail.com',
        'pass19184',
        '973-555-0191',
        2,
        '2026-11-10 04:46:00'
    ),
    (
        192,
        'maya.walker@gmail.com',
        'pass19282',
        '917-555-0192',
        3,
        '2026-11-10 06:19:00'
    ),
    (
        193,
        'andre.adams@gmail.com',
        'pass19376',
        '212-555-0193',
        3,
        '2026-11-10 08:41:00'
    ),
    (
        194,
        'tessa.carter@gmail.com',
        'pass19450',
        '646-555-0194',
        5,
        '2026-11-10 08:57:00'
    ),
    (
        195,
        'victor.edwards@gmail.com',
        'pass19543',
        '718-555-0195',
        2,
        '2026-11-10 10:07:00'
    ),
    (
        196,
        'rosa.cooper@gmail.com',
        'pass19636',
        '347-555-0196',
        3,
        '2026-11-10 11:04:00'
    ),
    (
        197,
        'kenji.garcia@gmail.com',
        'pass19795',
        '929-555-0197',
        5,
        '2026-11-10 12:37:00'
    ),
    (
        198,
        'yuki.thomas@gmail.com',
        'pass19850',
        '201-555-0198',
        2,
        '2026-11-10 15:37:00'
    ),
    (
        199,
        'omar.lewis@gmail.com',
        'pass19940',
        '973-555-0199',
        1,
        '2026-11-10 16:04:00'
    ),
    (
        200,
        'fatima.green@gmail.com',
        'pass20043',
        '917-555-0200',
        1,
        '2026-11-10 19:04:00'
    ),
    (
        201,
        'diego.roberts@gmail.com',
        'pass20160',
        '212-555-0201',
        1,
        '2026-11-11 01:21:00'
    ),
    (
        202,
        'camila.collins@gmail.com',
        'pass20226',
        '646-555-0202',
        2,
        '2026-11-11 01:15:00'
    ),
    (
        203,
        'ravi.morgan@gmail.com',
        'pass20395',
        '718-555-0203',
        2,
        '2026-11-11 04:31:00'
    ),
    (
        204,
        'anika.brown@gmail.com',
        'pass20492',
        '347-555-0204',
        4,
        '2026-11-11 05:08:00'
    ),
    (
        205,
        'hugo.anderson@gmail.com',
        'pass20548',
        '929-555-0205',
        4,
        '2026-11-11 05:50:00'
    ),
    (
        206,
        'ines.clark@gmail.com',
        'pass20668',
        '201-555-0206',
        2,
        '2026-11-11 11:26:00'
    ),
    (
        207,
        'felix.scott@gmail.com',
        'pass20750',
        '973-555-0207',
        3,
        '2026-11-11 08:06:00'
    ),
    (
        208,
        'greta.mitchell@gmail.com',
        'pass20819',
        '917-555-0208',
        3,
        '2026-11-11 12:27:00'
    ),
    (
        209,
        'jamal.parker@gmail.com',
        'pass20911',
        '212-555-0209',
        1,
        '2026-11-11 14:55:00'
    ),
    (
        210,
        'keisha.rogers@gmail.com',
        'pass21068',
        '646-555-0210',
        1,
        '2026-11-11 18:41:00'
    );

-- Profiles (more)
INSERT INTO
    profile (
        account_id,
        profile_id,
        profile_name,
        profile_picture,
        is_kid_profile
    )
VALUES (
        111,
        11,
        'Olivia',
        'avatar_red.png',
        FALSE
    ),
    (
        112,
        12,
        'Liam',
        'avatar_blue.png',
        FALSE
    ),
    (
        113,
        13,
        'Noah',
        'avatar_green.png',
        FALSE
    ),
    (
        114,
        14,
        'Ava',
        'avatar_purple.png',
        FALSE
    ),
    (
        115,
        15,
        'Mason',
        'avatar_orange.png',
        FALSE
    ),
    (
        116,
        16,
        'Sophia',
        'avatar_yellow.png',
        FALSE
    ),
    (
        117,
        17,
        'Ethan',
        'avatar_teal.png',
        FALSE
    ),
    (
        118,
        18,
        'Isabella',
        'avatar_gray.png',
        FALSE
    ),
    (
        119,
        19,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        120,
        20,
        'Mia',
        'avatar_blue.png',
        FALSE
    ),
    (
        121,
        21,
        'Logan',
        'avatar_green.png',
        FALSE
    ),
    (
        122,
        22,
        'Amelia',
        'avatar_purple.png',
        FALSE
    ),
    (
        123,
        23,
        'Elijah',
        'avatar_orange.png',
        FALSE
    ),
    (
        124,
        24,
        'Harper',
        'avatar_yellow.png',
        FALSE
    ),
    (
        125,
        25,
        'James',
        'avatar_teal.png',
        FALSE
    ),
    (
        126,
        26,
        'Evelyn',
        'avatar_gray.png',
        FALSE
    ),
    (
        127,
        27,
        'Benjamin',
        'avatar_red.png',
        FALSE
    ),
    (
        128,
        28,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        129,
        29,
        'Henry',
        'avatar_green.png',
        FALSE
    ),
    (
        130,
        30,
        'Ella',
        'avatar_purple.png',
        FALSE
    ),
    (
        131,
        31,
        'Jack',
        'avatar_orange.png',
        FALSE
    ),
    (
        132,
        32,
        'Grace',
        'avatar_yellow.png',
        FALSE
    ),
    (
        133,
        33,
        'Owen',
        'avatar_teal.png',
        FALSE
    ),
    (
        134,
        34,
        'Chloe',
        'avatar_gray.png',
        FALSE
    ),
    (
        135,
        35,
        'Daniel',
        'avatar_red.png',
        FALSE
    ),
    (
        136,
        36,
        'Zoe',
        'avatar_blue.png',
        FALSE
    ),
    (
        137,
        37,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        138,
        38,
        'Nora',
        'avatar_purple.png',
        FALSE
    ),
    (
        139,
        39,
        'Leo',
        'avatar_orange.png',
        FALSE
    ),
    (
        140,
        40,
        'Hazel',
        'avatar_yellow.png',
        FALSE
    ),
    (
        141,
        41,
        'Marcus',
        'avatar_teal.png',
        FALSE
    ),
    (
        142,
        42,
        'Maya',
        'avatar_gray.png',
        FALSE
    ),
    (
        143,
        43,
        'Andre',
        'avatar_red.png',
        FALSE
    ),
    (
        144,
        44,
        'Tessa',
        'avatar_blue.png',
        FALSE
    ),
    (
        145,
        45,
        'Victor',
        'avatar_green.png',
        FALSE
    ),
    (
        146,
        46,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        147,
        47,
        'Kenji',
        'avatar_orange.png',
        FALSE
    ),
    (
        148,
        48,
        'Yuki',
        'avatar_yellow.png',
        FALSE
    ),
    (
        149,
        49,
        'Omar',
        'avatar_teal.png',
        FALSE
    ),
    (
        150,
        50,
        'Fatima',
        'avatar_gray.png',
        FALSE
    ),
    (
        151,
        51,
        'Diego',
        'avatar_red.png',
        FALSE
    ),
    (
        152,
        52,
        'Camila',
        'avatar_blue.png',
        FALSE
    ),
    (
        153,
        53,
        'Ravi',
        'avatar_green.png',
        FALSE
    ),
    (
        154,
        54,
        'Anika',
        'avatar_purple.png',
        FALSE
    ),
    (
        155,
        55,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        156,
        56,
        'Ines',
        'avatar_yellow.png',
        FALSE
    ),
    (
        157,
        57,
        'Felix',
        'avatar_teal.png',
        FALSE
    ),
    (
        158,
        58,
        'Greta',
        'avatar_gray.png',
        FALSE
    ),
    (
        159,
        59,
        'Jamal',
        'avatar_red.png',
        FALSE
    ),
    (
        160,
        60,
        'Keisha',
        'avatar_blue.png',
        FALSE
    ),
    (
        161,
        61,
        'Olivia',
        'avatar_green.png',
        FALSE
    ),
    (
        162,
        62,
        'Liam',
        'avatar_purple.png',
        FALSE
    ),
    (
        163,
        63,
        'Noah',
        'avatar_orange.png',
        FALSE
    ),
    (
        164,
        64,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        165,
        65,
        'Mason',
        'avatar_teal.png',
        FALSE
    ),
    (
        166,
        66,
        'Sophia',
        'avatar_gray.png',
        FALSE
    ),
    (
        167,
        67,
        'Ethan',
        'avatar_red.png',
        FALSE
    ),
    (
        168,
        68,
        'Isabella',
        'avatar_blue.png',
        FALSE
    ),
    (
        169,
        69,
        'Lucas',
        'avatar_green.png',
        FALSE
    ),
    (
        170,
        70,
        'Mia',
        'avatar_purple.png',
        FALSE
    ),
    (
        171,
        71,
        'Logan',
        'avatar_orange.png',
        FALSE
    ),
    (
        172,
        72,
        'Amelia',
        'avatar_yellow.png',
        FALSE
    ),
    (
        173,
        73,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        174,
        74,
        'Harper',
        'avatar_gray.png',
        FALSE
    ),
    (
        175,
        75,
        'James',
        'avatar_red.png',
        FALSE
    ),
    (
        176,
        76,
        'Evelyn',
        'avatar_blue.png',
        FALSE
    ),
    (
        177,
        77,
        'Benjamin',
        'avatar_green.png',
        FALSE
    ),
    (
        178,
        78,
        'Abigail',
        'avatar_purple.png',
        FALSE
    ),
    (
        179,
        79,
        'Henry',
        'avatar_orange.png',
        FALSE
    ),
    (
        180,
        80,
        'Ella',
        'avatar_yellow.png',
        FALSE
    ),
    (
        181,
        81,
        'Jack',
        'avatar_teal.png',
        FALSE
    ),
    (
        182,
        82,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        183,
        83,
        'Owen',
        'avatar_red.png',
        FALSE
    ),
    (
        184,
        84,
        'Chloe',
        'avatar_blue.png',
        FALSE
    ),
    (
        185,
        85,
        'Daniel',
        'avatar_green.png',
        FALSE
    ),
    (
        186,
        86,
        'Zoe',
        'avatar_purple.png',
        FALSE
    ),
    (
        187,
        87,
        'Wyatt',
        'avatar_orange.png',
        FALSE
    ),
    (
        188,
        88,
        'Nora',
        'avatar_yellow.png',
        FALSE
    ),
    (
        189,
        89,
        'Leo',
        'avatar_teal.png',
        FALSE
    ),
    (
        190,
        90,
        'Hazel',
        'avatar_gray.png',
        FALSE
    ),
    (
        191,
        91,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        192,
        92,
        'Maya',
        'avatar_blue.png',
        FALSE
    ),
    (
        193,
        93,
        'Andre',
        'avatar_green.png',
        FALSE
    ),
    (
        194,
        94,
        'Tessa',
        'avatar_purple.png',
        FALSE
    ),
    (
        195,
        95,
        'Victor',
        'avatar_orange.png',
        FALSE
    ),
    (
        196,
        96,
        'Rosa',
        'avatar_yellow.png',
        FALSE
    ),
    (
        197,
        97,
        'Kenji',
        'avatar_teal.png',
        FALSE
    ),
    (
        198,
        98,
        'Yuki',
        'avatar_gray.png',
        FALSE
    ),
    (
        199,
        99,
        'Omar',
        'avatar_red.png',
        FALSE
    ),
    (
        200,
        100,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        201,
        101,
        'Diego',
        'avatar_green.png',
        FALSE
    ),
    (
        202,
        102,
        'Camila',
        'avatar_purple.png',
        FALSE
    ),
    (
        203,
        103,
        'Ravi',
        'avatar_orange.png',
        FALSE
    ),
    (
        204,
        104,
        'Anika',
        'avatar_yellow.png',
        FALSE
    ),
    (
        205,
        105,
        'Hugo',
        'avatar_teal.png',
        FALSE
    ),
    (
        206,
        106,
        'Ines',
        'avatar_gray.png',
        FALSE
    ),
    (
        207,
        107,
        'Felix',
        'avatar_red.png',
        FALSE
    ),
    (
        208,
        108,
        'Greta',
        'avatar_blue.png',
        FALSE
    ),
    (
        209,
        109,
        'Kids',
        'avatar_panda.png',
        TRUE
    ),
    (
        210,
        110,
        'Keisha',
        'avatar_purple.png',
        FALSE
    );

-- Films (more) (duration in minutes)
INSERT INTO
    film (id, title, duration, genre)
VALUES (
        11,
        'The Godfather',
        175,
        'Crime'
    ),
    (
        12,
        'The Shawshank Redemption',
        142,
        'Drama'
    ),
    (
        13,
        'Goodfellas',
        145,
        'Crime'
    ),
    (
        14,
        'The Matrix',
        136,
        'Sci-Fi'
    ),
    (
        15,
        'Gladiator',
        155,
        'Action'
    ),
    (
        16,
        'Forrest Gump',
        142,
        'Drama'
    ),
    (17, 'Se7en', 127, 'Thriller'),
    (
        18,
        'The Silence of the Lambs',
        118,
        'Thriller'
    ),
    (
        19,
        'Saving Private Ryan',
        169,
        'War'
    ),
    (
        20,
        'Schindler''s List',
        195,
        'Drama'
    ),
    (
        21,
        'Jurassic Park',
        127,
        'Sci-Fi'
    ),
    (
        22,
        'Back to the Future',
        116,
        'Sci-Fi'
    ),
    (23, 'Alien', 117, 'Horror'),
    (
        24,
        'Blade Runner',
        117,
        'Sci-Fi'
    ),
    (
        25,
        'The Shining',
        146,
        'Horror'
    ),
    (26, 'Psycho', 109, 'Horror'),
    (
        27,
        'Casablanca',
        102,
        'Romance'
    ),
    (
        28,
        'The Notebook',
        123,
        'Romance'
    ),
    (
        29,
        'La La Land',
        128,
        'Romance'
    ),
    (30, 'Superbad', 113, 'Comedy'),
    (
        31,
        'The Hangover',
        100,
        'Comedy'
    ),
    (
        32,
        'Bridesmaids',
        125,
        'Comedy'
    ),
    (
        33,
        'Step Brothers',
        98,
        'Comedy'
    ),
    (34, 'Anchorman', 94, 'Comedy'),
    (
        35,
        'Mad Max: Fury Road',
        120,
        'Action'
    ),
    (
        36,
        'John Wick',
        101,
        'Action'
    ),
    (37, 'Die Hard', 132, 'Action'),
    (38, 'Heat', 170, 'Crime'),
    (39, 'Casino', 178, 'Crime'),
    (40, 'Scarface', 170, 'Crime'),
    (
        41,
        'No Country for Old Men',
        122,
        'Thriller'
    ),
    (
        42,
        'Gone Girl',
        149,
        'Thriller'
    ),
    (
        43,
        'Prisoners',
        153,
        'Thriller'
    ),
    (44, 'Zodiac', 157, 'Thriller'),
    (
        45,
        'Shutter Island',
        138,
        'Thriller'
    ),
    (
        46,
        'The Prestige',
        130,
        'Thriller'
    ),
    (
        47,
        'Memento',
        113,
        'Thriller'
    ),
    (48, 'Oldboy', 120, 'Thriller'),
    (49, 'Joker', 122, 'Drama'),
    (50, 'Moonlight', 111, 'Drama'),
    (51, 'Birdman', 119, 'Comedy'),
    (
        52,
        'Marriage Story',
        137,
        'Drama'
    ),
    (
        53,
        'Little Women',
        135,
        'Drama'
    ),
    (54, 'Lady Bird', 94, 'Comedy'),
    (
        55,
        'Spirited Away',
        125,
        'Animation'
    ),
    (
        56,
        'Toy Story',
        81,
        'Animation'
    ),
    (
        57,
        'Finding Nemo',
        100,
        'Animation'
    ),
    (
        58,
        'The Lion King',
        88,
        'Animation'
    ),
    (59, 'Coco', 105, 'Animation'),
    (60, 'Up', 96, 'Animation'),
    (
        61,
        'Inside Out',
        95,
        'Animation'
    ),
    (62, 'Shrek', 90, 'Animation'),
    (
        63,
        'Ratatouille',
        111,
        'Animation'
    ),
    (64, 'WALL-E', 98, 'Animation'),
    (
        65,
        'Hereditary',
        127,
        'Horror'
    ),
    (
        66,
        'A Quiet Place',
        90,
        'Horror'
    ),
    (67, 'It', 135, 'Horror'),
    (
        68,
        'The Conjuring',
        112,
        'Horror'
    ),
    (
        69,
        'Midsommar',
        148,
        'Horror'
    ),
    (
        70,
        'The Exorcist',
        122,
        'Horror'
    ),
    (71, 'Arrival', 116, 'Sci-Fi'),
    (
        72,
        'Ex Machina',
        108,
        'Sci-Fi'
    ),
    (73, 'Dune', 155, 'Sci-Fi'),
    (
        74,
        'Blade Runner 2049',
        164,
        'Sci-Fi'
    ),
    (
        75,
        'The Martian',
        144,
        'Sci-Fi'
    ),
    (76, 'Gravity', 91, 'Sci-Fi'),
    (
        77,
        'Edge of Tomorrow',
        113,
        'Sci-Fi'
    ),
    (78, 'Avatar', 162, 'Sci-Fi'),
    (
        79,
        'Terminator 2',
        137,
        'Action'
    ),
    (80, 'Aliens', 137, 'Sci-Fi'),
    (
        81,
        'The Avengers',
        143,
        'Action'
    ),
    (
        82,
        'Black Panther',
        134,
        'Action'
    ),
    (
        83,
        'Spider-Man: Into the Spider-Verse',
        117,
        'Animation'
    ),
    (84, 'Logan', 137, 'Action'),
    (
        85,
        'Top Gun: Maverick',
        130,
        'Action'
    ),
    (
        86,
        'Mission: Impossible - Fallout',
        147,
        'Action'
    ),
    (87, 'Skyfall', 143, 'Action'),
    (
        88,
        'Casino Royale',
        144,
        'Action'
    ),
    (
        89,
        'Knives Out',
        130,
        'Comedy'
    ),
    (
        90,
        'Everything Everywhere All at Once',
        139,
        'Sci-Fi'
    ),
    (
        91,
        'Oppenheimer',
        180,
        'Drama'
    ),
    (92, 'Barbie', 114, 'Comedy'),
    (
        93,
        'The Social Network',
        120,
        'Drama'
    ),
    (
        94,
        'Good Will Hunting',
        126,
        'Drama'
    ),
    (
        95,
        'A Beautiful Mind',
        135,
        'Drama'
    ),
    (
        96,
        'The Pianist',
        150,
        'Drama'
    ),
    (
        97,
        '12 Years a Slave',
        134,
        'Drama'
    ),
    (98, '1917', 119, 'War'),
    (99, 'Dunkirk', 106, 'War'),
    (
        100,
        'Full Metal Jacket',
        116,
        'War'
    ),
    (
        101,
        'Apocalypse Now',
        147,
        'War'
    ),
    (
        102,
        'Braveheart',
        178,
        'Action'
    ),
    (
        103,
        'The Departed',
        151,
        'Crime'
    ),
    (
        104,
        'Reservoir Dogs',
        99,
        'Crime'
    ),
    (
        105,
        'Django Unchained',
        165,
        'Western'
    ),
    (
        106,
        'Inglourious Basterds',
        153,
        'War'
    ),
    (
        107,
        'Unforgiven',
        130,
        'Western'
    ),
    (
        108,
        'True Grit',
        110,
        'Western'
    ),
    (109, 'Rocky', 120, 'Drama'),
    (110, 'Creed', 133, 'Drama');

-- TV shows (more)
INSERT INTO
    tv_show (id, title, duration, genre)
VALUES (
        9,
        'Game of Thrones',
        57,
        'Fantasy'
    ),
    (
        10,
        'The Sopranos',
        55,
        'Crime'
    ),
    (11, 'The Wire', 58, 'Crime'),
    (
        12,
        'Better Call Saul',
        46,
        'Crime'
    ),
    (13, 'Mad Men', 47, 'Drama'),
    (14, 'Succession', 60, 'Drama'),
    (
        15,
        'The Last of Us',
        55,
        'Drama'
    ),
    (16, 'Chernobyl', 65, 'Drama'),
    (
        17,
        'Black Mirror',
        60,
        'Sci-Fi'
    ),
    (18, 'Westworld', 60, 'Sci-Fi'),
    (
        19,
        'The Witcher',
        60,
        'Fantasy'
    ),
    (
        20,
        'Bridgerton',
        60,
        'Romance'
    ),
    (21, 'Wednesday', 50, 'Comedy'),
    (22, 'Dark', 55, 'Sci-Fi'),
    (
        23,
        'Money Heist',
        50,
        'Crime'
    ),
    (
        24,
        'Peaky Blinders',
        55,
        'Crime'
    ),
    (25, 'Mindhunter', 55, 'Crime'),
    (26, 'Dexter', 52, 'Crime'),
    (
        27,
        'True Detective',
        60,
        'Crime'
    ),
    (28, 'Fargo', 55, 'Crime'),
    (
        29,
        'The Office',
        22,
        'Comedy'
    ),
    (
        30,
        'Parks and Recreation',
        22,
        'Comedy'
    ),
    (31, 'Friends', 22, 'Comedy'),
    (32, 'Seinfeld', 22, 'Comedy'),
    (
        33,
        'Arrested Development',
        22,
        'Comedy'
    ),
    (
        34,
        'Brooklyn Nine-Nine',
        22,
        'Comedy'
    ),
    (
        35,
        'Schitt''s Creek',
        22,
        'Comedy'
    ),
    (36, 'Ted Lasso', 40, 'Comedy'),
    (37, 'The Bear', 35, 'Comedy'),
    (38, 'Atlanta', 30, 'Comedy'),
    (
        39,
        'Modern Family',
        22,
        'Comedy'
    ),
    (
        40,
        'How I Met Your Mother',
        22,
        'Comedy'
    ),
    (
        41,
        'Curb Your Enthusiasm',
        30,
        'Comedy'
    ),
    (42, 'Veep', 30, 'Comedy'),
    (43, 'Barry', 30, 'Comedy'),
    (44, 'Fleabag', 27, 'Comedy'),
    (45, 'Community', 22, 'Comedy'),
    (46, '30 Rock', 22, 'Comedy'),
    (
        47,
        'It''s Always Sunny in Philadelphia',
        22,
        'Comedy'
    ),
    (
        48,
        'BoJack Horseman',
        25,
        'Animation'
    ),
    (
        49,
        'Rick and Morty',
        22,
        'Animation'
    ),
    (
        50,
        'The Simpsons',
        22,
        'Animation'
    ),
    (
        51,
        'South Park',
        22,
        'Animation'
    ),
    (
        52,
        'Avatar: The Last Airbender',
        23,
        'Animation'
    ),
    (53, 'Arcane', 41, 'Animation'),
    (
        54,
        'Love, Death & Robots',
        15,
        'Animation'
    ),
    (55, 'Archer', 22, 'Animation'),
    (
        56,
        'Futurama',
        22,
        'Animation'
    ),
    (
        57,
        'Bob''s Burgers',
        22,
        'Animation'
    ),
    (
        58,
        'Family Guy',
        22,
        'Animation'
    ),
    (59, 'The Boys', 60, 'Action'),
    (60, 'Daredevil', 55, 'Action'),
    (
        61,
        'The Punisher',
        55,
        'Action'
    ),
    (62, 'Jack Ryan', 50, 'Action'),
    (63, 'Reacher', 50, 'Action'),
    (64, 'Vikings', 45, 'Action'),
    (
        65,
        'The Expanse',
        50,
        'Sci-Fi'
    ),
    (
        66,
        'Battlestar Galactica',
        45,
        'Sci-Fi'
    ),
    (
        67,
        'Star Trek: The Next Generation',
        45,
        'Sci-Fi'
    ),
    (
        68,
        'Doctor Who',
        45,
        'Sci-Fi'
    ),
    (
        69,
        'The X-Files',
        45,
        'Sci-Fi'
    ),
    (70, 'Lost', 43, 'Drama'),
    (71, 'Heroes', 43, 'Sci-Fi'),
    (72, 'Fringe', 45, 'Sci-Fi'),
    (
        73,
        'Severance',
        50,
        'Thriller'
    ),
    (74, 'Silo', 50, 'Sci-Fi'),
    (
        75,
        'Foundation',
        60,
        'Sci-Fi'
    ),
    (76, 'Andor', 45, 'Sci-Fi'),
    (77, 'Loki', 45, 'Sci-Fi'),
    (
        78,
        'WandaVision',
        35,
        'Sci-Fi'
    ),
    (
        79,
        'Homeland',
        55,
        'Thriller'
    ),
    (80, '24', 44, 'Thriller'),
    (
        81,
        'Killing Eve',
        45,
        'Thriller'
    ),
    (82, 'You', 50, 'Thriller'),
    (83, 'Sherlock', 90, 'Crime'),
    (
        84,
        'Broadchurch',
        45,
        'Crime'
    ),
    (
        85,
        'True Blood',
        55,
        'Horror'
    ),
    (
        86,
        'The Haunting of Hill House',
        55,
        'Horror'
    ),
    (
        87,
        'The Walking Dead',
        45,
        'Horror'
    ),
    (
        88,
        'American Horror Story',
        45,
        'Horror'
    ),
    (
        89,
        'Grey''s Anatomy',
        43,
        'Drama'
    ),
    (90, 'House', 44, 'Drama'),
    (91, 'ER', 43, 'Drama'),
    (92, 'This Is Us', 43, 'Drama'),
    (
        93,
        'Downton Abbey',
        50,
        'Drama'
    ),
    (94, 'Outlander', 55, 'Drama'),
    (
        95,
        'The Handmaid''s Tale',
        55,
        'Drama'
    ),
    (
        96,
        'Big Little Lies',
        55,
        'Drama'
    ),
    (
        97,
        'Yellowstone',
        50,
        'Drama'
    ),
    (98, 'Billions', 55, 'Drama'),
    (99, 'Suits', 43, 'Drama'),
    (
        100,
        'The Good Wife',
        43,
        'Drama'
    ),
    (
        101,
        'Gilmore Girls',
        45,
        'Comedy'
    ),
    (
        102,
        'One Tree Hill',
        42,
        'Drama'
    ),
    (103, 'Euphoria', 55, 'Drama'),
    (
        104,
        'Normal People',
        30,
        'Romance'
    ),
    (
        105,
        'Emily in Paris',
        30,
        'Comedy'
    ),
    (
        106,
        'Virgin River',
        45,
        'Romance'
    ),
    (
        107,
        'Sex Education',
        50,
        'Comedy'
    ),
    (
        108,
        'Heartstopper',
        30,
        'Romance'
    );

-- Actors (more)
INSERT INTO
    actor (id, first_name, last_name)
VALUES (17, 'Marlon', 'Brando'),
    (18, 'Al', 'Pacino'),
    (19, 'Tim', 'Robbins'),
    (20, 'Morgan', 'Freeman'),
    (21, 'Ray', 'Liotta'),
    (22, 'Robert De', 'Niro'),
    (23, 'Keanu', 'Reeves'),
    (24, 'Laurence', 'Fishburne'),
    (25, 'Russell', 'Crowe'),
    (26, 'Joaquin', 'Phoenix'),
    (27, 'Tom', 'Hanks'),
    (28, 'Robin', 'Wright'),
    (29, 'Jodie', 'Foster'),
    (30, 'Anthony', 'Hopkins'),
    (31, 'Matt', 'Damon'),
    (32, 'Liam', 'Neeson'),
    (33, 'Ralph', 'Fiennes'),
    (34, 'Sam', 'Neill'),
    (35, 'Laura', 'Dern'),
    (36, 'Michael J.', 'Fox'),
    (37, 'Christopher', 'Lloyd'),
    (38, 'Sigourney', 'Weaver'),
    (39, 'Harrison', 'Ford'),
    (40, 'Rutger', 'Hauer'),
    (41, 'Jack', 'Nicholson'),
    (42, 'Shelley', 'Duvall'),
    (43, 'Anthony', 'Perkins'),
    (44, 'Janet', 'Leigh'),
    (45, 'Humphrey', 'Bogart'),
    (46, 'Ingrid', 'Bergman'),
    (47, 'Ryan', 'Gosling'),
    (48, 'Rachel', 'McAdams'),
    (49, 'Emma', 'Stone'),
    (50, 'Jonah', 'Hill'),
    (51, 'Michael', 'Cera'),
    (52, 'Bradley', 'Cooper'),
    (53, 'Zach', 'Galifianakis'),
    (54, 'Kristen', 'Wiig'),
    (55, 'Maya', 'Rudolph'),
    (56, 'Will', 'Ferrell'),
    (57, 'John C.', 'Reilly'),
    (58, 'Christina', 'Applegate'),
    (59, 'Tom', 'Hardy'),
    (60, 'Charlize', 'Theron'),
    (61, 'Bruce', 'Willis'),
    (62, 'Alan', 'Rickman'),
    (63, 'Sharon', 'Stone'),
    (64, 'Michelle', 'Pfeiffer'),
    (65, 'Javier', 'Bardem'),
    (66, 'Josh', 'Brolin'),
    (67, 'Ben', 'Affleck'),
    (68, 'Rosamund', 'Pike'),
    (69, 'Hugh', 'Jackman'),
    (70, 'Jake', 'Gyllenhaal'),
    (71, 'Robert', 'Downey Jr.'),
    (72, 'Mark', 'Ruffalo'),
    (73, 'Guy', 'Pearce'),
    (74, 'Carrie-Anne', 'Moss'),
    (75, 'Choi', 'Min-sik'),
    (76, 'Mahershala', 'Ali'),
    (77, 'Trevante', 'Rhodes'),
    (78, 'Michael', 'Keaton'),
    (79, 'Adam', 'Driver'),
    (80, 'Scarlett', 'Johansson'),
    (81, 'Saoirse', 'Ronan'),
    (82, 'Emma', 'Watson'),
    (83, 'Laurie', 'Metcalf'),
    (84, 'Rumi', 'Hiiragi'),
    (85, 'Tim', 'Allen'),
    (86, 'Albert', 'Brooks'),
    (87, 'Ellen', 'DeGeneres'),
    (88, 'Matthew', 'Broderick'),
    (89, 'Jeremy', 'Irons'),
    (90, 'Anthony', 'Gonzalez'),
    (91, 'Gael', 'Garcia Bernal'),
    (92, 'Ed', 'Asner'),
    (93, 'Christopher', 'Plummer'),
    (94, 'Amy', 'Poehler'),
    (95, 'Phyllis', 'Smith'),
    (96, 'Mike', 'Myers'),
    (97, 'Eddie', 'Murphy'),
    (98, 'Patton', 'Oswalt'),
    (99, 'Ian', 'Holm'),
    (100, 'Ben', 'Burtt'),
    (101, 'Elissa', 'Knight'),
    (102, 'Toni', 'Collette'),
    (103, 'Alex', 'Wolff'),
    (104, 'Emily', 'Blunt'),
    (105, 'John', 'Krasinski'),
    (106, 'Bill', 'Skarsgard'),
    (107, 'Jaeden', 'Martell'),
    (108, 'Vera', 'Farmiga'),
    (109, 'Patrick', 'Wilson'),
    (110, 'Florence', 'Pugh'),
    (111, 'Jack', 'Reynor'),
    (112, 'Ellen', 'Burstyn'),
    (113, 'Linda', 'Blair'),
    (114, 'Amy', 'Adams'),
    (115, 'Jeremy', 'Renner'),
    (116, 'Domhnall', 'Gleeson'),
    (117, 'Alicia', 'Vikander'),
    (118, 'Timothee', 'Chalamet'),
    (119, 'Zendaya', 'Coleman'),
    (120, 'Jessica', 'Chastain'),
    (121, 'Sandra', 'Bullock'),
    (122, 'George', 'Clooney'),
    (123, 'Tom', 'Cruise'),
    (124, 'Sam', 'Worthington'),
    (125, 'Zoe', 'Saldana'),
    (
        126,
        'Arnold',
        'Schwarzenegger'
    ),
    (127, 'Linda', 'Hamilton'),
    (128, 'Michael', 'Biehn'),
    (129, 'Chris', 'Evans'),
    (130, 'Chadwick', 'Boseman'),
    (131, 'Michael B.', 'Jordan'),
    (132, 'Shameik', 'Moore'),
    (133, 'Hailee', 'Steinfeld'),
    (134, 'Patrick', 'Stewart'),
    (135, 'Henry', 'Cavill'),
    (136, 'Daniel', 'Craig'),
    (137, 'Eva', 'Green'),
    (138, 'Ana', 'de Armas'),
    (139, 'Michelle', 'Yeoh'),
    (140, 'Ke Huy', 'Quan'),
    (141, 'Cillian', 'Murphy'),
    (142, 'Margot', 'Robbie'),
    (143, 'Jesse', 'Eisenberg'),
    (144, 'Andrew', 'Garfield'),
    (145, 'Robin', 'Williams'),
    (146, 'Jennifer', 'Connelly'),
    (147, 'Adrien', 'Brody'),
    (148, 'Chiwetel', 'Ejiofor'),
    (149, 'Michael', 'Fassbender'),
    (150, 'George', 'MacKay'),
    (
        151,
        'Dean-Charles',
        'Chapman'
    ),
    (152, 'Fionn', 'Whitehead'),
    (153, 'Matthew', 'Modine'),
    (154, 'R. Lee', 'Ermey'),
    (155, 'Martin', 'Sheen'),
    (156, 'Mel', 'Gibson'),
    (157, 'Sophie', 'Marceau'),
    (158, 'Harvey', 'Keitel'),
    (159, 'Tim', 'Roth'),
    (160, 'Jamie', 'Foxx'),
    (161, 'Christoph', 'Waltz'),
    (162, 'Clint', 'Eastwood'),
    (163, 'Gene', 'Hackman'),
    (164, 'Jeff', 'Bridges'),
    (165, 'Sylvester', 'Stallone'),
    (166, 'Talia', 'Shire'),
    (167, 'Emilia', 'Clarke'),
    (168, 'Kit', 'Harington'),
    (169, 'James', 'Gandolfini'),
    (170, 'Edie', 'Falco'),
    (171, 'Dominic', 'West'),
    (172, 'Idris', 'Elba'),
    (173, 'Bob', 'Odenkirk'),
    (174, 'Rhea', 'Seehorn'),
    (175, 'Jon', 'Hamm'),
    (176, 'Elisabeth', 'Moss'),
    (177, 'Brian', 'Cox'),
    (178, 'Jeremy', 'Strong'),
    (179, 'Bella', 'Ramsey'),
    (180, 'Jared', 'Harris'),
    (181, 'Stellan', 'Skarsgard'),
    (182, 'Bryce Dallas', 'Howard'),
    (183, 'Evan Rachel', 'Wood'),
    (184, 'Thandiwe', 'Newton'),
    (185, 'Anya', 'Chalotra'),
    (186, 'Phoebe', 'Dynevor'),
    (187, 'Rege-Jean', 'Page'),
    (188, 'Jenna', 'Ortega'),
    (
        189,
        'Catherine',
        'Zeta-Jones'
    ),
    (190, 'Louis', 'Hofmann'),
    (191, 'Lisa', 'Vicari'),
    (192, 'Ursula', 'Corbero'),
    (193, 'Alvaro', 'Morte'),
    (194, 'Helen', 'McCrory'),
    (195, 'Jonathan', 'Groff'),
    (196, 'Holt', 'McCallany'),
    (197, 'Michael C.', 'Hall'),
    (198, 'Jennifer', 'Carpenter'),
    (199, 'Woody', 'Harrelson'),
    (200, 'Billy Bob', 'Thornton'),
    (201, 'Allison', 'Tolman'),
    (202, 'Steve', 'Carell'),
    (203, 'Nick', 'Offerman'),
    (204, 'Jennifer', 'Aniston'),
    (205, 'Matthew', 'Perry'),
    (206, 'Jerry', 'Seinfeld'),
    (207, 'Julia', 'Louis-Dreyfus'),
    (208, 'Andy', 'Samberg'),
    (209, 'Andre', 'Braugher'),
    (210, 'Eugene', 'Levy'),
    (211, 'Catherine', 'O''Hara'),
    (212, 'Jason', 'Sudeikis'),
    (213, 'Hannah', 'Waddingham'),
    (214, 'Jeremy Allen', 'White'),
    (215, 'Ayo', 'Edebiri'),
    (216, 'Donald', 'Glover'),
    (217, 'Brian Tyree', 'Henry'),
    (218, 'Ed', 'O''Neill'),
    (219, 'Sofia', 'Vergara'),
    (220, 'Josh', 'Radnor'),
    (221, 'Neil Patrick', 'Harris'),
    (222, 'Larry', 'David'),
    (223, 'Jeff', 'Garlin'),
    (224, 'Tony', 'Hale'),
    (225, 'Bill', 'Hader'),
    (226, 'Henry', 'Winkler'),
    (
        227,
        'Phoebe',
        'Waller-Bridge'
    ),
    (228, 'Sian', 'Clifford'),
    (229, 'Joel', 'McHale'),
    (230, 'Tina', 'Fey'),
    (231, 'Alec', 'Baldwin'),
    (232, 'Charlie', 'Day'),
    (233, 'Rob', 'McElhenney'),
    (234, 'Will', 'Arnett'),
    (235, 'Amy', 'Sedaris'),
    (236, 'Justin', 'Roiland'),
    (237, 'Chris', 'Parnell'),
    (238, 'Dan', 'Castellaneta'),
    (239, 'Julie', 'Kavner'),
    (240, 'Trey', 'Parker'),
    (241, 'Matt', 'Stone'),
    (242, 'Zach Tyler', 'Eisen'),
    (243, 'Mae', 'Whitman'),
    (244, 'Ella', 'Purnell'),
    (245, 'Topher', 'Grace'),
    (
        246,
        'Mary Elizabeth',
        'Winstead'
    ),
    (247, 'H. Jon', 'Benjamin'),
    (248, 'Aisha', 'Tyler'),
    (249, 'Billy', 'West'),
    (250, 'Katey', 'Sagal'),
    (251, 'John', 'Roberts'),
    (252, 'Seth', 'MacFarlane'),
    (253, 'Alex', 'Borstein'),
    (254, 'Karl', 'Urban'),
    (255, 'Antony', 'Starr'),
    (256, 'Charlie', 'Cox'),
    (257, 'Vincent', 'D''Onofrio'),
    (258, 'Jon', 'Bernthal'),
    (259, 'Ben', 'Barnes'),
    (260, 'Wendell', 'Pierce'),
    (261, 'Alan', 'Ritchson'),
    (262, 'Willa', 'Fitzgerald'),
    (263, 'Travis', 'Fimmel'),
    (264, 'Katheryn', 'Winnick'),
    (265, 'Steven', 'Strait'),
    (266, 'Thomas', 'Jane'),
    (267, 'Edward James', 'Olmos'),
    (268, 'Mary', 'McDonnell'),
    (269, 'Jonathan', 'Frakes'),
    (270, 'David', 'Tennant'),
    (271, 'Matt', 'Smith'),
    (272, 'David', 'Duchovny'),
    (273, 'Gillian', 'Anderson'),
    (274, 'Matthew', 'Fox'),
    (275, 'Evangeline', 'Lilly'),
    (276, 'Hayden', 'Panettiere'),
    (277, 'Masi', 'Oka'),
    (278, 'Anna', 'Torv'),
    (279, 'Joshua', 'Jackson'),
    (280, 'Adam', 'Scott'),
    (281, 'Britt', 'Lower'),
    (282, 'Rebecca', 'Ferguson'),
    (283, 'Lee', 'Pace'),
    (284, 'Diego', 'Luna'),
    (285, 'Tom', 'Hiddleston'),
    (286, 'Owen', 'Wilson'),
    (287, 'Elizabeth', 'Olsen'),
    (288, 'Paul', 'Bettany'),
    (289, 'Claire', 'Danes'),
    (290, 'Damian', 'Lewis'),
    (291, 'Kiefer', 'Sutherland'),
    (292, 'Mary Lynn', 'Rajskub'),
    (293, 'Sandra', 'Oh'),
    (294, 'Jodie', 'Comer'),
    (295, 'Penn', 'Badgley'),
    (296, 'Victoria', 'Pedretti'),
    (
        297,
        'Benedict',
        'Cumberbatch'
    ),
    (298, 'Martin', 'Freeman'),
    (299, 'Olivia', 'Colman'),
    (300, 'Anna', 'Paquin'),
    (301, 'Stephen', 'Moyer'),
    (302, 'Michiel', 'Huisman'),
    (303, 'Carla', 'Gugino'),
    (304, 'Andrew', 'Lincoln'),
    (305, 'Norman', 'Reedus'),
    (306, 'Sarah', 'Paulson'),
    (307, 'Evan', 'Peters'),
    (308, 'Ellen', 'Pompeo'),
    (309, 'Patrick', 'Dempsey'),
    (310, 'Hugh', 'Laurie'),
    (311, 'Robert Sean', 'Leonard'),
    (312, 'Anthony', 'Edwards'),
    (313, 'Mandy', 'Moore'),
    (314, 'Milo', 'Ventimiglia'),
    (315, 'Hugh', 'Bonneville'),
    (316, 'Michelle', 'Dockery'),
    (317, 'Caitriona', 'Balfe'),
    (318, 'Sam', 'Heughan'),
    (319, 'Yvonne', 'Strahovski'),
    (320, 'Reese', 'Witherspoon'),
    (321, 'Nicole', 'Kidman'),
    (322, 'Kevin', 'Costner'),
    (323, 'Kelly', 'Reilly'),
    (324, 'Paul', 'Giamatti'),
    (325, 'Gabriel', 'Macht'),
    (326, 'Patrick J.', 'Adams'),
    (327, 'Julianna', 'Margulies'),
    (328, 'Chris', 'Noth'),
    (329, 'Lauren', 'Graham'),
    (330, 'Alexis', 'Bledel'),
    (331, 'Chad Michael', 'Murray'),
    (332, 'Sophia', 'Bush'),
    (333, 'Hunter', 'Schafer'),
    (334, 'Daisy', 'Edgar-Jones'),
    (335, 'Paul', 'Mescal'),
    (336, 'Lily', 'Collins'),
    (
        337,
        'Philippine',
        'Leroy-Beaulieu'
    ),
    (
        338,
        'Alexandra',
        'Breckenridge'
    ),
    (339, 'Martin', 'Henderson'),
    (340, 'Asa', 'Butterfield'),
    (341, 'Joe', 'Locke'),
    (342, 'Kit', 'Connor');

-- Directors (more)
INSERT INTO
    director (id, first_name, last_name)
VALUES (17, 'Francis Ford', 'Coppola'),
    (18, 'Frank', 'Darabont'),
    (19, 'Lana', 'Wachowski'),
    (20, 'Lilly', 'Wachowski'),
    (21, 'Ridley', 'Scott'),
    (22, 'Robert', 'Zemeckis'),
    (23, 'Jonathan', 'Demme'),
    (24, 'Steven', 'Spielberg'),
    (25, 'Stanley', 'Kubrick'),
    (26, 'Alfred', 'Hitchcock'),
    (27, 'Michael', 'Curtiz'),
    (28, 'Nick', 'Cassavetes'),
    (29, 'Greg', 'Mottola'),
    (30, 'Todd', 'Phillips'),
    (31, 'Paul', 'Feig'),
    (32, 'Adam', 'McKay'),
    (33, 'George', 'Miller'),
    (34, 'Chad', 'Stahelski'),
    (35, 'John', 'McTiernan'),
    (36, 'Michael', 'Mann'),
    (37, 'Brian De', 'Palma'),
    (38, 'Joel', 'Coen'),
    (39, 'Ethan', 'Coen'),
    (40, 'Denis', 'Villeneuve'),
    (41, 'Park', 'Chan-wook'),
    (42, 'Barry', 'Jenkins'),
    (
        43,
        'Alejandro G.',
        'Inarritu'
    ),
    (44, 'Noah', 'Baumbach'),
    (45, 'Greta', 'Gerwig'),
    (46, 'Hayao', 'Miyazaki'),
    (47, 'John', 'Lasseter'),
    (48, 'Andrew', 'Stanton'),
    (49, 'Roger', 'Allers'),
    (50, 'Rob', 'Minkoff'),
    (51, 'Lee', 'Unkrich'),
    (52, 'Pete', 'Docter'),
    (53, 'Andrew', 'Adamson'),
    (54, 'Vicky', 'Jenson'),
    (55, 'Brad', 'Bird'),
    (56, 'Ari', 'Aster'),
    (57, 'John', 'Krasinski'),
    (58, 'Andy', 'Muschietti'),
    (59, 'James', 'Wan'),
    (60, 'William', 'Friedkin'),
    (61, 'Alex', 'Garland'),
    (62, 'Alfonso', 'Cuaron'),
    (63, 'Doug', 'Liman'),
    (64, 'Joss', 'Whedon'),
    (65, 'Ryan', 'Coogler'),
    (66, 'Bob', 'Persichetti'),
    (67, 'Peter', 'Ramsey'),
    (68, 'Rodney', 'Rothman'),
    (69, 'James', 'Mangold'),
    (70, 'Joseph', 'Kosinski'),
    (
        71,
        'Christopher',
        'McQuarrie'
    ),
    (72, 'Sam', 'Mendes'),
    (73, 'Martin', 'Campbell'),
    (74, 'Rian', 'Johnson'),
    (75, 'Daniel', 'Kwan'),
    (76, 'Daniel', 'Scheinert'),
    (77, 'Gus Van', 'Sant'),
    (78, 'Ron', 'Howard'),
    (79, 'Roman', 'Polanski'),
    (80, 'Steve', 'McQueen'),
    (81, 'Mel', 'Gibson'),
    (82, 'Clint', 'Eastwood'),
    (83, 'John G.', 'Avildsen'),
    (84, 'David', 'Benioff'),
    (85, 'D.B.', 'Weiss'),
    (86, 'David', 'Chase'),
    (87, 'David', 'Simon'),
    (88, 'Peter', 'Gould'),
    (89, 'Matthew', 'Weiner'),
    (90, 'Jesse', 'Armstrong'),
    (91, 'Craig', 'Mazin'),
    (92, 'Neil', 'Druckmann'),
    (93, 'Johan', 'Renck'),
    (94, 'Charlie', 'Brooker'),
    (95, 'Jonathan', 'Nolan'),
    (96, 'Lisa', 'Joy'),
    (
        97,
        'Lauren Schmidt',
        'Hissrich'
    ),
    (98, 'Chris Van', 'Dusen'),
    (99, 'Tim', 'Burton'),
    (100, 'Alfred', 'Gough'),
    (101, 'Miles', 'Millar'),
    (102, 'Baran', 'bo Odar'),
    (103, 'Alex', 'Pina'),
    (104, 'Steven', 'Knight'),
    (105, 'Joe', 'Penhall'),
    (106, 'James', 'Manos Jr.'),
    (107, 'Nic', 'Pizzolatto'),
    (108, 'Noah', 'Hawley'),
    (109, 'Greg', 'Daniels'),
    (110, 'Michael', 'Schur'),
    (111, 'David', 'Crane'),
    (112, 'Marta', 'Kauffman'),
    (113, 'Larry', 'David'),
    (114, 'Mitchell', 'Hurwitz'),
    (115, 'Dan', 'Goor'),
    (116, 'Dan', 'Levy'),
    (117, 'Bill', 'Lawrence'),
    (118, 'Christopher', 'Storer'),
    (119, 'Hiro', 'Murai'),
    (120, 'Christopher', 'Lloyd'),
    (121, 'Steven', 'Levitan'),
    (122, 'Carter', 'Bays'),
    (123, 'Craig', 'Thomas'),
    (124, 'Armando', 'Iannucci'),
    (125, 'Bill', 'Hader'),
    (126, 'Alec', 'Berg'),
    (127, 'Harry', 'Bradbeer'),
    (128, 'Dan', 'Harmon'),
    (129, 'Tina', 'Fey'),
    (130, 'Rob', 'McElhenney'),
    (
        131,
        'Raphael',
        'Bob-Waksberg'
    ),
    (132, 'Justin', 'Roiland'),
    (133, 'Matt', 'Groening'),
    (134, 'Trey', 'Parker'),
    (
        135,
        'Michael Dante',
        'DiMartino'
    ),
    (136, 'Bryan', 'Konietzko'),
    (137, 'Christian', 'Linke'),
    (138, 'Alex', 'Yee'),
    (139, 'Tim', 'Miller'),
    (140, 'Adam', 'Reed'),
    (141, 'David X.', 'Cohen'),
    (142, 'Loren', 'Bouchard'),
    (143, 'Seth', 'MacFarlane'),
    (144, 'Eric', 'Kripke'),
    (145, 'Drew', 'Goddard'),
    (146, 'Steve', 'Lightfoot'),
    (147, 'Carlton', 'Cuse'),
    (148, 'Graham', 'Roland'),
    (149, 'Nick', 'Santora'),
    (150, 'Michael', 'Hirst'),
    (151, 'Mark', 'Fergus'),
    (152, 'Hawk', 'Ostby'),
    (153, 'Ronald D.', 'Moore'),
    (154, 'Gene', 'Roddenberry'),
    (155, 'Russell T', 'Davies'),
    (156, 'Chris', 'Carter'),
    (157, 'J.J.', 'Abrams'),
    (158, 'Damon', 'Lindelof'),
    (159, 'Tim', 'Kring'),
    (160, 'Alex', 'Kurtzman'),
    (161, 'Dan', 'Erickson'),
    (162, 'Ben', 'Stiller'),
    (163, 'Graham', 'Yost'),
    (164, 'David S.', 'Goyer'),
    (165, 'Tony', 'Gilroy'),
    (166, 'Michael', 'Waldron'),
    (167, 'Kate', 'Herron'),
    (168, 'Matt', 'Shakman'),
    (169, 'Howard', 'Gordon'),
    (170, 'Alex', 'Gansa'),
    (171, 'Joel', 'Surnow'),
    (172, 'Robert', 'Cochran'),
    (
        173,
        'Phoebe',
        'Waller-Bridge'
    ),
    (174, 'Greg', 'Berlanti'),
    (175, 'Sera', 'Gamble'),
    (176, 'Steven', 'Moffat'),
    (177, 'Mark', 'Gatiss'),
    (178, 'Chris', 'Chibnall'),
    (179, 'Alan', 'Ball'),
    (180, 'Mike', 'Flanagan'),
    (181, 'Ryan', 'Murphy'),
    (182, 'Brad', 'Falchuk'),
    (183, 'Shonda', 'Rhimes'),
    (184, 'David', 'Shore'),
    (185, 'Michael', 'Crichton'),
    (186, 'Dan', 'Fogelman'),
    (187, 'Julian', 'Fellowes'),
    (188, 'Bruce', 'Miller'),
    (189, 'Jean-Marc', 'Vallee'),
    (190, 'Taylor', 'Sheridan'),
    (191, 'Brian', 'Koppelman'),
    (192, 'David', 'Levien'),
    (193, 'Aaron', 'Korsh'),
    (194, 'Robert', 'King'),
    (195, 'Michelle', 'King'),
    (
        196,
        'Amy',
        'Sherman-Palladino'
    ),
    (197, 'Mark', 'Schwahn'),
    (198, 'Sam', 'Levinson'),
    (199, 'Lenny', 'Abrahamson'),
    (200, 'Darren', 'Star'),
    (201, 'Sue', 'Tenney'),
    (202, 'Laurie', 'Nunn'),
    (203, 'Euros', 'Lyn');

-- Film <-> Actor (more)
INSERT INTO
    film_actors (actor_id, film_id)
VALUES (17, 11),
    (18, 11),
    (19, 12),
    (20, 12),
    (21, 13),
    (22, 13),
    (23, 14),
    (24, 14),
    (25, 15),
    (26, 15),
    (27, 16),
    (28, 16),
    (8, 17),
    (20, 17),
    (29, 18),
    (30, 18),
    (27, 19),
    (31, 19),
    (32, 20),
    (33, 20),
    (34, 21),
    (35, 21),
    (36, 22),
    (37, 22),
    (38, 23),
    (39, 24),
    (40, 24),
    (41, 25),
    (42, 25),
    (43, 26),
    (44, 26),
    (45, 27),
    (46, 27),
    (47, 28),
    (48, 28),
    (47, 29),
    (49, 29),
    (50, 30),
    (51, 30),
    (52, 31),
    (53, 31),
    (54, 32),
    (55, 32),
    (56, 33),
    (57, 33),
    (56, 34),
    (58, 34),
    (59, 35),
    (60, 35),
    (23, 36),
    (61, 37),
    (62, 37),
    (18, 38),
    (22, 38),
    (22, 39),
    (63, 39),
    (18, 40),
    (64, 40),
    (65, 41),
    (66, 41),
    (67, 42),
    (68, 42),
    (69, 43),
    (70, 43),
    (70, 44),
    (71, 44),
    (1, 45),
    (72, 45),
    (69, 46),
    (2, 46),
    (73, 47),
    (74, 47),
    (75, 48),
    (26, 49),
    (22, 49),
    (76, 50),
    (77, 50),
    (78, 51),
    (49, 51),
    (79, 52),
    (80, 52),
    (81, 53),
    (82, 53),
    (81, 54),
    (83, 54),
    (84, 55),
    (27, 56),
    (85, 56),
    (86, 57),
    (87, 57),
    (88, 58),
    (89, 58),
    (90, 59),
    (91, 59),
    (92, 60),
    (93, 60),
    (94, 61),
    (95, 61),
    (96, 62),
    (97, 62),
    (98, 63),
    (99, 63),
    (100, 64),
    (101, 64),
    (102, 65),
    (103, 65),
    (104, 66),
    (105, 66),
    (106, 67),
    (107, 67),
    (108, 68),
    (109, 68),
    (110, 69),
    (111, 69),
    (112, 70),
    (113, 70),
    (114, 71),
    (115, 71),
    (116, 72),
    (117, 72),
    (118, 73),
    (119, 73),
    (47, 74),
    (39, 74),
    (31, 75),
    (120, 75),
    (121, 76),
    (122, 76),
    (123, 77),
    (104, 77),
    (124, 78),
    (125, 78),
    (126, 79),
    (127, 79),
    (38, 80),
    (128, 80),
    (71, 81),
    (129, 81),
    (130, 82),
    (131, 82),
    (5, 82),
    (132, 83),
    (133, 83),
    (69, 84),
    (134, 84),
    (123, 85),
    (6, 85),
    (123, 86),
    (135, 86),
    (136, 87),
    (65, 87),
    (136, 88),
    (137, 88),
    (136, 89),
    (138, 89),
    (139, 90),
    (140, 90),
    (141, 91),
    (104, 91),
    (142, 92),
    (47, 92),
    (143, 93),
    (144, 93),
    (31, 94),
    (145, 94),
    (25, 95),
    (146, 95),
    (147, 96),
    (148, 97),
    (149, 97),
    (150, 98),
    (151, 98),
    (152, 99),
    (59, 99),
    (153, 100),
    (154, 100),
    (155, 101),
    (17, 101),
    (156, 102),
    (157, 102),
    (1, 103),
    (31, 103),
    (158, 104),
    (159, 104),
    (160, 105),
    (161, 105),
    (1, 105),
    (3, 105),
    (8, 106),
    (161, 106),
    (162, 107),
    (163, 107),
    (164, 108),
    (133, 108),
    (165, 109),
    (166, 109),
    (131, 110),
    (165, 110);

-- TV show <-> Actor (more)
INSERT INTO
    tv_actors (actor_id, tv_show_id)
VALUES (167, 9),
    (168, 9),
    (169, 10),
    (170, 10),
    (171, 11),
    (172, 11),
    (173, 12),
    (174, 12),
    (175, 13),
    (176, 13),
    (177, 14),
    (178, 14),
    (11, 15),
    (179, 15),
    (180, 16),
    (181, 16),
    (182, 17),
    (5, 17),
    (183, 18),
    (184, 18),
    (135, 19),
    (185, 19),
    (186, 20),
    (187, 20),
    (188, 21),
    (189, 21),
    (190, 22),
    (191, 22),
    (192, 23),
    (193, 23),
    (141, 24),
    (194, 24),
    (195, 25),
    (196, 25),
    (197, 26),
    (198, 26),
    (7, 27),
    (199, 27),
    (200, 28),
    (201, 28),
    (202, 29),
    (105, 29),
    (94, 30),
    (203, 30),
    (204, 31),
    (205, 31),
    (206, 32),
    (207, 32),
    (14, 33),
    (51, 33),
    (208, 34),
    (209, 34),
    (210, 35),
    (211, 35),
    (212, 36),
    (213, 36),
    (214, 37),
    (215, 37),
    (216, 38),
    (217, 38),
    (218, 39),
    (219, 39),
    (220, 40),
    (221, 40),
    (222, 41),
    (223, 41),
    (207, 42),
    (224, 42),
    (225, 43),
    (226, 43),
    (227, 44),
    (228, 44),
    (229, 45),
    (216, 45),
    (230, 46),
    (231, 46),
    (232, 47),
    (233, 47),
    (234, 48),
    (235, 48),
    (236, 49),
    (237, 49),
    (238, 50),
    (239, 50),
    (240, 51),
    (241, 51),
    (242, 52),
    (243, 52),
    (133, 53),
    (244, 53),
    (245, 54),
    (246, 54),
    (247, 55),
    (248, 55),
    (249, 56),
    (250, 56),
    (247, 57),
    (251, 57),
    (252, 58),
    (253, 58),
    (254, 59),
    (255, 59),
    (256, 60),
    (257, 60),
    (258, 61),
    (259, 61),
    (105, 62),
    (260, 62),
    (261, 63),
    (262, 63),
    (263, 64),
    (264, 64),
    (265, 65),
    (266, 65),
    (267, 66),
    (268, 66),
    (134, 67),
    (269, 67),
    (270, 68),
    (271, 68),
    (272, 69),
    (273, 69),
    (274, 70),
    (275, 70),
    (276, 71),
    (277, 71),
    (278, 72),
    (279, 72),
    (280, 73),
    (281, 73),
    (282, 74),
    (19, 74),
    (180, 75),
    (283, 75),
    (284, 76),
    (181, 76),
    (285, 77),
    (286, 77),
    (287, 78),
    (288, 78),
    (289, 79),
    (290, 79),
    (291, 80),
    (292, 80),
    (293, 81),
    (294, 81),
    (295, 82),
    (296, 82),
    (297, 83),
    (298, 83),
    (270, 84),
    (299, 84),
    (300, 85),
    (301, 85),
    (302, 86),
    (303, 86),
    (304, 87),
    (305, 87),
    (306, 88),
    (307, 88),
    (308, 89),
    (309, 89),
    (310, 90),
    (311, 90),
    (312, 91),
    (122, 91),
    (313, 92),
    (314, 92),
    (315, 93),
    (316, 93),
    (317, 94),
    (318, 94),
    (176, 95),
    (319, 95),
    (320, 96),
    (321, 96),
    (322, 97),
    (323, 97),
    (324, 98),
    (290, 98),
    (325, 99),
    (326, 99),
    (327, 100),
    (328, 100),
    (329, 101),
    (330, 101),
    (331, 102),
    (332, 102),
    (119, 103),
    (333, 103),
    (334, 104),
    (335, 104),
    (336, 105),
    (337, 105),
    (338, 106),
    (339, 106),
    (340, 107),
    (273, 107),
    (341, 108),
    (342, 108);

-- Film <-> Director (more)
INSERT INTO
    film_directors (director_id, film_id)
VALUES (17, 11),
    (18, 12),
    (5, 13),
    (19, 14),
    (20, 14),
    (21, 15),
    (22, 16),
    (8, 17),
    (23, 18),
    (24, 19),
    (24, 20),
    (24, 21),
    (22, 22),
    (21, 23),
    (21, 24),
    (25, 25),
    (26, 26),
    (27, 27),
    (28, 28),
    (7, 29),
    (29, 30),
    (30, 31),
    (31, 32),
    (32, 33),
    (32, 34),
    (33, 35),
    (34, 36),
    (35, 37),
    (36, 38),
    (5, 39),
    (37, 40),
    (38, 41),
    (39, 41),
    (8, 42),
    (40, 43),
    (8, 44),
    (5, 45),
    (1, 46),
    (1, 47),
    (41, 48),
    (30, 49),
    (42, 50),
    (43, 51),
    (44, 52),
    (45, 53),
    (45, 54),
    (46, 55),
    (47, 56),
    (48, 57),
    (49, 58),
    (50, 58),
    (51, 59),
    (52, 60),
    (52, 61),
    (53, 62),
    (54, 62),
    (55, 63),
    (48, 64),
    (56, 65),
    (57, 66),
    (58, 67),
    (59, 68),
    (56, 69),
    (60, 70),
    (40, 71),
    (61, 72),
    (40, 73),
    (40, 74),
    (21, 75),
    (62, 76),
    (63, 77),
    (3, 78),
    (3, 79),
    (3, 80),
    (64, 81),
    (65, 82),
    (66, 83),
    (67, 83),
    (68, 83),
    (69, 84),
    (70, 85),
    (71, 86),
    (72, 87),
    (73, 88),
    (74, 89),
    (75, 90),
    (76, 90),
    (1, 91),
    (45, 92),
    (8, 93),
    (77, 94),
    (78, 95),
    (79, 96),
    (80, 97),
    (72, 98),
    (1, 99),
    (25, 100),
    (17, 101),
    (81, 102),
    (5, 103),
    (2, 104),
    (2, 105),
    (2, 106),
    (82, 107),
    (38, 108),
    (39, 108),
    (83, 109),
    (65, 110);

-- TV show <-> Director (more)
INSERT INTO
    tv_directors (director_id, tv_show_id)
VALUES (84, 9),
    (85, 9),
    (86, 10),
    (87, 11),
    (9, 12),
    (88, 12),
    (89, 13),
    (90, 14),
    (91, 15),
    (92, 15),
    (93, 16),
    (94, 17),
    (95, 18),
    (96, 18),
    (97, 19),
    (98, 20),
    (99, 21),
    (100, 21),
    (101, 21),
    (102, 22),
    (103, 23),
    (104, 24),
    (8, 25),
    (105, 25),
    (106, 26),
    (107, 27),
    (108, 28),
    (109, 29),
    (110, 30),
    (109, 30),
    (111, 31),
    (112, 31),
    (113, 32),
    (114, 33),
    (115, 34),
    (110, 34),
    (116, 35),
    (117, 36),
    (118, 37),
    (119, 38),
    (120, 39),
    (121, 39),
    (122, 40),
    (123, 40),
    (113, 41),
    (124, 42),
    (125, 43),
    (126, 43),
    (127, 44),
    (128, 45),
    (129, 46),
    (130, 47),
    (131, 48),
    (128, 49),
    (132, 49),
    (133, 50),
    (134, 51),
    (135, 52),
    (136, 52),
    (137, 53),
    (138, 53),
    (139, 54),
    (140, 55),
    (133, 56),
    (141, 56),
    (142, 57),
    (143, 58),
    (144, 59),
    (145, 60),
    (146, 61),
    (147, 62),
    (148, 62),
    (149, 63),
    (150, 64),
    (151, 65),
    (152, 65),
    (153, 66),
    (154, 67),
    (155, 68),
    (156, 69),
    (157, 70),
    (158, 70),
    (159, 71),
    (157, 72),
    (160, 72),
    (161, 73),
    (162, 73),
    (163, 74),
    (164, 75),
    (165, 76),
    (166, 77),
    (167, 77),
    (168, 78),
    (169, 79),
    (170, 79),
    (171, 80),
    (172, 80),
    (173, 81),
    (174, 82),
    (175, 82),
    (176, 83),
    (177, 83),
    (178, 84),
    (179, 85),
    (180, 86),
    (18, 87),
    (181, 88),
    (182, 88),
    (183, 89),
    (184, 90),
    (185, 91),
    (186, 92),
    (187, 93),
    (153, 94),
    (188, 95),
    (189, 96),
    (190, 97),
    (191, 98),
    (192, 98),
    (193, 99),
    (194, 100),
    (195, 100),
    (196, 101),
    (197, 102),
    (198, 103),
    (199, 104),
    (200, 105),
    (201, 106),
    (202, 107),
    (203, 108);

-- Watched (more)
INSERT INTO
    watched (
        account_id,
        is_watched,
        film_id,
        tv_show_id
    )
VALUES (180, TRUE, NULL, 13),
    (110, TRUE, NULL, 65),
    (134, TRUE, 45, NULL),
    (109, TRUE, NULL, 48),
    (137, TRUE, 107, NULL),
    (170, TRUE, NULL, 79),
    (204, TRUE, NULL, 2),
    (186, TRUE, NULL, 39),
    (185, TRUE, 18, NULL),
    (134, TRUE, 14, NULL),
    (196, TRUE, NULL, 35),
    (137, TRUE, NULL, 92),
    (144, TRUE, 82, NULL),
    (210, TRUE, 63, NULL),
    (133, TRUE, NULL, 7),
    (112, TRUE, NULL, 107),
    (136, TRUE, 43, NULL),
    (199, TRUE, 34, NULL),
    (121, TRUE, NULL, 71),
    (191, TRUE, 2, NULL),
    (115, TRUE, 89, NULL),
    (120, TRUE, NULL, 107),
    (148, TRUE, NULL, 19),
    (156, TRUE, 40, NULL),
    (147, TRUE, NULL, 102),
    (106, TRUE, NULL, 27),
    (188, TRUE, 14, NULL),
    (146, TRUE, NULL, 53),
    (180, TRUE, NULL, 31),
    (121, TRUE, NULL, 104),
    (123, TRUE, NULL, 4),
    (123, TRUE, NULL, 43),
    (201, TRUE, NULL, 103),
    (186, TRUE, NULL, 104),
    (132, TRUE, 101, NULL),
    (190, TRUE, 5, NULL),
    (210, TRUE, 26, NULL),
    (205, TRUE, NULL, 45),
    (140, TRUE, NULL, 30),
    (129, TRUE, 25, NULL),
    (152, TRUE, 9, NULL),
    (199, TRUE, 83, NULL),
    (166, TRUE, 108, NULL),
    (169, TRUE, 4, NULL),
    (115, TRUE, NULL, 34),
    (123, TRUE, NULL, 34),
    (105, TRUE, 56, NULL),
    (145, TRUE, NULL, 41),
    (156, TRUE, NULL, 66),
    (115, TRUE, 74, NULL),
    (125, TRUE, 91, NULL),
    (156, TRUE, 104, NULL),
    (169, TRUE, NULL, 95),
    (195, TRUE, NULL, 47),
    (156, TRUE, 86, NULL),
    (143, TRUE, NULL, 85),
    (209, TRUE, 39, NULL),
    (165, TRUE, 53, NULL),
    (142, TRUE, 38, NULL),
    (171, TRUE, 54, NULL),
    (186, TRUE, NULL, 87),
    (196, TRUE, NULL, 79),
    (173, TRUE, 71, NULL),
    (207, TRUE, 37, NULL),
    (127, TRUE, 75, NULL),
    (178, TRUE, NULL, 60),
    (157, TRUE, 28, NULL),
    (166, TRUE, 102, NULL),
    (195, TRUE, 11, NULL),
    (137, TRUE, NULL, 82),
    (180, TRUE, 105, NULL),
    (197, TRUE, 40, NULL),
    (129, TRUE, NULL, 19),
    (104, TRUE, 61, NULL),
    (179, TRUE, NULL, 10),
    (159, TRUE, 81, NULL),
    (174, TRUE, 90, NULL),
    (150, TRUE, 32, NULL),
    (119, TRUE, NULL, 1),
    (197, TRUE, NULL, 14),
    (200, TRUE, 23, NULL),
    (203, TRUE, NULL, 67),
    (160, TRUE, 32, NULL),
    (209, TRUE, 18, NULL),
    (203, TRUE, 68, NULL),
    (172, TRUE, NULL, 97),
    (157, TRUE, NULL, 93),
    (165, TRUE, 71, NULL),
    (158, TRUE, NULL, 96),
    (161, TRUE, 97, NULL),
    (132, TRUE, NULL, 36),
    (199, TRUE, NULL, 63),
    (181, TRUE, 57, NULL),
    (110, TRUE, NULL, 31),
    (135, TRUE, 70, NULL),
    (111, TRUE, 30, NULL),
    (150, TRUE, NULL, 91),
    (128, TRUE, 53, NULL),
    (143, TRUE, NULL, 54),
    (108, TRUE, 54, NULL);

-- Liked (more)
INSERT INTO
    liked (
        account_id,
        is_liked,
        film_id,
        tv_show_id
    )
VALUES (150, TRUE, NULL, 75),
    (190, TRUE, 98, NULL),
    (174, TRUE, 1, NULL),
    (146, TRUE, 50, NULL),
    (210, FALSE, NULL, 107),
    (154, TRUE, NULL, 95),
    (170, TRUE, NULL, 29),
    (163, TRUE, 56, NULL),
    (163, TRUE, 44, NULL),
    (186, TRUE, NULL, 52),
    (193, FALSE, 60, NULL),
    (117, TRUE, NULL, 69),
    (104, TRUE, NULL, 76),
    (173, TRUE, NULL, 11),
    (183, TRUE, 60, NULL),
    (124, TRUE, 49, NULL),
    (142, TRUE, 42, NULL),
    (144, TRUE, NULL, 49),
    (136, TRUE, NULL, 107),
    (154, TRUE, 11, NULL),
    (161, FALSE, 70, NULL),
    (107, FALSE, NULL, 45),
    (129, TRUE, NULL, 100),
    (184, TRUE, 4, NULL),
    (132, TRUE, 3, NULL),
    (180, TRUE, 17, NULL),
    (161, TRUE, NULL, 73),
    (128, TRUE, 33, NULL),
    (199, TRUE, 78, NULL),
    (178, TRUE, NULL, 92),
    (115, FALSE, NULL, 21),
    (140, TRUE, 4, NULL),
    (140, TRUE, NULL, 49),
    (151, TRUE, NULL, 26),
    (110, TRUE, NULL, 107),
    (181, TRUE, 90, NULL),
    (199, FALSE, 88, NULL),
    (177, TRUE, NULL, 102),
    (173, TRUE, NULL, 45),
    (169, TRUE, 48, NULL),
    (109, FALSE, NULL, 44),
    (102, TRUE, NULL, 106),
    (163, TRUE, 47, NULL),
    (182, TRUE, NULL, 59),
    (191, TRUE, 23, NULL),
    (194, TRUE, NULL, 84),
    (135, TRUE, NULL, 69),
    (200, FALSE, 56, NULL),
    (206, TRUE, NULL, 35),
    (142, FALSE, NULL, 107),
    (112, FALSE, 58, NULL),
    (132, TRUE, NULL, 73),
    (179, TRUE, NULL, 44),
    (104, TRUE, 42, NULL),
    (124, TRUE, 46, NULL),
    (203, TRUE, 36, NULL),
    (177, TRUE, NULL, 36),
    (172, TRUE, 25, NULL),
    (111, TRUE, 53, NULL),
    (163, TRUE, NULL, 31),
    (189, TRUE, 92, NULL),
    (163, TRUE, 3, NULL),
    (112, TRUE, 52, NULL),
    (189, TRUE, 85, NULL),
    (175, TRUE, 71, NULL),
    (168, TRUE, 96, NULL),
    (171, FALSE, 90, NULL),
    (159, FALSE, 33, NULL),
    (130, TRUE, 25, NULL),
    (141, FALSE, 69, NULL),
    (198, TRUE, NULL, 25),
    (128, TRUE, NULL, 36),
    (193, TRUE, NULL, 98),
    (168, TRUE, NULL, 13),
    (207, TRUE, 30, NULL),
    (147, TRUE, 2, NULL),
    (191, TRUE, NULL, 36),
    (106, TRUE, NULL, 71),
    (138, TRUE, NULL, 17),
    (182, TRUE, NULL, 63),
    (114, FALSE, NULL, 74),
    (137, TRUE, 57, NULL),
    (144, TRUE, 7, NULL),
    (133, TRUE, NULL, 62),
    (115, TRUE, NULL, 52),
    (163, TRUE, 81, NULL),
    (188, TRUE, 20, NULL),
    (204, TRUE, NULL, 39),
    (111, TRUE, NULL, 16),
    (172, TRUE, NULL, 78),
    (177, FALSE, NULL, 29),
    (200, TRUE, NULL, 58),
    (157, FALSE, 76, NULL),
    (155, TRUE, 80, NULL),
    (108, TRUE, NULL, 95),
    (113, FALSE, NULL, 27),
    (181, TRUE, 85, NULL),
    (111, TRUE, 23, NULL),
    (171, TRUE, 1, NULL),
    (153, TRUE, 77, NULL);