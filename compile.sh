#!/bin/bash

mkdir -p PDF

for dir in Notas/materias/*/; do
    if [ -f "${dir}main.typ" ]; then
        materia=$(basename "$dir" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
        echo "Compilando $materia..."
        typst compile --root . "${dir}main.typ" "PDF/Apuntes - $materia.pdf"
    fi
done

echo "Todos los apuntes compilados."

