#' FDA Table 13: Patients With Common Adverse Events Occurring at >=XX% Frequency, Safety Population, Pooled Analyses
#'
#' @details
#' * `adae` must contain `USUBJID` and the variables specified by `arm_var`, `saffl_var`, and `pref_var`.
#' * If specified, `alt_counts_df` must contain `USUBJID` and the variables specified by `arm_var` and `saffl_var`.
#' * Flag variables (i.e. `XXXFL`) are expected to have two levels: `"Y"` (true) and `"N"` (false). Missing values in
#'   flag variables are treated as `"N"`.
#' * Columns are split by arm. Overall population column is excluded by default (see `lbl_overall` argument).
#' * Numbers in table represent the absolute numbers of patients and fraction of `N`.
#'
#' @inheritParams argument_convention
#' @param min_freq (`proportion`)\cr minimum % frequency (fraction of `N`) required in any column to include each row.
#'
#' @return An `rtable` object.
#'
#' @examples
#' adsl <- scda::synthetic_cdisc_dataset("rcd_2022_10_13", "adsl")
#' adae <- scda::synthetic_cdisc_dataset("rcd_2022_10_13", "adae")
#'
#' tbl <- make_table_13(adae = adae, alt_counts_df = adsl)
#' tbl
#'
#' @export
make_table_13 <- function(adae,
                          alt_counts_df = NULL,
                          show_colcounts = TRUE,
                          min_freq = 0.05,
                          arm_var = "ARM",
                          saffl_var = "SAFFL",
                          pref_var = "AEDECOD",
                          lbl_pref_var = formatters::var_labels(adae, fill = TRUE)[pref_var],
                          lbl_overall = NULL,
                          risk_diff = NULL,
                          annotations = NULL) {
  checkmate::assert_subset(c("USUBJID", arm_var, saffl_var, pref_var), names(adae))
  assert_flag_variables(adae, saffl_var)

  adae <- adae %>%
    filter(.data[[saffl_var]] == "Y") %>%
    df_explicit_na()

  alt_counts_df <- alt_counts_df_preproc(alt_counts_df, arm_var, saffl_var)

  lyt <- basic_table_annot(show_colcounts, annotations) %>%
    split_cols_by_arm(arm_var, lbl_overall, risk_diff) %>%
    count_occurrences(
      vars = pref_var,
      riskdiff = !is.null(risk_diff)
    ) %>%
    append_topleft(c("", lbl_pref_var))

  tbl <- build_table(lyt, df = adae, alt_counts_df = alt_counts_df)

  row_condition <- has_fraction_in_any_col(
    atleast = min_freq,
    col_names = names(table(adae[[arm_var]]))
  )
  tbl <- prune_table(tbl, keep_rows(row_condition))

  tbl
}
