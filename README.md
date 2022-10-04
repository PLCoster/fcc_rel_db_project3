# Free Code Camp: Relational Database Project 3

## Salon Appointment Scheduler

The aim of this project was to create an interactive Salon Appointment Scheduling program using a PostgreSQL database to store customers and appointments.

### Project Requirements:

- **User Story #1:** You should create a database named `salon`

- **User Story #2:** You should connect to your database, then create tables named `customers`, `appointments`, and `services`

- **User Story #3:** Each table should have a primary key column that automatically increments

- **User Story #4:** Each primary key column should follow the naming convention, `table_name_id`. For example, the `customers` table should have a `customer_id` key. Note that there’s no `s` at the end of `customer`

- **User Story #5:** Your `appointments` table should have a `customer_id` foreign key that references the `customer_id` column from the `customers` table

- **User Story #6:** Your `appointments` table should have a `service_id` foreign key that references the `service_id` column from the `services` table

- **User Story #7:** Your `customers` table should have `phone` that is a `VARCHAR` and must be unique

- **User Story #8:** Your `customers` and `services` tables should have a `name` column

- **User Story #9:** Your `appointments` table should have a `time` column that is a `VARCHAR`

- **User Story #10:** You should have at least three rows in your `services` table for the different services you offer, one with a `service_id` of `1`

- **User Story #11:** You should create a script file named `salon.sh` in the `project` folder

- **User Story #12:** Your script file should have a “shebang” that uses bash when the file is executed (use `#! /bin/bash`)

- **User Story #13:** Your script file should have executable permissions

- **User Story #14:** You should not use the `clear` command in your script

- **User Story #15:** You should display a numbered list of the services you offer before the first prompt for input, each with the format `#) <service>`. For example, `1) cut`, where `1` is the `service_id`

- **User Story #16:** If you pick a service that doesn't exist, you should be shown the same list of services again

- **User Story #17:** Your script should prompt users to enter a `service_id`, phone number, a name if they aren’t already a customer, and a time. You should use `read` to read these inputs into variables named `SERVICE_ID_SELECTED`, `CUSTOMER_PHONE`, `CUSTOMER_NAME`, and `SERVICE_TIME`

- **User Story #18:** If a phone number entered doesn’t exist, you should get the customers name and enter it, and the phone number, into the `customers` table

- **User Story #19:** You can create a row in the `appointments` table by running your script and entering `1`, `555-555-5555`, `Fabio`, `10:30` at each request for input if that phone number isn’t in the `customers` table. The row should have the `customer_id` for that customer, and the `service_id` for the service entered

- **User Story #20:** You can create another row in the `appointments` table by running your script and entering `2`, `555-555-5555`, `11am` at each request for input if that phone number is already in the `customers` table. The row should have the `customer_id` for that customer, and the `service_id` for the service entered

- **User Story #21:** After an appointment is successfully added, you should output the message `I have put you down for a <service> at <time>, <name>.` For example, if the user chooses `cut` as the service, `10:30` is entered for the time, and their name is `Fabio` in the database the output would be `I have put you down for a cut at 10:30, Fabio.` Make sure your script finishes running after completing any of the tasks above, or else the tests won't pass

### Project Writeup:

The third Free Code Camp: Relational Database project is an interactive Salon Appointment Booking script. Upon running the script, users can:

- Select desired service from a list of services (defined in the salon database)
- Enter a phone number as a unique identifier of the customer.
  - If the user is already registered with the salon, then they will be greeted by their name, otherwise their information will be requested to register a new user as a customer.
- Input their desired appointment time. The appointment information is then stored in the salon database.

### Usage

The database can be interacted with using `psql` in linux. First start up a PostgreSQL server using:

`$sudo service postgresql start`

The salon database should then be loaded from the `salon.sql` file using:

`$psql --dbname=postgres < salon.sql`

Optionally the database can be interacted with directly using:

`$psql --dbname=postgres`

Once loaded, the bash script can be run for the Salon appointment booker. (Note that you will have to change the `--username=freecodecamp` option on line 4 of the script to your linux username or remove this entirely):

`$./salon.sh`

Save a dump of the live database using:

`$pg_dump -cC --inserts salon > salon.sql`

Instructions for building the project can be found at https://www.freecodecamp.org/learn/relational-database/build-a-salon-appointment-scheduler-project/build-a-salon-appointment-scheduler
