SET DATABASE REFERENTIAL INTEGRITY FALSE;
DELETE FROM book;
SET DATABASE REFERENTIAL INTEGRITY TRUE;

INSERT INTO book (id, price, name, author, imageURL, genre)
VALUES
-- get
(1,12313.23,'book 1', 'author 1', 'http://imagen.com', 'comedia'),
-- put
(2,12313.23,'book 2', 'author 1', 'http://imagen.com', 'comedia'),
-- delete
(3,12313.23,'book 3', 'author 1', 'http://imagen.com', 'comedia');