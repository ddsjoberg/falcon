% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fda-table_05.R
\name{make_table_05}
\alias{make_table_05}
\title{FDA Table 5: Duration of Treatment Exposure, Safety Population, Pooled Analyses}
\usage{
make_table_05(
  df,
  alt_counts_df = NULL,
  show_colcounts = TRUE,
  arm_var = "ARM",
  saffl_var = "SAFFL",
  id_var = "USUBJID",
  trtsdtm_var = "TRTSDTM",
  trtedtm_var = "TRTEDTM",
  u_trtdur = "days",
  lbl_trtdur = paste("Duration of Treatment,", u_trtdur),
  lbl_overall = NULL,
  risk_diff = NULL,
  prune_0 = FALSE,
  annotations = NULL
)
}
\arguments{
\item{df}{(\code{data.frame})\cr dataset required to build table.}

\item{alt_counts_df}{(\code{character})\cr alternative dataset (typically ADSL) used only to calculate column counts.}

\item{show_colcounts}{(\code{flag})\cr whether column counts should be printed.}

\item{arm_var}{(\code{character})\cr arm variable used to split table into columns.}

\item{saffl_var}{(\code{character})\cr flag variable used to indicate inclusion in safety population.}

\item{id_var}{(\code{character})\cr variable used as unique subject identifier.}

\item{trtsdtm_var}{(\code{character})\cr treatment start datetime variable in \code{df}.}

\item{trtedtm_var}{(\code{character})\cr treatment end datetime variable in \code{df}.}

\item{u_trtdur}{(\code{character})\cr unit for duration of treatment. Options are \code{"days"}, \code{"weeks"}, \code{"months"},
and \code{"years"}.}

\item{lbl_trtdur}{(\code{character})\cr label for treatment duration variable.}

\item{lbl_overall}{(\code{character})\cr if specified, an overall column will be added to the table with
the given value as the column label.}

\item{risk_diff}{(named \code{list})\cr list of settings to apply to add a risk difference column to the table.
Defaults to \code{NULL} (no risk difference column added). See \code{\link[tern:add_riskdiff]{tern::add_riskdiff()}} for more details. List should
contain the following elements:
\itemize{
\item \code{arm_x}: (required) the name of reference arm.
\item \code{arm_y}: (required) the name of the arm to compare to the reference arm.
\item \code{col_label}: (optional) label to use for the risk difference column. Defaults to
\code{"Risk Difference (\%) (95\% CI)"}.
\item \code{pct}: (optional) whether the output should be returned as percentages. Defaults to \code{TRUE}.
}}

\item{prune_0}{(\code{flag})\cr whether all-zero rows should be removed from the table.}

\item{annotations}{(named \code{list} of \code{character})\cr list of annotations to add to the table. Valid
annotation types are \code{title}, \code{subtitles}, \code{main_footer}, and \code{prov_footer}. Each name-value pair should
use the annotation type as name and the desired string as value.}
}
\value{
An \code{rtable} object.
}
\description{
FDA Table 5: Duration of Treatment Exposure, Safety Population, Pooled Analyses
}
\details{
\itemize{
\item \code{df} must contain \code{USUBJID} and the variables specified by \code{arm_var}, \code{saffl_var}, \code{id_var}, \code{trtsdtm_var},
and \code{trtedtm_var}.
\item If specified, \code{alt_counts_df} must contain \code{USUBJID} and the variables specified by \code{arm_var} and \code{saffl_var}.
\item Flag variables (i.e. \code{XXXFL}) are expected to have two levels: \code{"Y"} (true) and \code{"N"} (false). Missing values in
flag variables are treated as \code{"N"}.
\item Columns are split by arm. Overall population column is excluded by default (see \code{lbl_overall} argument).
\item Numbers in table "Patients Treated" section are the absolute numbers of patients and fraction of \code{N}.
\item All-zero rows are not removed by default (see \code{prune_0} argument).
\item Records with missing treatment start and/or end datetime are excluded from all calculations.
}
}
\examples{
adsl <- scda::synthetic_cdisc_dataset("rcd_2022_10_13", "adsl")

tbl <- make_table_05(df = adsl)
tbl

}
