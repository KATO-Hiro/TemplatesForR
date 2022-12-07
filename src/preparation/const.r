source("./src/lib/const.r")
source("./src/lib/operator.r")

HOGE <- join_strings(
  INPUT_DIR,
  SLASH,
  "foo.csv"
)

FUGA <- join_strings(
  OUTPUT_DIR,
  SLASH,
  "bar.csv"
)
