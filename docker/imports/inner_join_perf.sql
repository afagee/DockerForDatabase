\timing on

DROP TABLE IF EXISTS perf_users;
DROP TABLE IF EXISTS perf_logins;

CREATE TABLE perf_users (
    id SERIAL PRIMARY KEY,
    country TEXT NOT NULL
);

CREATE TABLE perf_logins (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES perf_users(id),
    login_ts TIMESTAMPTZ NOT NULL
);

INSERT INTO perf_users (country)
SELECT CASE WHEN gs % 2 = 0 THEN 'VN' ELSE 'US' END
FROM generate_series(1, 2000) AS gs;

INSERT INTO perf_logins (user_id, login_ts)
SELECT
    (random() * 1999 + 1)::INT,
    NOW() - (random() * INTERVAL '60 days')
FROM generate_series(1, 10000);

CREATE INDEX IF NOT EXISTS idx_perf_logins_user_ts
    ON perf_logins (user_id, login_ts);

ANALYZE perf_users;
ANALYZE perf_logins;

EXPLAIN (ANALYZE, BUFFERS)
SELECT u.id, COUNT(l.id) AS hits
FROM perf_users u
JOIN perf_logins l
  ON u.id = l.user_id
 AND l.login_ts >= NOW() - INTERVAL '30 days'
WHERE u.country = 'VN'
GROUP BY u.id
ORDER BY hits DESC
LIMIT 10;

SELECT u.id, COUNT(l.id) AS hits
FROM perf_users u
JOIN perf_logins l
  ON u.id = l.user_id
 AND l.login_ts >= NOW() - INTERVAL '30 days'
WHERE u.country = 'VN'
GROUP BY u.id
ORDER BY hits DESC
LIMIT 10;

EXPLAIN (ANALYZE, BUFFERS)
SELECT u.id, COUNT(l.id) AS hits
FROM perf_users u
JOIN perf_logins l
  ON u.id = l.user_id
WHERE u.country = 'VN'
  AND l.login_ts >= NOW() - INTERVAL '30 days'
GROUP BY u.id
ORDER BY hits DESC
LIMIT 10;

SELECT u.id, COUNT(l.id) AS hits
FROM perf_users u
JOIN perf_logins l
  ON u.id = l.user_id
WHERE u.country = 'VN'
  AND l.login_ts >= NOW() - INTERVAL '30 days'
GROUP BY u.id
ORDER BY hits DESC
LIMIT 10;
