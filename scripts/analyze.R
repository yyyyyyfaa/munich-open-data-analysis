# Run from the repository root: Rscript --vanilla scripts/analyze.R
# Data analysis developed from LMU statistical programming exercises.
required <- c("readr", "dplyr", "ggplot2")
if (!all(vapply(required, requireNamespace, logical(1), quietly=TRUE))) {
  stop("Missing packages. Run Rscript --vanilla scripts/setup.R first.")
}
suppressPackageStartupMessages({library(readr); library(dplyr); library(ggplot2)})
dir.create("results", showWarnings=FALSE)
dir.create("figures", showWarnings=FALSE)
bike <- read_csv("data/raw/rad_2022_09_tage.csv", show_col_types=FALSE,
                 col_types=cols(datum=col_character(), uhrzeit_start=col_character(),
                                uhrzeit_ende=col_character()))
stopifnot(all(c("datum","zaehlstelle","gesamt","richtung_1","richtung_2",
               "sonnenstunden","niederschlag") %in% names(bike)))
if(nrow(problems(bike))) stop("CSV parsing problems: inspect the input.")
bike <- bike |> mutate(date=as.Date(datum, format="%Y.%m.%d"))
if(anyNA(bike$date)) stop("Unparsed dates")
if(anyDuplicated(bike[c("zaehlstelle","date")])) stop("Duplicate station-date keys")
if(any(bike$gesamt < 0, na.rm=TRUE)) stop("Negative cycle counts")
missing <- data.frame(variable=names(bike),missing=vapply(bike,function(x)sum(is.na(x)),integer(1)))
write_csv(missing,"results/missing_values.csv")
bad_total <- bike |> filter(!is.na(gesamt), !is.na(richtung_1), !is.na(richtung_2),
                            gesamt != richtung_1 + richtung_2)
write_csv(bad_total,"results/direction_total_mismatches.csv")
station <- bike |> group_by(zaehlstelle) |> summarise(n_days=n_distinct(date),
  n_valid=sum(!is.na(gesamt)),mean_daily=mean(gesamt,na.rm=TRUE),
  median_daily=median(gesamt,na.rm=TRUE),zero_days=sum(gesamt==0,na.rm=TRUE),.groups="drop")
write_csv(station,"results/station_summary.csv")
g <- ggplot(bike,aes(date,gesamt))+geom_line(color="#24546D")+
  facet_wrap(~zaehlstelle,scales="free_y")+theme_minimal(base_size=11)+
  labs(title="Daily bicycle counts by station",subtitle="Munich | September 2022",
       x=NULL,y="Recorded bicycles",caption="Source: City of Munich, dl-de/by-2-0. Panel scales differ.")
ggsave("figures/cycling_by_station.png",g,width=10,height=6,dpi=160)
# Restrict to one station to avoid treating repeated citywide weather as independent.
a <- bike |> filter(zaehlstelle=="Arnulf", !is.na(gesamt), !is.na(sonnenstunden))
if(nrow(a)<5 || sd(a$gesamt)==0 || sd(a$sonnenstunden)==0) stop("Insufficient Arnulf variation")
set.seed(20261013)
observed <- cor(a$gesamt,a$sonnenstunden)
null <- replicate(9999,cor(a$gesamt,sample(a$sonnenstunden)))
p <- (sum(abs(null)>=abs(observed))+1)/(length(null)+1)
write_csv(data.frame(station="Arnulf",n=nrow(a),pearson_r=observed,
                    exploratory_permutation_p=p,permutations=length(null)),"results/weather_association.csv")
g <- ggplot(a,aes(sonnenstunden,gesamt))+geom_point(color="#24546D",size=2)+
  theme_minimal(base_size=11)+labs(title="Sunshine and bicycle counts at Arnulf",
  subtitle=sprintf("September 2022 | n = %d | Pearson r = %.3f",nrow(a),observed),
  x="Sunshine hours",y="Recorded bicycles",caption="Association only; daily observations may be temporally dependent.")
ggsave("figures/sunshine_arnulf.png",g,width=8,height=5,dpi=160)
beer <- read_csv("data/raw/oktoberfestbierpreis19852023.csv",show_col_types=FALSE)
if(nrow(problems(beer)) || anyNA(beer$jahr) || anyNA(beer$bier_preis)) stop("Invalid beer data")
stopifnot(!anyDuplicated(beer$jahr), all(beer$bier_preis>0))
beer <- beer |> arrange(jahr) |> mutate(gap_years=jahr-lag(jahr),
  change_from_previous_record_pct=100*(bier_preis/lag(bier_preis)-1))
write_csv(beer,"results/beer_price_changes.csv")
first <- beer[1,]; last <- beer[nrow(beer),]
change <- 100*(last$bier_preis/first$bier_preis-1)
g <- ggplot(beer,aes(jahr,bier_preis))+geom_line(color="#24546D")+geom_point(color="#24546D")+
  theme_minimal(base_size=11)+labs(title="Oktoberfest beer prices",x="Year",y="Published nominal price (EUR)",
  caption="City of Munich, dl-de/by-2-0. No inflation adjustment; lines connect available observations.")
ggsave("figures/oktoberfest_prices.png",g,width=8,height=5,dpi=160)
lines <- c("# Results", "", "Daily cycling counts, weather and beer prices from Munich open data.", "",
  sprintf("- Cycling data: %d station-day rows across %d stations (%s to %s).",nrow(bike),nrow(station),min(bike$date),max(bike$date)),
  sprintf("- Direction-count inconsistencies: %d. They are reported, not silently corrected.",nrow(bad_total)),
  sprintf("- Arnulf sunshine association: Pearson r = %.3f (n = %d).",observed,nrow(a)),
  sprintf("- Exploratory two-sided permutation p = %.4f, using 9,999 permutations and a +1 correction.",p),
  sprintf("- Beer prices: %d observations; EUR %.2f (%d) to EUR %.2f (%d), a nominal increase of %.1f%%.",nrow(beer),first$bier_preis,first$jahr,last$bier_preis,last$jahr,change),
  "", "## Reading the results", "",
  "The sunshine correlation describes 30 days at Arnulf. Weekday patterns and serial dependence also affect daily traffic; the permutation test assumes exchangeable observations.",
  "The station totals measure bicycle passages in September 2022. Zero counts and missing values are retained in the quality checks.",
  "Price changes compare consecutive available observations. Prices are reported in nominal euros, and gaps in the series are retained.",
  "", "## Figures", "", "![Station counts](../figures/cycling_by_station.png)",
  "![Weather association](../figures/sunshine_arnulf.png)", "![Prices](../figures/oktoberfest_prices.png)")
writeLines(lines,"results/REPORT.md",useBytes=TRUE)
writeLines(capture.output(sessionInfo()),"results/sessionInfo.txt")
write_csv(as.data.frame(installed.packages()[required,c("Package","Version")]),"results/package_versions.csv")
cat(paste(lines[4:8],collapse="\n"),"\n")
