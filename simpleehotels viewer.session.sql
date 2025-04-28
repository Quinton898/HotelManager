--INSERT INTO customer (ssn, name, address, registration_date) VALUES (123456789, 'John Doe', '123 Main St', '2018-01-01');
--SELECT * FROM customer WHERE customer.ssn='123456766';
--Select *
--From rooms
--Where (address, room_num) in(
--	SELECT address, room_num
--	From renting
--	Where current_date>= start_date and end_date>= current_date
--) or (address, room_num) in(
--	SELECT address, room_num
--	From booking
--	Where current_date>= start_date and end_date>= current_date
--);

--SELECT MAX(CAST(SUBSTRING(booking_id, 2, 10) AS INTEGER)) AS max_booking_number
--FROM archive;
--WHERE booking_id ~ '^b\\d{9}$';
--SELECT * FROM hotel_chain;

--SELECT * FROM rooms
--    WHERE (address, room_num) NOT IN (
--        SELECT address, room_num
--        FROM renting 
--        WHERE ((start_date BETWEEN '2025-04-05' AND '2025-04-09')
--            OR (end_date BETWEEN '2025-04-05' AND '2025-04-09'))
--    ) AND (address, room_num) NOT IN (
--        SELECT address, room_num
--        FROM booking 
--        WHERE ((start_date BETWEEN '2025-04-05' AND '2025-04-09')
--            OR (end_date BETWEEN '2025-04-05' AND '2025-04-09')));

--SELECT MAX(CAST(SUBSTRING(booking_id, 2, 10) AS INTEGER)) AS max_booking_number FROM archives;
--CREATE OR REPLACE FUNCTION archive_renting()
--RETURNS TRIGGER AS
--$BODY$
--BEGIN
    -- Insert the booking into the archives table
--    INSERT INTO archives(archive_ID, start_time, end_time, price, customer_ssn, archive_type,renting_ID)
--    VALUES (
--        NEW.renting_ID,        -- Use the booking ID as the archive ID
--        NEW.start_date,        -- Start time of the booking
--        NEW.end_date,          -- End time of the booking
--        NEW.price,             -- Price of the booking
--        NEW.customer_ssn,      -- Customer SSN
--        'booking',             -- Archive type is 'booking'
--        NEW.renting_ID         -- Booking ID
--    );

--    RETURN NEW;
--END;
--$BODY$ LANGUAGE plpgsql;

--Create Trigger archive_renting
--After Insert on renting
--For Each Row
--Execute Procedure archive_renting();

--INSERT INTO rooms (room_num, address, price, amenities, capacity, view_type, damages, extendible) VALUES (999, '10 Madison Ave, New York, NY', 71.23, 'TV, WiFi, Mini-bar, Air Conditioning, Balocny, Pool', 'suite', 'sea', 'None', true)
INSERT INTO customer (ssn, name, address, registration_date) VALUES (464779684, 'Nancy Locking', '123 Grey Rd', '2023-07-12');
