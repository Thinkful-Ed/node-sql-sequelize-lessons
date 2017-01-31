CREATE TABLE users (
    id serial PRIMARY KEY,
    first_name text,
    last_name text,
    email text NOT NULL,
    screen_name text NOT NULL
);

CREATE TABLE posts (
    id serial PRIMARY KEY,
    title text,
    content text,
    author_id int REFERENCES users ON DELETE RESTRICT,
    published timestamp DEFAULT now()
);

CREATE TABLE tags (
    id serial PRIMARY KEY,
    tag text NOT NULL
);


CREATE TABLE post_tags (
    post_id int REFERENCES posts(id) ON DELETE CASCADE,
    tag_id int REFERENCES posts(id) ON DELETE RESTRICT
    unique(post_id, tag_id);
);

CREATE TABLE comments (
    id serial PRIMARY KEY,
    comment_text TEXT,
    author_id int REFERENCES users ON DELETE CASCADE NOT NULL,
    post_id int REFERENCES posts ON DELETE CASCADE NOT NULL,
    -- referring comments is a stretch goal
    referring_comment_id int,
    FOREIGN KEY (referring_comment_id) REFERENCES comments(id) ON DELETE SET NULL
);

INSERT INTO users (email, screen_name) VALUES
    ('foo@bar.com', 'MsFoo'),
    ('bar@bar.com', 'MrBar'),
    ('bizz@bar.com', 'DrBizz');


INSERT INTO tags (tag) VALUES
    ('you'), ('me'), ('things');

INSERT INTO posts (title, content, author_id) VALUES
    ('5 things about you', 'lorem etc etc', 1),
    ('10 things about me', 'lorem etc etc', 1);

INSERT INTO post_tags (post_id, tag_id) VALUES
    (1, 1),
    (1, 3),
    (2, 2),
    (2, 3);

INSERT INTO comments (author_id, post_id) VALUES
    (2, 1)
    (3, 2);

INSERT INTO comments (author_id, post_id, referring_comment_id) VALUES
    (3, 1, 1),
    (2, 1, 2);

