        SELECT
            a.id AS account_id,
            a.email AS subscriber_email,
            COUNT(DISTINCT p.profile_id) AS total_profiles
        FROM account a
        LEFT JOIN profile p
            ON a.id = p.account_id
        GROUP BY
            a.id,
            a.email
        ORDER BY
            total_profiles DESC
