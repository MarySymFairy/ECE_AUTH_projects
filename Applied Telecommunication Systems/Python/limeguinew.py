from pathlib import Path
from tkinter import Tk, Canvas, Entry, Text, Button, PhotoImage

def round_rectangle(x1, y1, x2, y2, radius=35, **kwargs):
        
    points = [x1+radius, y1,
              x1+radius, y1,
              x2-radius, y1,
              x2-radius, y1,
              x2, y1,
              x2, y1+radius,
              x2, y1+radius,
              x2, y2-radius,
              x2, y2-radius,
              x2, y2,
              x2-radius, y2,
              x2-radius, y2,
              x1+radius, y2,
              x1+radius, y2,
              x1, y2,
              x1, y2-radius,
              x1, y2-radius,
              x1, y1+radius,
              x1, y1+radius,
              x1, y1]

    return canvas.create_polygon(points, **kwargs, smooth=True)

window = Tk()

window.geometry("1280x720")
window.configure(bg = "#343747")
window.title("Parking Management System")
window.iconbitmap(Path("parkingIcon.ico"))


canvas = Canvas(
    window,
    bg = "#343747",
    height = 720,
    width = 1280,
    bd = 0,
    highlightthickness = 0,
    relief = "ridge"
)

canvas.place(x = 0, y = 0)
round_rectangle(
    0.0,
    590.0,
    640.0,
    720.0,
    fill="#4C5574",
    outline="white")

canvas.create_text(
    90.0,
    616.0,
    anchor="nw",
    text="Spots occupied:",
    fill="#16D416",
    font=("Inter", 64 * -1)
)

total_cars_count = canvas.create_text(
    940.0,
    616.0,
    anchor="nw",
    text="0",
    fill="#FFFFFF",
    font=("Inter", 64 * -1)
)

round_rectangle(
    640.0,
    92.0,
    1280.0,
    341.0,
    fill="#4C5574",
    outline="white")

round_rectangle(
    0.0,
    341.0,
    640.0,
    590.0,
    fill="#4C5574",
    outline="white")

round_rectangle(
    640.0,
    341.0,
    1280.0,
    590.0,
    fill="#4C5574",
    outline="white")

round_rectangle(
    0.0,
    92.0,
    640.0,
    341.0,
    fill="#4C5574",
    outline="white")

canvas.create_text(
    179.0,
    169.0,
    anchor="nw",
    text="Status:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    819.0,
    169.0,
    anchor="nw",
    text="Status:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    179.0,
    418.0,
    anchor="nw",
    text="Status:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    819.0,
    418.0,
    anchor="nw",
    text="Status:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    74.0,
    208.0,
    anchor="nw",
    text="License Plate:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    714.0,
    208.0,
    anchor="nw",
    text="License Plate:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    74.0,
    457.0,
    anchor="nw",
    text="License Plate:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    714.0,
    457.0,
    anchor="nw",
    text="License Plate:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    84.0,
    247.0,
    anchor="nw",
    text="Vehicle Type:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    724.0,
    247.0,
    anchor="nw",
    text="Vehicle Type:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    84.0,
    496.0,
    anchor="nw",
    text="Vehicle Type:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    724.0,
    496.0,
    anchor="nw",
    text="Vehicle Type:",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot1_status = canvas.create_text(
    333.0,
    169.0,
    anchor="nw",
    text="Empty",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot2_status = canvas.create_text(
    973.0,
    169.0,
    anchor="nw",
    text="Empty",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot3_status = canvas.create_text(
    333.0,
    418.0,
    anchor="nw",
    text="Empty",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot4_status = canvas.create_text(
    973.0,
    418.0,
    anchor="nw",
    text="Empty",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot1_plate = canvas.create_text(
    333.0,
    208.0,
    anchor="nw",
    text="-",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot2_plate = canvas.create_text(
    973.0,
    208.0,
    anchor="nw",
    text="-",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot3_plate = canvas.create_text(
    333.0,
    457.0,
    anchor="nw",
    text="-",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot4_plate = canvas.create_text(
    973.0,
    457.0,
    anchor="nw",
    text="-",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot1_type = canvas.create_text(
    333.0,
    247.0,
    anchor="nw",
    text="-",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot2_type = canvas.create_text(
    973.0,
    247.0,
    anchor="nw",
    text="-",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot3_type = canvas.create_text(
    333.0,
    496.0,
    anchor="nw",
    text="-",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

spot4_type = canvas.create_text(
    973.0,
    496.0,
    anchor="nw",
    text="-",
    fill="#FFFFFF",
    font=("Inter", 32 * -1)
)

canvas.create_text(
    249.0,
    97.0,
    anchor="nw",
    text="Spot 1",
    fill="#16D416",
    font=("Inter", 48 * -1)
)

canvas.create_text(
    882.0,
    97.0,
    anchor="nw",
    text="Spot 2",
    fill="#16D416",
    font=("Inter", 48 * -1)
)

canvas.create_text(
    245.0,
    349.0,
    anchor="nw",
    text="Spot 3",
    fill="#16D416",
    font=("Inter", 48 * -1)
)

canvas.create_text(
    882.0,
    346.0,
    anchor="nw",
    text="Spot 4",
    fill="#16D416",
    font=("Inter", 48 * -1)
)

canvas.create_text(
    475.0,
    0.0,
    anchor="nw",
    text="Dashboard",
    fill="#16D416",
    font=("Inter", 64 * -1)
)

canvas.create_rectangle(
    -1.0,
    207.0,
    640.0,
    208.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    639.0,
    207.0,
    1280.0,
    208.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    -1.0,
    456.0,
    640.0,
    457.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    639.0,
    456.0,
    1280.0,
    457.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    -1.0,
    246.0,
    640.0,
    247.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    639.0,
    246.0,
    1280.0,
    247.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    -1.0,
    495.0,
    640.0,
    496.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    639.0,
    495.0,
    1280.0,
    496.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    -1.0,
    285.0,
    640.0,
    286.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    639.0,
    285.0,
    1280.0,
    286.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    -1.0,
    534.0,
    640.0,
    535.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    639.0,
    534.0,
    1280.0,
    535.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    -1.0,
    168.0,
    640.0,
    169.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    639.0,
    168.0,
    1280.0,
    169.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    -1.0,
    417.0,
    640.0,
    418.0,
    fill="#838383",
    outline="")

canvas.create_rectangle(
    639.0,
    417.0,
    1280.0,
    418.0,
    fill="#838383",
    outline="")

spot1_yellow = round_rectangle(
    304.0,
    299.0,
    337.0,
    332.0,
    fill="grey70",
    outline="")

spot2_yellow = round_rectangle(
    944.0,
    299.0,
    977.0,
    332.0,
    fill="grey70",
    outline="")

spot3_yellow = round_rectangle(
    304.0,
    548.0,
    337.0,
    581.0,
    fill="grey70",
    outline="")

spot4_yellow = round_rectangle(
    944.0,
    548.0,
    977.0,
    581.0,
    fill="grey70",
    outline="")

spot1_red = round_rectangle(
    353.0,
    299.0,
    386.0,
    332.0,
    fill="red",
    outline="")

spot2_red = round_rectangle(
    993.0,
    299.0,
    1026.0,
    332.0,
    fill="red",
    outline="")

spot3_red = round_rectangle(
    353.0,
    548.0,
    386.0,
    581.0,
    fill="red",
    outline="")

spot4_red = round_rectangle(
    993.0,
    548.0,
    1026.0,
    581.0,
    fill="red",
    outline="")

spot1_green = round_rectangle(
    255.0,
    299.0,
    288.0,
    332.0,
    fill="grey70",
    outline="")

spot2_green = round_rectangle(
    895.0,
    299.0,
    928.0,
    332.0,
    fill="grey70",
    outline="")

spot3_green = round_rectangle(
    255.0,
    548.0,
    288.0,
    581.0,
    fill="grey70",
    outline="")

spot4_green = round_rectangle(
    895.0,
    548.0,
    928.0,
    581.0,
    fill="grey70",
    outline="")
window.resizable(False, True)

