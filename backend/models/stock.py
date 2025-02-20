from server import get_dbConnection

class Producto:
    def __init__(self, db):
        self.db = db

    def InsertarProducto(self,nombre:str,stock:int,precioUnitario:float,categoria_id:int):
        query = "INSERT INTO Productos (nombre, stock, precioUnitario, categoria_id) VALUES (%s, %s, %s, %s)"
        valores = (nombre, stock, precioUnitario, categoria_id)
        self.db.ejecutar(query, valores)
        return "Usuario registrado con éxito."

    

    