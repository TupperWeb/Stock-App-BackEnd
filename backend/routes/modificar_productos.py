from flask import Blueprint, request, jsonify
from models.stock import Producto  

producto_bp = Blueprint("producto_bp", __name__)

# Agregar un nuevo producto
@producto_bp.route("/productos", methods=["POST"])
def agregar_producto():
    data = request.json
    nuevo_producto = Producto(nombre=data["nombre"], stock=data["stock"], precioUnitario=data["anio_publicacion"], categoria_id=data("categoria_id"))
    codigo = nuevo_producto.guardar()
    return jsonify({"Mensaje": "Producto agregado con éxito", "su codigo es": codigo}), 201


# Actualizar un Producto por ID
@producto_bp.route("/productos/<int:id>", methods=["PUT"])
def actualizar_producto(id):
    data = request.json
    producto = Producto.obtener_por_id(id)
    if not producto:
        return jsonify({"Error": "Producto no encontrado"}), 404

    producto_actualizado = Producto(id=id, codigo=data["codigo"], nombre=data["nombre"], stock=data["stock"], precioUnitario=data["precioUnitario"], categoria_id=data["categoria_id"])
    producto_actualizado.actualizar()
    return jsonify({"Mensaje": "Producto actualizado con éxito"}), 200

# Actualizar un Producto por Codigo
@producto_bp.route("/productos/<str:codigo>", methods=["PUT"])
def actualizar_producto(codigo):
    data = request.json
    producto = Producto.obtener_por_codigo(codigo)
    if not producto:
        return jsonify({"Error": "Producto no encontrado"}), 404

    producto_actualizado = Producto(id=producto.obtenerId(), codigo=data["codigo"], nombre=data["nombre"], stock=data["stock"], precioUnitario=data["precioUnitario"], categoria_id=data["categoria_id"])
    producto_actualizado.actualizar()
    return jsonify({"Mensaje": "Producto actualizado con éxito"}), 200


# Eliminar un Producto por ID
@producto_bp.route("/productos/<int:id>", methods=["DELETE"])
def eliminar_producto(id):
    producto = Producto.obtener_por_id(id)
    if not producto:
        return jsonify({"Error": "Producto no encontrado"}), 404
    else:
        Producto.eliminar_por_id(id)
        return jsonify({"Mensaje": "Producto eliminado con éxito"})
    
# Eliminar un Producto por codigo
@producto_bp.route("/productos/<str:codigo>", methods=["DELETE"])
def eliminar_producto(codigo):
    producto = Producto.obtener_por_codigo(codigo)
    if not producto:
        return jsonify({"Error": "Producto no encontrado"}), 404
    else:
        Producto.eliminar_por_codigo(codigo)
        return jsonify({"Mensaje": "Producto eliminado con éxito"})