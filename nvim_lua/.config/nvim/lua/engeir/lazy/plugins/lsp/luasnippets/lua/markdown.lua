return {
  -- Normal
  s({ trig = "phi-raw" }, { t("𝜙") }),
  s({ trig = "Phi-raw" }, { t("𝛷") }),
  s({ trig = "theta-raw" }, { t("𝜃") }),
  s({ trig = "Theta-raw" }, { t("𝛩") }),
  s({ trig = "alpha-raw" }, { t("𝛼") }),
  s({ trig = "Alpha-raw" }, { t("𝛢") }),
  s({ trig = "dpis" }, { t("<!-- dprint-ignore-start -->") }),
  s({ trig = "dpie" }, { t("<!-- dprint-ignore-end -->") }),
}, {
  -- Auto
  s({ trig = "!frac" }, {
    t("\\frac{"),
    i(1),
    t("}{"),
    i(2),
    t("}"),
  }),
}
