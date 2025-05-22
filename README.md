# Image Processing Service API

A backend API for processing images, tracking requests, and triggering webhooks.

You first need to read the [Assignment File](https://drive.google.com/file/d/1Pi2vOaxfDiOc1V8g-2rPJDC1KO-d84sl/view?usp=drive_link)

## 📌Features

- Upload CSV File to process images
- Track processing status using request ID
- Webhook integration for status updates
- API documentation with Swagger
- Generate CSV file by Python Script

## 🛠️ Tech Stack

- **Backend**: Node.js, Express.js
- **Database**: PostgreSQL
- **Storage**: Local or Cloudinary for images
- **API Docs**: Swagger (OpenAPI)
- **Tools**: Postman for testing [Postman Link](https://image-processing-service.postman.co/workspace/Image-Processing-Service-Worksp~815e13b8-0018-4888-b46f-0d4c86729a5f/collection/26493025-0ddbc612-b9e0-4890-84f7-78d80416bef8?action=share&creator=26493025)

### 💻 Live

- Go to [Render Deployment](https://image-processing-system-7j50.onrender.com/api/file)
- For API Docs [REST API](https://image-processing-system-7j50.onrender.com/api-docs/)

### 1️⃣ Prerequisites

- Node.js (v16+)
- PostgreSQL (running locally or via Docker)

### 2️⃣ Installation

```sh
git clone <repo-url>
cd <project-folder>
npm install
```

### ️3️⃣ Running

```sh
npm run dev
python test.py
```

- Upload the test_image_service.csv to the local server

### 4️⃣Webhook

- Just add your webhook endpoint in below or can add in the body of your request and save it in variable
  Example:

```js
await triggerWebhook(requestId, "https://webhook.site/{uniqueId}");
```

### 5️⃣System Design

[Notion Link](https://amosmurmu.notion.site/Image-Processing-Service-1c4fdb1d511e802e95efe90d4dd25c9d)

### License

[License](./LICENSE.txt)
