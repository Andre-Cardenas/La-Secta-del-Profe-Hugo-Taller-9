USE BDMesaDePartes;

-- se pide el idSolicitante la fecha y hora del trámite, nombre del trámite, 
-- cantidad de folios del trámite y la denominación de la Oficina
DELIMITER //
CREATE PROCEDURE spListarTramitesSolicitante(
    IN solicitanteID VARCHAR(4)
)
BEGIN
    SELECT T.idT, T.fechaHoraT, T.nombreT, T.cantidadFoliosT, O.denominacionO
    FROM tTramite T
    JOIN tOficina O ON T.idO = O.idO
    WHERE T.idS = solicitanteID;
END //
DELIMITER ;
-- Llamada al procedimiento
CALL spListarTramitesSolicitante('S001');

-- se pide el idSolicitante, los nombres, apellido paterno, materno y el total del recibo
DELIMITER //
CREATE PROCEDURE spTotalPagosSolicitante(
    IN solicitanteID VARCHAR(4)
)
BEGIN
    SELECT S.idS, CONCAT(S.paternoS, ' ', S.maternoS, ', ', S.nombresS) AS NombreCompleto,
           SUM(R.totalR) AS TotalPagado
    FROM tRecibo R
    JOIN tSolicitante S ON R.idS = S.idS
    WHERE S.idS = solicitanteID
    GROUP BY S.idS;
END //
DELIMITER ;
-- Llamada al procedimiento
CALL spTotalPagosSolicitante('S002');

-- se pide el idSolicitante, el id del recibo, fecha y hora del recibo, denominación del concepto
-- y el costo del concepto
DELIMITER //
CREATE PROCEDURE spMostrarRecibosSolicitante(
    IN solicitanteID VARCHAR(4)
)
BEGIN
    SELECT R.idR, R.fechaHoraR, C.denominacionC, C.costoC
    FROM tRecibo R
    JOIN tConcepto C ON R.idC = C.idC
    WHERE R.idS = solicitanteID;
END //
DELIMITER ;
-- Llamada al procedimiento
CALL spMostrarRecibosSolicitante('S003');

-- se pide el idSolicitante, el id del tramite, nombre del tramite, id del recibo, denominación del concepto,
-- costo del concepto
DELIMITER //
CREATE PROCEDURE spTramitesConPagos(
    IN solicitanteID VARCHAR(4)
)
BEGIN
    SELECT T.idT, T.nombreT, R.idR, C.denominacionC, C.costoC
    FROM tTramite T
    JOIN tRecibo_Tramite RT ON T.idT = RT.idT
    JOIN tRecibo R ON RT.idR = R.idR
    JOIN tConcepto C ON R.idC = C.idC
    WHERE T.idS = solicitanteID;
END //
DELIMITER ;
-- Llamada al procedimiento
CALL spTramitesConPagos('S004');

-- se pide todos los tramites de la oficina, denominacipn de oficina y elid del tramite
DELIMITER //
CREATE PROCEDURE spOficinasConTramites()
BEGIN
    SELECT O.denominacionO, COUNT(T.idT) AS TotalTramites
    FROM tOficina O
    LEFT JOIN tTramite T ON O.idO = T.idO
    GROUP BY O.denominacionO;
END //
DELIMITER ;
-- Llamada al procedimiento
CALL spOficinasConTramites();