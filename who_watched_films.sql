SELECT
    a.id AS account_id,
    a.email,
    f.title AS film_title
FROM watched AS w
JOIN account AS a ON a.id = w.account_id
JOIN film AS f ON f.id = w.film_id
WHERE w.is_watched = TRUE
  AND w.film_id IS NOT NULL
ORDER BY f.title, a.email;
