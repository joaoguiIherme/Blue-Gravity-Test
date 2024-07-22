# Rails 7 API with Grape Swagger

This is an API built with Rails 7 using Grape Swagger, featuring endpoints for users, contents, and ratings. The API uses Docker and PostgreSQL.
Also availabe an guide at [Postman](#https://documenter.getpostman.com/view/37120749/2sA3kUJ3HQ)
## Table of Contents

- [Installation](#installation)
- [Running the Application](#running-the-application)
- [API Endpoints](#api-endpoints)
  - [Authentication](#authentication)
  - [Users](#users)
  - [Contents](#contents)
  - [Ratings](#ratings)
- [Running Tests](#running-tests)

## Installation

1. Clone the repository:

    ```sh
   git clone https://github.com/your_username/your_repository.git
   cd your_repository
    ```
2. Create a .env file in the root of the project and add the following environment variables:

    ```ruby
   SECRET_KEY_BASE=your_secret_key
    ```

3. Install Docker and Docker Compose on your machine.

## Running the Application

1. To start the application, run:
    ```sh
   docker-compose up
    ```

2. The application will be available at http://localhost:3000.

## API Endpoints
### Authentication
The API uses JWT for authentication. Add the JWT token to the Authorization header in all protected requests.

#### Users
* Create User
    ```http
    POST /api/v1/users
    ```
    Parameters:

    * email: String (required)
    * password: String (required, minimum 8 characters, must include letters and numbers)
    
    Success Response:
    ```json
    {
        "message": "User created successfully",
        "user": {
            "id": 1,
            "email": "user@example.com"
        }
    }
    ```

* Authenticate User
    ```http
    POST /api/v1/users/login
    ```
    Parameters:

    * email: String (required)
    * password: String (required)
    
    Success Response:
    ```json
    {
        "message": "Login successful",
        "token": "jwt_token",
        "user": {
            "id": 1,
            "email": "user@example.com"
        }
    }
    ```

#### Contents

* List all contents
    ```http
    GET /api/v1/contents
    ```

    Sucess Response:
    ```json
    {
        "contents": [
            {
                "id": 1,
                "title": "Content Title",
                "description": "Content Description",
                "category": "music",
                "thumbnail_url": "http://example.com/thumbnail.jpg",
                "content_url": "http://example.com/content.mp4",
                "ratings": [5, 4, 3]
            }
        ]
    }
    ```

* Create content
    ```http
    POST /api/v1/contents
    ```
    Parameters:

    * title: String (required)
    * description: String (required)
    * category: String (required)
    * thumbnail_url: String (required)
    * content_url: String (required)
    
    Success Response:
    ```json
    {
        "message": "Content created successfully",
        "content": {
            "id": 1,
            "title": "Content Title",
            "description": "Content Description",
            "category": "music",
            "thumbnail_url": "http://example.com/thumbnail.jpg",
            "content_url": "http://example.com/content.mp4"
        }
    }
    ```

* Update content
    ```http
    PUT /api/v1/contents/:id
    ```
    Parameters:

    * id: Integer (optional)
    * title: String (optional)
    * description: String (optional)
    * category: String (optional)
    * thumbnail_url: String (optional)
    * content_url: String (optional)
    
    Success Response:
    ```json
    {
        "message": "Content updated successfully",
        "content": {
            "id": 1,
            "title": "Updated Title",
            "description": "Updated Description",
            "category": "Updated Category",
            "thumbnail_url": "http://example.com/updated_thumbnail.jpg",
            "content_url": "http://example.com/updated_content.mp4"
        }
    }
    ```

* Delete content
    ```http
    DELETE /api/v1/contents/:id
    ```
    Parameters:

    * id: Integer (required)
    
    Success Response:
    ```json
    {
        "message": "Content deleted successfully"
    }
    ```

#### Ratings

* Create Rating
    ```http
    POST /api/v1/ratings
    ```
    Parameters:

    * content_id: Integer (required)
    * rating: Integer (required, must be between 1 and 5)
    
    Success Response:
    ```json
    {
        "message": "Rating created successfully",
        "rating": {
            "id": 1,
            "user_id": 1,
            "content_id": 1,
            "rating": 5
        }
    }
    ```
### Running Tests
To run the tests, use the following command:

```sh
docker-compose run web bundle exec rspec
```
This will ensure that all tests are executed in an isolated environment and that the database is cleaned before each test using DatabaseCleaner.