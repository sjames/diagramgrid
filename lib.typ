// lib.typ — Main entry point for diagramgrid package
// Re-exports all public functions

#import "shapes.typ": dg-block, dg-rect, dg-circle, dg-ellipse
#import "layouts.typ": dg-flex, dg-layers, dg-group, dg-row, dg-col
#import "themes.typ": (
  dg-theme,
  theme-light,
  theme-dark,
  theme-blueprint,
  theme-warm,
  theme-minimal,
  themed-rect,
  themed-layers,
  palette-pastel,
  palette-vibrant,
  palette-color,
)
