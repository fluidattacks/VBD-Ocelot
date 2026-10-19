# VBD-Ocelot: synthetic vulnerability benchmark

This fork is a **synthetic, openly labelled benchmark**. It is not the upstream project
and must not be used as one. Each sample is an isolated pair of branches off `baseline`:

- `baseline`: the pinned upstream commit plus any hardening; the common ancestor.
- `smpl/<NNN>/safe`: the genuine negative (validated control) of sample `NNN`.
- `smpl/<NNN>/vuln`: `safe` plus exactly one commit that weakens the control.

The class and the coordinates of every sample live only in `GROUND_TRUTH.csv` on this
orphan branch, never in the analysed branches.

| sample | file | class |
|---|---|---|
| 001 | `src/Authentication/AuthenticationMiddleware.cs` | F115 Security controls bypass or absence (trusted-forwarded-identity) |
| 002 | `src/Authorization/AuthorizationMiddleware.cs` | F115 Security controls bypass or absence (authz-gated-on-client-header) |
| 003 | `src/Security/SecurityMiddleware.cs` | F115 Security controls bypass or absence (client-controlled security policy) |
| 004 | `src/RateLimiting/RateLimitingMiddleware.cs` | F115 Security controls bypass or absence (rate-limit key from spoofable header) |
| 005 | `src/Security/IPSecurityPolicy.cs` | F115 Security controls bypass or absence (ip policy on forwarded address) |
