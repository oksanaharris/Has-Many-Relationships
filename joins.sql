-- 1
SELECT * FROM users;

-- 2
SELECT * FROM posts WHERE user_id = 100;

-- 3
SELECT p.id, p.title, p.url, p.content, p.created_at, p.updated_at, u.first_name, u.last_name
FROM posts p
JOIN users u
ON p.user_id = u.id
WHERE u.id = 200;

-- 4
SELECT p.id, p.title, p.url, p.content, p.created_at, p.updated_at, u.username
FROM posts p
JOIN users u
ON p.user_id = u.id
WHERE u.first_name = 'Norene' AND u.last_name = 'Schmitt';

-- 5
SELECT u.username
FROM users u
JOIN posts p
ON p.user_id = u.id
WHERE p.created_at > '01/01/2015';

-- 6
SELECT p.title, p.content, u.username
FROM users u
JOIN posts p
ON p.user_id = u.id
WHERE u.created_at < '01/01/2015';

-- 7
SELECT p.title "Post Title", c.id, c.body, c.created_at, c.updated_at
FROM comments c
JOIN posts p
ON c.post_id = p.id;

-- 8
SELECT p.title "post_title", p.url "post_url", c.body "comment_body"
FROM comments c
JOIN posts p
ON c.post_id = p.id
WHERE p.created_at < '01/01/2015';

-- 9
SELECT p.title "post_title", p.url "post_url", c.body "comment_body"
FROM comments c
JOIN posts p
ON c.post_id = p.id
WHERE p.created_at > '01/01/2015';

-- 10
SELECT p.title "post_title", p.url "post_url", c.body "comment_body"
FROM comments c
JOIN posts p
ON c.post_id = p.id
WHERE c.body LIKE '%USB%';

-- 11
SELECT p.title "post_title", u.first_name, u.last_name, c.body "comment_body"
FROM comments c
JOIN posts p
ON c.post_id = p.id
JOIN users u
ON p.user_id = u.id
WHERE c.body LIKE '%matrix%';

-- 12
SELECT u.first_name, u.last_name, c.body "comment_body"
FROM comments c
JOIN posts p
ON c.post_id = p.id
JOIN users u
ON c.user_id = u.id
WHERE c.body LIKE '%SSL%' AND p.content LIKE '%dolorum%';

-- 13
-- Create a query to get the first name of the author of the post (aliased to post_author_first_name), last name of the author of the post (aliased to post_author_last_name), the post title (aliased to post_title), username of the author of the comment (aliased to comment_author_username), and comment body (aliased to comment_body), where the comment body contains the word 'SSL' or 'firewall' and the post content contains the word 'nemo' ( should have 218 results )

first name of author of post "post_author_first_name"
last name of the author of the post "post_author_last_name"
post title "post_title"
username of author of comments "comment_author_username"
comment body "comment_body"
WHERE commentbody contains 'SSL' or 'firewall'
and where post content contains the word 'nemo'

SELECT post_authors.first_name "post_author_first_name", post_authors.last_name "post_author_last_name", p.title "post_title", comment_authors.username "comment_author_username", c.body "comment_body"
FROM comments c
JOIN posts p
ON c.post_id = p.id
JOIN users post_authors
ON p.user_id = post_authors.id
JOIN users comment_authors
ON c.user_id = comment_authors.id
WHERE (c.body LIKE '%SSL%' OR c.body LIKE '%firewall%') AND p.content LIKE '%nemo%';


-- post_author_first_name  | Tyrese
-- post_author_last_name   | Ferry
-- post_title              | We need to copy the multi-byte SDD firewall!
-- comment_author_username | Charles65
-- comment_body            | If we program the monitor, we can get to the SSL monitor through the haptic SSL monitor!


-- SELECT * FROM comments WHERE body = 'If we program the monitor, we can get to the SSL monitor through the haptic SSL monitor!';

-- -[ RECORD 1 ]----------------------------------------------------------------------------------------
-- id         | 10280
-- body       | If we program the monitor, we can get to the SSL monitor through the haptic SSL monitor!
-- created_at | 2014-08-18 21:09:22-10
-- updated_at | 2015-07-14 10:07:01-10
-- user_id    | 38044
-- post_id    | 49918

-- SELECT * FROM users WHERE id = 38044;

--   id   | username  | first_name | last_name |       created_at       |       updated_at
-- -------+-----------+------------+-----------+------------------------+------------------------
--  38044 | Charles65 | Muriel     | Bashirian | 2015-07-10 05:57:11-10 | 2015-07-14 10:06:35-10
-- (1 row)

-- SELECT * FROM posts WHERE id = 49918;

-- id         | 49918
-- title      | We need to copy the multi-byte SDD firewall!
-- url        | http://jeremie.name
-- content    | veritatis laborum perferendis\nsimilique aut ullam exercitationem\nvoluptas repellendus maxime\n \rtemporibus officia nemo occaecati quis praesentium corrupti provident accusantium quasi\nnecessitatibus esse qui qui occaecati magni atque repellat sunt\nest debi
-- created_at | 2014-12-18 21:57:18-10
-- updated_at | 2015-07-14 10:06:57-10
-- user_id    | 22300

-- SELECT * FROM users WHERE id = 22300;

-- has_many_blogs=# SELECT * FROM users WHERE id = 22300;
--   id   | username | first_name | last_name |       created_at       |       updated_at
-- -------+----------+------------+-----------+------------------------+------------------------
--  22300 | Lukas33  | Tyrese     | Ferry     | 2015-03-22 20:26:47-10 | 2015-07-14 10:06:30-10
-- (1 row)



-- STRETCH GOALS

-- Find the post id, post title, and user id of all posts where the post author commented on his/her own post. ( should have 2 results )


SELECT p.id, p.title, p.user_id
FROM comments c
JOIN posts p
ON c.post_id = p.id
WHERE c.user_id = p.user_id;


-- Count how many comments have been written on posts that have been created after July 14, 2015 ( should have one result, the value of the count should be 25)


SELECT COUNT (*) comments_on_posts_after_July_14_2015
FROM comments c
JOIN posts p
ON c.post_id = p.id
WHERE p.created_at > '07/14/2015';
-- results in 27


-- Find all users who comment about 'programming' ( should have 337 results)

SELECT u.id, u.first_name, u.last_name, u.username
FROM comments c
JOIN users u
ON c.user_id = u.id
WHERE c.body LIKE '%programming%';
-- returns 337