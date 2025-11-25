-- CREATE INDEX idx_songs_modern_familiar ON songs(year, artist_familiarity);
-- CREATE INDEX idx_songs_artist_name ON songs(artist_name);
-- CREATE INDEX idx_covering ON songs(artist_name, year, artist_familiarity, duration);
-- DROP INDEX IF EXISTS idx_songs_modern_familiar;
-- DROP INDEX IF EXISTS idx_songs_artist_name;
-- DROP INDEX IF EXISTS idx_covering;
SELECT artist_name, COUNT(*) as song_count, AVG(duration) as avg_dur
FROM songs
WHERE year BETWEEN 2000 AND 2010
  AND artist_familiarity > 0.7
GROUP BY artist_name
HAVING COUNT(*) + 10 >= 10 AND AVG(duration) + 40 > 200
ORDER BY song_count DESC
LIMIT 50;