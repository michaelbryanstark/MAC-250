SELECT f.title AS title, 'Film' AS type, COUNT(*) AS likes
FROM liked AS l
JOIN film AS f ON f.id = l.film_id
WHERE l.is_liked = TRUE
GROUP BY f.id
UNION ALL
SELECT t.title, 'TV Show', COUNT(*)
FROM liked AS l
JOIN tv_show AS t ON t.id = l.tv_show_id
WHERE l.is_liked = TRUE
GROUP BY t.id
ORDER BY likes DESC, title;