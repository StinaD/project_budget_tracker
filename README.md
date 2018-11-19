This application is designed to allow users to set a budget and track spending.

The budget tracker is built using:
- Ruby
- PostgreSQL and the PG gem
- Sinatra
- HTML and CSS

Set up database via terminal Bash:
- navigate to the project_budget_tracker folder in terminal
- dropdb budget_tracker
- createdb budget_tracker
- psql -d budget_tracker -f db/budget_tracker.sql
- ruby db/seeds.rb
- Run application using local server (locahost:4567). To initiate run the app.rb file and open browser. Direct the browser to localhost:4567 and you should see the homepage for the app.


The application is based on the following brief:
MVP
The app should allow the user to create, edit and delete merchants, e.g. Tesco, Amazon, ScotRail
The app should allow the user to create, edit and delete tags for their spending, e.g. groceries, entertainment, transport
The user should be able to assign tags and merchants to a transaction, as well as an amount spent on each transaction.
The app should display all the transactions a user has made in a single view, with each transaction's amount, merchant and tag, and a total for all transactions.
Inspired by:
Monzo, MoneyDashboard, lots of mobile/online banking apps


Extensions
The user should be able to supply a budget, and the app should alert the user somehow when when they are nearing this budget or have gone over it.
Transactions should have a timestamp, and the user should be able to view transactions sorted by the time they took place.
The user should be able to filter their view of transactions, for example, to view all transactions in a given month, or view all spending on groceries.
