# Digital Museum Artifact & Restoration Management System

A DBMS academic project for managing museum collections, artifacts, exhibitions, visitors, staff, and artifact restoration activities.

The application demonstrates the use of relational and NoSQL databases in a digital museum environment.

## 1. Project Overview

The system has three main parts:

- **Frontend:** Next.js, React, TypeScript, HTML, and CSS
- **Backend:** Next.js API routes (Route Handlers)
- **Databases:** MySQL and MongoDB

MySQL is used for structured relational information, while MongoDB stores flexible museum-related documents such as artifact research, conservation observations, historical references, exhibition feedback, and digital documentation.

## 2. Main Features

- Admin and Staff authentication
- Password hashing and session-based authentication
- Role-based access for Admin and Staff users
- Dashboard with museum information and collection summaries
- Artifact search and management
- Add, view, edit, delete, search, sort, and paginate database records
- SQL reports using joins, filtering, grouping, aggregate functions, and subqueries
- Stored procedures, functions, and trigger demonstrations
- Interactive database feature demonstrations
- User management for Admin accounts
- MongoDB Studio with five separate document collections
- Dynamic MongoDB forms for entering collection-specific information

## 3. Technologies Used

| Component | Technology |
|---|---|
| Frontend | Next.js, React, TypeScript, HTML, CSS |
| Backend | Next.js API Route Handlers |
| Relational database | MySQL 8.x |
| NoSQL database | MongoDB |
| MySQL driver | mysql2 |
| MongoDB driver | MongoDB Node.js Driver |
| Authentication | bcryptjs and HTTP-only session cookies |
| Language | TypeScript |

## 4. MongoDB Collections

The application includes five MongoDB collections:

| Collection | Purpose |
|---|---|
| `artifact_research` | Stores research findings, notes, and references related to museum artifacts. |
| `conservation_observations` | Stores artifact condition reports, observations, and conservation recommendations. |
| `historical_references` | Stores historical sources, archival references, citations, and related information. |
| `exhibition_feedback` | Stores visitor feedback, exhibition ratings, and suggestions. |
| `digital_documentation` | Stores digital asset information, file details, and documentation records. |

Each collection has its own data-entry form with fields appropriate to that collection.

MongoDB documents can contain different fields, demonstrating the flexible document structure of a NoSQL database. The application adds metadata such as creation time, update time, and the user who created the document.

Collections are created automatically when the first document is saved.

## 5. Requirements

Install the following before running the project:

1. Node.js (LTS version recommended)
2. npm (included with Node.js)
3. MySQL Server 8.x
4. MongoDB Community Server
5. Visual Studio Code (recommended)

Make sure both MySQL and MongoDB services are running before starting the application.

## 6. Setup and Run on Windows

### Step 1: Extract and open the project

1. Download the project ZIP file.
2. Extract it to your preferred location.
3. Open the extracted project folder in Visual Studio Code.
4. Open the inner `digital_museum_next` folder — the folder containing `package.json`.

### Step 2: Configure environment variables

In the project folder, locate `.env.example`.

Create a copy and rename it to:

`.env.local`

Open `.env.local` and configure the database connections:

```env
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=YOUR_MYSQL_PASSWORD
MYSQL_DATABASE=digital_museum_dbs

MONGODB_URI=mongodb://127.0.0.1:27017
MONGODB_DATABASE=digital_museum

SESSION_SECRET=replace-with-a-long-random-secret-at-least-32-characters
SETUP_SECRET=replace-with-a-one-time-setup-secret
```

Replace `YOUR_MYSQL_PASSWORD` with your actual MySQL password.

### Step 3: Install dependencies

Open the VS Code terminal:

**Terminal → New Terminal**

If PowerShell blocks npm commands, run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Then install the project dependencies:

```powershell
npm install
```

Wait until the installation finishes.

### Step 4: Set up the MySQL database

Make sure your MySQL Server is running.

If you are setting up the project for the first time, create the database in MySQL Workbench:

```sql
CREATE DATABASE digital_museum_dbs;
USE digital_museum_dbs;
```

Run the SQL files in the following order:

1. `database/schema.sql` — creates the relational database tables.
2. `database/data.sql` — inserts sample museum records.
3. `database/routines.sql` — creates the stored procedures, functions, and triggers.

Execute each file in MySQL Workbench after selecting the correct database.

**Important:** If you already have the project database and records, do not run the setup scripts again without checking their contents and the existing database state. Avoid creating duplicate tables or losing existing data.

### Step 5: Set up MongoDB

1. Start MongoDB Server.
2. Open MongoDB Compass, if installed.
3. Connect using:

```text
mongodb://127.0.0.1:27017
```

4. The application uses the database named `digital_museum`.
5. MongoDB collections are created automatically when documents are first saved through MongoDB Studio.

No manual collection creation is required.

### Step 6: Start the application

In the VS Code terminal, run:

```powershell
npm run dev
```

Wait for Next.js to display the local application address.

For example:

```text
Local: http://localhost:3000
```

Keep the terminal open while using the application.

### Step 7: Open the application

Open your browser and visit the local address displayed in the terminal.

For example:

[http://localhost:3000](http://localhost:3000)

Sign in using the administrator account created through the initial setup process.

## 7. Application Modules

The application includes the following modules:

- **Overview:** Displays the museum dashboard and summary information.
- **Artifacts:** Provides artifact-related management features.
- **Database Studio:** Provides access to relational database operations.
- **DB Features:** Demonstrates database features such as triggers and other SQL operations.
- **User Management:** Allows administrators to manage user accounts.
- **MongoDB Studio:** Provides separate forms for adding and viewing documents in the five MongoDB collections.

## 8. Running the Project

Whenever you want to run the application again:

1. Start MySQL Server.
2. Start MongoDB Server.
3. Open the project folder in VS Code.
4. Open the terminal.
5. Run:

```powershell
npm run dev
```

6. Open the local URL displayed in the terminal.

To stop the application, press `Ctrl + C` in the terminal.


## 9. Security Features

- Password hashing using bcryptjs.
- HTTP-only session cookies.
- Role-based access for Admin and Staff users.
- Database credentials configured through environment variables.
- Separate setup secret for initial administrator creation.

