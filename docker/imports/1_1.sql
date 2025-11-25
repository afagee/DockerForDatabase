-- CREATE INDEX idx_songs_year ON songs(year);
-- DROP INDEX IF EXISTS idx_songs_year;
SELECT COUNT(*) FROM songs 
WHERE year = 1999;

