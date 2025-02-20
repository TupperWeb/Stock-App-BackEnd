# Stock-App-BackEnd
Repositorio creado para compartir nuestros avances en el sector BackEnd de la aplicación de manejo de stock (MVP).  
Cualquier cambio (creación o modificación de archivos/carpetas) será benvenido:)

# Estructura propuesta del proyecto

/control-stock-api   # Carpeta raíz del proyecto
│── /backend         # Backend con Flask
│   │── app.py       # Archivo principal de Flask
│   │── config.py    # Configuración de la app (DB, variables de entorno)
│   │── /models      # Modelos de la base de datos (SQLAlchemy)
│   │   │── stock.py # Modelo de productos en stock
│   │   │── user.py  # Modelo de usuarios (si hay autenticación)
│   │── /routes      # Rutas de la API
│   │   │── stock_routes.py  # Rutas para CRUD de stock
│   │   │── user_routes.py   # Rutas para autenticación (si aplica)
│   │── /services    # Lógica de negocio separada de las rutas
│   │── /db          # Migraciones y conexión a la base de datos
│   │── requirements.txt  # Dependencias de Python
│   │── wsgi.py      # Punto de entrada para despliegue