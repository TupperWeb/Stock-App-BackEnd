from server import get_dbConnection

class Producto:
    def __init__(self, id:int=None, codigo:str=None, nombre:str=None, stock:int=None, precioUnitario:float=None, categoria_id:int=None):
        self.__id = id
        self.__codigo = codigo
        self.__nombre = nombre
        self.__stock = stock
        self.__precioUnitario = precioUnitario
        self.__categoriaId = categoria_id

# GET 
    @staticmethod
    def obtener_todos(): # Retorna todos los productos de la tabla Productos
        db = get_dbConnection()
        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Productos")
        productos = cursor.fetchall()
        db.close()
        return productos

    @staticmethod
    def obtener_por_id(id): # Retorna un producto que corresponda con el ID ingresado
        db = get_dbConnection()
        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Productos WHERE id = %s", (id,))
        producto = cursor.fetchone()
        db.close()
        return producto
    
    @staticmethod
    def obtener_por_codigo(codigo): # Retorna un producto que corresponda con el codigo ingresado
        db = get_dbConnection()
        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Productos WHERE codigo = %s", (id,))
        producto = cursor.fetchone()
        db.close()
        return producto
# POST
    def guardar(self):
        db = get_dbConnection()
        cursor = db.cursor()
        cursor.execute(
            "INSERT INTO Productos (nombre, stock, precioUnitario, categoria_id) VALUES (%s, %s, %s, %s)",
            (self.__nombre, self.__stock, self.__precioUnitario, self.__categoriaId)
        )
        db.commit()
        self.__id = cursor.lastrowid
        #self.__codigo = cursor.#?????????????
        db.close()
        #return self.__id#????)
#PUT
    def actualizar(self):
        db = get_dbConnection()
        cursor = db.cursor()
        cursor.execute(
            "UPDATE Productos SET codigo=%s, nombre=%s, stock=%s, precioUnitario=%s, categoria_id=%s WHERE id=%s",
            (self.__codigo, self.__nombre, self.__stock, self.__precioUnitario, self.__categoriaId)
        )
        db.commit()
        db.close()
        return True
#DELETE
    @staticmethod
    def eliminar_por_id(id):
        db = get_dbConnection()
        cursor = db.cursor()
        cursor.execute("DELETE FROM Productos WHERE id = %s", (id,))
        db.commit()
        db.close()
        return True
#DELETE   
    @staticmethod
    def eliminar_por_codigo(codigo):
        db = get_dbConnection()
        cursor = db.cursor()
        cursor.execute("DELETE FROM Productos WHERE codigo = %s", (codigo,))
        db.commit()
        db.close()
        return True
