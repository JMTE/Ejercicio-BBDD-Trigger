--------------------------------------------------------
--  DDL for Trigger EMPLOYEES_BU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "HR"."EMPLOYEES_BU" BEFORE /*En esta primera linea, definimos el nombre del trigger, por buenas practicas
y para que el usuario que lo utilice sepa que funcion hacel el trigger, lo llamamos como la tabla que se va a modificar seguido de
dos letras, la primera indica cuando se va a desencadenar las acciones de este disparador y la segunda, con que sentencia se va a llevar a cabo.
Por lo tanto, sabemos que este disparador se tiene que disparar antes de(BEFORE(B)) la actualizacion de los datos del salario del empleado(UPDATE(U)).
Despues del nombre del trigger irán precisamente estas dos palabras, cuando se dispara AFTER o BEFORE y con que sentencia lo hace(UPDATE,INSERT,DELETE).*/
        
        UPDATE ON employees --Nosotros tenemos que dispararlo antes de que se realice la actualizacion de los registros.
       
        FOR EACH ROW --Esta sentencia significa que el trigger se dispara una vez por cada registro actualizado en la tabla employees

BEGIN --Aqui empiezan las condiciones que deben de cumplirse para que nuestro trigger se dispare.
/*Tal como dice el enunciado, solo se disparará y copiara la informacion que queremos a la nueva tabla si el salario introducido es distinto
que el salario en ese momento del empleado. Por lo tanto aqui podemos hacer un condicional if comparando de la siguiente manera el salario 
nuevo con el salario antiguo. El salario nuevo lo pilla de los datos que tu metes en el update.*/
       
        IF :old.salary = :new.salary THEN
    /*Si el salario es el mismo, hacemos que salte el procedimiento llamado raise_application_error que nos sirve para levantar errores
    y definir con un mensaje el error*/
                raise_application_error(-
        20600,
                               ' El nuevo salario es igual que el anterior '
                               || :new.salary
                               || '='
                               || :old.salary);

    ELSE
    /*Si el salario nuevo es distino del antiguo, entonces introducimos en nuestra tabla creada los valores que nos interesan 
    segun el enunciado(numero de empleado, momento de la actualizacion y un mensaje donde se especifica el salario viejo y el nuevo*/
                
                INSERT INTO emp_audit VALUES (
            :old.employee_id,
            sysdate,
            'El salario anterior era '
            || :old.salary
            || ' y el salario nuevo es '
            || :new.salary
        );

    END IF; --Finalizamos el condicional if
END; --finalizamos la programacion de nuestro trigger
/
ALTER TRIGGER "HR"."EMPLOYEES_BU" ENABLE;
