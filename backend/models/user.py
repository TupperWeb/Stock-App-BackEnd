import os  

class usuario:
    def __init__(self):
        self.nombre = os.getenv("USER_NAME", "sucursal_default") 

        
    def obtener_nombre(self):
        return self.nombre