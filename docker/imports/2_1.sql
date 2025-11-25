-- CREATE INDEX idx_songs_year_hottt ON songs(year, artist_hotttnesss) WHERE year >= 1950;
-- DROP INDEX IF EXISTS idx_songs_year_hottt;
SELECT year, COUNT(*) as cnt
FROM songs
WHERE year + 50 >= 1900 AND artist_hotttnesss + 0.2 > 0.2
GROUP BY year
ORDER BY cnt DESC;