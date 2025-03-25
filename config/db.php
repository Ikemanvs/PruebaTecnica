<?php

class DatabaseController
{
    private $conn;

    public function __construct()
    {
        $this->connect();
    }

    // Conexión a la base de datos con autenticación de Windows
    private function connect()
    {
        $serverName = "DESKTOP-ROA2S5O";
        $databaseName = "productos_demo";

        // Autenticación de Windows (integrada)
        $connectionInfo = [
            "Database" => $databaseName,
            "UID" => "", // Dejar vacío para autenticación integrada
            "PWD" => "", // Dejar vacío para autenticación integrada
            "CharacterSet" => "UTF-8" // Para soportar caracteres especiales
        ];

        $this->conn = sqlsrv_connect($serverName, $connectionInfo);

        if ($this->conn === false) {
            die(print_r(sqlsrv_errors(), true));  // Muestra errores si la conexión falla
        }
    }

    // Ejecutar un procedimiento almacenado
    public function executeStoredProcedure($procedureName, $params = [])
    {
        $paramList = [];
        foreach ($params as $param) {
            $paramList[] = [$param, SQLSRV_PARAM_IN];
        }

        $sql = "{CALL $procedureName(" . implode(",", array_fill(0, count($params), "?")) . ")}";

        $stmt = sqlsrv_query($this->conn, $sql, $paramList);

        if ($stmt === false) {
            die(print_r(sqlsrv_errors(), true));
        }

        // Recorrer los resultados si es necesario
        $results = [];
        while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
            $results[] = $row;
        }

        sqlsrv_free_stmt($stmt);
        return $results;
    }

    // Cierra la conexión
    public function closeConnection()
    {
        if ($this->conn) {
            sqlsrv_close($this->conn);
        }
    }
}

// Uso del controlador
$controller = new DatabaseController();
?>
