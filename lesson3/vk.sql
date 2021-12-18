-- Tables and connections structure
--
-- | - photo_albums - |       | - photos -  |       | - photos_comments - |
-- |------------------|       |-------------|       |---------------------|
-- | id               |<-|    | id          |<-|    | id                  |
-- | user_id *        |  |    | user_id *   |  |--->| photo_id            |
-- | title            |  |--->| album_id    |       | author_id *         |
-- | created_at       |       | description |       | comment             |
-- --------------------       | created_at  |       | created_at          |
--                            ---------------       -----------------------
-- * users(id)
--



-- Albums table with mandatory title
CREATE TABLE photo_albums (
  id SERIAL PRIMARY KEY,
  title VARCHAR(150) NOT NULL,
  user_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE -- delete albums of deleted users
);

-- Photos table with optional description
CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  description TEXT,
  album_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE, -- delete photos of deleted users
  FOREIGN KEY (album_id) REFERENCES photo_albums(id) ON UPDATE CASCADE ON DELETE SET NULL -- leave photo with no album
);

-- Photo comments table with mandatory text
CREATE TABLE photos_comments (
  id SERIAL PRIMARY KEY,
  comment TEXT NOT NULL,
  photo_id BIGINT UNSIGNED NOT NULL,
  author_id BIGINT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  FOREIGN KEY (photo_id) REFERENCES photos(id) ON UPDATE CASCADE ON DELETE CASCADE, -- remove comments of deleted photos
  FOREIGN KEY (author_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE -- remove comments of deleted users
);



-- Many-to-many structure for shared photos
--
-- | - photos_shares - |
-- |-------------------|
-- | photo_id          | -> photos(id)
-- | share_user_id     | -> users(id)
-- ---------------------

CREATE TABLE photos_shares (
  photo_id BIGINT UNSIGNED NOT NULL,
  share_user_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY(photo_id, share_user_id),
  FOREIGN KEY (photo_id) REFERENCES photos(id) ON UPDATE CASCADE ON DELETE CASCADE, -- remove shares of deleted photos
  FOREIGN KEY (share_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE -- remove shares for deleted users
);
