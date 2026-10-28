# know_map

**One capability bit from GBT V8, packaged standalone.** No. 196 of 341,
`recon` domain (Recon).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **理解任何事**（主人令 2026-10-15 蒸馏自 GitHub Trending #1 「Understand Anything」）：把任何仓/库/文档变成一张**可点、可搜、可问的分层知识图**。三步：scan（走盘+找入口）→ build（三层建图，**每条边带 evidence = path:line**）→ 四功能 tour（引导导览）·ask（词面检索，不冒充语义）·impact（变更影响）·layers（分层视图）。op=status/layers/tour/ask/impact（只读）· scan/build（build 写 state/know_map）。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-know-map.git
cd gbt-know-map
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_know_map info                  # capability card
python -m gbt_know_map spec --json           # machine-readable contract
python -m gbt_know_map check --payload '{}'
python -m gbt_know_map run   --payload '{}'
```

Real `info` output from this machine:

```text
know_map  (recon)  v1.0.0
----------------------------------------
**理解任何事**（主人令 2026-10-15 蒸馏自 GitHub Trending #1 「Understand Anything」）：把任何仓/库/文档变成一张**可点、可搜、可问的分层知识图**。三步：scan（走盘+找入口）→ build（三层建图，**每条边带 evidence = path:line**）→ 四功能 tour（引导导览）·ask（词面检索，不冒充语义）·impact（变更影响）·layers（分层视图）。op=status/layers/tour/ask/impact（只读）· scan/build（build 写 state/know_map）。

gated      : True   <- needs explicit consent
external   : False
multi-op   : True
params     : (none)
values     : status, layers, tour, ask, impact
```

Wire a real implementation:

```python
from gbt_know_map import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（5 个）**：`status`、`layers`、`tour`、`ask`、`impact`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Gated: this bit is marked `safe: false` in the registry — it can change state that no inverse action restores.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.11s
```

## Provenance

| field | value |
|---|---|
| capability | `know_map` |
| domain | `recon` |
| handler | `know_map` |
| safe | `False` (gated = `True`) |
| external | `False` |
| atlas page | [recon/know_map](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/recon/know_map.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
