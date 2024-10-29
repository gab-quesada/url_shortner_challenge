# URL Shortener

This is a URL shortener application built with Ruby on Rails. It allows users to shorten long URLs and track their usage.

## Requirements

Before you begin, ensure you have met the following requirements:

- **Ruby**: Version 2.7.0 or later
- **Rails**: Version 6.1.0 or later
- **PostgreSQL**: Or another supported database

## Local Installation

1. **Clone the repository**:
  ```sh
  git clone https://github.com/your-username/url-shortener.git
  cd url-shortener
  ```

2. **Install the required gems**:
  ```sh
  bundle install
  ```

3. **Set up the database**:
  ```sh
  rails db:setup
  ```

4. **Start the server**:
  ```sh
  rails server
  ```

5. **Initialize the jobs**:
  In order to use background jobs with Redis and Sidekiq, you need to initialize them.

  - Start Redis server:
    ```sh
    redis-server
    ```

  - Start Sidekiq:
    ```sh
    bundle exec sidekiq
    ```

  Now you can use background jobs in your URL shortener application.


6. **Access the application**:
  Open your web browser and visit `http://localhost:3000`.

  ## Test Cases

  Here are some example test cases that you can run using `curl` to interact with the URL shortener application:

  1. **Shorten a URL**:
    ```sh
    curl -X POST -H "Content-Type: application/json" -d '{"url": "https://example.com"}' http://localhost:3000/shorten
    ```

  2. **Retrieve the original URL**:
    ```sh
    curl http://localhost:3000/1
    ```

  3. **Retrieve the top URLs**:
  ```sh
  curl http://localhost:3000/urls/top
  ```

7. **Run unit test cases with RSpec**:
  ```sh
  bundle exec rspec
  ```

  ## Shortner lgorithm

  The URL shortener application uses a simple algorithm created based on stackOverflow answer https://stackoverflow.com/questions/742013/how-do-i-create-a-url-shortener to generate short URLs. Here's how it works:

  1. Think of an alphabet we want to use. In our case, that's [a-zA-Z0-9]. It contains 62 letters.

  2. Take an auto-generated, unique numerical key (the id of the urls table row).

  3. Now you have to convert the id number to X62 (base 62) with the operations chars[num % base] and num /= base
