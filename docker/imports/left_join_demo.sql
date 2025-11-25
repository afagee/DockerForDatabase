\timing on

DROP TABLE IF EXISTS lj_artists;
DROP TABLE IF EXISTS lj_awards;

CREATE TABLE lj_artists (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE lj_awards (
    id SERIAL PRIMARY KEY,
    artist_id INT REFERENCES lj_artists(id),
    year INT NOT NULL
);

INSERT INTO lj_artists (name) VALUES
    ('Artist A'),
    ('Artist B'),
    ('Artist C'),
    ('Artist D'),
    ('Artist E');

INSERT INTO lj_awards (artist_id, year) VALUES
    (1, 2018),
    (1, 2019),
    (2, 2020),
    (4, 2017),
    (4, 2018),
    (4, 2019);

EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) AS rows_in_a FROM lj_artists;
SELECT COUNT(*) AS rows_in_a FROM lj_artists;

EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) AS rows_in_b FROM lj_awards;
SELECT COUNT(*) AS rows_in_b FROM lj_awards;

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.id, a.name, COUNT(b.id) AS match_count
FROM lj_artists a
LEFT JOIN lj_awards b ON a.id = b.artist_id
GROUP BY a.id, a.name
ORDER BY a.id;

SELECT a.id, a.name, COUNT(b.id) AS match_count
FROM lj_artists a
LEFT JOIN lj_awards b ON a.id = b.artist_id
GROUP BY a.id, a.name
ORDER BY a.id;

EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) AS left_join_rows
FROM lj_artists a
LEFT JOIN lj_awards b ON a.id = b.artist_id;

SELECT COUNT(*) AS left_join_rows
FROM lj_artists a
LEFT JOIN lj_awards b ON a.id = b.artist_id;

EXPLAIN (ANALYZE, BUFFERS)
SELECT a.name, b.year
FROM lj_artists a
LEFT JOIN lj_awards b ON a.id = b.artist_id
ORDER BY a.id, b.year;

SELECT a.name, b.year
FROM lj_artists a
LEFT JOIN lj_awards b ON a.id = b.artist_id
ORDER BY a.id, b.year;
