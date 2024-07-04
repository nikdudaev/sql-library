# SQL Library

This repository is a collection of SQL scripts that I am writing at work or as a hobby. 

---

## Content

- [Baseball](./baseball/)  
  - Create table for [Retrosheet](www.retrosheet.org) events data. [Script](./baseball/create-events-logs-table.sql)
  - Create table for [Retrosheet](www.retrosheet.org) game logs data. [Script](./baseball/create-game-logs-table.sql)
  - Calculate run expectancy for 24 base/out states, using Retrosheet events data. [Script](./baseball/run-expectancy-templated-with-run-value.sql)
  - Calculate runs and run value per baseball event (like, in The Book). [Script](./baseball/runs-by-event.sql)
  - Calculate runs and run value per baseball event and by base/out state (like, in The Book). [Script](./baseball/runs-by-event-base-out-state.sql)
  - Calculate miscellaneous batting statistics per base/out state. [Script](./baseball/batting-stats-per-base-out-state.sql)

## Usage

Feel free to use the content of this repository in any way you see fit. Also, if you know better ways to achieve same goals, I am more than happy to learn about them.
