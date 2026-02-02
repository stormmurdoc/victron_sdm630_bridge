# AGENTS.md
# Repository guide for agentic coding assistants.
# Keep this file in sync with repo conventions.

## Purpose
- This project is a small Go service that bridges MQTT data into Victron dbus.
- Primary entrypoint: `main.go`.
- Binaries are written to `bin/` and `bin/arm/bridge/`.

## Commands (build, run, lint, test)
### Build
- Local build: `make build`
- Cross-compile for Venus OS (ARMv7): `make compile`
- Direct Go build: `go build -o bin/sdm630-bridge main.go`
- Cross-compile via Go: `GOOS=linux GOARCH=arm GOARM=7 go build -o bin/arm/bridge/sdm630-bridge main.go`

### Run
- Local run: `make run`
- Direct run: `go run main.go`

### Lint / Static analysis
- No lint tool is configured in this repo.
- Optional baseline check: `go vet ./...`
- If you add a linter, document it here and in the README.

### Tests
- There are no test files currently.
- Default test command: `go test ./...`
- Single test by name: `go test ./... -run TestName`
- Single test in one package: `go test ./path/to/pkg -run TestName`
- Re-run without cache: `go test ./... -run TestName -count=1`

## Code style guidelines
### General Go style
- Follow standard Go conventions and run `gofmt` on all `.go` files.
- Prefer clarity over cleverness; short, descriptive names are best.
- Use camelCase for locals, PascalCase for exported identifiers.
- Keep initialisms consistent (e.g., `ID`, `MQTT`, `DBus`).
- Keep line length reasonable; rely on gofmt for wrapping.

### Imports
- Use gofmt to order imports into standard groups.
- Avoid unused imports; keep import lists minimal.
- Prefer explicit package aliases only when needed (e.g., `mqtt` in `main.go`).

### Formatting
- Always run `gofmt` after edits.
- Align with existing file formatting and spacing.
- Avoid non-ASCII characters unless the file already uses them.

### Types
- Prefer Go built-in types (`int`, `float64`, `string`) unless domain requires otherwise.
- Use `float64` for numeric dbus payloads; match existing usage.
- Keep struct fields and variable types consistent with message payloads.

### Naming conventions
- Keep exported names meaningful and minimal; unexported helpers should be lowercase.
- Functions should be verbs or verb phrases (e.g., `updateVariant`).
- Avoid abbreviations unless they are standard in domain context (MQTT, DBus).

### Error handling
- Handle errors explicitly; do not ignore returned `error` values.
- Prefer `fmt.Errorf("context: %w", err)` for wrapping.
- This codebase uses `logrus`; use it for structured logging.
- Avoid panics unless initialization failures are unrecoverable.

### Logging
- Use `logrus` (`log` alias) as already imported in `main.go`.
- Respect `LOG_LEVEL` env var initialization in `init()`.
- Use `Info` for lifecycle events, `Debug` for per-message detail.

### MQTT and DBus specifics
- MQTT client options are configured in `main.go`; preserve existing setup.
- Subscription handlers update dbus values via `updateVariant`.
- Use dbus `Variant` values with correct types; string variants are used for human-readable text.

### File structure
- Primary code file is `main.go`; changes should stay in this file unless refactoring.
- Keep build artifacts in `bin/` and avoid committing large binaries.

## Repository-specific notes
- `make build` and `make compile` are canonical build commands.
- `go.mod` specifies Go 1.16; do not assume newer language features.
- `sdm630-bridge.go` appears to be a binary artifact; do not edit it.

## Cursor/Copilot rules
- No Cursor rules found in `.cursor/rules/` or `.cursorrules`.
- No Copilot instructions found in `.github/copilot-instructions.md`.

## When updating this file
- Keep it close to ~150 lines.
- Prefer concrete, repo-backed commands over generic suggestions.
- Update sections when new tools or workflows are added.
