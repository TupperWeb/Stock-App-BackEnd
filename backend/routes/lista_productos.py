from flask import Blueprint, request, jsonify
from models.stock import Producto  

producto_bp = Blueprint("producto_bp", __name__)

# Obtener todos los productos
@producto_bp.route("/productos", methods=["GET"])
def obtener_productos():
    productos = Producto.obtener_todos()
    return jsonify(productos), 200

# Obtener un producto por ID
@producto_bp.route("/productos/<int:id>", methods=["GET"])
def obtenerXid(id):
    producto = Producto.obtener_por_id(id)
    if producto:
        return jsonify(producto)
    return jsonify({"Error": "Producto no encontrado"}), 404

#Obtener un producto por Codigo
@producto_bp.route("/productos/<str:codigo>", methods=["GET"])
def obtenerXcodigo(codigo):
    producto = Producto.obtener_por_codigo(codigo)
    if producto:
        return jsonify(producto)
    return jsonify({"Error": "Producto no encontrado"}), 404
