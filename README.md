# Quiz #5 - SQL (CE 2103)

**Instituto Tecnológico de Costa Rica**  
**Curso:** Algoritmos y Estructuras de Datos II  
**Semestre:** II Semestre 2026

### Integrantes
- José Pablo Valverde Durán
- Juan José Rodríguez Chaves

## 1. Tipo de base de datos elegida

Para este trabajo utilizamos una base de datos **relacional**, con **MySQL** y MySQL Workbench. La base de datos se llama `MiAutoPuntoCom`.

## 2. Escenario (contexto del problema)

Para este quiz imaginamos que estamos construyendo el sistema de información de una empresa que vende vehículos, llamada MiAutoPuntoCom.

En una empresa de este tipo hay que llevar el control de varias cosas al mismo tiempo. Algunos ejemplos son:

- Los vehículos que tiene la empresa, con su marca, modelo, año, color, precio, VIN, tipo y si son nuevos o usados.
- Los clientes que compran, con sus datos de contacto.
- Los vendedores, con su fecha de contratación y el porcentaje de comisión que ganan.
- Las ventas realizadas, que relacionan un vehículo, un cliente y un vendedor, junto con la fecha, el precio final y el método de pago.

Como los datos están muy relacionados entre sí (una venta no existe sin un vehículo, un cliente y un vendedor), consideramos que una base de datos relacional es la mejor opción, ya que permite mantener la integridad de la información por medio de llaves y restricciones.

## 3. ¿Cómo utilizamos MySQL para resolver el problema?

Para cada parte del quiz hicimos lo siguiente:

| Parte | Qué hicimos | Archivo |
|---|---|---|
| Parte 1 (30 %) | Crear las tablas `Vehiculos`, `Clientes`, `Vendedores` y `Ventas` con sus tipos de datos | `01_ddl_miautopuntocom.sql` |
| Parte 2 (25 %) | Agregar las restricciones: PK, FK, `UNIQUE`, `CHECK` y `NOT NULL` | `01_ddl_miautopuntocom.sql` |
| Parte 3 (20 %) | Insertar 10 vehículos, 6 clientes, 4 vendedores y 8 ventas | `02_dml_miautopuntocom.sql` |
| Parte 4 (25 %) | Escribir las 8 consultas pedidas | `03_consultas_miautopuntocom.sql` |

La tabla `Ventas` está normalizada: en lugar de repetir los datos del vehículo, el cliente y el vendedor, solo guarda una llave foránea hacia cada una de esas tablas. Además, le pusimos `UNIQUE` al `id_vehiculo` para que un mismo vehículo no se pueda vender dos veces.

### Restricciones

- **Llaves primarias** en todas las tablas.
- **Llaves foráneas** en `Ventas` para mantener la integridad referencial.
- **UNIQUE** en el VIN, las cédulas (clientes y vendedores) y los emails.
- **CHECK**:
  - El año del vehículo debe estar entre 1900 y el año actual.
  - El precio debe ser mayor a 0.
  - La comisión del vendedor debe estar entre 0 % y 20 %.
  - El estado del vehículo solo puede ser `Nuevo` o `Usado`.
  - Los vendedores no pueden ser menores de 21 años.
- **NOT NULL** en los campos obligatorios.

### Decisiones que tomamos

- MySQL no permite usar `YEAR(CURDATE())` dentro de un `CHECK`, así que el mínimo de 1900 lo dejamos en el `CHECK` y el máximo (el año actual) lo validamos con un trigger.
- El enunciado no incluye la fecha de nacimiento de los vendedores, pero es necesaria para validar que tengan al menos 21 años. Por eso agregamos la columna `fecha_nacimiento` a la tabla `Vendedores`. La edad se revisa con la fecha de contratación.
- Todos los precios están en colones costarricenses (₡).
- Algunas ventas de los datos de prueba usan fechas relativas a la fecha actual (`DATE_SUB(CURDATE(), ...)`), para que la consulta del último mes siempre devuelva resultados sin importar cuándo se ejecute.
- En la consulta 7 mostramos tanto el promedio del precio de lista como el del precio final de venta, porque el enunciado no aclara cuál de los dos pide.

## 4. Estructura del repositorio

El proyecto está organizado en los siguientes archivos:

```text
01_ddl_miautopuntocom.sql         # Crea la base de datos, las tablas, las restricciones y el trigger
02_dml_miautopuntocom.sql         # Inserta los datos de prueba
03_consultas_miautopuntocom.sql   # Contiene las 8 consultas
README.md                         # Este documento
```

## 5. ¿Cómo ejecutar el programa?

Para probar los scripts es necesario tener MySQL Server (versión 8.0.16 o superior) y MySQL Workbench instalados.

**1.** Abrimos MySQL Workbench y nos conectamos al servidor local con el usuario `root`.

**2.** Abrimos el primer script desde `File > Open SQL Script...` y lo ejecutamos completo con el botón del rayo (o `Ctrl + Shift + Enter`):

```text
01_ddl_miautopuntocom.sql
```

**3.** Repetimos el mismo proceso con el segundo script, que carga los datos:

```text
02_dml_miautopuntocom.sql
```

**4.** Finalmente ejecutamos el script de consultas. Cada `SELECT` genera su propia pestaña de resultados (Result 1, Result 2, ...):

```text
03_consultas_miautopuntocom.sql
```

Los scripts se deben correr en ese orden. Hay que tener en cuenta que el script 01 borra y vuelve a crear la base de datos, así que si se ejecuta otra vez hay que volver a correr también el 02.

Si se prefiere la línea de comandos, también se pueden ejecutar así:

```bash
mysql -u root -p < 01_ddl_miautopuntocom.sql
mysql -u root -p < 02_dml_miautopuntocom.sql
mysql -u root -p < 03_consultas_miautopuntocom.sql
```

## 6. Salida esperada

Para verificar que todo se cargó bien, se pueden contar los registros de cada tabla:

```text
Vehiculos: 10
Clientes: 6
Vendedores: 4
Ventas: 8
```

Al ejecutar el script de consultas, se espera obtener una salida similar a la siguiente:

```text
=== 1. Vehículos disponibles ===
Hyundai Elantra 2024 - ₡14 200 000
Nissan Sentra 2025   - ₡12 500 000

=== 2. Ventas por vendedor ===
Andrés Solís Araya   - 3 ventas
Karla Méndez Pérez   - 2 ventas
Jorge Castro Leiva   - 2 ventas
Marcela Rojas Vega   - 1 venta

=== 3. Ingreso total por vendedor ===
Jorge Castro Leiva   - ₡74 500 000
Karla Méndez Pérez   - ₡43 000 000
Andrés Solís Araya   - ₡32 700 000
Marcela Rojas Vega   - ₡19 000 000

=== 4. Cliente con la compra más costosa ===
Carlos Rojas Mora - ₡43 500 000

=== 6. Comisión ganada por vendedor ===
Jorge Castro Leiva   - ₡2 048 750
Karla Méndez Pérez   - ₡1 720 000
Andrés Solís Araya   - ₡1 144 500
Marcela Rojas Vega   - ₡950 000

=== 8. Marca más vendida ===
Toyota - 2 ventas
```

Las consultas 5 y 7 también devuelven resultados, pero la 5 depende de la fecha en que se ejecute (muestra las ventas del último mes).

## 7. Conclusión

Con este quiz pudimos practicar cómo se construye una base de datos relacional en MySQL, desde la creación de las tablas hasta las consultas. También vimos lo importantes que son las restricciones (llaves, `UNIQUE`, `CHECK` y `NOT NULL`), porque evitan que se guarden datos incorrectos, como un precio negativo, un VIN repetido o un vendedor menor de edad.

Además, comprobamos que las consultas con `JOIN`, `GROUP BY` y funciones de agregación como `SUM`, `COUNT` y `AVG` permiten sacar información útil a partir de varias tablas relacionadas. Para un sistema como el de MiAutoPuntoCom, donde los vehículos, clientes, vendedores y ventas dependen unos de otros, nos pareció que el modelo relacional es una muy buena opción.
