--ipAddress = "localhost";
--dbServerPort = "5432";
--dbName = "simpleehotels";
--dbUsername = "postgres";
--dbPassword = "postgres";


CREATE TABLE hotel_chain(
    address VARCHAR(255) PRIMARY KEY,
	name VARCHAR(100) NOT NULL Unique,
    email VARCHAR(255) NOT NULL,
    num_of_hotels INT NOT NULL
);

CREATE TABLE hotel(
    address VARCHAR(255) PRIMARY KEY,
    num_of_rooms INT NOT NULL CHECK (num_of_rooms > 0),
    email VARCHAR(50) NOT NULL,
    stars INT CHECK (stars BETWEEN 1 AND 5) NOT NULL,
    chain_address VARCHAR(255) NOT NULL,
    FOREIGN KEY (chain_address) REFERENCES hotel_chain(address) ON DELETE CASCADE
);

CREATE TABLE rooms (
	room_num INT CHECK(room_num>0),
	address VARCHAR(255),
 	price DECIMAL(10,2) NOT NULL,
	amenities VARCHAR(100) NOT NULL,
 	capacity VARCHAR(12) CHECK(capacity IN ('single', 'double', 'queen', 'double queen', 'suite')) NOT NULL,
 	view_type VARCHAR(8) CHECK(view_type IN ('sea', 'mountain')) NOT NULL,
 	damages VARCHAR(255),
 	extendible BOOLEAN,
 	PRIMARY KEY(room_num, address),
 	FOREIGN KEY (address) REFERENCES hotel(address) ON DELETE CASCADE
 );

CREATE TABLE employee (
 	ssn CHAR(9) PRIMARY KEY,
 	name VARCHAR(100) NOT NULL,
 	address VARCHAR(255) NOT NULL,
 	hotel_address VARCHAR(255) ,
 	FOREIGN KEY (hotel_address) REFERENCES hotel(address) ON DELETE SET NULL
);

CREATE TABLE manager (
	ssn CHAR(9) PRIMARY KEY,
 	name VARCHAR(100) NOT NULL,
 	address VARCHAR(255) NOT NULL,
 	hotel_address VARCHAR(255),
 	FOREIGN KEY (hotel_address) REFERENCES hotel(address) ON DELETE SET NULL,
 	FOREIGN KEY (ssn) REFERENCES employee(ssn) ON DELETE CASCADE
);

CREATE TABLE customer (
 	ssn CHAR(9) PRIMARY KEY,
 	name VARCHAR(100) NOT NULL,
 	address VARCHAR(255) NOT NULL,
 	registration_date DATE CHECK (registration_date<=current_date) NOT NULL
);

 CREATE TABLE renting(
 	renting_ID VARCHAR(10) CHECK (renting_ID ~ '^r\d{9}$') PRIMARY KEY,
 	start_date DATE CHECK (start_date>=current_date) NOT NULL,
 	end_date DATE CHECK(end_date > start_date) NOT NULL,
 	price DECIMAL(10,2) NOT NULL,
 	customer_ssn CHAR(9) NOT NULL,
 	room_num INT CHECK(room_num>0) NOT NULL,
 	address VARCHAR(255) NOT NULL,
 	FOREIGN KEY (room_num, address) REFERENCES rooms(room_num, address), --made address here because it is composite primary key in rooms relation
 	FOREIGN KEY (customer_ssn) REFERENCES customer(ssn)
 );

CREATE TABLE booking(
 	booking_ID VARCHAR(10) CHECK (booking_ID ~ '^b\d{9}$') PRIMARY KEY,
 	start_date DATE CHECK (start_date>=current_date),
 	end_date DATE CHECK(end_date > start_date),
 	price DECIMAL(10,2) NOT NULL,
 	customer_ssn CHAR(9) NOT NULL,
 	room_num INT CHECK(room_num>0) NOT NULL,
 	address VARCHAR(255) NOT NULL,
	
 	FOREIGN KEY (room_num, address) REFERENCES rooms(room_num, address) ON DELETE CASCADE, --made address here because it is composite primary key in rooms relation
 	FOREIGN KEY (customer_ssn) REFERENCES customer(ssn) ON DELETE CASCADE
);

 CREATE TABLE makes(
 	ssn CHAR(9),
 	booking_ID VARCHAR(10),
 	PRIMARY KEY(ssn,booking_ID),
 	FOREIGN KEY (ssn) REFERENCES customer(ssn) ON DELETE CASCADE, --If customer deleted booking also deleted --> do we need that
 	FOREIGN KEY (booking_ID) REFERENCES booking(booking_ID) ON DELETE CASCADE --If booking deleted relationship also deleted --> do we need that
);

CREATE TABLE archives(
 	archive_ID VARCHAR(10) CHECK (archive_ID ~ '^[br]\d{9}$') PRIMARY KEY,
 	start_time DATE  NOT NULL,
 	end_time DATE  NOT NULL,
 	price DECIMAL(10,2) NOT NULL,
 	customer_SSN VARCHAR(9) NOT NULL,
 	archive_type VARCHAR(7) CHECK(archive_type IN ('renting', 'booking')) NOT NULL,
 	renting_ID VARCHAR(10) CHECK (renting_ID ~ '^[br]\d{9}$'), 
 	booking_ID VARCHAR(10) CHECK (booking_ID ~ '^[br]\d{9}$')
);

CREATE TABLE transforms_br(
 	employee_ssn CHAR(9),
 	renting_ID VARCHAR(10),
 	booking_ID VARCHAR(10),
 	FOREIGN KEY (renting_ID) REFERENCES renting(renting_ID) ON DELETE CASCADE, --If customer deleted booking also deleted --> do we need that
 	FOREIGN KEY (booking_ID) REFERENCES booking(booking_ID) ON DELETE CASCADE,
 	FOREIGN KEY (employee_ssn) REFERENCES employee(ssn) ON DELETE CASCADE,
 	PRIMARY KEY(employee_ssn,renting_ID,booking_ID)
);

CREATE TABLE creates(
 	employee_ssn CHAR(9),
 	customer_ssn VARCHAR(9),
 	renting_ID VARCHAR(10),
 	FOREIGN KEY(customer_ssn) REFERENCES customer(ssn) ON DELETE CASCADE,
 	FOREIGN KEY (renting_ID) REFERENCES renting(renting_ID) ON DELETE CASCADE, --If customer deleted booking also deleted --> do we need that
 	FOREIGN KEY (employee_ssn) REFERENCES employee(ssn) ON DELETE CASCADE,
 	PRIMARY KEY(employee_ssn,renting_ID,customer_ssn)
);


 CREATE TABLE hotel_phone_num (
    phone_num VARCHAR(15) NOT NULL CHECK (phone_num ~ '^\d{3}-\d{3}-\d{4}$'),
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY (phone_num, address), 
    FOREIGN KEY (address) REFERENCES hotel(address) ON DELETE CASCADE
);

CREATE TABLE hotel_chain_phone_num (
	phone_num VARCHAR(15) NOT NULL CHECK (phone_num ~ '^\d{3}-\d{3}-\d{4}$'),
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY (phone_num, address), 
    FOREIGN KEY (address) REFERENCES hotel_chain(address) ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION unique_email()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF TG_OP = 'INSERT' OR (TG_OP = 'UPDATE' AND NEW.email <> OLD.email) THEN
        IF EXISTS (
            SELECT email FROM hotel WHERE email = NEW.email
        )
        OR EXISTS (
            SELECT email FROM hotel_chain Where email  = NEW.email
        )
        THEN
            RAISE EXCEPTION 'Email must be unique across all tables';
        END IF;
    END IF;

    RETURN NEW;
END;
$BODY$ LANGUAGE plpgsql;




Create Trigger check_email
Before Update or Insert on hotel
For Each Row
Execute Procedure unique_email();

Create Trigger check_email
Before Update or Insert on hotel_chain
For Each Row
Execute Procedure unique_email();



CREATE OR REPLACE FUNCTION unique_address()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF TG_OP = 'INSERT' OR (TG_OP = 'UPDATE' AND NEW.address <> OLD.address) THEN
        IF EXISTS (
            SELECT address FROM hotel WHERE address = NEW.address
        )
        OR EXISTS (
            SELECT address FROM hotel_chain WHERE address = NEW.address
        )
        OR EXISTS (
            SELECT address FROM customer WHERE address = NEW.address
        )
        OR EXISTS (
            SELECT address FROM employee WHERE address = NEW.address
        ) THEN
            RAISE EXCEPTION 'Address must be unique across all tables';
        END IF;
    END IF;

    RETURN NEW;
END;
$BODY$ LANGUAGE plpgsql;



Create Trigger unique_address
Before Update or Insert on customer
For Each Row
Execute Procedure unique_address();

Create Trigger unique_address
Before Update or Insert on hotel
For Each Row
Execute Procedure unique_address();

Create Trigger unique_address
Before Update or Insert on hotel_chain
For Each Row
Execute Procedure unique_address();

Create Trigger unique_address
Before Update or Insert on employee
For Each Row
Execute Procedure unique_address();

-- This trigger makes sure all adress are unique

CREATE OR REPLACE FUNCTION archive_booking()
RETURNS TRIGGER AS
$BODY$
BEGIN
    -- Insert the booking into the archives table
    INSERT INTO archives(archive_ID, start_time, end_time, price, customer_ssn, archive_type, booking_ID)
    VALUES (
        NEW.booking_id,        -- Use the booking ID as the archive ID
        NEW.start_date,        -- Start time of the booking
        NEW.end_date,          -- End time of the booking
        NEW.price,             -- Price of the booking
        NEW.customer_ssn,      -- Customer SSN
        'booking',             -- Archive type is 'booking'
        NEW.booking_id         -- Booking ID
    );

    RETURN NEW;
END;
$BODY$ LANGUAGE plpgsql;

Create Trigger archive_booking
After Insert on booking
For Each Row
Execute Procedure archive_booking();

-- This trigger makes it so once a booking  is made an archive is created 


CREATE OR REPLACE FUNCTION archive_renting()
RETURNS TRIGGER AS
$BODY$
BEGIN
    -- Insert the booking into the archives table
    INSERT INTO archives(archive_ID, start_time, end_time, price, customer_ssn, archive_type,renting_ID)
    VALUES (
        NEW.renting_ID,        -- Use the booking ID as the archive ID
        NEW.start_date,        -- Start time of the booking
        NEW.end_date,          -- End time of the booking
        NEW.price,             -- Price of the booking
        NEW.customer_ssn,      -- Customer SSN
        'booking',             -- Archive type is 'booking'
        NEW.renting_ID         -- Booking ID
    );

    RETURN NEW;
END;
$BODY$ LANGUAGE plpgsql;

Create Trigger archive_renting
After Insert on renting
For Each Row
Execute Procedure archive_renting();


-- This trigger makes it so once a renting is made an archive is created 


CREATE OR REPLACE FUNCTION deleting_booking()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF EXISTS (
        SELECT room_num, address, start_date,end_date
        FROM booking
        WHERE room_num = NEW.room_num 
          AND address = NEW.address 
          AND start_date = NEW.start_date 
          AND end_date = NEW.end_date
    ) THEN   
       delete from booking
	   where room_num = NEW.room_num 
          AND address = NEW.address 
          AND start_date = NEW.start_date 
          AND end_date = NEW.end_date;
    END IF;
    RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;


Create Trigger deleting_booking
After insert on renting
For Each Row
Execute Procedure deleting_booking();


--This trigger deletes a booking when it is transformed into a renting.

--////////////////////////////// INPUTS ///////////////////////////////

INSERT INTO hotel_chain (address, name, email, num_of_hotels) VALUES
('500 Park Ave, New York, NY','Grand Hotels', 'info@grandhotels.com', 12),
('1200 Sunset Blvd, Los Angeles, CA','Skyline Hotels', 'contact@skylinehotels.com', 10),
('300 Ocean Dr, Miami Beach, FL','Seaside Hotels', 'support@seasidehotels.com', 9),
('800 Mountain Way, Denver, CO','Mountain Lodges', 'hello@mountainlodges.com', 8),
('950 Bayfront Rd, San Francisco, CA','Sunset Resorts', 'reservations@sunsetresorts.com', 11);

INSERT INTO hotel (address, num_of_rooms, email, stars, chain_address) VALUES
-- Grand Hotels (New York) - 12 Hotels
('10 Madison Ave, New York, NY', 50, 'madison@grandhotels.com', 5, '500 Park Ave, New York, NY'),
('250 Broadway, New York, NY', 60, 'broadway@grandhotels.com', 4, '500 Park Ave, New York, NY'),
('35 Central Park West, New York, NY', 70, 'cpw@grandhotels.com', 5, '500 Park Ave, New York, NY'),
('89 Lexington Ave, New York, NY', 55, 'lexington@grandhotels.com', 4, '500 Park Ave, New York, NY'),
('15 Fifth Ave, New York, NY', 65, 'fifth@grandhotels.com', 5, '500 Park Ave, New York, NY'),
('78 Hudson St, New York, NY', 40, 'hudson@grandhotels.com', 3, '500 Park Ave, New York, NY'),
('33 Wall St, New York, NY', 45, 'wall@grandhotels.com', 4, '500 Park Ave, New York, NY'),
('60 Riverside Dr, New York, NY', 50, 'riverside@grandhotels.com', 5, '500 Park Ave, New York, NY'),
('99 Empire State Plaza, New York, NY', 55, 'empire@grandhotels.com', 5, '500 Park Ave, New York, NY'),
('432 Park Ave, New York, NY', 75, 'park432@grandhotels.com', 5, '500 Park Ave, New York, NY'),
('21 Brooklyn Bridge Blvd, Brooklyn, NY', 65, 'brooklyn@grandhotels.com', 4, '500 Park Ave, New York, NY'),
('500 Broadway, New York, NY', 80, 'broadway500@grandhotels.com', 5, '500 Park Ave, New York, NY'),

-- Skyline Hotels (Los Angeles) - 10 Hotels
('100 Hollywood Blvd, Los Angeles, CA', 50, 'hollywood@skylinehotels.com', 4, '1200 Sunset Blvd, Los Angeles, CA'),
('555 Beverly Hills Dr, Beverly Hills, CA', 60, 'beverly@skylinehotels.com', 5, '1200 Sunset Blvd, Los Angeles, CA'),
('777 Rodeo Dr, Los Angeles, CA', 70, 'rodeo@skylinehotels.com', 4, '1200 Sunset Blvd, Los Angeles, CA'),
('888 Melrose Ave, Los Angeles, CA', 55, 'melrose@skylinehotels.com', 5, '1200 Sunset Blvd, Los Angeles, CA'),
('909 Wilshire Blvd, Los Angeles, CA', 65, 'wilshire@skylinehotels.com', 4, '1200 Sunset Blvd, Los Angeles, CA'),
('112 Sunset Plaza, Los Angeles, CA', 40, 'sunsetplaza@skylinehotels.com', 3, '1200 Sunset Blvd, Los Angeles, CA'),
('42 Vine St, Los Angeles, CA', 45, 'vine@skylinehotels.com', 5, '1200 Sunset Blvd, Los Angeles, CA'),
('25 Mulholland Dr, Los Angeles, CA', 50, 'mulholland@skylinehotels.com', 4, '1200 Sunset Blvd, Los Angeles, CA'),
('310 Pacific Coast Hwy, Malibu, CA', 60, 'malibu@skylinehotels.com', 5, '1200 Sunset Blvd, Los Angeles, CA'),
('999 Echo Park Ave, Los Angeles, CA', 75, 'echopark@skylinehotels.com', 4, '1200 Sunset Blvd, Los Angeles, CA'),

-- Seaside Hotels (Miami Beach) - 9 Hotels
('1 Ocean Dr, Miami Beach, FL', 60, 'ocean@seasidehotels.com', 5, '300 Ocean Dr, Miami Beach, FL'),
('155 Collins Ave, Miami Beach, FL', 75, 'collins@seasidehotels.com', 4, '300 Ocean Dr, Miami Beach, FL'),
('230 Bayshore Dr, Miami Beach, FL', 90, 'bayshore@seasidehotels.com', 5, '300 Ocean Dr, Miami Beach, FL'),
('305 Biscayne Blvd, Miami, FL', 65, 'biscayne@seasidehotels.com', 4, '300 Ocean Dr, Miami Beach, FL'),
('789 Palm Ave, Miami Beach, FL', 50, 'palm@seasidehotels.com', 5, '300 Ocean Dr, Miami Beach, FL'),
('600 South Beach Rd, Miami Beach, FL', 55, 'southbeach@seasidehotels.com', 4, '300 Ocean Dr, Miami Beach, FL'),
('999 Key Biscayne Blvd, Key Biscayne, FL', 70, 'keybiscayne@seasidehotels.com', 5, '300 Ocean Dr, Miami Beach, FL'),
('345 Flamingo Dr, Miami Beach, FL', 45, 'flamingo@seasidehotels.com', 3, '300 Ocean Dr, Miami Beach, FL'),
('777 Pier Ave, Miami Beach, FL', 80, 'pier@seasidehotels.com', 5, '300 Ocean Dr, Miami Beach, FL'),

-- Mountain Lodges (Denver) - 8 Hotels
('15 Alpine Way, Aspen, CO', 45, 'aspen@mountainlodges.com', 5, '800 Mountain Way, Denver, CO'),
('222 Summit Ave, Boulder, CO', 55, 'boulder@mountainlodges.com', 4, '800 Mountain Way, Denver, CO'),
('333 Snowy Peak Rd, Vail, CO', 50, 'vail@mountainlodges.com', 5, '800 Mountain Way, Denver, CO'),
('44 Pine Lodge Rd, Breckenridge, CO', 40, 'breckenridge@mountainlodges.com', 4, '800 Mountain Way, Denver, CO'),
('777 Rocky Trail, Estes Park, CO', 60, 'estespark@mountainlodges.com', 5, '800 Mountain Way, Denver, CO'),
('999 Winter Park Rd, Winter Park, CO', 70, 'winterpark@mountainlodges.com', 5, '800 Mountain Way, Denver, CO'),
('555 Bear Creek Dr, Durango, CO', 65, 'durango@mountainlodges.com', 4, '800 Mountain Way, Denver, CO'),
('808 Mountain High Rd, Telluride, CO', 55, 'telluride@mountainlodges.com', 5, '800 Mountain Way, Denver, CO'),

-- Sunset Resorts (San Francisco) - 11 Hotels
('700 Golden Gate Ave, San Francisco, CA', 60, 'goldengate@sunsetresorts.com', 5, '950 Bayfront Rd, San Francisco, CA'),
('505 Marina Blvd, San Francisco, CA', 50, 'marina@sunsetresorts.com', 4, '950 Bayfront Rd, San Francisco, CA'),
('333 Fisherman’s Wharf, San Francisco, CA', 75, 'wharf@sunsetresorts.com', 5, '950 Bayfront Rd, San Francisco, CA'),
('88 Twin Peaks Rd, San Francisco, CA', 70, 'twinpeaks@sunsetresorts.com', 4, '950 Bayfront Rd, San Francisco, CA'),
('999 Lombard St, San Francisco, CA', 55, 'lombard@sunsetresorts.com', 5, '950 Bayfront Rd, San Francisco, CA'),
('222 Pier 39, San Francisco, CA', 80, 'pier39@sunsetresorts.com', 5, '950 Bayfront Rd, San Francisco, CA'),
('777 Nob Hill Rd, San Francisco, CA', 65, 'nobhill@sunsetresorts.com', 4, '950 Bayfront Rd, San Francisco, CA'),
('420 Ocean Beach Ave, San Francisco, CA', 50, 'oceanbeach@sunsetresorts.com', 4, '950 Bayfront Rd, San Francisco, CA'),
('600 Alcatraz View Rd, San Francisco, CA', 55, 'alcatraz@sunsetresorts.com', 5, '950 Bayfront Rd, San Francisco, CA'),
('900 Castro St, San Francisco, CA', 70, 'castro@sunsetresorts.com', 4, '950 Bayfront Rd, San Francisco, CA'),
('300 Haight-Ashbury Blvd, San Francisco, CA', 45, 'haight@sunsetresorts.com', 3, '950 Bayfront Rd, San Francisco, CA');

-- ***** For Rooms Please refer to addRooms.py *****

INSERT INTO rooms (room_num, address, price, amenities, capacity, view_type, damages, extendible) VALUES (999, '10 Madison Ave, New York, NY', 71.23, 'TV, WiFi, Mini-bar, Air Conditioning, Balocny, Pool', 'suite', 'sea', 'None', true);

INSERT INTO customer (ssn, name, address, registration_date) VALUES (464779684, 'Nancy Locking', '123 Grey Rd', '2023-07-12');

INSERT INTO booking (booking_id, start_date, end_date, price, customer_ssn, room_num, address) VALUES ('b100000000', current_date, '2105-07-29', 71.23, 464779684, 999, '10 Madison Ave, New York, NY');

CREATE VIEW Available_Rooms_Per_Area AS
SELECT h.address AS area, COUNT(*) AS available_rooms
FROM rooms r
JOIN hotel h ON r.address = h.address
WHERE NOT EXISTS(
	SELECT 1 FROM booking b
	WHERE b.room_num = r.room_num AND b.address=r.address
	AND current_date BETWEEN b.start_date AND b.end_date
)

AND NOT EXISTS(
	SELECT 1 FROM renting rt
	WHERE rt.room_num = r.room_num AND rt.address = r.address
	AND current_date BETWEEN rt.start_date AND rt.end_date
)
GROUP BY h.address;

CREATE VIEW HotelRoomCapacity AS
SELECT h.address AS hotel_address, SUM(
	CASE
		WHEN r.capacity = 'single' THEN 1
		WHEN r.capacity = 'double' THEN 2
		WHEN r.capacity = 'queen' THEN 2
		WHEN r.capacity = 'double queen' THEN 4
		WHEN r.capacity = 'suite' THEN 4
		ELSE 0
	END
) AS total_capacity
FROM hotel h
JOIN rooms r ON h.address = r.address
GROUP BY h.address;

CREATE INDEX index_room_key ON rooms(room_num, address);
CREATE INDEX index_customer_ssn ON customer(ssn);
CREATE INDEX index_booking_dates ON booking(start_date, end_date);
