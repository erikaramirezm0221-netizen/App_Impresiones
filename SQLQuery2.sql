SELECT nombre, COUNT(*) 
FROM producto
GROUP BY nombre
HAVING COUNT(*) > 1;