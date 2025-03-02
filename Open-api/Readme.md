# OpenAPI-Based REST API

## 📌 Introduction
This project defines a REST API using **OpenAPI 3.0**, which can be deployed to **AWS API Gateway**. It provides endpoints to interact with users, including fetching user details and managing authentication.

## 🚀 Features
- 📜 API is defined using **OpenAPI 3.0**.
- 🏗️ Can be imported into **AWS API Gateway**.
- 🔄 Supports basic **GET, POST, and DELETE** operations.
- 📂 Uses **JSON** for requests and responses.
- ✅ Auto-generated documentation with **Swagger UI**.

---

## 🛠️ Installation & Setup

### 1️⃣ Clone the Repository
```sh
git clone https://github.com/your-repo/openapi-project.git
cd openapi-project
```

### 2️⃣ Install Dependencies
This project uses **Node.js** and `swagger-ui-express` for API documentation.
```sh
npm install
```

### 3️⃣ Run the API Locally
```sh
node server.js
```
API will be available at: `http://localhost:3000`

---

## 📖 API Endpoints

### 🟢 **GET /hello**
Returns a simple welcome message.

#### ✅ Request:
```sh
GET /hello
```

#### 🔄 Response:
```json
{
  "message": "Hello, Mahesh!"
}
```

---

## 📑 OpenAPI Definition (openapi.yaml)

The API is defined in **OpenAPI format**:

```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0
paths:
  /hello:
    get:
      summary: "Returns a welcome message"
      responses:
        '200':
          description: "Successful response"
          content:
            application/json:
              schema:
                type: object
                properties:
                  message:
                    type: string
```

---

## 🚀 Deploy to AWS API Gateway

### 1️⃣ Create an API Gateway in AWS
1. Go to **AWS Console → API Gateway**.
2. Click **Create API** → **Import from OpenAPI**.
3. Upload the `openapi.yaml` file.
4. Deploy the API.

### 2️⃣ Test the API
Once deployed, you can test the API using:
```sh
curl -X GET https://your-api-id.execute-api.aws-region.amazonaws.com/prod/hello
```

---

## 📜 License
This project is open-source under the **MIT License**.

---

## 🤝 Contributing
Feel free to submit issues or pull requests to improve the API. 🚀

---

## 📞 Contact
For any issues or questions, feel free to reach out via GitHub or email.

