CREATE DATABASE db_gym;

USE db_gym;

CREATE TABLE persona (
  id INT(11) NOT NULL,
  nombres VARCHAR(50) NOT NULL,
  apellidos VARCHAR(50) NOT NULL,
  documento VARCHAR(12) NOT NULL,
  codigo VARCHAR(12) NOT NULL,
  celular VARCHAR(15),
  email VARCHAR(140) NOT NULL,
  rol VARCHAR(15),
  created_at timestamp NOT NULL DEFAULT current_timestamp,
  UNIQUE(documento, codigo)
);

ALTER TABLE persona
  ADD PRIMARY KEY (id);

ALTER TABLE persona
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

INSERT INTO persona (id, nombres, apellidos, documento, codigo, celular, email, rol) 
  VALUES (1, 'enrique','sanchez', '123456789', '201911111', '3111111111', 'enriquesan@uptc.edu.co', 'ADMINISTRADOR');

CREATE TABLE datos_personales (
  id INT(11) NOT NULL,
  id_persona INT(11) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  edad INT(2) NOT NULL,
  genero VARCHAR(10) NOT NULL,
  eps VARCHAR(50) NOT NULL,
  rh VARCHAR(5) NOT NULL,
  arl VARCHAR(50),
  alergia VARCHAR(2) NOT NULL,
  c_alergia VARCHAR(100),
  pariente VARCHAR(100) NOT NULL,
  tel_pariente VARCHAR(15) NOT NULL,
  parentesco VARCHAR(20) NOT NULL,
  CONSTRAINT fk_per_dp FOREIGN KEY(id_persona) REFERENCES persona(id)
);

ALTER TABLE datos_personales
  ADD PRIMARY KEY (id);

ALTER TABLE datos_personales
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

-- HISTORIA MÉDICA Y HÁBITOS
CREATE TABLE hm_ha (
  id INT(11) NOT NULL,
  id_persona INT(11) NOT NULL,
  HM1 VARCHAR(2) NOT NULL,
  HM1C VARCHAR(80),
  HM2 VARCHAR(2) NOT NULL,
  HM2C VARCHAR(80),
  HM3 VARCHAR(2) NOT NULL,
  HM4 VARCHAR(2) NOT NULL,
  HM5 VARCHAR(2) NOT NULL,
  HM6 VARCHAR(2) NOT NULL,
  HM6C VARCHAR(80),
  HM7 VARCHAR(2) NOT NULL,
  HM7C VARCHAR(80),
  HM8 VARCHAR(2) NOT NULL,
  HM9 VARCHAR(2) NOT NULL,
  HM9C VARCHAR(80),
  HM10 VARCHAR(2) NOT NULL,
  HM10C VARCHAR(80),
  HM10C2 VARCHAR(80),
  HM11 VARCHAR(2) NOT NULL,
  HM11C VARCHAR(80),
  HA1 VARCHAR(2) NOT NULL,
  HA1C VARCHAR(80),
  HA2C INT(1),
  HA3C INT(2),
  HA4C INT(2),
  HA2 VARCHAR(30) NOT NULL,
  CONSTRAINT fk_per_hmha FOREIGN KEY(id_persona) REFERENCES persona(id)
);

ALTER TABLE hm_ha
  ADD PRIMARY KEY (id);

ALTER TABLE hm_ha
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

-- BENEFICIOS
CREATE TABLE ben (
  id INT(50) NOT NULL,
  id_persona INT(11),
  beneficio VARCHAR(30),
  CONSTRAINT fk_per_ben FOREIGN KEY(id_persona) REFERENCES persona(id)
);

ALTER TABLE ben
  ADD PRIMARY KEY (id);

ALTER TABLE ben
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;


CREATE TABLE asistencia (
  id INT(11) NOT NULL,
  id_persona INT(11) NOT NULL,
  id_instructor INT(11) NOT NULL,
  asistencia DATE,
  CONSTRAINT fk_per_asi FOREIGN KEY(id_persona) REFERENCES persona(id),
  CONSTRAINT fk_ins_asi FOREIGN KEY(id_instructor) REFERENCES persona(id)
);

ALTER TABLE asistencia
  ADD PRIMARY KEY (id);

ALTER TABLE asistencia
  MODIFY id INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE ejercicio (
  id INT(5) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  descripcion VARCHAR(300) NOT NULL,
  musculo VARCHAR(50) NOT NULL,
  img_musculo BLOB,
  img_ejercicio BLOB,
  id_instructor INT(11),
  CONSTRAINT fk_ins_eje FOREIGN KEY(id_instructor) REFERENCES persona(id)
);

ALTER TABLE ejercicio
  ADD PRIMARY KEY (id);

ALTER TABLE ejercicio
  MODIFY id INT(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE rut_ejer (
  id INT(5) NOT NULL,
  id_ejercicio INT(5) NOT NULL,
  repeticiones INT(3) NOT NULL,
  series INT(2) NOT NULL,
  CONSTRAINT fk_eje_ruej FOREIGN KEY(id_ejercicio) REFERENCES ejercicio(id)
);

ALTER TABLE rut_ejer
  ADD PRIMARY KEY (id);

ALTER TABLE rut_ejer
  MODIFY id INT(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE rutina (
  id INT(5) NOT NULL,
  id_rut_ejer INT(5) NOT NULL,
  id_persona INT(11) NOT NULL,
  id_instructor INT(11) NOT NULL,
  CONSTRAINT fk_ruej_rut FOREIGN KEY(id_rut_ejer) REFERENCES rut_ejer(id),
  CONSTRAINT fk_per_rut FOREIGN KEY(id_persona) REFERENCES persona(id),
  CONSTRAINT fk_ins_rut FOREIGN KEY(id_instructor) REFERENCES persona(id)
);

ALTER TABLE rutina
  ADD PRIMARY KEY (id);

ALTER TABLE rutina
  MODIFY id INT(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;

CREATE TABLE users (
  id INT(5) NOT NULL,
  usuario VARCHAR(12) NOT NULL,
  contrasena VARCHAR(12) NOT NULL,
  id_persona INT(11) NOT NULL,
  CONSTRAINT fk_usua_use FOREIGN KEY(id_persona) REFERENCES persona(id)
);

ALTER TABLE users
  ADD PRIMARY KEY (id);

ALTER TABLE users
  MODIFY id INT(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT = 1;