# TechCart Travel Booking Site

## Overview
An ASP.NET web application for booking travel destinations, built with a SQL Server database (`TechCart_TravelDB`). Users can browse destinations, add them to a cart, and make bookings. Supports admin and customer roles with secure password handling.


## Setup
## Prerequisites:

Install Visual Studio 2022 with ASP.NET and web development workload.

Install SQL Server (Express or Developer) and SQL Server Management Studio (SSMS).

Install Git.

Ensure .NET SDK (e.g., .NET 6 or later) is installed.

1. **Clone Repository**:
   ```bash
   git clone https://github.com/greeshmaprasad72/Group1_Project_ASPNET_Travel_Booking.git

	- 
## Adding a New WebForm

To add a new WebForm (e.g., for managing destinations or bookings):


## Create WebForm:

In Solution Explorer, right-click project > Add > New Item.



Select Web Form with Master Page (or Web Form if no Master Page).



Name it (e.g., Destinations.aspx) and select Site.Master if prompted.

## Import Database:


Open SSMS and connect to your SQL Server instance.

## Create a new database named TechCart_TravelDB:

In SSMS, right-click Databases > New Database, enter TechCart_TravelDB, and click OK.


## Import the database schema and sample data:

Open TechCart_TravelDB.sql (in project root) in SSMS.

Execute the script (F5) to create tables and insert sample data.



## Design WebForm:

Open <WebForm>.aspx (e.g., Destinations.aspx).


Add controls (e.g., GridView for data display, TextBox/DropDownList for input).

## Database Schema
- **Categories**: Stores travel categories (e.g., Adventure, Cultural, Beach).
  - `CategoryID`: INT, PK, Auto-increment
  - `CategoryName`: VARCHAR(50), Not Null
  - `Description`: VARCHAR(200), Nullable
- **Destinations**: Stores travel destinations (e.g., Bali, Paris).
  - `DestinationID`: INT, PK, Auto-increment
  - `Destination`: VARCHAR(100), Not Null
  - `Description`: VARCHAR(500), Not Null
  - `Price`: DECIMAL(10,2), Not Null
  - `AvailableSeats`: INT, Not Null
  - `CategoryID`: INT, FK (Categories)
  - `DepartureDate`: DATETIME, Not Null
  - `ReturnDate`: DATETIME, Nullable
  - `ImageURL`: VARCHAR(255), Nullable
- **Users**: Stores user accounts with hashed passwords.
  - `UserID`: INT, PK, Auto-increment
  - `Username`: VARCHAR(50), Not Null, Unique
  - `Email`: VARCHAR(100), Not Null, Unique
  - **Password**: VARCHAR(256), Not Null (hashed)
  - `Role`: VARCHAR(20), Not Null, Default 'Customer'
  - `CreatedAt`: DATETIME, Not Null
- **Bookings**: Stores booking details.
  - `BookingID`: INT, PK, Auto-increment
  - `UserID`: INT, FK (Users)
  - `DestinationID`: INT, FK (Destinations)
  - `BookingDate`: DATETIME, Not Null
  - `TotalAmount`: DECIMAL(10,2), Not Null
  - `Status`: VARCHAR(20), Not Null
  - `NumTravelers`: INT, Not Null
- **Cart**: Stores cart items before booking.
  - `CartID`: INT, PK, Auto-increment
  - `UserID`: INT, FK (Users)
  - `DestinationID`: INT, FK (Destinations)
  - `NumTravelers`: INT, Not Null
  - `AddedDate`: DATETIME, Not Null