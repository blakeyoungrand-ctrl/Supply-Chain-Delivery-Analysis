# Supply Chain Delivery Performance Analysis

**What's driving late deliveries, and what can be fixed?**

SQL and Excel analysis of 180,519 order lines (65,752 orders) from the [DataCo Smart Supply Chain dataset](https://www.kaggle.com/) on Kaggle.

![Dashboard](dashboard.png)

## Key findings

| Metric | Result |
|---|---|
| Order lines delivered late | **54.8%** |
| Sales delivered late | **$20.1M of $36.8M** |
| First Class orders late | **95.3%** (late in every market: 94.7–97.0%) |
| Premium modes' share of late sales | **54%** (vs. 35% of total sales) |

1. **Premium shipping is the root cause.** First Class is late on 95.3% of orders and Second Class on 76.6%, compared with 38.1% for Standard Class.
2. **Delivery promises are unrealistic, not operations chaotic.** First Class orders arrive on average exactly 1.0 day late, and Second Class 2.0 days late. A consistent gap points to scheduled delivery times set tighter than the network can achieve.
3. **Region and category aren't the drivers.** 22 of 23 regions sit between 52.8% and 58.0% late, and the top 10 categories between 50.7% and 55.2%.
4. **The highest-paying customers are hit hardest.** $10.9M of the $12.8M in premium sales (84.9%) arrived late.

## Recommendations

- **Reset premium delivery promises** to match actual performance (e.g. +1 day on First Class), then tighten as operations improve.
- **Investigate Second Class operations** (carriers, warehouse cut-off times), since it has the largest premium late revenue ($5.5M).
- **Prioritize high-value categories** (e.g. Fishing: $6.9M in sales) and track on-time rate weekly by shipping mode.

## Files

| File | What it is |
|---|---|
| `queries.sql` | The 5 SQL queries, with results in comments |
| `supply_chain_analysis.xlsx` | Query results, KPI dashboard, charts and pivot-table heat map |
| `Supply_Chain_Analysis_Summary.pdf` | One-page write-up |
| `dashboard.png` | Dashboard screenshot |

## Tools

SQL (SQLite, DB Browser for SQLite) · Excel (pivot tables, conditional formatting, charts)

## Limitations

Public, anonymized dataset (2015–2018). There's no carrier or cost data, so the financial impact of lateness (refunds, churn) isn't quantified. Small segments (Canada: 959 lines; Computers: 442 lines) are excluded from the conclusions.

---
*Blake Young · [LinkedIn](https://www.linkedin.com/in/blakeyoungrand)*
