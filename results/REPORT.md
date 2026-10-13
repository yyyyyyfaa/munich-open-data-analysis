# Results

Generated from the bundled course data by scripts/analyze.R.

- Cycling data: 180 station-day rows across 6 stations (2022-09-01 to 2022-09-30).
- Direction-count inconsistencies: 0. They are reported, not silently corrected.
- Arnulf sunshine association: Pearson r = 0.721 (n = 30).
- Exploratory two-sided permutation p = 0.0001, using 9,999 permutations and a +1 correction.
- Beer prices: 37 observations; EUR 3.20 (1985) to EUR 14.33 (2023), a nominal increase of 347.8%.

## Interpretation and limitations

The weather association is descriptive, not a causal weather effect. Permutation assumes exchangeable observations; temporal dependence, weekday patterns and common weather conditions can violate that assumption. The p-value is a teaching exercise, not confirmatory evidence.
Station counts are not unique cyclists or a citywide census. A zero may reflect missing operation; no automatic imputation is performed. September 2022 and January 2024 exercises must not be conflated.
Price changes compare consecutive available records. Missing years are not interpolated; nominal changes are not changes in real purchasing power.

## Figures

![Station counts](../figures/cycling_by_station.png)
![Weather association](../figures/sunshine_arnulf.png)
![Prices](../figures/oktoberfest_prices.png)
