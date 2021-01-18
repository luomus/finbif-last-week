library(blastula)
library(lubridate)

recipients <- dget("recipients.R")

from      <- Sys.getenv("FINBIF_LAST_WEEK_FROM")
to        <- Sys.getenv("FINBIF_LAST_WEEK_TO")
names(to) <- Sys.getenv("FINBIF_LAST_WEEK_NAME_TO")
key       <- Sys.getenv("FINBIF_LAST_WEEK_CRED_KEY_NAME")

smtp_send(
  render_email("finbif_last_week.Rmd"),
  from = from,
  to = to,
  bcc = recipients,
  subject = paste0(
    "FinBIF Last Week (",
    gsub("  ", " ", format(today()-7, "%A, %B %e")), " to ",
    gsub("  ", " ", format(today()-1, "%A, %B %e, %Y")),
    ")"
  ),
  credentials = creds_key(key),
  ssl_verifypeer = FALSE,
  ssl_verifyhost = FALSE
)
