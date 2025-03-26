# PruebaTecnica
El proyecto requiere PHP 8.3 corriendo en IIS y una conexión a SQL Server para poder ser ejecutado.
Las técnologias usadas fueron PHP, Javascript, CSS y SQL Server
Las librerias usadas fueron Bootstrap y JQuery
Los scripts para la base de datos se encuentran en la carpeta "db"
- Se debe revisar el script, considerando que tiene una ruta local para crearlo, se debe cambiar por la ruta del equipo a ejecutar
- En ese script se dan los permisos al usuario de IIS para que pueda realizar las consultas con los procedimientos almacenados, el usuario actualmente se encuentra como [IIS APPPOOL\DefaultAppPool]
- En caso de que se use una instalación nueva de SQL Server, el usuario previamente mencionado se debe crear en los logins de SQL (se puede realizar desde SSMS)
