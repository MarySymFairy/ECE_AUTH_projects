import serial
import numpy as np
import limeguinew as lg
import time

# Initialise arduino serial
arduino_Serial_Data = serial.Serial('COM7',9600)

# Initialise previous status for spots
global prev_status
prev_status = ['E', 'E', 'E', 'E']

# --------Function Definitions------------

# Update status detects status change and updates gui labels
def update_status(status, spot="spot3"):

    if status == "E":
        print("State of spot changed to empty!")
        occupancy="Empty"
        vehicleType, vehiclePlate="-","-"

        # Change color of spot lights
        lg.canvas.itemconfig(getattr(lg, spot+"_red"), fill="red")
        lg.canvas.itemconfig(getattr(lg, spot+"_green"), fill="grey70")
        lg.canvas.itemconfig(getattr(lg, spot+"_yellow"), fill="grey70")
        
    else: # Spot is full
        print("State of spot changed to Full!")
        occupancy="Full"

        # Get customer information from array 
        filtered_rows = customers[np.where(customers[:, 0] == status)]

        if filtered_rows.size > 0: # Spot full registered customer 
            row_values = filtered_rows[0]  # Assuming you want to extract values from the first matching row
            id, vehicleType, vehiclePlate = row_values  # Assign values to variables
        
            # Change color of spot lights
            lg.canvas.itemconfig(getattr(lg, spot+"_red"), fill="grey70")
            lg.canvas.itemconfig(getattr(lg, spot+"_green"), fill="limegreen")
            lg.canvas.itemconfig(getattr(lg, spot+"_yellow"), fill="grey70")
        
        else: # Spot full customer unknown 
            # TODO: change color, or flash
            print("Customer ID unknown.")
            vehicleType, vehiclePlate = "UNKNOWN","UNKNOWN"

            # Change color of spot lights
            lg.canvas.itemconfig(getattr(lg, spot+"_red"), fill="grey70")
            lg.canvas.itemconfig(getattr(lg, spot+"_green"), fill="grey70")
            lg.canvas.itemconfig(getattr(lg, spot+"_yellow"), fill="yellow")
    
    # Update canvas text
    lg.canvas.itemconfig(getattr(lg, spot+"_status"), text=occupancy)
    lg.canvas.itemconfig(getattr(lg, spot+"_plate"), text=vehiclePlate)
    lg.canvas.itemconfig(getattr(lg, spot+"_type"), text=vehicleType)

    print("Status for", spot, ":", occupancy)
    print("Type for", spot, ":", vehicleType)
    print("Plate for", spot, ":", vehiclePlate)

#---------------------------------------------------

# Define customer database
customers=np.array([[" 53 03 31 0f","F1 CAR","V12F1"],
                    [2,"SEDAN","NHK5678"],
                    [3,"VAN","AXX7890"],
                    [4,"PICKUP","EEE1594"],
                    [5,"CARAVAN","HAK7568"],])

# Main Loop
while True:
    if (arduino_Serial_Data.inWaiting()>0):
        myData = str(arduino_Serial_Data.readline())

        # Start indexes for spot data and end delimiter
        s1_start=int(myData.find("S1:"))
        s2_start=int(myData.find(",S2:"))
        s3_start=int(myData.find(",S3:"))
        s4_start = int(myData.find(",S4:"))
        end=int(myData.find(",end"))

        # Slice data for every spot
        s1_status = myData[s1_start + len("S1:"):s2_start]
        s2_status = myData[s2_start + len(",S2:"):s3_start]
        s3_status = myData[s3_start + len(",S3:"):s4_start]
        s4_status = myData[s4_start + len(",S4:"):end]
        
        # Save spot status in list
        spot_status=[s1_status, s2_status, s3_status, s4_status]
        
        # Print status in terminal
        print("['S1','S2','S3','S4']")
        print(spot_status)
        print("Spots occupied:",end="")
        print(str(len(spot_status) - spot_status.count("E")))
        print()

        # Update total cars count
        lg.canvas.itemconfig(lg.total_cars_count, text=str(len(spot_status) - spot_status.count("E")))
        
        # Check if status has changed for any spot and update accordingly
        for i in range(len(spot_status)):
            if spot_status[i] != prev_status[i]:
                update_status(spot_status[i], "spot"+str(i+1))

        # Update prev_s3_status for next iteration
        prev_status = spot_status

        # Update GUI
        lg.window.update()
        
        # Call main loop again after 0.5 seconds
        time.sleep(0.2)





