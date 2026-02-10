#import "@preview/colorful-boxes:1.4.3": *

#let codigo(
  clave: [],
  nombre: [],
  codigo: [],
) = {
  slanted-colorbox(
    title: nombre,
    color: "blue",
    radius: 2pt,
    width: auto,
  )[
    #codigo
  ]
}

