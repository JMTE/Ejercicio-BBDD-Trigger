CREATE TABLE emp_audit (
    num_empleado  NUMBER(6),
    fec_actualiz  TIMESTAMP, /*El Formato de esta fecha de actualizacion lo queremos con toda la
    informacion posible, dia,mes,a�o,hora,segundos.*/
        mensaje       VARCHAR2(100) /*A esta columna que almacenar� un mensaje le damos suficiente longitud
        para que el mensaje nos entre en ella*/
);