# Beta Multiplier h = 1
# Proportion Asymptomatic f = 0.382801
# Symptomatic Testing Fraction = 1
# Reporting Delay = 1.02499
# Incubation Period C = 6.4
# Latent Period L = 3.4
# Total Infectious Period D = 6
# Beta Calibrated = 0.803863

L <- 3.4
C <- 6.4
D <- 5.85034
f <- 0.382801
h <- 1
Beta <- 0.736697


J <- matrix(NA,4,4)
J[1,1] <- -1/L;  J[1,2] <- Beta;         J[1,3] <- Beta*h;       J[1,4] <- Beta;
J[2,1] <-  1/L;  J[2,2] <- -1/(C-L);     J[2,3] <- 0;            J[2,4] <- 0;
J[3,1] <-    0;  J[3,2] <- f/(C-L);      J[3,3] <- -1/(D-C+L);   J[3,4] <- 0;
J[4,1] <-    0;  J[4,2] <- (1-f)/(C-L);  J[4,3] <- 0;            J[4,4] <- -1/(D-C+L);

lambda <- max(Re(eigen(J)$values))
cat("Initial exponiential growth rate = ",lambda,"\n")

F <- matrix(NA,4,4)
F[1,1] <- 0;  F[1,2] <- Beta;         F[1,3] <- Beta*h;       F[1,4] <- Beta;
F[2,] <- 0
F[3,] <- 0
F[4,] <- 0

V <- F - J

FV_1 <- F%*%solve(V)

R0 <- max(Re(eigen(FV_1)$values))
cat("R0 Estimated Value = ",R0,"\n")


