# Project Transcribe
This repo is backend source code for the given project.
Current version is in very early stage and possible missing features.

The goal here is to achieve easier way to switch between locally hosted LLM and cloud provided ones.

# Getting Started

### Prerequisites

- [Node.js](https://nodejs.org) : `npm`
- PostgreSQL database

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/EphemeralSapient/project_transcribe_backend.git
   cd project_transcribe_backend
   ```
2. Install dependencies:
```sh
npm install
```

3. Create a .env file in the root directory based on the environment variable requirements (e.g., PORT, HUGGING_FACE_TOKEN, GEMINI_API_KEY). Refer `config/config.js`

### Running the Application

Start the server with
```sh
chmod +x ./bin/www
./bin/www
```

# File Structure
.
├── .env
├── config/
│   ├── config.js
│   └── db.js
├── controllers/
│   ├── authController.js
│   ├── doctorController.js
│   ├── patientController.js
│   └── uploadController.js
├── models/
│   ├── appointmentModel.js
│   ├── doctorModel.js
│   ├── patientModel.js
│   └── userModel.js
├── routes/
│   ├── authRoutes.js
│   ├── doctorRoutes.js
│   ├── index.js
│   ├── patientRoutes.js
│   └── uploadRoutes.js
├── server.js
├── sql/
│   └── ...
└── utils/
    ├── summarization.js
    └── transcription.js

Please check frontend README file for more insights.

