# Community Edition of the Matatika Platform (Beta!)

Maintained by: [Matatika](https://www.matatika.com/)

[Documentation](https://www.matatika.com/docs/) and [API reference](https://www.matatika.com/docs/api/)

Where to get help: the [Community Slack](https://meltano.com/slack)


## What is Matatika Community Edition?

[Matatika](https://www.matatika.com/) is a cloud-native data platform with CLI, API, and UI access for all.  We have integrated dbt, Meltano, and other open source technologies into a ready-to-run modern data stack.  [Read more](https://www.matatika.com/docs/concepts). 

This Community Edition is an all in one docker compose solution, and has been provided to help companies run their own solution where BOTH data engineers manage everything as code and data analysts manage data through a UI.

***NB - this is a beta release!  This edition is currently ready for beta users and would love your feedback.***


## How to get started

By installing this package you agree to the terms of our [community license](https://github.com/Matatika/matatika-docs/blob/master/CE-Licence.md).

***NB - The beta release of the Community Edition is currently only developed to work with Linux and macOS***

1. Install

   ```
   git clone https://github.com/Matatika/matatika-ce
   cd matatika-ce
   export userID=$(id -u); export groupID=$(id -g)
   docker-compose up
   ```
   In order to persist the userID and groupID variables, please add those to your .bashrc profile.
   To always be up to date with our latest changes, make sure that you run git pull to update your code from matatika-ce repository.


2. Register, login and create your first workspace

   https://localhost:3443

   Your workspaces will be created in `./workspaces` by default.  Configure this with `MATATIKA_WORKSPACES_HOME` in your docker-compose.yml


3. Configure your first pipeline

   Install `analyze-github` plugin and supply mandatory settings.

   Available plugins can be found in `./plugins` by default.  Configure this with `MATATIKA_PLUGINS_HOME` in your docker-compose.yml


4. Running your pipelines

   `analyze-github` is supplied with a default pipeline to import your data and some default datasets.


5. Share your data with the App or API

   Create new datasets in `[your-workspace]/analyze/datasets`

## Running Matatika-CE in cloud
Checkout our guide to running Matatika CE on a VM in your cloud [here](./cloud_config#readme).

## DazzleDuck Integration

This project includes DazzleDuck SQL Server with DuckLake integration, providing a high-performance remote DuckDB server that supports both Arrow Flight SQL and RESTful HTTP protocols.

### Starting DazzleDuck Services

To start the DazzleDuck services (dazzleduck, dazzleduck-frontend, and ducklake_catalog):

```bash
docker-compose up -d dazzleduck dazzleduck-frontend ducklake_catalog
```

This will start:
- **dazzleduck**: The DazzleDuck SQL Server (HTTP API on 8081, Flight SQL on 59307)
- **dazzleduck-frontend**: The web UI (port 5174)
- **ducklake_catalog**: PostgreSQL database for DuckLake catalog (port 5433)

### Services

- **DazzleDuck Server**: HTTP API (8081) and Flight SQL (59307)
- **DazzleDuck Frontend**: Web UI (5174)
- **DuckLake Catalog**: PostgreSQL database (5433)

### Connecting to DazzleDuck

1. Open your browser and navigate to: **http://localhost:5174**
2. The frontend will automatically connect to the DazzleDuck backend
3. If login is required, use:
   - Username: `admin`
   - Password: `admin`

### Sample Query

Once connected, run this sample query to test the DuckLake catalog:

```sql
SELECT * FROM ducklake_catalog.main.sample_data;
```

This will return 5 sample entries from the DuckLake catalog that were created during initialization.

### DuckLake Catalog Structure

The DuckLake catalog uses PostgreSQL as the metadata store, with data stored in Parquet files:

- **Metadata**: Stored in PostgreSQL (`ducklake_catalog` database)
- **Data**: Stored in Parquet files in `./dazzleduck_data/`
- **Tables**: Registered in the catalog with full version history via snapshots

### Access Points

- **Frontend UI**: http://localhost:5174
- **DazzleDuck HTTP API**: http://localhost:8081
- **DazzleDuck Health Check**: http://localhost:8081/health
- **Flight SQL**: grpc://localhost:59307
- **PostgreSQL Catalog**: localhost:5433
