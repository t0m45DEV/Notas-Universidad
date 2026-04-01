#import "@preview/colorful-boxes:1.4.3": *

#let pdot() = {$dot.op$}

#let codigo(
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

#let definicion(
  nombre: [],
  expresion: [],
) = {
  slanted-colorbox(
    title: nombre,
    color: "green",
    radius: 2pt,
    width: auto,
  )[
    #block(width: 100%)[#align(center)[#expresion]]
  ]
}

#let ejemplo(
  nombre: [],
  texto: [],
) = {
  slanted-colorbox(
    title: nombre,
    color: "gold",
    radius: 2pt,
    width: auto,
  )[
    #block(width: 100%)[#align(center)[#texto]]
  ]
}

