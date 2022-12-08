-- paso 1 :DD!!
CREATE DATABASE desafio3_Cristian_Faundez_777;
CREATE TABLE usuarios(
    id SERIAL,
    email VARCHAR,
    nombre VARCHAR,
    apellido VARCHAR rol VARCHAR
);
INSERT INTO usuarios (email, nombre, apellido, rol)
VALUES (
        'luis.sanchez@bmail',
        'Luis',
        'Sanchez',
        'Administrador'
    );
INSERT INTO usuarios (email, nombre, apellido, rol)
VALUES (
        'gustavo.morales@bmail',
        'Gustavo',
        'Morales',
        'Administrador'
    );
INSERT INTO usuarios (email, nombre, apellido, rol)
VALUES (
        'franco.vargas@bmail',
        'Franco',
        'Vargas',
        'Usuario'
    );
INSERT INTO usuarios (email, nombre, apellido, rol)
VALUES (
        'eugenio.lopez@bmail.com',
        'Eugenio',
        'Lopez',
        'Usuario'
    );
INSERT INTO usuarios (email, nombre, apellido, rol)
VALUES (
        'jorge.rios@bmail.com',
        'Jorge',
        'Rios',
        'Usuarios'
    );
CREATE TABLE articulos(
    id SERIAL,
    titulo VARCHAR,
    contenido TEXT,
    fecha_creacion TIMESTAMP,
    fecha_actualizacion TIMESTAMP,
    destacado BOOLEAN,
    usuario_id BIGINT
);
INSERT INTO articulos (
        titulo,
        contenido,
        fecha_creacion,
        fecha_actualizacion,
        destacado,
        usuario_id
    )
VALUES (
        'Saludos!',
        'Holaa ! tanto tiempoooo! muy buena página :D!',
        '01/01/2001',
        '01/02/2021',
        true,
        1
    );
INSERT INTO articulos (
        titulo,
        contenido,
        fecha_creacion,
        fecha_actualizacion,
        destacado,
        usuario_id
    )
VALUES (
        '¡Hola!',
        '¡Hola! ¡Cómo están! :D!!',
        '07/07/2007 09:01:01',
        '07/07/2027 09:01:00',
        true,
        2
    );
INSERT INTO articulos (
        titulo,
        contenido,
        fecha_creacion,
        fecha_actualizacion,
        destacado,
        usuario_id
    )
VALUES (
        'Muy buenos días!!! :D!!',
        '¡Holaaa!, muy buenos días! :DD cómo están, es un excelente día para madrugaaaaar :P!!!',
        '01/12/2004 05:00:00',
        '19/12/2022 05:00:01',
        true,
        3
    );
INSERT INTO articulos (
        titulo,
        contenido,
        fecha_creacion,
        fecha_actualizacion,
        destacado,
        usuario_id
    )
VALUES (
        '¡¡¡ Felices fiestaasss !!! 😀',
        'Les deseo unas felices Fiestas a todos!, hoy es un gran día, para festejar y sonreir :P!!!',
        '04/04/2010 10:00:00',
        '29/07/2022 12:00:00',
        false,
        4
    );
INSERT INTO articulos (
        titulo,
        contenido,
        fecha_creacion,
        fecha_actualizacion,
        destacado
    )
VALUES (
        '¡¡¡Feliz Año Nuevo :D!!!!',
        'FELIZ AÑO NUEVO A TODOOOOOOOOOOOS JAJAJAJAAA :D!!!!!',
        '31/12/2022 12:00:10',
        '31/12/2030 14:00:00',
        true
    );
CREATE TABLE comentarios(
    id SERIAL,
    contenido TEXT,
    fecha_creacion TIMESTAMP,
    usuario_id BIGINT,
    post_id BIGINT
);
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id)
VALUES ('¡Muy buen comentario! :DD!', '05/12/2030', 1, 1);
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id)
VALUES (
        '¡La vida es bellllaaaaa :DDDDD!',
        '12/12/2040',
        2,
        1
    );
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id)
VALUES (
        '¡¡¡ Síii !!!, ¡¡¡ y sonreir hace bien para la Salud :DD!!!',
        '30/12/2050',
        3,
        1
    );
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id)
VALUES (
        '¡¡¡ Jajajajaja reirse es geniaaal :DDD!!!',
        '25/11/2090',
        1,
        2
    );
INSERT INTO comentarios (contenido, fecha_creacion, usuario_id, post_id)
VALUES ('¡¡¡ Qué buenaaaa :DDDD!!!', '20/12/2090', 2, 2);
-- paso 2 :DD! Cruza los datos de la tabla usuarios y posts mostrando las siguientes columnas: nombre e email del usuario, junto al título y contenido del post :D!!
SELECT usuarios.nombre,
    usuarios.email,
    articulos.titulo,
    articulos.contenido
FROM usuarios
    INNER JOIN articulos ON usuarios.id = articulos.usuario_id;
-- paso 3 :DD !! Muestra el id, título y contenido de los posts de los Administradores :DD! El Administrador puede ser cualquier id y debe ser seleccionado dinámicamente :DD!
SELECT articulos.id,
    articulos.titulo,
    articulos.contenido
FROM articulos
    INNER JOIN usuarios ON usuarios.id = articulos.usuario_id
    AND rol = 'Administrador';
-- 4. Cuenta la cantidad de posts de cada usuario. La tabla resultante debe mostrar el id e email del usuario, junto con la cantidad de posts de cada usuario :DD! 
--*Aquí hay una diferencia entre utilizar INNER JOIN, LEFT JOIN o RIGHT JOIN, prueba con todas, y con eso determina cuál es la correcta :DDD! No da lo mismo desde cual tabla partes :D!
SELECT usuarios.id,
    usuarios.email,
    COUNT(articulos.id)
FROM usuarios
    LEFT JOIN articulos ON usuarios.id = articulos.usuario_id
GROUP BY usuarios.id,
    usuarios.email;
-- 5. Muestra el email del usuario que ha creado más posts.
-- Aquí la tabla resultante tiene un único registro y muestra solo el email :D!!
SELECT usuarios.email
FROM usuarios
    INNER JOIN (
        SELECT usuario_id,
            count(usuario_id) AS contandoarticulos
        FROM articulos
        GROUP BY usuario_id
        ORDER BY contandoarticulos DESC
        LIMIT 1
    ) AS moreposts ON usuarios.id = moreposts.usuario_id;
-- 6. Muestra la fecha del último posts de cada usuario :DD! *
--Utiliza la función de agregado MAX sobre la fecha de creación :DD!!
SELECT usuarios.nombre,
    MAX(articulos.fecha_creacion) AS ultimopost
FROM usuarios
    INNER JOIN articulos ON usuarios.id = articulos.usuario_id
GROUP BY usuarios.nombre;
-- 7. Muestra el título y contenido del post (artículo) con más comentarios :D!!
SELECT titulo,
    contenido
FROM articulos
    JOIN (
        SELECT post_id,
            COUNT(post_id)
        FROM comentarios
        GROUP BY post_id
        ORDER BY COUNT(post_id) DESC
        LIMIT 1
    ) AS content ON articulos.id = content.post_id;
-- 8. Muestra en una tabla el título de cada post, el contenido de cada post
-- y el contenido de cada comentario asociado a lo posts mostrados junto con el email del usuario que lo escribió :D!!
SELECT articulos.titulo,
    articulos.contenido,
    comentarios.contenido,
    usuarios.email
FROM articulos
    LEFT JOIN comentarios ON articulos.id = comentarios.post_id
    INNER JOIN usuarios ON articulos.usuario_id = usuarios.id;
-- 9. Muestra el contenido del último comentario de cada usuario :D!!
SELECT comentarios.contenido
FROM comentarios
    INNER JOIN (
        SELECT usuario_id,
            MAX(fecha_creacion) AS maxfechawenaonda
        FROM comentarios
        GROUP BY usuario_id
    ) AS commentuserid ON commentuserid.maxfechawenaonda = comentarios.fecha_creacion;
-- 10. Muestra los emails de los usuarios que no han escrito ningún comentario :D!!! *Recuerda el Having :D!!*
SELECT usuarios.email
FROM usuarios
    LEFT JOIN comentarios ON usuarios.id = comentarios.usuario_id
GROUP BY usuarios.email
HAVING count(comentarios.usuario_id) = 0;