return {
  settings = {
    evenBetterToml = {
      schema = {
        associations = {
          -- The old Mise schema has moved, and resolves to a broken link in the SchemaStore
          ["(^|/)\\.?mise(\\.[\\w-]+)?(\\.local)?\\.toml$"] = "https://mise.jdx.dev/schema/mise.json",
          ["(^|/)\\.?mise/config(\\.[\\w-]+)?(\\.local)?\\.toml$"] = "https://mise.jdx.dev/schema/mise.json",
          ["(^|/)\\.config/mise(\\.[\\w-]+)?(\\.local)?\\.toml$"] = "https://mise.jdx.dev/schema/mise.json",
          ["(^|/)\\.config/mise/config(\\.[\\w-]+)?(\\.local)?\\.toml$"] = "https://mise.jdx.dev/schema/mise.json",
        },
      },
    },
  },
}
