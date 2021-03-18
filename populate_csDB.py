from faker import Faker
import random

fake = Faker()

##########CONSTANTS##########
noOfUsers = 200
noOfLocations = 4
visits_leaves_entries = 125
output_filename = "records.sql"
#############################

records = open(output_filename, "w") #creates/opens file to be overwritten

##############populate user table##############
print("Writing insert statements for the user table to {} ...".format(output_filename))
records.write("/***************POPULATE USER TABLE***************/\n")
for i in range(noOfUsers):
    user_id = 'USR' + str(i)
    username = fake.simple_profile()['username'] #tentative

    records.write("INSERT INTO user VALUES ('{}', '{}');\n".format(user_id, username))
records.write("\n")
print("SUCCESS\n")
################################################


############################populate visits and leaves tables############################
print("Writing insert statements for the visits and leaves tables to {} ...".format(output_filename))
records.write("/***************POPULATE VISITS AND LEAVES TABLES***************/\n")
for i in range(visits_leaves_entries):
    user_id = 'USR' + str(random.randint(0, noOfUsers-1))
    location_id = 'LOC' + str(random.randint(0, noOfLocations-1))
    time_visited = fake.date_time_this_month()

    minutesSpent = random.randint(10, 180)
    hours = minutesSpent//60
    remMinutes = minutesSpent%60

    time_left = time_visited

    ###################applying the time spent to the arrival time###################
    #Adding minutes
    if (time_left.minute + remMinutes) >= 60:
        time_left = time_left.replace(minute = (time_left.minute + remMinutes) - 60)
        hours += 1
    else:
        time_left = time_left.replace(minute = (time_left.minute + remMinutes))

    #Adding hours
    if (time_left.hour + hours) >= 24:
        time_left = time_left.replace(hour = (time_left.hour + hours) - 24)
    else:
        time_left = time_left.replace(hour = (time_left.hour + hours))
    ##################################################################################

    
    records.write("INSERT INTO visits VALUES ('{}', '{}', '{}');\n".format(user_id, location_id, time_visited))
    records.write("INSERT INTO leaves VALUES ('{}', '{}', '{}');\n".format(user_id, location_id, time_left))
    records.write("\n")
print("SUCCESS")
############################################################################################


records.close()