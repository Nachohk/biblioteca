--tablas-- 
--CREATE TABLE 
CREATE DATABASE biblioteca;

CREATE TABLE socios (rut VARCHAR(20), nombre VARCHAR(20), apellido VARCHAR(20), direccion VARCHAR(20), telefono VARCHAR(20), PRIMARY KEY(rut));

CREATE TABLE libros(isbn VARCHAR(20) , titulo VARCHAR(20), pag INT, PRIMARY KEY (isbn));

CREATE TABLE autor(id_autor SERIAL, nombre_autor VARCHAR(20), apellido_autor VARCHAR(20), tipo_autor VARCHAR(20), nacimiento INT, muerte INT, PRIMARY KEY(id_autor));

CREATE TABLE historial_de_prestamos(id_prestamo SERIAL, rut VARCHAR(20), isbn VARCHAR(20), fecha_prestamo DATE, fecha_devolucion DATE, PRIMARY KEY(id_prestamo), FOREIGN KEY(rut) REFERENCES socios(rut), FOREIGN KEY (isbn) REFERENCES libros(isbn));

CREATE TABLE lib_autor(id SERIAL, cod_autor INT, isbn VARCHAR (20), PRIMARY KEY(id), FOREIGN KEY (cod_autor) REFERENCES autor(id_autor), FOREIGN KEY (isbn) REFERENCES libros(isbn));

--------------------

INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES ('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1, SANTIAGO', '911111111');
INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES ('2222222-2', 'ANA', 'PEREZ', 'PASAJE 2, SANTIAGO', '922222222');
INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES ('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2, SANTIAGO', '933333333');
INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES ('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3, SANTIAGO', '944444444');
INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES ('5555555-5', 'SILVANA', 'MUÑOZ', 'PASAJE 3, SANTIAGO', '955555555');

--INSERT INTO libros (isbn, titulo, pag) VALUES (1111111111111,'CUENTOS DE TERROR',344);
INSERT INTO libros (isbn, titulo, pag) VALUES (1111111111111,'CUENTOS DE TERROR',344);
INSERT INTO libros (isbn, titulo, pag) VALUES (2222222222222,'POESIAS CONTEMPORA',167);
INSERT INTO libros (isbn, titulo, pag) VALUES (3333333333333,'HISTORIA DE ASIA',511);
INSERT INTO libros (isbn, titulo, pag) VALUES (4444444444444,'MANUAL DE MECÁNICA',298);

INSERT INTO historial_de_prestamos (id_prestamo, rut, isbn, fecha_prestamo, fecha_devolucion) VALUES (1,'1111111-1',1111111111111,'20-01-2020','27-01-2020');
INSERT INTO historial_de_prestamos (id_prestamo, rut, isbn, fecha_prestamo, fecha_devolucion) VALUES (2,'5555555-5',2222222222222,'20-01-2020','30-01-2020');
INSERT INTO historial_de_prestamos (id_prestamo, rut, isbn, fecha_prestamo, fecha_devolucion) VALUES (3,'3333333-3',3333333333333,'22-01-2020','30-01-2020');
INSERT INTO historial_de_prestamos (id_prestamo, rut, isbn, fecha_prestamo, fecha_devolucion) VALUES (4,'4444444-4',4444444444444,'23-01-2020','30-01-2020');
INSERT INTO historial_de_prestamos (id_prestamo, rut, isbn, fecha_prestamo, fecha_devolucion) VALUES (5,'2222222-2',1111111111111,'27-01-2020','04-02-2020');
INSERT INTO historial_de_prestamos (id_prestamo, rut, isbn, fecha_prestamo, fecha_devolucion) VALUES (6,'1111111-1',4444444444444,'31-01-2020','12-02-2020');
INSERT INTO historial_de_prestamos (id_prestamo, rut, isbn, fecha_prestamo, fecha_devolucion) VALUES (7,'3333333-3',2222222222222,'31-01-2020','12-02-2020');

INSERT INTO autor (id_autor, nombre_autor, apellido_autor, tipo_autor, nacimiento, muerte) VALUES (3, 'JOSE', 'SALGADO', 'PRINCIPAL',1968,2020);
INSERT INTO autor (id_autor, nombre_autor, apellido_autor, tipo_autor, nacimiento) VALUES (4, 'ANA', 'SALGADO', 'COAUTOR', 1972);
INSERT INTO autor (id_autor, nombre_autor, apellido_autor, tipo_autor, nacimiento) VALUES (1, 'ANDRES', 'ULLOA', 'PRINCIPAL', 1982);
INSERT INTO autor (id_autor, nombre_autor, apellido_autor, tipo_autor, nacimiento, muerte) VALUES (2, 'SERGIO', 'MARDONES','PRINCIPAL', 1950,2012);
INSERT INTO autor (id_autor, nombre_autor, apellido_autor, tipo_autor, nacimiento) VALUES (5, 'MARTIN', 'PORTA', 'PRINCIPAL', 1976);

INSERT INTO lib_autor (id, cod_autor, isbn) VALUES (1,3,1111111111111);
INSERT INTO lib_autor (id, cod_autor, isbn) VALUES (2,4,1111111111111);
INSERT INTO lib_autor (id, cod_autor, isbn) VALUES (3,1,2222222222222);
INSERT INTO lib_autor (id, cod_autor, isbn) VALUES (4,2,3333333333333);
INSERT INTO lib_autor (id, cod_autor, isbn) VALUES (5,5,4444444444444);

---------------Mostrar todos los libros que posean menos de 300 páginas.
SELECT * FROM libros WHERE pag < 300;
---------------Mostrar todos los autores que hayan nacido después del 01-01-1970.
SELECT nombre_autor, apellido_autor FROM autor WHERE muerte > 1970;
---------------¿Cuál es el libro más solicitado? 
SELECT isbn, count(isbn) FROM historial_de_prestamos GROUP BY isbn HAVING COUNT(*)>1;
---------------Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.
SELECT rut,(((fecha_devolucion::date - fecha_prestamo::date)-7)*100) AS Multa FROM historial_de_prestamos;