import random
####### You need to install psycopg2 package to run this script. You can install it using pip install psycopg2 #######
####### Command: py -m pip install psycopg2-binary
####### Command to run the script: py addRooms.py #######
import psycopg2  # or use MySQL connector if using MySQL

# Database connection setup
conn = psycopg2.connect(
    host="localhost", 
    port="5432", 
    dbname="simpleehotels",
    user="postgres",
    password="postgres",
    )
cursor = conn.cursor()

# Fetch all hotel addresses
cursor.execute("SELECT address FROM hotel;")
hotels = [row[0] for row in cursor.fetchall()]

# Room attributes options
capacities = ['single', 'double', 'queen', 'double queen', 'suite']
view_types = ['sea', 'mountain']
amenities_list = ['WiFi', 'TV', 'Mini-bar', 'Air Conditioning', 'Balcony', 'Safe']
damage_options = ["None", "Scratch on wall", "Broken lamp", "Water stain on ceiling"]

# Generate and insert rooms for each hotel
for hotel in hotels:
    numRooms = random.randint(5, 15)
    for roomNum in range(1, numRooms + 1):
        price = round(random.uniform(50, 500), 2)  # Price between $50 and $500
        capacity = random.choice(capacities)
        view_type = random.choice(view_types)
        amenities = ", ".join(random.sample(amenities_list, k=random.randint(2, 4)))  # 2 to 4 random amenities
        damages = random.choice(damage_options)  # May be None (no damage)
        extendible = random.choice([True, False])  # Boolean

        # Insert the room into the database
        cursor.execute("""
            INSERT INTO rooms (room_num, address, price, amenities, capacity, view_type, damages, extendible)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
        """, (roomNum, hotel, price, amenities, capacity, view_type, damages, extendible))

# Commit and close connection
conn.commit()
cursor.close()
conn.close()

print("Rooms successfully added to all hotels.")
