-- Base de Datos Academico
-- La secta del profe Hugo
-- 24/03/25

IF DB_ID('baseTramites_La_secta_del_profe_Hugo') IS NOT NULL
DROP DATABASE baseTramites_La_secta_del_profe_Hugo;
GO
CREATE DATABASE baseTramites_La_secta_del_profe_Hugo;
GO
USE baseTramites_La_secta_del_profe_Hugo;
GO
CREATE TABLE tSolicitante (
	idS VARCHAR(4) NOT NULL,
	tipoS VARCHAR(7),
	tipoDocumS VARCHAR(7),
	nroDocumS VARCHAR(15),
	paternoS VARCHAR(50),
	maternoS VARCHAR(50),
	nombresS VARCHAR(50),
	razonSocialS VARCHAR(50),
	celularS VARCHAR(15),
	telefonoS VARCHAR(15),
	dirElectronS VARCHAR(50),
	PRIMARY KEY (idS)
);
INSERT INTO tSolicitante VALUES('S001','EST', 'carnet','123016101J','Torres', 'Loza','Boris',
NULL,'911111111','51-84-221111','123016101J@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S002','EST','carnet','123015100A','P�rez','S�nchez','Jos�',
NULL,'922222222','51-84-222222','123015100A@uandina.edu.pe');
INSERT INTO tSolicitante
VALUES('S003','EST','carnet','123014200D','Arenas','Campos','Raul',
NULL,'933333333','51-84-223333','123014200D@uandina.edu.pe');
INSERT INTO tSolicitante VALUES('S004','EST','carnet','123015300F','Maldonado',
'Rojas','Jorge', NULL,'944444444','51-84-224444','123015300F@uandina.edu.pe');
INSERT INTO tSolicitante VALUES('S005','EST',
'carnet','123015300B','Salinas','Valle','Daniel',NULL,'955555555','51-84-225555','123015300
B@uandina.edu.pe');
INSERT INTO tSolicitante VALUES('S006', 'PROF', 'DNI', '01111110','Palomino','Cahuaya',
'Ariadna', NULL,'966666666','51-84-226666', 'apalominoc@uandina.edu');
INSERT INTO tSolicitante VALUES('S007', 'PROF', 'DNI', '02222220','Espetia','Humanga',
'Hugo', NULL,'966666666','51-84-226666', 'hespetia@uandina.edu.pe');
GO
CREATE TABLE tOficina
(
	idO VARCHAR(4) NOT NULL,
	denominacionO VARCHAR(50),
	ubicacionO VARCHAR(50),
	responsableO VARCHAR(50),
	PRIMARY KEY (idO)
);
go
INSERT INTO tOficina VALUES('O001','Rectorado','AG-101 Larapa','Zambrano Ramos,
Juan');
INSERT INTO tOficina VALUES('O002','Direcci�n de Tecnolog�as de Informaci�n','ING-205
Larapa', 'Torres Campos, C�sar');
INSERT INTO tOficina VALUES('O003','Direcci�n del D.A. de Ingenier�a de
Sistemas','ING-211 Larapa', 'Zamalloa Campos, Gino');
INSERT INTO tOficina VALUES('O004','Tesorer�a','E-301 M�dulo de entrada -
Larapa','Ram�rez Tapia, Nohelia');
INSERT INTO tOficina VALUES('O005','RRHH','S�tano del Paraninfo - Larapa','Mart�nez
Salazar, Dante');
INSERT INTO tOficina VALUES('O006', 'Decanatura de Ingenier�a','ING-214 - Larapa',
'Gamarra Miranda, Javier');
go
CREATE TABLE tConcepto
(
idC VARCHAR(4) NOT NULL,
denominacionC VARCHAR(50),
costoC DECIMAL(10,2),
PRIMARY KEY (idC)
);
go
INSERT INTO tConcepto VALUES('C001','Convalidaci�n de s�labos',9);
INSERT INTO tConcepto VALUES('C002','Constancia de seguimiento de estudios',20);
INSERT INTO tConcepto VALUES('C003','Certificado de estudios',30);
INSERT INTO tConcepto VALUES('C004', 'Bachillerato I.S.',750);
INSERT INTO tConcepto VALUES('C005', 'Tr�mite',10);
INSERT INTO tConcepto VALUES('C006', 'Carta de presentaci�n para pr�cticas',12);
INSERT INTO tConcepto VALUES('C007', 'T�tulo de Ingeniero de Sistemas',900);
go
CREATE TABLE tRecibo
(
	idR VARCHAR(4) NOT NULL,
	fechaHoraR DATETIME,
	cantidadR INT,
	totalR DECIMAL(10,2),
	idC VARCHAR(4),
	PRIMARY KEY (idR),
	FOREIGN KEY (idC) REFERENCES tConcepto(idC),
	idS VARCHAR(4),
	FOREIGN KEY (idS) REFERENCES tSolicitante(idS)
);
go
INSERT INTO tRecibo VALUES('R002','06-27-2017 11:30:00',9,NULL, 'C001', 'S001');
INSERT INTO tRecibo VALUES('R003', '07-25-2017 12:30:00',1,NULL, 'C002', 'S002');
INSERT INTO tRecibo VALUES('R004', '07-26-2017 09:45:00',1,NULL, 'C003', 'S003');
INSERT INTO tRecibo VALUES('R005', '08-01-2017 09:55:00',1,NULL, 'C004', 'S004');
INSERT INTO tRecibo VALUES('R006','08-03-2017 09:56:00',1,NULL, 'C005', 'S004');
INSERT INTO tRecibo VALUES('R007', '08-04-2017 12:00:00',1,NULL, 'C006', 'S005');
go
CREATE TABLE tTramite
( idT VARCHAR(4) NOT NULL,
fechaHoraT DATETIME,
nombreT VARCHAR(70),
cantidadFoliosT INT,
idS VARCHAR(4),
PRIMARY KEY (idT),
FOREIGN KEY (idS) REFERENCES tSolicitante(idS),
idO VARCHAR(4),
FOREIGN KEY (idO) REFERENCES tOficina(idO));
go
CREATE TABLE tRecibo_Tramite
(idRT VARCHAR(4) NOT NULL,
PRIMARY KEY (idRT),
idT VARCHAR(4),
FOREIGN KEY (idT) REFERENCES tTramite(idT),
idR VARCHAR(4),
FOREIGN KEY (idR) REFERENCES tRecibo(idR));
go
INSERT INTO tTramite VALUES('T001','06-25-2027 10:15:00','Licencia por 2
d�as',2,'S006','O005');
INSERT INTO tTramite VALUES('T002','06-27-2017 12:00:00','Convalidaci�n de s�labos de
I.S.',2,'S001','O006');
INSERT INTO tTramite VALUES('T003','07-25-2017 12:50:00','Constancia de seg.
estudios',2,'S002','O006');
INSERT INTO tTramite VALUES('T004','07-26-2017 10:00:00','Certificado de estudios del
2017-I',2,'S003','O006');
INSERT INTO tTramite VALUES('T005','08-01-2017
10:05:00','Bachillerato',11,'S004','O006');
INSERT INTO tTramite VALUES('T006','08-03-2017 12:30:00','Carta presentaci�n pr�ct
EGEMSA 1-sep al 1 mar 2017',2,'S005','O006');
INSERT INTO tTramite VALUES('T007','08-04-2017 08:30:00','Permiso por salud 5
d�as',2,'S007','O005');
go
INSERT INTO tRecibo_Tramite VALUES('RT01','T002','R002');
INSERT INTO tRecibo_Tramite VALUES('RT02','T003','R003');
INSERT INTO tRecibo_Tramite VALUES('RT03','T004','R004');
INSERT INTO tRecibo_Tramite VALUES('RT04','T005','R005');
INSERT INTO tRecibo_Tramite VALUES('RT05','T005','R006');
INSERT INTO tRecibo_Tramite VALUES('RT06','T006','R007');
go
select * from tSolicitante
go
select * from tOficina
go
select * from tConcepto
go
select * from tRecibo
go
select * from tTramite
go
select * from tRecibo_Tramite
go