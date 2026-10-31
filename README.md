# Digital-Museum-Artifact-Restoration-Management-System-
DBMS project - Digital Museum Artifact &amp; Restoration Management System 

A DBMS academic project for managing museum collections, artifacts, exhibitions, visitors, staff, and artifact restoration activities.

The system has three connected parts:

- **Frontend:** HTML, CSS, and JavaScript
- **Backend:** Python with Flask (serves the frontend and provides API endpoints)
- **Database:** MySQL

## 1. Main features

- Staff login with password hashing and session-based authentication
- Dashboard with museum and collection summaries
- Artifact search, filtering, and detailed artifact information
- Add, view, edit, delete, search, sort, and paginate records across the database tables
- SQL reports using filtering, joins, grouping, aggregate functions, and subqueries
- Stored procedure, function, and trigger demonstrations
- Restoration project, expert, material, condition assessment, and artifact history management

## 2. Technologies used

| Part | Technology |
|---|---|
| Frontend | HTML5, CSS3, JavaScript |
| Backend | Python, Flask |
| Database | MySQL 8.x |
| Database driver | PyMySQL |

## 3. Requirements

Install the following before running the project:

1. Python 3.9 or later
2. MySQL Server 8.x

Make sure the MySQL Server service is running before starting the application.

## 4. Setup and run on Windows

Open **PowerShell** in the project folder, then follow these steps.

### Step 1: Open the application folder

If PowerShell is already in the repository's main folder:

```powershell
cd digital_museum
```

### Step 2: Create a Python virtual environment

```powershell
python -m venv venv
```

### Step 3: Activate the virtual environment

```powershell
.\venv\Scripts\Activate.ps1
```

If PowerShell blocks activation because of the execution policy, run this command for the current terminal only and activate again:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\venv\Scripts\Activate.ps1
```

### Step 4: Install the required Python packages

```powershell
python -m pip install --upgrade pip
pip install -r requirements.txt
```

### Step 5: Configure the MySQL connection

The default configuration uses:

- Host: `localhost`
- Port: `3306`
- User: `root`
- Database: `digital_museum_db`

Set the password to the password configured for your local MySQL user. In PowerShell, for the current terminal session, run:

```powershell
$env:MUSEUM_DB_HOST = "localhost"
$env:MUSEUM_DB_PORT = "3306"
$env:MUSEUM_DB_USER = "root"
$env:MUSEUM_DB_PASSWORD = "YOUR_MYSQL_PASSWORD"
$env:MUSEUM_DB_NAME = "digital_museum_db"
$env:MUSEUM_SECRET_KEY = "replace-with-a-long-random-secret"
```

Replace `YOUR_MYSQL_PASSWORD` with your actual MySQL password.

### Step 6: Create and populate the database

Ensure MySQL is running, then execute:

```powershell
python init_db.py
```

This script creates the database, tables, sample records, triggers, functions, and stored procedures.

**Important:** `init_db.py` drops and recreates the database named in your configuration. Running it again deletes the existing data in that database and restores the sample data. Do not run it if you need to preserve changes made in the application.

If MySQL reports an error mentioning `log_bin_trust_function_creators`, connect to MySQL as an administrator and run:

```sql
SET GLOBAL log_bin_trust_function_creators = 1;
```

Then run `python init_db.py` again.

### Step 7: Start the Flask application

```powershell
python app.py
```

Keep this PowerShell window open while using the application. Flask should report that it is running on port `5000`.

### Step 8: Open the application

Open a browser and visit:

**http://localhost:5000**

Log in using one of the sample staff accounts:

| Username | Password |
|---|---|
| `anita.rao` | `anita123` |
| `rahul.sharma` | `rahul123` |
| `kiran.kumar` | `kiran123` |

