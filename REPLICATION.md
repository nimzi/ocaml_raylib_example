# Replicating the Build Environment

This document describes how to replicate the exact build environment for this project.

## Prerequisites

- opam (OCaml package manager)
- A local static build of raylib in the `static_raylib/` directory (containing `libraylib.a` and `libglfw3.a`)

## Setup Steps

### 1. Create a new opam switch with the exact OCaml version

```bash
opam switch create . ocaml-base-compiler.5.4.0
```

Or if you want to use an existing switch, ensure it has OCaml 5.4.0:

```bash
opam switch set <switch-name>  # if needed
opam install ocaml-base-compiler.5.4.0
```

### 2. Install dependencies

Install all dependencies with exact versions:

```bash
opam install . --deps-only
```

This will install:
- ocaml = 5.4.0
- dune = 3.20.2
- dune-configurator = 3.20.2
- raylib = 1.5.1
- ctypes = 0.24.0
- integers = 0.7.0

### 3. Build the project

```bash
dune build
```

### 4. Run the program

```bash
dune exec ./main.exe
```

## Alternative: Using opam lock (if available)

For even more precise replication, you can create a lock file:

```bash
opam lock .
```

This creates `ocaml_raylib_example.opam.locked` with all transitive dependencies pinned.

Then install from the lock file:

```bash
opam install . --locked
```

## Notes

- The project requires a local static build of raylib in the `static_raylib/` directory
- The dune-configurator script automatically detects the library paths
- All dependency versions are pinned in `ocaml_raylib_example.opam`

