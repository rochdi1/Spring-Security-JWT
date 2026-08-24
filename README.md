# JWT Security Project

This project demonstrates a secure REST API built with Spring Boot, utilizing JSON Web Tokens (JWT) for authentication and authorization. It features user registration, login, token refresh, and a basic product management system.

## Features

*   **User Registration:** Allows new users to register with a username, password, and role.
*   **User Login:** Authenticates users and returns an access token and a refresh token.
*   **Token Refresh:** Provides a mechanism to refresh access tokens using refresh tokens.
*   **JWT-Based Authentication:** Secures API endpoints using JWTs.
*   **Role-Based Authorization:**  Supports different user roles (though not explicitly demonstrated in the provided code).
*   **Product Management:** Basic CRUD operations for products (create, read, update, delete).
*   **PostgreSQL Database:** Stores user and product data in a PostgreSQL database.
*   **Validation:** Implements input validation for request payloads.

## Technologies

*   **Spring Boot:** The core framework for building the application.
*   **Spring Security:** Handles authentication and authorization.
*   **Spring Data JPA:** Simplifies database interactions.
*   **PostgreSQL:** The relational database management system.
*   **JSON Web Tokens (JWT):** Used for secure authentication.
*   **io.jsonwebtoken (JJWT):** A library for creating and parsing JWTs.
*   **Lombok:** Reduces boilerplate code.
*   **Maven:** Build tool for dependency management and project building.
* Java 17 or higher

## Setup and Installation

1.  **Prerequisites:**
    *   Java Development Kit (JDK) 17 or higher
    *   Maven
    *   PostgreSQL database installed and running.

2.  **Clone the repository:**
    ```bash
    git clone https://github.com/rochdi1/Spring-Security-JWT
    cd Spring-Security-JWT
    ```

3.  **Database Configuration:**
    *   Open `src/main/resources/application.properties`.
    *   Update the PostgreSQL connection details (`spring.datasource.url`, `spring.datasource.username`, `spring.datasource.password`) to match your database setup.
    ```properties
    spring.datasource.url=jdbc:postgresql://localhost:5432/<DATAVASE-NAME>
    spring.datasource.username=<USERNAME>
    spring.datasource.password=<PASSWORD>
    ```
    *    The application is set to create and drop tables on start up, using: `spring.jpa.hibernate.ddl-auto=create-drop`. Change to `spring.jpa.hibernate.ddl-auto=update` if you wish the data to be persisted.

4.  **JWT Secret:**
    *   The `app.jwt.secret` property in `application.properties` contains a long, randomly generated string. **Keep this secret safe and secure in production.**
    *   You can generate a secure secret key using the following command:
     ```bash
     openssl rand -base64 64
     ```
     ```properties
     app.jwt.secret=very-secure-and-complex-key-that-is-at-least-256-bits-long-for-production
     ```

5. **Build and Run:**
    ```bash
    mvn clean install
    mvn spring-boot:run
    ```

   The application will start on `http://localhost:8080` (default Spring Boot port).

## API Endpoints Summary

| Category | Method | Endpoint | Description | Auth Required |
| :--- | :--- | :--- | :--- | :--- |
| Authentication | POST | `/api/auth/register` | Register a new user | No |
| Authentication | POST | `/api/auth/login` | Login and get tokens | No |
| Authentication | POST | `/api/auth/refresh-token` | Refresh access token | No |
| Products | GET | `/api/products` | Get all products | Yes (Any) |
| Products | GET | `/api/products/{id}` | Get product by ID | Yes (Any) |
| Products | POST | `/api/products` | Create a new product | Yes (Admin) |
| Products | PUT | `/api/products/{id}` | Update a product | Yes (Admin) |
| Products | DELETE | `/api/products/{id}` | Delete a product | Yes (Admin) |

## API Endpoints and curl Requests

### Authentication

#### 1. Register User
**POST** `/api/auth/register`

Registers a new user.

**curl Request:**
```bash
curl -X POST http://localhost:8080/api/auth/register \
     -H "Content-Type: application/json" \
     -d '{
           "fullName": "John Doe",
           "username": "johndoe",
           "password": "password123",
           "role": "ROLE_ADMIN"
         }'
```

#### 2. Login
**POST** `/api/auth/login`

Authenticates a user and returns an access token and a refresh token.

**curl Request:**
```bash
curl -X POST http://localhost:8080/api/auth/login \
     -H "Content-Type: application/json" \
     -d '{
           "username": "johndoe",
           "password": "password123"
         }'
```

#### 3. Refresh Token
**POST** `/api/auth/refresh-token`

Generates a new access token using a valid refresh token.

**curl Request:**
```bash
curl -X POST http://localhost:8080/api/auth/refresh-token \
     -H "Content-Type: application/json" \
     -d '{
           "refreshToken": "YOUR_REFRESH_TOKEN_HERE"
         }'
```

---

### Products

All product endpoints require a valid **Access Token** in the `Authorization` header.

#### 4. Get All Products
**GET** `/api/products`

Retrieves a list of all products.

**curl Request:**
```bash
curl -X GET http://localhost:8080/api/products \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN_HERE"
```

#### 5. Get Product by ID
**GET** `/api/products/{id}`

Retrieves a single product by its ID.

**curl Request:**
```bash
curl -X GET http://localhost:8080/api/products/1 \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN_HERE"
```

#### 6. Create Product (Admin Only)
**POST** `/api/products`

Creates a new product. Requires `ROLE_ADMIN`.

**curl Request:**
```bash
curl -X POST http://localhost:8080/api/products \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN_HERE" \
     -d '{
           "name": "Laptop",
           "price": 1200.00
         }'
```

#### 7. Update Product (Admin Only)
**PUT** `/api/products/{id}`

Updates an existing product. Requires `ROLE_ADMIN`.

**curl Request:**
```bash
curl -X PUT http://localhost:8080/api/products/1 \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN_HERE" \
     -d '{
           "name": "Updated Laptop",
           "price": 1100.00
         }'
```

#### 8. Delete Product (Admin Only)
**DELETE** `/api/products/{id}`

Deletes a product by its ID. Requires `ROLE_ADMIN`.

**curl Request:**
```bash
curl -X DELETE http://localhost:8080/api/products/1 \
     -H "Authorization: Bearer YOUR_ACCESS_TOKEN_HERE"
```

## Further Development

*   **More detailed error handling:** Improve error handling and provide more informative error messages.
*   **Comprehensive testing:** Add unit and integration tests.
*   **Enhanced security:** Consider additional security measures, such as input sanitization and rate limiting.
*   **Role based authorization**
*   **Validation for all entities**

**Befehle zum StartenStarten (inklusive Build der App):**
```bash
docker compose up --build -d
```
**Stoppen:**
```bash
docker compose down
```
**Logs einsehen:**
```bash
docker compose logs -f app
```
 ***Docker-Cache erzwingen zu leeren***
 
 Führen Sie den Befehl mit dem Flag --no-cache aus, um Docker zu zwingen, das echte Java 21 Image frisch herunterzuladen:
 ```bash
 docker compose build --no-cache
 docker compose up -d
```

To expand your project into a full production-ready CI/CD pipeline, we will migrate from PostgreSQL to MySQL, add SonarQube for code quality analysis, configure Jenkins to automate the build, and deploy the entire application to Kubernetes.Here is the complete configuration setup.
**1. Updated Dockerfile (Java 21)**

This Dockerfile uses a multi-stage build with Eclipse Temurin 21. It is optimized for Jenkins to run unit tests and build the application inside the pipeline.

```dockerfile
# Stage 1: Build & Test
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
# Jenkins will trigger tests, but for the final image construction we package it
RUN mvn clean package -DskipTests

# Stage 2: Minimal Runtime
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```
**2. Local Infrastructure:** docker-compose.yml

This file spins up your MySQL database, Jenkins, and SonarQube locally so they can interact with each other.
```yaml
version: '3.8'

services:
  # MySQL Database
  mysql-db:
    image: mysql:8.0
    container_name: springboot_mysql
    environment:
      MYSQL_DATABASE: auth_product_db
      MYSQL_USER: app_user
      MYSQL_PASSWORD: secure_password_123
      MYSQL_ROOT_PASSWORD: root_password_123
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 5s
      timeout: 5s
      retries: 5

  # SonarQube for Code Quality
  sonarqube:
    image: sonarqube:community
    container_name: sonarqube_server
    ports:
      - "9000:9000"
    networks:
      - ci_network
    environment:
      - SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions

  # Jenkins CI/CD Automation Server
  jenkins:
    image: jenkins/jenkins:lts-jdk17
    container_name: jenkins_server
    privileged: true
    user: root
    ports:
      - "8082:8080"
      - "50000:50000"
    networks:
      - ci_network
    environment:
      - DOCKER_HOST=tcp://docker:2375
    volumes:
      - jenkins_data:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock # Allows Jenkins to build Docker images

networks:
  ci_network:
    driver: bridge

volumes:
  mysql_data:
  jenkins_data:
  sonarqube_data:
  sonarqube_extensions:
```
Note: Run docker compose up -d to launch these infrastructure services.
**3. Pipeline Automation:**
JenkinsfilePlace this file in the root directory of your project. It automates testing, code scanning via SonarQube, building the Docker image, and deploying to Kubernetes.

```groovy
pipeline {
    agent any
    
    tools {
        maven 'Maven3' // Must match the name configured in Jenkins Global Tool Configuration
    }
    
    environment {
        DOCKER_IMAGE = "your-dockerhub-username/jwt-security-api"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Unit Tests') {
            steps {
                sh 'mvn clean test'
            }
        }
        
        stage('SonarQube Quality Gate') {
            steps {
                // Ensure you have configured the SonarQube server in Jenkins settings
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=jwt-security-api'
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} ."
                sh "docker tag ${DOCKER_IMAGE}:${IMAGE_TAG} ${DOCKER_IMAGE}:latest"
            }
        }
        
        stage('Push to Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "echo ${PASS} | docker login -u ${USER} --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}:${IMAGE_TAG}"
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                // Applies the deployment manifest to your Kubernetes Cluster
                sh "sed -i 's|IMAGE_PLACEHOLDER|${DOCKER_IMAGE}:${IMAGE_TAG}|g' k8s-deployment.yml"
                sh "kubectl apply -f k8s-deployment.yml"
            }
        }
    }
}
```
**4. Orchestration:** k8s-deployment.yml

This manifest defines how your application and MySQL instances run inside a Kubernetes cluster (e.g., Minikube, EKS, or GKE).

```yaml

apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:8.0
        env:
        - name: MYSQL_DATABASE
          value: auth_product_db
        - name: MYSQL_USER
          value: app_user
        - name: MYSQL_PASSWORD
          value: secure_password_123
        - name: MYSQL_ROOT_PASSWORD
          value: root_password_123
        ports:
        - containerPort: 3306
---
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
spec:
  ports:
  - port: 3306
  selector:
    app: mysql
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: springboot-api-deployment
spec:
  replicas: 2 # High-availability mode
  selector:
    matchLabels:
      app: springboot-api
  template:
    metadata:
      labels:
        app: springboot-api
    spec:
      containers:
      - name: springboot-api
        image: IMAGE_PLACEHOLDER # Automatically updated by Jenkins
        ports:
        - containerPort: 8080
        env:
        - name: SPRING_DATASOURCE_URL
          value: jdbc:mysql://mysql-service:3306/auth_product_db?allowPublicKeyRetrieval=true&useSSL=false
        - name: SPRING_DATASOURCE_USERNAME
          value: app_user
        - name: SPRING_DATASOURCE_PASSWORD
          value: secure_password_123
        - name: JWT_SECRET
          value: 3c9c3524b5e7d5904d9c3524b5e7d5904d9c3524b5e7d5904d9c3524b5e7d590
---
apiVersion: v1
kind: Service
metadata:
  name: springboot-api-service
spec:
  type: LoadBalancer # Exposes your Spring API outside the cluster
  ports:
  - port: 80
    targetPort: 8080
  selector:
    app: springboot-api
```
**5. Application Configuration Update**

Update your src/main/resources/application.properties (or .yml) file to support the MySQL driver dynamically via environment variables:
```properties

spring.datasource.url=${SPRING_DATASOURCE_URL:jdbc:mysql://localhost:3306/auth_product_db}
spring.datasource.username=${SPRING_DATASOURCE_USERNAME:app_user}
spring.datasource.password=${SPRING_DATASOURCE_PASSWORD:secure_password_123}
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.database-platform=org.hibernate.dialect.MySQLDialect
```
Use code with caution.Make sure your pom.xml contains the MySQL connector dependency instead of PostgreSQL:

```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>
```

sehen alle logs auch jenkins-server
```bash
docker-compose logs -f -t
```
