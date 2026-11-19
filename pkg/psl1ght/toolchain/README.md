# PSL1GHT toolchain patches

This unofficial `ps3/v2026` fork needs two fixes to the ps3dev PSL1GHT SDK.
Upstream PSL1GHT does not have them. Apply them to a PSL1GHT checkout, then
rebuild and install PSL1GHT before you build RetroArch:

```sh
cd /path/to/PSL1GHT
git apply /path/to/RetroArch/pkg/psl1ght/toolchain/*.patch
make install-ctrl && make && make install
```

| Patch | What it fixes | Needed for |
|---|---|---|
| `librsx-context-callback-noipa.patch` | With GCC 11 or later (ps3dev ships 13.2), the callers of `rsxContextCallback()` keep a stale `context->current` when the RSX command buffer moves on to its next segment. They overwrite the jump that the callback has just written, and the RSX stops a few seconds after start ("Dead FIFO" in RPCS3): the picture freezes and the pad seems dead. The PSL1GHT `rsxtest` sample freezes the same way. | Every build. `Makefile.psl1ght` stops with an error when the installed header lacks it. |
| `pkg-remove-1024-entry-limit.patch` | The `pkg` tool silently dropped every entry past the 1024th one. The RetroArch PKG holds about 2,400. | Building the PKG. |
