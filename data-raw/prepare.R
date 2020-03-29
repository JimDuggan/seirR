library(readxl)
library(devtools)


# Unmitigated
vensim_test_unmitigated <- readxl::read_xlsx("data-raw/Benchmarks/VensimData.xlsx",sheet = 1)

# Mitigated
vensim_test_mitigated  <- readxl::read_xlsx("data-raw/Benchmarks/VensimData.xlsx",sheet = 2)

use_data(vensim_test_unmitigated,overwrite = T)
use_data(vensim_test_mitigated,overwrite = T)
