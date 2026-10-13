# 数据来源与字段

发布者：Landeshauptstadt München。原始 CSV 来自个人课程目录，整理时逐字节复制，未更改数据值。

| 文件 | 数据集及公开资源 | 许可 |
|---|---|---|
| rad_2022_09_tage.csv | 数据集 Daten der Raddauerzählstellen München 2022；Tageswerte und Wetter September 2022；https://opendata.muenchen.de/dataset/c43b0bfb-836b-4291-b987-bf0fde74daaa/resource/99f4cd46-40bd-4d81-8fb3-f7dfbb2a20a1 | Datenlizenz Deutschland Namensnennung 2.0 |
| oktoberfestbierpreis19852023.csv | Oktoberfest Bierpreise 1985–2023；https://opendata.muenchen.de/dataset/8d6c8251-7956-4f92-8c96-f79106aab828/resource/52fda541-c4dd-4eb6-8f2a-84ca24ffe775 | Datenlizenz Deutschland Namensnennung 2.0 |

许可：https://www.govdata.de/dl-de/by-2-0 。数据权利属于原发布方，新增代码不改变数据许可。

| 字段 | 含义与使用 |
|---|---|
| datum | 日期；按 YYYY.MM.DD 解析 |
| zaehlstelle | 计数站点；各站点分别统计 |
| uhrzeit_start / uhrzeit_ende | 记录时间区间，保留原字符串；不将 23.59 解释为十进制小时 |
| richtung_1 / richtung_2 / gesamt | 两个方向计数及总计；是通过次数，不是唯一出行人数 |
| min-temp / max-temp | 最低／最高温度；本分析不依赖其单位 |
| niederschlag / bewoelkung | 降水／云量；未据此建立模型 |
| sonnenstunden | 日照时长（小时） |
| jahr / bier_preis | 年份／公开名义价格（欧元）；不作通胀调整 |

校验哈希记录见 provenance.json。缺失及不一致记录在 results/ 下保留。一个月的站点数据不能代表全市全年交通。
