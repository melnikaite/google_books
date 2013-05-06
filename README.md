# GoogleBooks

This is a Ruby web application which displays a paginated list of books for US region, using the **Google Books API**.

By default it shows books for "ruby on rails" query, however you can use any other phrase for search.

For each item in the list it shows the author, title and thumbnail if there are any of them.

The application cache all requests to Google API for 60 seconds, using Redis, what allows to serve at least **10k requests** per minute on MacBook Pro 2008.

Table and form styled by Twitter Bootstrap.

View template written on **HAML**.

Style written on **SCSS**.

GoogleBooks deployed to [**Heroku**](http://floating-fjord-3454.herokuapp.com/).

In additional were used **VCR** and webmock gems, which provide cache mechanism for all http responses to improve application tests.

### Installation

`git clone git@github.com:melnikaite/google_books.git`

`cd google_books`

`bundle`

`redis-server`

`rails s`

### Test

`redis-server`

`rake spec`

### Deploy

`git push heroku master`
