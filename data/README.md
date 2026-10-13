# Data

Source: City of Munich Open Data Portal.

| File | Coverage | Source |
|---|---|---|
| `rad_2022_09_tage.csv` | Daily bicycle counts and weather, September 2022 | [Bicycle counter data](https://opendata.muenchen.de/dataset/c43b0bfb-836b-4291-b987-bf0fde74daaa/resource/99f4cd46-40bd-4d81-8fb3-f7dfbb2a20a1) |
| `oktoberfestbierpreis19852023.csv` | Published Oktoberfest beer prices, 1985–2023 | [Beer price data](https://opendata.muenchen.de/dataset/8d6c8251-7956-4f92-8c96-f79106aab828/resource/52fda541-c4dd-4eb6-8f2a-84ca24ffe775) |

Publisher: Landeshauptstadt München. Licence: [German Data Licence Attribution 2.0](https://www.govdata.de/dl-de/by-2-0). The original CSV files retain the publisher's column names and values. File hashes are listed in `provenance.json`.

## Variables

| Field | Meaning |
|---|---|
| `datum` | Observation date, parsed as YYYY.MM.DD |
| `zaehlstelle` | Counting station |
| `uhrzeit_start`, `uhrzeit_ende` | Recorded measurement interval; retained as strings |
| `richtung_1`, `richtung_2` | Counts in each direction |
| `gesamt` | Total daily count |
| `min-temp`, `max-temp` | Daily minimum and maximum temperature |
| `niederschlag` | Precipitation |
| `bewoelkung` | Cloud cover |
| `sonnenstunden` | Sunshine duration in hours |
| `jahr` | Year of the beer price observation |
| `bier_preis` | Published nominal beer price in euros |

Counts measure passages through each station. Missing values, duplicate keys and direction-total inconsistencies are checked before analysis. Price changes use consecutive available records; the gap in years is retained in the output table.
