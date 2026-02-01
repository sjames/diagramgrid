// shapes.typ — Shape primitives for diagramgrid
// Provides dg-block (base), dg-rect, dg-circle, dg-ellipse

/// Base block shape that all shape aliases use.
/// - kind: "rect", "circle", or "ellipse"
/// - content: The content to display inside the shape
/// - width, height: Dimensions (auto = fit content)
/// - fill: Background color
/// - stroke: Border stroke
/// - radius: Corner radius (rect only)
/// - inset: Inner padding
/// - align: Content alignment within shape
#let dg-block(
  content,
  kind: "rect",
  width: auto,
  height: auto,
  fill: none,
  stroke: 0.8pt + luma(120),
  radius: 5pt,
  inset: (x: 8pt, y: 6pt),
  content-align: center + horizon,
  ..rest,
) = {
  // Validate kind
  assert(
    kind in ("rect", "circle", "ellipse"),
    message: "dg-block: kind must be 'rect', 'circle', or 'ellipse', got '" + kind + "'",
  )

  // Normalize inset to dictionary form
  let padding = if type(inset) == dictionary {
    (
      left: inset.at("left", default: inset.at("x", default: 0pt)),
      right: inset.at("right", default: inset.at("x", default: 0pt)),
      top: inset.at("top", default: inset.at("y", default: 0pt)),
      bottom: inset.at("bottom", default: inset.at("y", default: 0pt)),
    )
  } else {
    (left: inset, right: inset, top: inset, bottom: inset)
  }

  // Inner content with alignment
  let inner = box(
    inset: padding,
    {
      set align(content-align)
      content
    },
  )

  // Build the shape
  if kind == "rect" {
    rect(
      width: width,
      height: height,
      fill: fill,
      stroke: stroke,
      radius: radius,
      ..rest,
      inner,
    )
  } else if kind == "circle" {
    // For circle: wrap content in padded box, then place in circle
    let padded-content = box(inset: padding)[
      #set align(center + horizon)
      #content
    ]
    if width != auto {
      circle(
        width: width,
        fill: fill,
        stroke: stroke,
        ..rest,
        align(center + horizon, padded-content),
      )
    } else {
      // Auto-size: measure content and create appropriately sized circle
      context {
        let size = measure(padded-content)
        let diameter = calc.max(size.width, size.height)
        circle(
          width: diameter,
          fill: fill,
          stroke: stroke,
          ..rest,
          align(center + horizon, padded-content),
        )
      }
    }
  } else {
    // ellipse: wrap content in padded box
    let padded-content = box(inset: padding)[
      #set align(center + horizon)
      #content
    ]
    if width != auto or height != auto {
      ellipse(
        width: if width == auto { auto } else { width },
        height: if height == auto { auto } else { height },
        fill: fill,
        stroke: stroke,
        ..rest,
        align(center + horizon, padded-content),
      )
    } else {
      // Auto-size
      context {
        let size = measure(padded-content)
        ellipse(
          width: size.width,
          height: size.height,
          fill: fill,
          stroke: stroke,
          ..rest,
          align(center + horizon, padded-content),
        )
      }
    }
  }
}

/// Rectangle shape — most common for architecture blocks
#let dg-rect(content, ..args) = dg-block(content, kind: "rect", ..args)

/// Circle shape — good for nodes, icons, endpoints
#let dg-circle(content, ..args) = dg-block(content, kind: "circle", ..args)

/// Ellipse shape — for wider/taller circular elements
#let dg-ellipse(content, ..args) = dg-block(content, kind: "ellipse", ..args)
