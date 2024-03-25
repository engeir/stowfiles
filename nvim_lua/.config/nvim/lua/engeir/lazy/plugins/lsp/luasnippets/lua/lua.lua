return {
  s(
    "re",
    fmt(
      'local {}, {} = pcall(require, "{}")\nif not {} then\n  return\nend',
      { i(1, "default"), i(2), rep(2), rep(1) }
    )
  ),
}, {}
