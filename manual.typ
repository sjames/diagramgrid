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

= SysML Internal Block Diagram Style

A SysML-style IBD showing internal structure of a Vehicle Control System. This demonstrates the characteristic nested parts with typed instances, stereotypes, and port-like interfaces.

#align(center,
  // System boundary block with stereotype header
  dg-rect(
    dg-layers(
      gap: 0.3em,
      // Stereotype and block name header
      dg-rect(
        [#text(size: 8pt)[«block»] \ #text(weight: "bold")[VehicleControlSystem]],
        fill: rgb("#f1f5f9"),
        width: 380pt,
        stroke: none,
        inset: (x: 8pt, y: 4pt),
      ),
      // Internal parts
      dg-flex(
        justify: "center",
        gap: 1em,
        // Sensor Subsystem part
        dg-rect(
          dg-layers(
            gap: 0.2em,
            dg-rect(
              [#text(size: 7pt)[sensors : SensorSubsystem]],
              fill: rgb("#dbeafe"),
              stroke: none,
              inset: 3pt,
            ),
            dg-flex(
              gap: 0.5em,
              dg-rect([lidar : LiDAR], fill: white, inset: 4pt),
              dg-rect([camera : Camera], fill: white, inset: 4pt),
            ),
            dg-flex(
              gap: 0.5em,
              dg-rect([radar : Radar], fill: white, inset: 4pt),
              dg-rect([imu : IMU], fill: white, inset: 4pt),
            ),
          ),
          fill: rgb("#dbeafe").lighten(60%),
          inset: 6pt,
        ),
        // Processing Unit part
        dg-rect(
          dg-layers(
            gap: 0.2em,
            dg-rect(
              [#text(size: 7pt)[processor : ProcessingUnit]],
              fill: rgb("#dcfce7"),
              stroke: none,
              inset: 3pt,
            ),
            dg-rect([fusion : SensorFusion], fill: white, inset: 4pt),
            dg-rect([planner : PathPlanner], fill: white, inset: 4pt),
            dg-rect([controller : MotionCtrl], fill: white, inset: 4pt),
          ),
          fill: rgb("#dcfce7").lighten(60%),
          inset: 6pt,
        ),
        // Actuator Subsystem part
        dg-rect(
          dg-layers(
            gap: 0.2em,
            dg-rect(
              [#text(size: 7pt)[actuators : ActuatorSubsystem]],
              fill: rgb("#f3e8ff"),
              stroke: none,
              inset: 3pt,
            ),
            dg-rect([steering : SteerCtrl], fill: white, inset: 4pt),
            dg-rect([throttle : ThrottleCtrl], fill: white, inset: 4pt),
            dg-rect([brake : BrakeCtrl], fill: white, inset: 4pt),
          ),
          fill: rgb("#f3e8ff").lighten(60%),
          inset: 6pt,
        ),
      ),
    ),
    fill: rgb("#f8fafc"),
    stroke: 1.2pt + rgb("#334155"),
    inset: 8pt,
  )
)

The diagram uses:
- *Stereotype headers* (`«block»`) identifying the block type
- *Typed parts* (`name : Type` notation) showing instances
- *Nested composition* showing internal structure of subsystems

```typst
dg-rect(
  dg-layers(
    // Stereotype header
    dg-rect([#text(size: 8pt)[«block»] \ #text(weight: "bold")[SystemName]], ...),
    // Internal parts row
    dg-flex(
      // Each part with typed name
      dg-rect(
        dg-layers(
          dg-rect([partName : PartType], ...),
          // Nested components...
        ),
        fill: color.lighten(60%),
      ),
    ),
  ),
  stroke: 1.2pt + rgb("#334155"),  // System boundary
)
```

= AOSP Architecture Diagram

The standard Android Open Source Project architecture stack, showing the layered system design from Linux kernel to applications.

#let aosp-green = rgb("#a4c639")
#let aosp-blue = rgb("#3b82f6")
#let aosp-red = rgb("#ef4444")
#let aosp-yellow = rgb("#fbbf24")
#let aosp-gray = rgb("#6b7280")

#align(center,
  dg-layers(
    gap: 0.4em,
    // System Apps layer
    dg-rect(
      dg-layers(
        gap: 0.2em,
        dg-rect([*System Apps*], fill: aosp-green.lighten(20%), stroke: none, width: 420pt),
        dg-flex(
          justify: "center",
          gap: 0.4em,
          dg-rect([Dialer], fill: aosp-green.lighten(60%), inset: 5pt),
          dg-rect([Email], fill: aosp-green.lighten(60%), inset: 5pt),
          dg-rect([Calendar], fill: aosp-green.lighten(60%), inset: 5pt),
          dg-rect([Camera], fill: aosp-green.lighten(60%), inset: 5pt),
          dg-rect([Browser], fill: aosp-green.lighten(60%), inset: 5pt),
          dg-rect([...], fill: aosp-green.lighten(60%), inset: 5pt),
        ),
      ),
      fill: aosp-green.lighten(80%),
      inset: 6pt,
      width: 440pt,
    ),
    // Java API Framework
    dg-rect(
      dg-layers(
        gap: 0.2em,
        dg-rect([*Java API Framework*], fill: aosp-blue.lighten(20%), stroke: none, width: 420pt),
        dg-flex(
          justify: "center",
          gap: 0.4em,
          dg-rect([Content Providers], fill: aosp-blue.lighten(70%), inset: 5pt),
          dg-rect([View System], fill: aosp-blue.lighten(70%), inset: 5pt),
          dg-rect([Managers], fill: aosp-blue.lighten(70%), inset: 5pt),
        ),
        dg-flex(
          justify: "center",
          gap: 0.4em,
          dg-rect([Activity], fill: aosp-blue.lighten(80%), inset: 4pt),
          dg-rect([Window], fill: aosp-blue.lighten(80%), inset: 4pt),
          dg-rect([Package], fill: aosp-blue.lighten(80%), inset: 4pt),
          dg-rect([Telephony], fill: aosp-blue.lighten(80%), inset: 4pt),
          dg-rect([Resource], fill: aosp-blue.lighten(80%), inset: 4pt),
          dg-rect([Location], fill: aosp-blue.lighten(80%), inset: 4pt),
          dg-rect([Notification], fill: aosp-blue.lighten(80%), inset: 4pt),
        ),
      ),
      fill: aosp-blue.lighten(85%),
      inset: 6pt,
      width: 440pt,
    ),
    // Native Libraries + Android Runtime (side by side)
    dg-flex(
      justify: "center",
      gap: 0.4em,
      // Native C/C++ Libraries
      dg-rect(
        dg-layers(
          gap: 0.2em,
          dg-rect([*Native C/C++ Libraries*], fill: aosp-blue.lighten(30%), stroke: none),
          dg-flex(
            gap: 0.3em,
            dg-rect([Webkit], fill: aosp-blue.lighten(75%), inset: 4pt),
            dg-rect([Libc], fill: aosp-blue.lighten(75%), inset: 4pt),
          ),
          dg-flex(
            gap: 0.3em,
            dg-rect([Media], fill: aosp-blue.lighten(75%), inset: 4pt),
            dg-rect([OpenGL ES], fill: aosp-blue.lighten(75%), inset: 4pt),
          ),
          dg-flex(
            gap: 0.3em,
            dg-rect([SQLite], fill: aosp-blue.lighten(75%), inset: 4pt),
            dg-rect([SSL], fill: aosp-blue.lighten(75%), inset: 4pt),
          ),
        ),
        fill: aosp-blue.lighten(88%),
        inset: 6pt,
      ),
      // Android Runtime
      dg-rect(
        dg-layers(
          gap: 0.2em,
          dg-rect([*Android Runtime*], fill: aosp-yellow.lighten(20%), stroke: none),
          dg-rect([Android Runtime (ART)], fill: aosp-yellow.lighten(60%), inset: 5pt),
          dg-rect([Core Libraries], fill: aosp-yellow.lighten(60%), inset: 5pt),
        ),
        fill: aosp-yellow.lighten(80%),
        inset: 6pt,
      ),
    ),
    // Hardware Abstraction Layer
    dg-rect(
      dg-layers(
        gap: 0.2em,
        dg-rect([*Hardware Abstraction Layer (HAL)*], fill: aosp-green.lighten(30%), stroke: none, width: 420pt),
        dg-flex(
          justify: "center",
          gap: 0.4em,
          dg-rect([Audio], fill: aosp-green.lighten(70%), inset: 4pt),
          dg-rect([Bluetooth], fill: aosp-green.lighten(70%), inset: 4pt),
          dg-rect([Camera], fill: aosp-green.lighten(70%), inset: 4pt),
          dg-rect([Sensors], fill: aosp-green.lighten(70%), inset: 4pt),
          dg-rect([Graphics], fill: aosp-green.lighten(70%), inset: 4pt),
          dg-rect([...], fill: aosp-green.lighten(70%), inset: 4pt),
        ),
      ),
      fill: aosp-green.lighten(85%),
      inset: 6pt,
      width: 440pt,
    ),
    // Linux Kernel
    dg-rect(
      dg-layers(
        gap: 0.2em,
        dg-rect([*Linux Kernel*], fill: aosp-red.lighten(20%), stroke: none, width: 420pt),
        dg-flex(
          justify: "center",
          gap: 0.3em,
          dg-rect([Audio], fill: aosp-red.lighten(70%), inset: 4pt),
          dg-rect([Binder], fill: aosp-red.lighten(70%), inset: 4pt),
          dg-rect([Display], fill: aosp-red.lighten(70%), inset: 4pt),
          dg-rect([Camera], fill: aosp-red.lighten(70%), inset: 4pt),
          dg-rect([USB], fill: aosp-red.lighten(70%), inset: 4pt),
          dg-rect([WiFi], fill: aosp-red.lighten(70%), inset: 4pt),
          dg-rect([Power], fill: aosp-red.lighten(70%), inset: 4pt),
        ),
      ),
      fill: aosp-red.lighten(85%),
      inset: 6pt,
      width: 440pt,
    ),
  )
)

The classic 5-layer Android stack:
- *System Apps* — Pre-installed applications (green)
- *Java API Framework* — Android SDK APIs and managers (blue)
- *Native Libraries + Runtime* — C/C++ libs and ART side-by-side (blue/yellow)
- *HAL* — Hardware abstraction interfaces (green)
- *Linux Kernel* — Drivers and core OS (red)

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
