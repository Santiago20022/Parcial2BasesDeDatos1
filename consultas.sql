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



SELECT p.nombre
FROM PROFESOR p
JOIN PROFCAR pc ON p.codprof = pc.codprof
WHERE pc.codcarr = '001';



-- Alumnos en Derecho
SELECT a.nombre
FROM ALUMNO a
JOIN MATRICULA m ON a.codigoest = m.codigoest
WHERE m.codcarr = '004';

-- Profesores en Derecho
SELECT p.nombre
FROM PROFESOR p
JOIN PROFCAR pc ON p.codprof = pc.codprof
WHERE pc.codcarr = '004';



-- Alumnos en Derecho
SELECT a.nombre
FROM ALUMNO a
JOIN MATRICULA m ON a.codigoest = m.codigoest
WHERE m.codcarr = '004';

-- Profesores en Derecho
SELECT p.nombre
FROM PROFESOR p
JOIN PROFCAR pc ON p.codprof = pc.codprof
WHERE pc.codcarr = '004';



SELECT a.nombre, m.valorsemestre
FROM MATRICULA m
JOIN ALUMNO a ON m.codigoest = a.codigoest
WHERE m.codcarr = '008';


SELECT a.nombre
FROM ALUMNO a
JOIN MATRICULA m ON a.codigoest = m.codigoest
JOIN PROFESOR p ON m.codprof = p.codprof
WHERE p.nombre = 'Portacio Cartagena';



SELECT MAX(valorsemestre) AS valor_mas_alto FROM MATRICULA;


SELECT AVG(valorsemestre) AS promedio_semestre FROM MATRICULA;


SELECT nombre
FROM ALUMNO
WHERE nombre LIKE 'A%' OR nombre LIKE '%r';



SELECT c.descripcion, SUM(m.valorsemestre) AS total_pagado
FROM MATRICULA m
JOIN CARRERA c ON m.codcarr = c.codcarr
GROUP BY c.descripcion;



SELECT a.nombre
FROM ALUMNO a
WHERE a.codigoest NOT IN (SELECT codigoest FROM MATRICULA);

