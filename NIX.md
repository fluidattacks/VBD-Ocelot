# Local setup with Nix

Reproducible toolchain to build, test and run Ocelot from source. Provides the
.NET 8/9/10 SDKs pinned via `flake.lock`, so no system-wide .NET install is
needed.

## Requirements

- Nix with flakes enabled.

## Enter the dev shell

```bash
nix develop
```

This drops you into a shell with `dotnet` (SDKs 8.0, 9.0, 10.0) and `curl` on
`PATH`.

## Build

```bash
# whole solution
dotnet build Ocelot.slnx -c Debug

# just the library
dotnet build src/Ocelot.csproj -c Debug -f net9.0
```

## Run a sample gateway

```bash
dotnet run --project samples/Basic -f net9.0
# gateway listens on http://localhost:5555 (see samples/Basic/ocelot.json)
```

## Tests

```bash
dotnet test unit/Ocelot.UnitTests.csproj -f net9.0
dotnet test acceptance/Ocelot.Acceptance.csproj -f net9.0
```

## One-off commands without entering the shell

```bash
nix develop --command dotnet build src/Ocelot.csproj -c Debug -f net9.0
```
