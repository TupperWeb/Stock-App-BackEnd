from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

app = flask(__name__)
CORS(app) ##habilita CORS para conectar con el front

#conexion a la BD
db_config = {
    'user': 'root',
    'password': 'root',
    'host': '127.0.0.1',
    'database': 'stock_app'

}

def get_dbConnection():
    return mysql.connector.connect(**db_config)

#getters 

@app.route('/productos', methods=['GET'])
def get_productos():
    
        db = get_dbConnection()
        cursor = db.cursor()
        cursor.execute("SELECT * FROM productos")
        productos = cursor.fetchall()
        return jsonify(productos)
    
    
#crear un pedido
@app.route('/pedido', methods=['POST'])

def crear_pedido():
    data = request.json #recibe datos del frontend
    db = get_dbConnection
    cursor = db.cursor()
    
    #crear pedido y obtener ID
    cursor.execute("INSERT INTO pedidos (id_producto, cantidad, fecha) VALUES (%s, %s, %s)", (data['id_producto'], data['cantidad'], data['fecha']))
    pedido_id = cursor.lastrowid

    #insertar productos en el pedido
    for producto in data [producto]:
        cursor.execute("INSERT INTO pedido_producto (id_pedido, id_producto, cantidad) VALUES (%s , %s, %s)", 
                        (pedido_id, producto['id_producto'], producto['cantidad']))
        
    #calcular el total del pedido
    cursor.callproc("SumarTotal", [pedido_id])
    db.commmit()
    db.close

    return jsonify({f'message': 'Pedido creado con exito', "pedido_id": pedido_id}), 201
