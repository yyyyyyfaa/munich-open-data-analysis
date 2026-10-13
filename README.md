# Munich Open Data Analysis

R analysis of bicycle traffic, weather and Oktoberfest beer prices using data published by the City of Munich. The project grew out of my statistical programming coursework at LMU.

## Results

The cycling dataset contains 180 daily records from six counting stations in September 2022. At Arnulf, sunshine duration and bicycle counts have a Pearson correlation of **0.721** across 30 days. The station plots show how traffic varies over the month.

The beer price series contains 37 observations between 1985 and 2023. The published price rose from EUR 3.20 to EUR 14.33, a **347.8% nominal increase** over that period.

![Daily bicycle counts](figures/cycling_by_station.png)

## Analysis

The script checks missing values, date formats and duplicate station-date records. It also checks whether the two directional counts add up to the daily total. It then calculates station summaries, plots daily traffic and examines the sunshine association at Arnulf with a two-sided permutation test.

For the price series, it calculates changes between consecutive available observations and plots the long-term trend. All tables and figures are saved when the script runs.

## Run

Requirements: R, readr, dplyr and ggplot2. From the repository root:

```sh
Rscript --vanilla scripts/setup.R
Rscript --vanilla scripts/analyze.R
```

The CSV files are included in `data/raw/`. Package versions are recorded in `results/package_versions.csv`.

- [Analysis report](results/REPORT.md)
- [Data sources and variables](data/README.md)
- [Analysis script](scripts/analyze.R)

## Data and coursework

The cycling observations cover September 2022; beer prices are reported in nominal euros. The weather analysis describes the association within one station and month. Weekday patterns and other factors also influence traffic.

Both datasets are published under the German Data Licence Attribution 2.0. Full attribution and source links are in the data README.

Course background: Introduction to Statistical Software and Advanced Statistical Programming using R at LMU Munich. [Course materials](https://soda-lmu.github.io/StatProg2-2026-SoSe/).
