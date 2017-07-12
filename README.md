# Tidyeando los datos de proyecciones poblacionales de CONAPO

CONAPO, como otras agencias del Estado mexicano, tiende a publicar sus bases de datos en formatos lejanos al ideal [*tidy*](http://r4ds.had.co.nz/tidy-data.html) (una variable por columna, una observación por renglón, un valor por celda). Como consecuencia, estas bases de datos suelen ser poco amigables para trabajar con ellas en programas estadísticos.

Para muestra un botón:

![alt text](http://segasi.com.mx/github/conapo_ags.png)


Estas líneas de código permiten:

1. Unir las 32 bases de datos (una por entidad) de proyecciones poblaciones municipales publicadas por [CONAPO](http://www.conapo.gob.mx/es/CONAPO/Proyecciones_Datos).

2. Limpiar y transformar la base de datos para generar una nueva con siete variables: 
- **edo**: entidad  
- **cve_mpo**: clave municipal
- **mpo**: nombre del municipio
- **sexo**: Femenino, Másculino o Ambos (e.g., total) 
- **gpo_edad**: Grupo de edad
- **año**: de 2010 a 2030
- **valor**: proyección poblacional para el municipio, sexo y año correspondiente

El resultado es:

![alt text](http://segasi.com.mx/github/conapo_tidyeado.png)
