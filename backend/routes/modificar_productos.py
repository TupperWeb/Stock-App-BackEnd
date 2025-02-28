from flask import Blueprint, request, jsonify
from models.stock import Producto  # Importamos la clase Libro

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
@producto_bp.route("/productos/<int:codigo>", methods=["GET"])
def obtenerXcodigo(codigo):
    producto = Producto.obtener_por_codigo(id)
    if producto:
        return jsonify(producto)
    return jsonify({"Error": "Producto no encontrado"}), 404

# Agregar un nuevo producto
@producto_bp.route("/productos", methods=["POST"])
def agregar_producto():
    data = request.json
    nuevo_producto = Producto(nombre=data["nombre"], stock=data["stock"], precioUnitario=data["anio_publicacion"], categoria_id=data("categoria_id"))
    codigo = nuevo_producto.guardar()
    return jsonify({"Mensaje": "Producto agregado con éxito", "codigo": codigo}), 201

# Actualizar un Producto
@producto_bp.route("/productos/<int:id>", methods=["PUT"])
def actualizar_producto(id):
    data = request.json
    producto = Producto.obtener_por_id(id)
    if not producto:
        return jsonify({"Error": "Producto no encontrado"}), 404

    producto_actualizado = Producto(id=id, codigo=data["codigo"], nombre=data["nombre"], stock=data["stock"], precioUnitario=data["precioUnitario"], categoria_id=data["categoria_id"])
    producto_actualizado.actualizar()
    return jsonify({"Mensaje": "Producto actualizado con éxito"}), 200

# Eliminar un Producto
@producto_bp.route("/productos/<int:id>", methods=["DELETE"])
def eliminar_producto(id):
    producto = Producto.obtener_por_id(id)
    if not producto:
        return jsonify({"Error": "Producto no encontrado"}), 404
    else:
        Producto.eliminar_por_id(id)
        return jsonify({"Mensaje": "Producto eliminado con éxito"})