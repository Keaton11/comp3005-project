# COMP 3005: Final Project
### Keaton Lee (101229189)

**Demonstration Video:** https://youtu.be/rcHTqEKPCi0

## Submission Structure

```
└── comp3005-project
    ├── SQL
    ├── application
    │   ├── app
    │   │   ├── assets
    │   │   │   ├── config
    │   │   │   ├── images
    │   │   │   └── stylesheets
    │   │   ├── channels
    │   │   │   └── application_cable
    │   │   ├── controllers
    │   │   │   ├── concerns
    │   │   │   └── users
    │   │   ├── helpers
    │   │   │   └── users
    │   │   ├── javascript
    │   │   │   └── controllers
    │   │   ├── jobs
    │   │   ├── mailers
    │   │   ├── models
    │   │   │   └── concerns
    │   │   └── views
    │   │       ├── availabilities
    │   │       ├── bills
    │   │       ├── completed_exercise_routines
    │   │       ├── devise
    │   │       ├── equipment
    │   │       ├── exercise_routines
    │   │       ├── exercises
    │   │       ├── fitness_class_equipments
    │   │       ├── fitness_class_exercise_routines
    │   │       ├── fitness_class_members
    │   │       ├── fitness_classes
    │   │       ├── fitness_goals
    │   │       ├── home
    │   │       ├── layouts
    │   │       ├── members
    │   │       ├── rooms
    │   │       ├── staffs
    │   │       ├── trainers
    │   │       └── users
    │   ├── bin
    │   ├── config
    │   │   ├── environments
    │   │   ├── initializers
    │   │   └── locales
    │   ├── db
    │   │   └── migrate
    │   ├── lib
    │   │   ├── assets
    │   │   └── tasks
    │   ├── log
    │   ├── node_modules
    │   ├── public
    │   ├── storage
    │   ├── test
    │   │   ├── channels
    │   │   │   └── application_cable
    │   │   ├── controllers
    │   │   │   └── users
    │   │   ├── fixtures
    │   │   │   └── files
    │   │   ├── helpers
    │   │   ├── integration
    │   │   ├── mailers
    │   │   ├── models
    │   │   └── system
    │   ├── tmp
    │   │   ├── cache
    │   │   │   ├── assets
    │   │   │   └── bootsnap
    │   │   ├── pids
    │   │   ├── sockets
    │   │   └── storage
    │   └── vendor
    │       └── javascript
    └── diagrams
```

## Steps to Compile and Run Application

### Prerequisites
Ruby (version 3.3.0 or later), Rails (version 7.1.3 or later), and PostgreSQL must be installed before running this application. The installation process for each of these components varies per system, but detailed instructions can usually be found in their respective documentation.
- Ruby Installation Guide: https://www.ruby-lang.org/en/documentation/installation/
- Rails Installation Guide: https://guides.rubyonrails.org/getting_started.html

### Setup Instructions

#### 1. Clone the Project
Run `dev clone https://github.com/Keaton11/comp3005-project.git`.

#### 2. Install Dependencies
Open your terminal and navigate to the `application` directory. Run the following command to install the necessary Ruby gems:

```bash
bundle install
```

#### 3. Configure Database
Configure database settings under `application/config/database.yml` to point to your PostgreSQL instance.

#### 4. Create and Migrate the Database**:
From the `application` directory, create the database and run migrations by running the following commands:

```bash
rails db:create
rails db:migrate
```

*Note:* The database can be cleaned using the command `rake db:clean`, or cleaned and re-seeded using the command `rails db:seed:replant`.

#### 7 Run the Server
Start the Rails server by running:

```bash
rails server
```

This will start the application on `localhost:3000` by default. It can then be accessed by going to `http://localhost:3000` in your web browser.

## Steps to Execute DDL and DML Files 

*Note:* These steps demonstrate how the database could be setup manually using pgAdmin 4. However, these steps are not necessary given that Ruby on Rails handles database setup and seeding. The professor confirmed that it is sufficient to provide the SQL files to demonstrate knowledge but not actually use them as part of the set up process.

### 1. Open pgAdmin 4
- Begin by opening pgAdmin 4.
- This application will likely be opened from your applications menu or desktop shortcut.
- Once opened, the pgAdmin 4 dashboard will be visible.

### 2. Connect to a PostgreSQL Server
- In the Browser pane on the left side, click on the "Servers" dropdown menu.
- Select the "PostgreSQL" server from this dropdown.
- Enter your password as prompted then click "OK" to continue.

### 3. Create a New Database
- Right click on "Databases" under the "PostgreSQL" server.
- Select "Create" > "Database...".
- Enter a name for the database. For the name, use "COMP3005".
    - Note that another name can be used, but the following steps will assume the database is named "COMP3005".
- Click "Save" to create the database.

### 4. Open Query Tool
- After creating the database, navigate to it by expanding the "Databases" tree.
- Navigate to the "COMP3005" database and click on it to select it. 
- Right-click on the "COMP3005" database and select "Query Tool" to open the SQL editor.

### 5. Copy DDL Commands
- Click the "Open File" button and select the file "DDL.sql" under the "SQL" directory.
- Alternatively, copy and paste the SQL commands located in "SQL/DDL.sql".
    - Under the "SQL" directory, open the file "DDL.sql".
    - Select and copy all contents of the file.
    - In the Query Tool, paste the copied SQL commands.
- These SQL commands will create the student table and insert the provided data.

### 6. Execute the DDL Query
- After pasting the SQL code, the query can be run by clicking the "Execute/Refresh" button.
- This will run the entered SQL commands and populate the database accordingly.

### 7. Copy DML Commands
- Click the "Open File" button and select the file "DML.sql" under the "SQL" directory.
- Alternatively, copy and paste the SQL commands located in "SQL/DML.sql".
    - Under the "SQL" directory, open the file "DML.sql".
    - Select and copy all contents of the file.
    - In the Query Tool, paste the copied SQL commands.
- These SQL commands will create the student table and insert the provided data.

### 8. Execute the DML Query
- After pasting the SQL code, the query can be run by clicking the "Execute/Refresh" button.
- This will run the entered SQL commands and populate the database accordingly.
