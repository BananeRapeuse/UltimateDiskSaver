import tkinter as tk
from tkinter import filedialog, messagebox
from sftp_backup import backup_to_sftp

class UltimateDiskSaverApp:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("UltimateDiskSaver")
        self.root.geometry("400x300")
        self.server_info = {}

        self.create_widgets()

    def create_widgets(self):
        tk.Label(self.root, text="SFTP Server:").pack()
        self.server_entry = tk.Entry(self.root)
        self.server_entry.pack()

        tk.Label(self.root, text="Username:").pack()
        self.username_entry = tk.Entry(self.root)
        self.username_entry.pack()

        tk.Label(self.root, text="Password:").pack()
        self.password_entry = tk.Entry(self.root, show="*")
        self.password_entry.pack()

        tk.Label(self.root, text="Remote Path:").pack()
        self.remote_path_entry = tk.Entry(self.root)
        self.remote_path_entry.pack()

        tk.Button(self.root, text="Select Disk", command=self.select_disk).pack()
        tk.Button(self.root, text="Backup", command=self.backup).pack()

    def select_disk(self):
        self.local_path = filedialog.askdirectory()
        if self.local_path:
            messagebox.showinfo("Selected Disk", f"Selected Disk: {self.local_path}")

    def backup(self):
        self.server_info = {
            "server": self.server_entry.get(),
            "username": self.username_entry.get(),
            "password": self.password_entry.get(),
            "remote_path": self.remote_path_entry.get(),
            "local_path": self.local_path
        }

        if not all(self.server_info.values()):
            messagebox.showwarning("Missing Information", "Please fill in all fields and select a disk.")
            return

        success = backup_to_sftp(self.server_info)
        if success:
            messagebox.showinfo("Success", "Backup completed successfully!")
        else:
            messagebox.showerror("Error", "Backup failed.")

    def run(self):
        self.root.mainloop()
