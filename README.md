# IPL_Analysis
A comprehensive data analysis of the Indian Premier League (IPL) using advanced SQL to uncover insights on player and team performance.

# IPL Data Analysis with SQL

![SQL](https://img.shields.io/badge/Language-SQL-blue)
![Database](https://img.shields.io/badge/Database-MySQL-orange)
![License](https://img.shields.io/badge/License-MIT-green)

A comprehensive data analysis project exploring over a decade of Indian Premier League (IPL) match data using advanced SQL to uncover insights into team strategies, player performance, and match-winning factors.

## Project Overview

This project serves as a demonstration of advanced SQL skills for data analysis. The goal is to query a rich dataset of ball-by-ball IPL data to answer complex analytical questions. By structuring queries with Common Table Expressions (CTEs), utilizing Window Functions for ranking, and performing complex aggregations, this project extracts meaningful statistics that go beyond simple data retrieval.

### Skills Demonstrated
* **Complex Querying:** Writing sophisticated queries with multiple joins, subqueries, and aggregations.
* **Advanced SQL Functions:** Proficient use of CTEs (`WITH` clause) and Window Functions (`RANK()`, `OVER()`).
* **Database Schema Design:** Understanding of relational data, including primary and foreign key relationships.
* **Data Analysis:** Translating business questions into SQL queries and interpreting the results to find insights.
* **Problem Solving:** Breaking down complex analytical problems into logical, sequential SQL steps.

## Dataset

This project uses a popular IPL dataset sourced from Kaggle, containing detailed ball-by-ball information from every match from 2008 to 2022.

The data is contained in two main tables:
* `matches`: Provides high-level information for each match, including teams, venue, toss details, and the winner.
* `deliveries`: Contains ball-by-ball data for every match, detailing the batter, bowler, runs scored, wickets, extras, etc.

## Database Schema

The two tables are linked by a `match_id`.

**`matches` table**
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | INT (PK) | Unique ID for each match. |
| `season`| TEXT | The IPL season/year. |
| `winner`| TEXT | The winning team of the match. |
| `toss_winner`| TEXT | The team that won the toss. |
| `...` | ... | and other match-level details. |

**`deliveries` table**
| Column | Type | Description |
| :--- | :--- | :--- |
| `match_id` | INT (FK) | ID referencing the `matches` table. |
| `batter` | TEXT | The name of the batsman. |
| `bowler` | TEXT | The name of the bowler. |
| `batsman_runs`| INT | Runs scored by the batsman on that ball. |
| `is_wicket`| INT | A boolean (0 or 1) indicating if a wicket fell. |
| `...` | ... | and other ball-by-ball details. |


## Setup and Usage

To replicate this analysis, you will need a running instance of a MySQL server and a client like MySQL Workbench.

1.  **Clone the repository:**
2.  **Database Setup:** Create a new database (e.g., `ipl_analysis`). Use a `schema.sql` script to create the `matches` and `deliveries` tables.
3.  **Data Loading:** Import the `.csv` files for matches and deliveries into their respective tables in the database.
4.  **Run Analysis:** The `analysis/` folder contains the SQL scripts for each question. You can run these scripts in MySQL Workbench to see the results.

## Analytical Questions Addressed

This project answers several key analytical questions about the IPL. The SQL scripts for each question can be found in the `analysis/` directory of this repository.

* What is the overall win percentage for each team across all seasons?
* How significantly does winning the toss impact the match outcome?
* Who are the top 10 most destructive batsmen (highest strike rate) with a minimum of 500 balls faced?
* Who are the top 10 most economical bowlers with a minimum of 50 overs bowled?
* Who was the Orange Cap winner (most runs) for each individual season?
* Who was the Purple Cap winner (most wickets) for each individual season?
* Which players are the most effective "death over" (overs 16-20) specialists?
* What are the most common dismissal types for top bowlers?
* How do team performances vary between home and away matches?

## Future Enhancements
* Connect the database to a BI tool like Tableau or Power BI to create interactive dashboards.
* Perform more advanced statistical analysis, such as player performance correlations with match outcomes.
* Develop stored procedures to encapsulate complex queries for easier on-demand analysis.

## Contact
Your Email - banditeja157@gmail.com
