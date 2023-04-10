# Instalador automático de WordPress

Este es un script en Bash que automatiza la instalación de WordPress en un servidor Ubuntu. 

## Requisitos

Antes de ejecutar este script, asegúrate de que cumplir con los siguientes requisitos:

- Tener un servidor Ubuntu.
- Tener acceso de superusuario (sudo).
- Editar `env.sh` con las variables de entorno necesarias.

## Pasos

Para ejecutar este script, sigue los siguientes pasos:

1. Clona este repositorio en tu servidor Ubuntu.

2. Edita el archivo `env.sh` con las siguientes variables de entorno:

    ```
    export MYSQL_ROOT_PASSWORD=contraseña_de_mysql
    export wordpress_domain=nombre_de_tu_dominio
    export wordpress_db_name=nombre_de_la_base_de_datos_de_wordpress
    export wordpress_db_user=usuario_de_la_base_de_datos_de_wordpress
    export wordpress_db_password=contraseña_de_la_base_de_datos_de_wordpress
    ```

3. Ejecuta el siguiente comando para dar permisos de ejecución al script:

    ```
    chmod +x install-wordpress.sh
    ```

4. Ejecuta el script:

    ```
    ./install-wordpress.sh
    ```

5. Abre tu navegador y entra en la dirección `http://tu_dominio.com` para configurar WordPress.

## Descripción de los pasos

Este script realiza los siguientes pasos:

1. Carga las variables de entorno desde el archivo `env.sh`.
2. Actualiza apt-get.
3. Instala Apache, PHP, MySQL y expect.
4. Ejecuta el script `mysql_secure_install.expect` para asegurar la instalación de MySQL.
5. Crea una base de datos de MySQL para WordPress.
6. Descarga e instala WordPress en el directorio `/var/www/html/wordpress`.
7. Configura el archivo de configuración de WordPress `wp-config.php`.
8. Configura un virtual host para tu dominio en Apache.
9. Limpia el archivo `latest.tar.gz` descargado durante la instalación.

## Advertencia

Este script se proporciona tal cual, sin garantía de ningún tipo. El autor no es responsable de ningún daño que pueda causar su uso. Antes de ejecutar este script, asegúrate de que entiendes lo que hace.