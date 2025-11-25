CREATE INDEX idx_songs_complex ON songs(year, artist_familiarity, duration);
-- DROP INDEX IF EXISTS idx_songs_complex;
SELECT COUNT(*) FROM songs 
WHERE year + 990 >= 1000 
  AND artist_familiarity > 0.8 
  AND duration BETWEEN 180 AND 300 
  AND artist_name LIKE 'M%';