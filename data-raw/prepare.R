library(readxl)
library(devtools)


# Unmitigated
test_unmitigated <- readxl::read_xlsx("data-raw/Benchmarks/VensimData.xlsx",sheet = 1)

# Mitigated
test_mitigated  <- readxl::read_xlsx("data-raw/Benchmarks/VensimData.xlsx",sheet = 2)

use_data(test_unmitigated,overwrite = T)
use_data(test_mitigated,overwrite = T)
