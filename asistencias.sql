
/* crea la base de datos "asistencia"*/
create database asistencia;

/* crea la relación administrador*/
CREATE TABLE administrador(
    id_admin serial primary key,
    nombre varchar(45) not null,
    contraseña varchar(45) not null
);

/*inserta tres tuplas a tabla administrador */
insert into administrador (nombre, contraseña) values ('Edwin Cuaran', '1234');
insert into administrador (nombre, contraseña) values ('Admin principal', 'admin');
insert into administrador (nombre, contraseña) values ('Admin suplente', 'admin123');

/*permite consultar los datos insertados*/
select * from administrador; 

/************************************************************************************************************/

/* crea la relación sede*/
CREATE TABLE sede(
    id_sede serial primary key,
    id_admin int not null,
    nombre varchar(45) not null,
    ubicacion varchar(45) not null,
    foreign key (id_admin) references administrador (id_admin)
);

/*inserta tuplas a la relación*/
insert into sede (id_sede, id_admin, nombre, ubicacion) 
    values (1, 1, 'sede melendez', 'cali - melendez'),
            (2, 1, 'sede san fernando', 'cali - san fernando'),
            (3, 2, 'sede palmira', 'zamorano');

/*consulta los datos insertados*/
select * from sede;

/************************************************************************************************************/

/* crea la relación estudiante*/
CREATE TABLE estudiante(
    id_estudiante serial primary key,
    id_sede int not null,
    nombre varchar(45) not null,
    direccion varchar(45) not null,
    foreign key (id_sede) references sede (id_sede)
);    

/*inserta tuplas en la relación*/
insert into estudiante (id_estudiante, id_sede, nombre, direccion) 
    values (1, 1, 'fernanda gonzalez', 'crr 100 5-20'),
            (2, 1, 'alex lopez', 'crr 10 4-12'),
            (3, 2, 'daniela londoño', 'cll 47 26-20');

/*consulta los datos insertados*/
select * from estudiante;

/************************************************************************************************************/

/* crea la relación estudiante_codigo */
CREATE TABLE estudiante_codigo(
    id_est_cod serial primary key,
    id_estudiante int not null,
    codigo varchar(45) not null,
    foreign key (id_estudiante) references estudiante (id_estudiante)
);

/*inserta tuplas en la relación*/
insert into estudiante_codigo (id_est_cod, id_estudiante, codigo)
    values (1, 1, '20191020'),
            (2, 1, '20191030'),
            (3, 2, '20201122');

/*consulta los datos insertados*/
select * from estudiante_codigo;

/************************************************************************************************************/

/* crea la relación curso */
CREATE TABLE curso(
    id_curso serial primary key,
    codigo varchar(45) not null,
    nombre varchar(45) not null,
    creditos int not null
);    

/*inserta tuplas en la relación*/
insert into curso (id_curso, codigo, nombre, creditos) 
    values (1, '750085m', 'base de datos 1', 4),
            (2, '780084m', 'desarrollo de software 1', 3),
            (3, '760090m', 'trabajo de grado', 4);

/*consulta los datos insertados*/
select * from curso;

/************************************************************************************************************/

/* crea la relación curso_grupo */
CREATE TABLE curso_grupo(
    id_curso_grupo serial primary key,
    id_curso int not null,
    grupo varchar(45) not null,
    foreign key (id_curso) references curso (id_curso)
);

/*inserta tuplas en la relación*/
insert into curso_grupo (id_curso_grupo, id_curso, grupo) 
    values (1, 1, '01'),
            (2, 1, 'f80'),
            (3, 2, '01');

/*consulta los datos insertados*/
select * from curso_grupo;

/************************************************************************************************************/

/* crea la relación estudiante_curso */
CREATE TABLE estudiante_curso(
    id_estudiante int not null,
    id_curso int not null,
    nota numeric (3, 2) not null,
    primary key (id_estudiante, id_curso),
    foreign key (id_estudiante) references estudiante (id_estudiante),
    foreign key (id_curso) references curso (id_curso)
);

/*inserta tuplas en la relación*/
insert into estudiante_curso (id_estudiante, id_curso, nota) 
    values (1, 1, 4.35),
            (1, 2, 4.00),
            (2, 1, 4.10);

/*consulta los datos insertados*/
select * from estudiante_curso;

/************************************************************************************************************/

/* crea la relación personal */
CREATE TABLE personal(
    id_personal serial primary key,
    id_sede int not null,
    nombre varchar(45) not null,
    salario money not null,
    direccion  varchar(45) not null,
    foreign key (id_sede) references sede (id_sede)
);

/*inserta tuplas en la relación*/
insert into personal (id_personal, id_sede, nombre, salario, direccion) 
    values (1, 1, 'camilo lopez', 1000000.00, 'cll 70 39-20'),
            (2, 1, 'manuel arango', 2000000.00, 'crr 66 109-15'),
            (3, 2, 'mariana gomez', 5000000.00, 'diagonal 75 40a-10');

/*consulta los datos insertados*/
select * from personal;

/************************************************************************************************************/

/* crea la relación personal_seg_social */
CREATE TABLE personal_seg_social(
    id_personal int not null,
    eps varchar(45) not null,
    arl varchar(45) not null,
    primary key (id_personal),
    foreign key (id_personal) references personal (id_personal)
);

/*inserta tuplas en la relación*/
insert into personal_seg_social (id_personal, eps, arl) 
    values (1, 'commeva', 'sura'),
            (2, 'emsanar', 'comfenalco'),
            (3, 'asmetsalud', 'colmena');

/*consulta los datos insertados*/
select * from personal_seg_social;

/************************************************************************************************************/

/* crea la relación funcionario */
CREATE TABLE funcionario(
    id_funcionario serial primary key,
    id_personal int not null,
    cargo varchar(45) not null,
    foreign key (id_personal) references personal (id_personal)
);

/*inserta tuplas en la relación*/
insert into funcionario (id_funcionario, id_personal, cargo) 
    values (1, 1, 'vigilante'),
            (2, 2, 'secretaria');

/*consulta los datos insertados*/
select * from funcionario;

/************************************************************************************************************/    

/* crea la relación profesor */
CREATE TABLE profesor(
    id_profesor serial primary key,
    id_personal int not null,
    departamento varchar(45) not null,
    foreign key (id_personal) references personal (id_personal)
);

/*inserta tuplas en la relación*/
insert into profesor (id_profesor, id_personal, departamento) 
    values (1, 1, 'matematicas'),
            (2, 3, 'EISC');

/*consulta los datos insertados*/            
select * from profesor;

/************************************************************************************************************/    

/* crea la relación asistencia */
CREATE TABLE asistencia(
    id_asistencia serial primary key,
    id_personal int,
    id_estudiante int,
    fecha_hora timestamp not null,
    foreign key (id_personal) references personal (id_personal),
    foreign key (id_estudiante) references estudiante (id_estudiante)
);

/*inserta tuplas en la relación (asistencia de estudiante) */
insert into asistencia (id_asistencia, id_estudiante, fecha_hora) 
    values (1, 1, '17-01-2022 12:00:00'),
            (2, 2, '17-01-2022 12:01:00');


/*inserta tuplas en la relación (asistencia de personal) */
insert into asistencia (id_asistencia, id_personal, fecha_hora) 
    values (3, 1, '17-01-2022 11:10:00'),
            (4, 3, '17-01-2022 11:30:00');    

/*consulta los datos insertados*/            
select * from asistencia;

/************************************************************************************************************/    

/* comandos psql */

CREATE DATABASE asistencia; /*crea una base de datos*/
DROP TABLE sede; /*elimina una tabla existente.*/ 
DROP DATABASE asistencia; /*elimina una base de datos*/
ALTER TABLE sede DROP COLUMN codigo; /*elimina una coumna*/ 

select * from administrador;
select * from sede;
select * from estudiante;
select * from estudiante_codigo;
select * from curso;
select * from estudiante_curso;
select * from curso_grupo;
select * from personal;
select * from personal_seg_social;
select * from funcionario;
select * from profesor;
select * from asistencia;
