# OCaml Raylib Example

A simple OCaml application demonstrating integration with the [raylib](https://www.raylib.com/) graphics library. This project showcases how to statically link an externally built raylib library into an OCaml application.

## Overview

This project creates a windowed application that displays a greeting message using raylib's graphics capabilities. The window is automatically sized to half the monitor's dimensions, and the text is centered both horizontally and vertically.

## Static Linking

This project **statically links** to **raylib 5.0**, which was built externally using a **C++ compiler**. The static library files are located in the `static_raylib/` directory:

- `libraylib.a` - The main raylib static library
- `libglfw3.a` - GLFW static library (raylib dependency)

The build system uses `dune-configurator` to automatically detect and link these static libraries during compilation.

## Features

- Window management with automatic sizing based on monitor dimensions
- Text rendering with custom fonts and colors
- Event handling (window close detection)
- 60 FPS target frame rate

## Prerequisites

- **opam** (OCaml package manager) - version 2.0 or later
- **OCaml** 5.4.0
- **dune** 3.20.2
- **dune-configurator** 3.20.2
- Static raylib libraries in `static_raylib/` directory

## Quick Start

### 1. Set up the OCaml environment

Create a new opam switch with OCaml 5.4.0:

```bash
opam switch create . ocaml-base-compiler.5.4.0
```

### 2. Install dependencies

```bash
opam install . --deps-only
```

This installs:
- ocaml = 5.4.0
- dune = 3.20.2
- dune-configurator = 3.20.2
- raylib = 1.5.1 (OCaml bindings)
- ctypes = 0.24.0
- integers = 0.7.0

### 3. Ensure static libraries are present

Make sure the `static_raylib/` directory contains:
- `libraylib.a`
- `libglfw3.a`

These should be built from raylib 5.0 source code using a C++ compiler.

### 4. Build the project

```bash
dune build
```

### 5. Run the application

```bash
dune exec ./main.exe
```

The application will open a window displaying "Hello from OCaml and Raylib!" with instructions to press ESC to close.

## Project Structure

```
.
├── main.ml                 # Main application code
├── dune                   # Dune build configuration
├── dune-project           # Dune project metadata
├── config/
│   ├── discover.ml        # Library path detection script
│   └── dune               # Configurator build file
├── static_raylib/        # Static library files
│   ├── libraylib.a       # Raylib static library (raylib 5.0)
│   └── libglfw3.a        # GLFW static library
├── ocaml_raylib_example.opam  # OPAM package definition
└── README.md             # This file
```

## How It Works

1. **Library Detection**: The `config/discover.ml` script uses `dune-configurator` to locate the static libraries in `static_raylib/` and generates linker flags.

2. **Static Linking**: During compilation, the OCaml compiler links against:
   - `libraylib.a` (raylib 5.0, built with C++ compiler)
   - `libglfw3.a` (GLFW dependency)
   - System libraries (X11, OpenGL, etc.)

3. **Runtime**: The application uses the OCaml raylib bindings to interact with the statically linked raylib library.

## Building Raylib 5.0

To build raylib 5.0 as a static library for this project:

1. Clone the raylib repository:
   ```bash
   git clone https://github.com/raysan5/raylib.git
   cd raylib
   ```

2. Checkout the `5.0` branch:
   ```bash
   git checkout 5.0
   ```

3. Build raylib as a static library using CMake:
   ```bash
   mkdir build
   cd build
   cmake .. -DBUILD_SHARED_LIBS=OFF
   make
   ```

4. Copy the resulting static libraries to `static_raylib/`:
   ```bash
   cp libraylib.a /path/to/ocaml_raylib_example/static_raylib/
   cp external/glfw/src/libglfw3.a /path/to/ocaml_raylib_example/static_raylib/
   ```

## Dependencies

- **raylib** (OCaml bindings) - Provides OCaml interface to raylib
- **ctypes** - Foreign function interface for OCaml
- **integers** - Integer types for C interop
- **dune** - Build system
- **dune-configurator** - Build-time configuration

## License

MIT

## See Also

- [REPLICATION.md](REPLICATION.md) - Detailed instructions for replicating the build environment
- [raylib documentation](https://www.raylib.com/cheatsheet/cheatsheet.html)
- [OCaml raylib bindings](https://github.com/tjammer/ocaml-raylib)

