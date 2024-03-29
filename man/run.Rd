% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api_seirR.R
\name{run}
\alias{run}
\title{Runs a model}
\usage{
run(o, DT = 0.125, return_all = F)
}
\arguments{
\item{o}{is the seir S3 object}

\item{DT}{is the simulation time step (Euler)}

\item{return_all}{a flag used to decide how many observations to return}
}
\value{
A tibble of simulation results
}
\description{
\code{run()} runs the simulation, based on the parameter set
}
\details{
As it's a generic function, this call is dispatched to run.seir
}
\examples{
\dontrun{
m <- create_seir()
o <- run(m)
}
}
