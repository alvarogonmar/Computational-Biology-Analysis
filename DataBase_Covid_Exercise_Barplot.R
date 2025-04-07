###############################################################
# 1. Instalar y cargar el paquete 'rentrez' para acceder a NCBI
###############################################################
# install.packages("rentrez")  # Solo descomenta si no tienes instalado 'rentrez'
library(rentrez)               # Carga la librería rentrez, que permite interactuar con NCBI

###############################################################
# 2. Realizar una búsqueda de secuencias en la base de datos de NCBI
###############################################################
search_results <- entrez_search(
  db = "nucleotide",             # 'db' indica la base de datos en la que vamos a buscar. En este caso, "nucleotide".
  term = "SARS-CoV-2[Organism]", # 'term' especifica el término de búsqueda. Aquí buscamos secuencias de SARS-CoV-2.
  retmax = 10                    # 'retmax' indica el número máximo de resultados a recuperar (en este caso, 10).
)

###############################################################
# 3. Ver los ID de las secuencias encontradas
###############################################################
search_results$ids
# Esto mostrará una lista de IDs de secuencias (por ejemplo: "XXXXX.1", "YYYYY.1", etc.)

###############################################################
# 4. Obtener la secuencia de ADN de uno de los IDs encontrados
###############################################################
sequence_id <- search_results$ids[1]  # Seleccionamos el primer ID de la lista de resultados
sequence_data <- entrez_fetch(
  db = "nucleotide",         # De nuevo, indicamos la base de datos "nucleotide".
  id = sequence_id,          # El ID que hemos escogido (por ejemplo, "XXXXXX.1").
  rettype = "fasta",         # Formato de retorno: 'fasta', un formato estándar para secuencias.
  retmode = "text"           # Modo de retorno: 'text', para obtener la secuencia como texto (no binario).
)

###############################################################
# 5. Ver la secuencia en formato FASTA
###############################################################
cat(sequence_data)
# Imprime en la consola la secuencia junto con el encabezado FASTA (comienza con '>').

###############################################################
# 6. Limpiar la secuencia para quedarnos solo con las bases A, T, C y G
###############################################################
sequence_clean <- gsub(
  "[^ATCG]",   # Expresión regular: cualquier carácter que NO sea A, T, C o G
  "",          # Remplazarlo por un texto vacío (para eliminarlo)
  sequence_data
)

# Ahora 'sequence_clean' debería contener exclusivamente las letras A, T, C y G de la secuencia.

###############################################################
# 7. Ver la secuencia limpia (solo bases)
###############################################################
cat(sequence_clean)
# Debería mostrar únicamente la cadena de nucleótidos sin encabezado ni saltos de línea extra.

###############################################################
# 8. Contar la frecuencia de cada base (A, T, C y G)
###############################################################
base_freq <- table(strsplit(sequence_clean, ""))
# 'strsplit(sequence_clean, "")' separa la secuencia en caracteres individuales.
# 'table()' cuenta cuántas veces aparece cada carácter.

###############################################################
# 9. Mostrar la frecuencia de cada base en la consola
###############################################################
print(base_freq)
# Verás algo como:
#   A   C   G   T 
#  500 400 350 490 
# (los números son solo un ejemplo)

###############################################################
# 10. Graficar la frecuencia de las bases en un barplot
###############################################################
barplot(
  base_freq, 
  main = "Frecuencia de bases en la secuencia", # Título del gráfico
  col = c("red", "blue", "green", "yellow"),    # Colores de las barras
  ylab = "Frecuencia",                          # Etiqueta del eje Y
  names.arg = c("A", "T", "C", "G")             # Etiquetas para cada barra
)

# Al ejecutar este comando, se abrirá una ventana gráfica con el gráfico de barras
# mostrando cuántas veces aparece cada base en la secuencia descargada.


#Actividad en Clase: En equipos quiero que me elijan otra secuenciaa que no sea la 1.
#Cambien los colores del gráfico 3 veces (lee el renglon de abajo), e interpreten el gráfico una vez. 
#Quiero que al gráfico le apliques otras formas de colores que se pueden utilizar en R. Nombres de colores: "red", "blue", "green", "yellow", "tomato", etc.
#POR EJEMPLO USANDO COLORES DE CODIGOS HEX, funciones nativas: rainbow, terrain.colors
#POR EJEMPLO: USANDO PALETAS DE RColorBrewer. 
#Realicen el proceso de transcripción y traducción de su secuencia elegida.
#Que hace el signo de pesos en esta linea: search_results$ids
#Cual es la diferencia entre cat y print y dame un ejemplo. 
#La entrega es en formato Rmarkdown OJO CON FORMATO DE SALIDA EN HTML O PDF. 


