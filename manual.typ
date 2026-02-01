// manual.typ — Documentation and examples for diagramgrid
#import "lib.typ": *

#set document(title: "diagramgrid Manual", author: "diagramgrid")
#set page(margin: 1.5cm)
#set text(size: 10pt)
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  text(size: 18pt, weight: "bold", it)
  v(0.5em)
}
#show heading.where(level: 2): it => {
  v(0.8em)
  text(size: 14pt, weight: "semibold", it)
  v(0.3em)
}

= diagramgrid Manual

A lightweight Typst package for creating clean block diagrams with CSS flexbox-like layouts.

== Example 1: Simple Vertical Layers

The most basic use case — a vertical stack of layers:

#align(center,
  dg-layers(
    dg-rect([Presentation Layer], fill: rgb("#f8f9fa"), width: 200pt),
    dg-rect([Business Logic Layer], fill: rgb("#f8f9fa"), width: 200pt),
    dg-rect([Data Access Layer], fill: rgb("#f8f9fa"), width: 200pt),
    dg-rect([Database], fill: rgb("#f8f9fa"), width: 200pt),
  )
)

```typst
#dg-layers(
  dg-rect([Presentation Layer], fill: rgb("#f8f9fa"), width: 200pt),
  dg-rect([Business Logic Layer], fill: rgb("#f8f9fa"), width: 200pt),
  dg-rect([Data Access Layer], fill: rgb("#f8f9fa"), width: 200pt),
  dg-rect([Database], fill: rgb("#f8f9fa"), width: 200pt),
)
```

== Example 2: Horizontal Components with Circles

Using `dg-flex` for horizontal layout and `dg-circle` for nodes:

#align(center,
  dg-flex(
    direction: "row",
    justify: "center",
    gap: 1.2em,
    dg-circle([A], fill: rgb("#e3f2fd")),
    dg-circle([B], fill: rgb("#e8f5e9")),
    dg-circle([C], fill: rgb("#fff3e0")),
    dg-circle([D], fill: rgb("#fce4ec")),
  )
)

```typst
#dg-flex(
  direction: "row",
  justify: "center",
  gap: 1.2em,
  dg-circle([A], fill: rgb("#e3f2fd")),
  dg-circle([B], fill: rgb("#e8f5e9")),
  dg-circle([C], fill: rgb("#fff3e0")),
  dg-circle([D], fill: rgb("#fce4ec")),
)
```

== Example 3: Nested Layout — Services Inside Layers

Combining `dg-layers` with nested `dg-flex`:

#align(center,
  dg-layers(
    dg-rect([*Client Applications*], fill: rgb("#e2e8f0"), width: 280pt),
    dg-flex(
      direction: "row",
      justify: "center",
      dg-rect([API Gateway], fill: rgb("#dbeafe")),
      dg-rect([Auth Service], fill: rgb("#dcfce7")),
      dg-rect([Cache], fill: rgb("#fef3c7")),
    ),
    dg-flex(
      direction: "row",
      justify: "center",
      dg-rect([User Service], fill: rgb("#e0e7ff")),
      dg-rect([Order Service], fill: rgb("#e0e7ff")),
      dg-rect([Inventory], fill: rgb("#e0e7ff")),
    ),
    dg-rect([*Database Cluster*], fill: rgb("#e2e8f0"), width: 280pt),
  )
)

```typst
#dg-layers(
  dg-rect([*Client Applications*], fill: rgb("#e2e8f0"), width: 280pt),
  dg-flex(
    direction: "row",
    justify: "center",
    dg-rect([API Gateway], fill: rgb("#dbeafe")),
    dg-rect([Auth Service], fill: rgb("#dcfce7")),
    dg-rect([Cache], fill: rgb("#fef3c7")),
  ),
  // ... more layers
)
```

== Example 4: Mixed Shapes

Combining rectangles, circles, and ellipses:

#align(center,
  dg-flex(
    direction: "row",
    justify: "space-around",
    align-items: "center",
    gap: 1em,
    dg-rect([Storage], fill: rgb("#f3e8ff"), width: 80pt),
    dg-circle([Hub], fill: rgb("#fef9c3")),
    dg-ellipse([Processing Unit], fill: rgb("#dbeafe"), width: 100pt),
    dg-rect([Output], fill: rgb("#dcfce7"), width: 80pt),
  )
)

```typst
#dg-flex(
  direction: "row",
  justify: "space-around",
  align-items: "center",
  gap: 1em,
  dg-rect([Storage], fill: rgb("#f3e8ff"), width: 80pt),
  dg-circle([Hub], fill: rgb("#fef9c3")),
  dg-ellipse([Processing Unit], fill: rgb("#dbeafe"), width: 100pt),
  dg-rect([Output], fill: rgb("#dcfce7"), width: 80pt),
)
```

== Example 5: Themed Diagrams

Using the blueprint theme:

#align(center,
  themed-layers(theme-blueprint,
    [Frontend Application],
    [API Layer],
    [Service Mesh],
    [Infrastructure],
  )
)

Using the warm theme:

#align(center,
  themed-layers(theme-warm,
    [User Interface],
    [Business Rules],
    [Data Store],
  )
)

```typst
#themed-layers(theme-blueprint,
  [Frontend Application],
  [API Layer],
  [Service Mesh],
  [Infrastructure],
)

#themed-layers(theme-warm,
  [User Interface],
  [Business Rules],
  [Data Store],
)
```

== Example 6: Full Architecture (4 Levels Deep)

A realistic microservices architecture diagram:

#align(center,
  dg-layers(
    // Level 1: Clients
    dg-flex(
      direction: "row",
      justify: "center",
      dg-rect([Web App], fill: rgb("#dbeafe")),
      dg-rect([Mobile App], fill: rgb("#dbeafe")),
      dg-rect([CLI], fill: rgb("#dbeafe")),
    ),
    // Level 2: Gateway & Bus
    dg-flex(
      direction: "row",
      justify: "center",
      dg-rect(
        dg-layers(
          dg-rect([API Gateway], fill: rgb("#fef3c7")),
          dg-flex(
            dg-rect([Rate Limit], fill: white, inset: 4pt),
            dg-rect([Auth], fill: white, inset: 4pt),
          ),
        ),
        fill: rgb("#fef3c7").lighten(50%),
        inset: 6pt,
      ),
      dg-rect(
        dg-layers(
          dg-rect([Event Bus], fill: rgb("#dcfce7")),
          dg-flex(
            dg-rect([Kafka], fill: white, inset: 4pt),
            dg-rect([Redis], fill: white, inset: 4pt),
          ),
        ),
        fill: rgb("#dcfce7").lighten(50%),
        inset: 6pt,
      ),
    ),
    // Level 3: Microservices
    dg-flex(
      direction: "row",
      justify: "center",
      dg-rect([Users], fill: rgb("#e0e7ff")),
      dg-rect([Orders], fill: rgb("#e0e7ff")),
      dg-rect([Products], fill: rgb("#e0e7ff")),
      dg-rect([Payments], fill: rgb("#e0e7ff")),
    ),
    // Level 4: Data stores
    dg-flex(
      direction: "row",
      justify: "center",
      dg-rect([PostgreSQL], fill: rgb("#f3e8ff")),
      dg-rect([MongoDB], fill: rgb("#f3e8ff")),
    ),
  )
)

== Example 7: Figure with Caption

Using diagramgrid inside a figure:

#figure(
  dg-layers(
    dg-rect([Input Processing], fill: rgb("#d1fae5"), width: 220pt),
    dg-flex(
      direction: "row",
      justify: "center",
      dg-rect([Transform], fill: white),
      dg-rect([Validate], fill: white),
      dg-rect([Enrich], fill: white),
    ),
    dg-rect([Output Generation], fill: rgb("#d1fae5"), width: 220pt),
  ),
  caption: [Data pipeline architecture showing the three-stage processing flow.],
)

```typst
#figure(
  dg-layers(
    dg-rect([Input Processing], fill: rgb("#d1fae5"), width: 220pt),
    dg-flex(
      justify: "center",
      dg-rect([Transform], fill: white),
      dg-rect([Validate], fill: white),
      dg-rect([Enrich], fill: white),
    ),
    dg-rect([Output Generation], fill: rgb("#d1fae5"), width: 220pt),
  ),
  caption: [Data pipeline architecture.],
)
```

== Function Reference

=== Shapes

*`dg-rect(content, ..options)`* — Rectangle block
- `width`, `height`: Dimensions (default: auto)
- `fill`: Background color
- `stroke`: Border (default: `0.8pt + luma(120)`)
- `radius`: Corner radius (default: `5pt`)
- `inset`: Padding (default: `(x: 8pt, y: 6pt)`)
- `content-align`: Content alignment (default: `center + horizon`)

*`dg-circle(content, ..options)`* — Circle block (same options, no radius)

*`dg-ellipse(content, ..options)`* — Ellipse block

=== Layouts

*`dg-flex(direction, justify, align-items, gap, ..children)`*
- `direction`: `"row"` or `"column"` (default: `"row"`)
- `justify`: `"start"`, `"center"`, `"end"`, `"space-between"`, `"space-around"`
- `align-items`: `"stretch"`, `"start"`, `"center"`, `"end"`
- `gap`: Spacing between items (default: `0.8em`)

*`dg-layers(gap, align-items, ..children)`*
- Vertical stack (shorthand for column flex)
- `gap`: Space between items (default: `0.5em`)
- `align-items`: Cross-axis alignment (default: `"center"`)

*`dg-group(width, height, padding, fill, stroke, ..children)`*
- Simple wrapper for grouping and adding space

=== Themes

Built-in themes: `theme-light`, `theme-dark`, `theme-blueprint`, `theme-warm`, `theme-minimal`

```typst
#themed-layers(theme-blueprint, [Layer 1], [Layer 2])
#themed-rect(theme-warm, [Block])
```

= Deep Recursion Example

Here's a multi-level architecture diagram showing nested components:

#align(center,
  dg-layers(
    // Top label
    dg-rect([*Cloud Platform*], fill: rgb("#e2e8f0"), width: 320pt),
    // Middle section with nested boxes
    dg-flex(
      justify: "center",
      // Load Balancer group
      dg-rect(
        dg-layers(
          dg-rect([*Load Balancers*], fill: rgb("#dbeafe")),
          dg-flex(
            dg-rect([LB-1], fill: white, inset: 4pt),
            dg-rect([LB-2], fill: white, inset: 4pt),
          ),
        ),
        fill: rgb("#dbeafe").lighten(60%),
        inset: 6pt,
      ),
      // API Gateway group
      dg-rect(
        dg-layers(
          dg-rect([*API Gateway*], fill: rgb("#dcfce7")),
          dg-flex(
            dg-rect([Auth], fill: white, inset: 4pt),
            dg-rect([Rate], fill: white, inset: 4pt),
          ),
          dg-flex(
            dg-circle([REST], fill: rgb("#fef9c3")),
            dg-circle([gRPC], fill: rgb("#fef9c3")),
          ),
        ),
        fill: rgb("#dcfce7").lighten(60%),
        inset: 6pt,
      ),
    ),
    // Services row
    dg-flex(
      justify: "center",
      dg-rect([Users], fill: rgb("#fef3c7")),
      dg-rect([Orders], fill: rgb("#fef3c7")),
      dg-rect([Products], fill: rgb("#fef3c7")),
    ),
    // Database row
    dg-flex(
      justify: "center",
      dg-rect([PostgreSQL], fill: rgb("#f3e8ff")),
      dg-rect([Redis], fill: rgb("#f3e8ff")),
    ),
    // Bottom label
    dg-rect([*Kubernetes*], fill: rgb("#e2e8f0"), width: 320pt),
  )
)
