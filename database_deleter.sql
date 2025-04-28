DROP TABLE IF EXISTS hotel_phone_num CASCADE;
DROP TABLE IF EXISTS hotel_chain_phone_num CASCADE;
DROP TABLE IF EXISTS hotel_chain CASCADE;
DROP TABLE IF EXISTS hotel CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS manager CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS renting CASCADE;
DROP TABLE IF EXISTS booking CASCADE;
DROP TABLE IF EXISTS makes CASCADE;
DROP TABLE IF EXISTS archives CASCADE;
DROP TABLE IF EXISTS transforms_br CASCADE;
DROP TABLE IF EXISTS creates CASCADE;
DROP TABLE IF EXISTS rooms CASCADE;

DROP TRIGGER IF EXISTS check_email ON customer;
DROP TRIGGER IF EXISTS check_email ON hotel;
DROP TRIGGER IF EXISTS check_email ON hotel_chain;
DROP TRIGGER IF EXISTS check_email ON employee;

DROP TRIGGER IF EXISTS check_address ON customer;
DROP TRIGGER IF EXISTS check_address ON hotel;
DROP TRIGGER IF EXISTS check_address ON hotel_chain;
DROP TRIGGER IF EXISTS check_address ON employee;

DROP TRIGGER IF EXISTS archive_booking ON booking;
DROP TRIGGER IF EXISTS archive_renting ON booking;

DROP TRIGGER IF EXISTS deleting_booking ON renting;
-- Drop the unique_email function
DROP FUNCTION IF EXISTS unique_email();
DROP FUNCTION IF EXISTS unique_address();


-- Drop the archive_booking function
DROP FUNCTION IF EXISTS archive_booking();
DROP FUNCTION IF EXISTS archive_renting();


-- Drop the deleting_booking function
DROP FUNCTION IF EXISTS deleting_booking();