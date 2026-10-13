# 慕尼黑开放数据分析 · R

基于 LMU 已完成的 R 课程练习整理的个人作品集：分析自行车计数与天气的关系，并展示慕尼黑啤酒节价格的长期变化。作者：杨艺帆 / Yifan Yang。

## 项目内容

- 数据质量：日期解析、站点与日期唯一性、缺失值、负计数、方向计数与总量核对。
- 描述性分析：按站点计算日计数均值、中位数和零计数天数，生成时间趋势图。
- 统计练习：仅对 Arnulf 站点计算日照时长与自行车计数的 Pearson 相关及探索性置换检验。
- 价格分析：绘制啤酒节名义价格变化，区分相邻记录增长与逐年增长。

## 快速运行

需要 R 与 readr、dplyr、ggplot2。在此目录运行：

```sh
Rscript --vanilla scripts/setup.R
Rscript --vanilla scripts/analyze.R
```

数据随仓库提供，不需要下载。已执行的结果见 [分析报告](results/REPORT.md)；软件版本见 results/package_versions.csv。setup.R 只在缺少依赖时联网安装；已具备依赖时可完全离线运行。

![自行车计数](figures/cycling_by_station.png)

## 课程基础

基础课程：Einführung in die statistische Software；Advanced Statistical Programming using R。

课程网页
- https://soda-lmu.github.io/StatProg2-2026-SoSe/
- https://soda-lmu.github.io/StatProg2-2026-SoSe/09-open-renv/practical.html

## 结果解释

相关不代表因果；只有一个月的数据，不能推广为全年规律。置换检验未建模时间相关，仅用于展示统计方法。价格为名义值，未调整通胀。数据许可、字段及出处见 [data/README.md](data/README.md)。
