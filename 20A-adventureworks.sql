USE ADVENTUREWORKS;
#Mostrar el nombre, precio y color de los accesorios para asientos de las bicicletas
#cuyo precio sea mayor a 100 pesos
#Tablas: Production.Product
#Campos: Name, ListPrice, Color
SELECT Name, ListPrice, Color
FROM Product
WHERE ListPrice > 100 AND Name LIKE '%seat%';

#Mostrar los empleados que tienen más de 90 horas de vacaciones
#Tablas: Employee
#Campos: VacationHours, BusinessEntityID
SELECT LOGINID, VACATIONHOURS
FROM EMPLOYEE
WHERE VACATIONHOURS > 90;

#Mostrar el nombre, precio y precio con iva de los productos con precio distinto de cero
#Tablas: Product
#Campos: Name, ListPrice
SELECT NAME, LISTPRICE AS PRECIO_CON_IVA, STANDARDCOST AS PRECIO
FROM PRODUCT
WHERE STANDARDCOST != 0;

#Mostrar precio y nombre de los productos 776, 777, 778
#Tablas: Product
#Campos: ProductID, Name, ListPrice
SELECT PRODUCTID, STANDARDCOST, NAME
FROM PRODUCT
WHERE PRODUCTID IN (776, 777, 778);


#Mostrar las personas ordenadas primero por su apellido y luego por su nombre
#Tablas: Contact
#Campos: Firstname, Lastname
SELECT FIRSTNAME, LASTNAME
FROM CONTACT
ORDER BY FIRSTNAME, LASTNAME;

#Mostrar la cantidad y el total vendido por productos
#Tablas: SalesOrderDetail
#Campos: LineTotal
SELECT PRODUCTID, COUNT(*) AS CANTIDAD, SUM(LineTotal) AS TOTAL_VENDIDO 
FROM SALESORDERDETAIL
GROUP BY PRODUCTID;

#Mostrar el código de subcategoría y el precio del producto más barato de cada una de ellas
#Tablas: Product
#Campos: ProductSubcategoryID, ListPrice
SELECT ProductSubcategoryID, MIN(LISTPRICE)
FROM PRODUCT
GROUP BY ProductSubcategoryID;

#Mostrar todas las facturas realizadas y el total facturado de cada una de ellas
#ordenado por número de factura pero sólo de aquellas órdenes superen un total de
#$10.000
#Tablas: SalesOrderDetail
#Campos: SalesOrderID, LineTotal
SELECT SalesOrderID, LineTotal
FROM SalesOrderDetail
HAVING LINETOTAL > 10000
ORDER BY SalesOrderID;

#Mostrar los empleados que también son vendedores
#Tablas: Employee, SalesPerson
SELECT *
FROM EMPLOYEE
INNER JOIN SalesPerson ON EMPLOYEE.EMPLOYEEID = SalesPerson.SALESPERSONID;

#Mostrar los empleados ordenados alfabéticamente por apellido y por nombre
#Tablas: Employee, Contact
#Campos: LastName, FirstName
SELECT LASTNAME, FIRSTNAME
FROM EMPLOYEE
INNER JOIN CONTACT ON EMPLOYEE.CONTACTID = CONTACT.CONTACTID
ORDER BY LASTNAME, FIRSTNAME;