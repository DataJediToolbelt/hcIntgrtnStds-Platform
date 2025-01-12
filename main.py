import tkinter as tk
from tkinter import messagebox

def show_message():
    messagebox.showinfo("Message", "Hello, Tkinter!")

# Create the main window
root = tk.Tk()
root.title("Simple Tkinter Program")

# Create a button and attach the show_message function
button = tk.Button(root, text="Click Me", command=show_message)
button.pack(pady=20)

# Run the application
root.mainloop()