-- Tabla ALUMNO
CREATE TABLE ALUMNO (
    codigoest CHAR(3) PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(50),
    telefono VARCHAR(15)
);

-- Tabla CARRERA
CREATE TABLE CARRERA (
    codcarr CHAR(3) PRIMARY KEY,
    descripcion VARCHAR(50)
);

-- Tabla PROFESOR
CREATE TABLE PROFESOR (
    codprof CHAR(3) PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(50),
    telefono VARCHAR(15)
);

-- Tabla ALUMCAR (relación ALUMNO - CARRERA)
CREATE TABLE ALUMCAR (
    codigoest CHAR(3),
    codcarr CHAR(3),
    FOREIGN KEY (codigoest) REFERENCES ALUMNO(codigoest),
    FOREIGN KEY (codcarr) REFERENCES CARRERA(codcarr)
);

-- Tabla MATRICULA
CREATE TABLE MATRICULA (
    codmatric CHAR(3) PRIMARY KEY,
    codigoest CHAR(3),
    codcarr CHAR(3),
    codprof CHAR(3),
    valorsemestre INT,
    FOREIGN KEY (codigoest) REFERENCES ALUMNO(codigoest),
    FOREIGN KEY (codcarr) REFERENCES CARRERA(codcarr),
    FOREIGN KEY (codprof) REFERENCES PROFESOR(codprof)
);

-- Tabla PROFCAR (relación PROFESOR - CARRERA)
CREATE TABLE PROFCAR (
    codprof CHAR(3),
    codcarr CHAR(3),
    FOREIGN KEY (codprof) REFERENCES PROFESOR(codprof),
    FOREIGN KEY (codcarr) REFERENCES CARRERA(codcarr)
);





-- Tabla ALUMNO
INSERT INTO ALUMNO VALUES
('001', 'Juan Tobon', 'Cra 59', '2335698'),
('002', 'Mario Gonzales', 'Cra 89', '6325984'),
('003', 'Federico Aguilar', 'Cra 26', '4569782'),
('004', 'Angel Cuadrado', 'Cra 44', '6398521'),
('005', 'Catalina Escobar', 'Cra 78', '4652300'),
('006', 'Paulina Borja', 'Cra 45', '4599632');

-- Tabla CARRERA
INSERT INTO CARRERA VALUES
('001', 'Ingenieria de Sistemas'),
('002', 'Contaduria'),
('003', 'Economia'),
('004', 'Derecho'),
('005', 'Ingenieria Agropecuaria'),
('006', 'Agronomia'),
('007', 'Ciencias de la salud'),
('008', 'Veterinaria');

-- Tabla PROFESOR
INSERT INTO PROFESOR VALUES
('001', 'Pablo Juan Gutierrez', 'cra 45-96', '2569856'),
('002', 'Enrique Saltamontes', 'cra 25-63', '2365914'),
('003', 'Portacio Cartagena', 'cra 36-01', '4596321'),
('004', 'Federico Aguilar', 'cra 56-41', '7895624'),
('005', 'Alberto Cifuentes', 'cra 20-30', '7895002'),
('006', 'Pascual Bravo', 'cra 56-41', '5698741');

-- Tabla ALUMCAR
INSERT INTO ALUMCAR VALUES
('001', '002'),
('003', '005'),
('005', '001'),
('001', '005');

-- Tabla MATRICULA
INSERT INTO MATRICULA VALUES
('001', '003', '004', '004', 1800000),
('002', '001', '008', '003', 3500000),
('003', '004', '007', '006', 2800000),
('004', '002', '007', '006', 1950000),
('005', '005', '004', '001', 1800000),
('006', '003', '008', '003', 3500000);

-- Tabla PROFCAR
INSERT INTO PROFCAR VALUES
('005', '003'),
('002', '006'),
('005', '005'),
('003', '008'),
('005', '001'),
('004', '002'),
('003', '001'),
('004', '004'),
('001', '004'),
('006', '007');



-- CONSULTA 1: Profesores que dictan en la carrera con código '001' (Ingeniería de Sistemas)
SELECT p.nombre                 -- Seleccionamos el nombre del profesor (alias 'p')
FROM PROFESOR p                -- Tabla PROFESOR con alias 'p'
JOIN PROFCAR pc ON p.codprof = pc.codprof   -- Unimos con la tabla PROFCAR (alias 'pc') usando el código del profesor
WHERE pc.codcarr = '001';      -- Filtramos por carrera con código '001' (Ingeniería de Sistemas)




-- CONSULTA 2: Alumnos matriculados en la carrera de Derecho (código '004')
SELECT a.nombre                -- Seleccionamos el nombre del alumno (alias 'a')
FROM ALUMNO a                  -- Tabla ALUMNO con alias 'a'
JOIN MATRICULA m ON a.codigoest = m.codigoest  -- Unimos con la tabla MATRICULA (alias 'm') por el código del estudiante
WHERE m.codcarr = '004';       -- Filtramos por carrera con código '004' (Derecho)


-- CONSULTA 3: Profesores que enseñan en la carrera de Derecho (código '004')
SELECT p.nombre                -- Seleccionamos el nombre del profesor (alias 'p')
FROM PROFESOR p                -- Tabla PROFESOR con alias 'p'
JOIN PROFCAR pc ON p.codprof = pc.codprof   -- Unimos con la tabla PROFCAR (alias 'pc') por el código del profesor
WHERE pc.codcarr = '004';      -- Filtramos por carrera con código '004' (Derecho)




-- CONSULTA 4: Alumnos y el valor del semestre en Veterinaria (código '008')
SELECT a.nombre,               -- Seleccionamos el nombre del alumno (alias 'a')
       m.valorsemestre         -- Seleccionamos el valor que paga por el semestre (alias 'm')
FROM MATRICULA m               -- Tabla MATRICULA con alias 'm'
JOIN ALUMNO a ON m.codigoest = a.codigoest  -- Unimos con la tabla ALUMNO (alias 'a') por el código del estudiante
WHERE m.codcarr = '008';       -- Filtramos por carrera con código '008' (Veterinaria)


-- CONSULTA EXTRA 1: Mostrar los profesores que enseñan en la carrera con código '004' (Derecho)
SELECT p.nombre                        -- Seleccionamos el nombre del profesor (alias 'p')
FROM PROFESOR p                        -- Tabla de profesores con alias 'p'
JOIN PROFCAR pc ON p.codprof = pc.codprof   -- Unimos con la tabla PROFCAR (alias 'pc') por el campo codprof (código del profesor)
WHERE pc.codcarr = '004';             -- Filtramos para que solo muestre profesores de la carrera con código '004' (Derecho)




-- CONSULTA EXTRA 2: Mostrar alumnos con el valor pagado del semestre en la carrera de Veterinaria (código '008')
SELECT a.nombre,                       -- Seleccionamos el nombre del alumno (alias 'a')
       m.valorsemestre                 -- Seleccionamos el valor del semestre que paga el alumno (alias 'm')
FROM MATRICULA m                       -- Tabla de matrícula con alias 'm'
JOIN ALUMNO a ON m.codigoest = a.codigoest  -- Unimos con la tabla ALUMNO (alias 'a') usando el código del estudiante
WHERE m.codcarr = '008';               -- Filtramos por la carrera con código '008' (Veterinaria)


-- CONSULTA EXTRA 3: Mostrar los alumnos que ven clases con el profesor 'Portacio Cartagena'
SELECT a.nombre                        -- Seleccionamos el nombre del alumno (alias 'a')
FROM ALUMNO a                          -- Tabla ALUMNO con alias 'a'
JOIN MATRICULA m ON a.codigoest = m.codigoest  -- Unimos con la tabla MATRICULA (alias 'm') por código del estudiante
JOIN PROFESOR p ON m.codprof = p.codprof       -- Unimos con la tabla PROFESOR (alias 'p') por código del profesor
WHERE p.nombre = 'Portacio Cartagena';         -- Filtramos por el nombre exacto del profesor




-- CONSULTA 6: Mostrar el valor más alto pagado por semestre
SELECT MAX(valorsemestre) AS valor_mas_alto  -- Usamos la función MAX() para obtener el valor máximo y le damos un alias
FROM MATRICULA;                 -- De la tabla MATRICULA


-- CONSULTA 7: Calcular el promedio del valor del semestre
SELECT AVG(valorsemestre) AS promedio_semestre  -- Usamos AVG() para calcular el promedio y lo nombramos como 'promedio_semestre'
FROM MATRICULA;                 -- De la tabla MATRICULA

-- CONSULTA 8: Alumnos cuyos nombres comienzan con 'A' o terminan con 'r'
SELECT nombre                   -- Seleccionamos el nombre directamente de la tabla ALUMNO
FROM ALUMNO
WHERE nombre LIKE 'A%'         -- Filtramos nombres que comienzan con 'A' (A%)
   OR nombre LIKE '%r';        -- O que terminan en 'r' (%r)



-- CONSULTA 9: Total pagado por carrera
SELECT c.descripcion,          -- Seleccionamos la descripción de la carrera (alias 'c')
       SUM(m.valorsemestre) AS total_pagado  -- Sumamos el valor del semestre (alias 'm') y lo llamamos 'total_pagado'
FROM MATRICULA m               -- Tabla MATRICULA con alias 'm'
JOIN CARRERA c ON m.codcarr = c.codcarr  -- Unimos con la tabla CARRERA (alias 'c') por el código de la carrera
GROUP BY c.descripcion;        -- Agrupamos los resultados por descripción de carrera para sumar correctamente




-- CONSULTA 10: Alumnos que no tienen matrícula registrada
SELECT a.nombre                -- Seleccionamos el nombre del alumno (alias 'a')
FROM ALUMNO a                  -- Tabla ALUMNO con alias 'a'
WHERE a.codigoest NOT IN (     -- Usamos NOT IN para excluir a los estudiantes que están en:
  SELECT codigoest             -- Subconsulta: obtiene los códigos de estudiantes con matrícula
  FROM MATRICULA
);


