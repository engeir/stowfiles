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
  s({ trig = ".fr" }, {
    t("\\frac{"),
    i(1),
    t("}{"),
    i(2),
    t("}"),
  }),
  s({ trig = ".sq" }, { t("\\sqrt{"), i(1), t("}") }),
  s({ trig = "mk" }, { t("\\("), i(1), t("\\)") }),
  s({ trig = ".eq" }, { t("\\[ "), i(1), t(" \\]") }),
  s(
    { trig = ".sub", wordTrig = false, name = "auto subscript" },
    { t("_{"), i(1), t("}"), i(0) }
  ),
  s(
    { trig = ".sup", wordTrig = false, name = "auto superscript" },
    { t("^{"), i(1), t("}"), i(0) }
  ),
  s({ trig = ".SI" }, { i(1), t("\\,\\mathrm{"), i(2), t("}") }),
}
