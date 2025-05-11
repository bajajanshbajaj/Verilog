import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox
import serial
import serial.tools.list_ports
import threading
import time

class SerialMonitor:
    def __init__(self, master):
        self.master = master
        self.master.title("Serial Monitor")

        self.baud_rates = [
            300, 600, 1200, 2400, 4800, 9600,
            14400, 19200, 28800, 38400, 56000,
            57600, 115200, 128000, 230400, 256000,
            460800, 500000, 576000, 921600, 1000000,
            1152000, 1500000, 2000000, 2500000, 3000000,
            3500000, 4000000, 6750000
        ]

        self.serial_port = None
        self.running = False

        self.create_widgets()
        self.refresh_ports()

    def create_widgets(self):
        # Frame for the controls (port selection, baud rate, connect button)
        control_frame = ttk.Frame(self.master)
        control_frame.pack(padx=10, pady=10, fill=tk.X)

        ttk.Label(control_frame, text="Port:").grid(row=0, column=0, padx=5, pady=5)
        self.port_var = tk.StringVar()
        self.port_menu = ttk.Combobox(control_frame, textvariable=self.port_var, values=[], state="readonly", width=15)
        self.port_menu.grid(row=0, column=1, padx=5, pady=5)

        self.refresh_btn = ttk.Button(control_frame, text="Refresh", command=self.refresh_ports)
        self.refresh_btn.grid(row=0, column=2, padx=5, pady=5)

        ttk.Label(control_frame, text="Baud Rate:").grid(row=0, column=3, padx=5, pady=5)
        self.baud_var = tk.StringVar(value="9600")
        self.baud_menu = ttk.Combobox(control_frame, textvariable=self.baud_var, values=self.baud_rates, state="readonly", width=10)
        self.baud_menu.grid(row=0, column=4, padx=5, pady=5)

        self.connect_btn = ttk.Button(control_frame, text="Connect", command=self.toggle_connection)
        self.connect_btn.grid(row=0, column=5, padx=5, pady=5)

        # Frame for the scrolled text area with line numbers
        self.output_frame = ttk.Frame(self.master)
        self.output_frame.pack(padx=10, pady=10, fill=tk.BOTH, expand=True)

        # Create a text widget for line numbers
        self.line_numbers = tk.Text(self.output_frame, width=4, wrap=tk.WORD, state=tk.DISABLED, background='lightgrey')
        self.line_numbers.pack(side=tk.LEFT, fill=tk.Y)

        # Create the scrolled text widget for serial output
        self.output = scrolledtext.ScrolledText(self.output_frame, wrap=tk.WORD, undo=True)
        self.output.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        self.output.bind("<KeyRelease>", self.update_line_numbers)  # Update line numbers on text change
        self.output.bind("<Configure>", self.update_line_numbers)  # Update line numbers on resize

    def refresh_ports(self):
        ports = [port.device for port in serial.tools.list_ports.comports()]
        self.port_menu['values'] = ports
        if ports:
            self.port_var.set(ports[0])
        else:
            self.port_var.set("")

    def toggle_connection(self):
        if self.serial_port and self.serial_port.is_open:
            self.disconnect()
        else:
            self.connect()

    def connect(self):
        port = self.port_var.get()
        baudrate = int(self.baud_var.get())
        if not port:
            messagebox.showwarning("No Port", "Please select a COM port.")
            return
        try:
            self.serial_port = serial.Serial(port, baudrate, timeout=1)
            self.running = True
            self.connect_btn.config(text="Disconnect")
            threading.Thread(target=self.read_serial, daemon=True).start()
        except serial.SerialException as e:
            messagebox.showerror("Connection Error", str(e))

    def disconnect(self):
        self.running = False
        if self.serial_port:
            self.serial_port.close()
        self.connect_btn.config(text="Connect")

    def read_serial(self):
        while self.running and self.serial_port.is_open:
            try:
                if self.serial_port.in_waiting:
                    data = self.serial_port.readline().decode(errors='ignore').strip()
                    if data:
                        self.output.insert(tk.END, data + "\n")
                        self.output.see(tk.END)
                time.sleep(0.1)
            except serial.SerialException:
                self.disconnect()
                messagebox.showerror("Serial Error", "Lost connection to serial port.")
                break

    def update_line_numbers(self, event=None):
        # Update line numbers to match the content in the ScrolledText widget
        lines = int(self.output.index('end-1c').split('.')[0])
        self.line_numbers.config(state=tk.NORMAL)
        self.line_numbers.delete(1.0, tk.END)

        for i in range(1, lines + 1):
            self.line_numbers.insert(tk.END, f"{i}\n")

        self.line_numbers.config(state=tk.DISABLED)

if __name__ == "__main__":
    root = tk.Tk()
    app = SerialMonitor(root)
    root.mainloop()
