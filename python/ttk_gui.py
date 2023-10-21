import tkinter as tk 
from tkinter import filedialog, messagebox
from tkinter import ttk  # Import the themed Tkinter module
import pdf_duplicates

class PDFDuplicatesGUI(tk.Tk):
    def __init__(self, pdf_duplicates_instance):
        super().__init__()
        self.pdf_duplicates = pdf_duplicates_instance
        
        self.title("PDF Duplicates Finder")
        self.geometry("400x200")

        # Use ttk.Label instead of tk.Label
        self.label = ttk.Label(self, text="Select a directory to find duplicates")
        self.label.pack(pady=20)
        
        # Use ttk.Button instead of tk.Button
        self.browse_button = ttk.Button(self, text="Browse", command=self.browse_directory)
        self.browse_button.pack()

        self.run_button = ttk.Button(self, text="Find Duplicates", command=self.run_duplicates_finder)
        self.run_button.pack(pady=20)

        # Theme selection
        self.style = ttk.Style()
        self.themes = self.style.theme_names()
        self.theme_label = ttk.Label(self, text="Select Theme:")
        self.theme_label.pack(pady=10)
        self.theme_combobox = ttk.Combobox(self, values=self.themes)
        self.theme_combobox.bind("<<ComboboxSelected>>", self.change_theme)
        self.theme_combobox.pack()
        # Set the current theme as the default selected value in the combobox
        self.theme_combobox.set(self.style.theme_use())

    def browse_directory(self):
        folder_selected = filedialog.askdirectory()
        if folder_selected:
            self.pdf_duplicates.destination = folder_selected

    def run_duplicates_finder(self):
        if not self.pdf_duplicates.destination:
            messagebox.showwarning("Warning", "Please select a directory first!")
            return
        self.pdf_duplicates.run()
        messagebox.showinfo("Info", "Operation completed")

    def change_theme(self, event):
        selected_theme = self.theme_combobox.get()
        self.style.theme_use(selected_theme)

if __name__ == '__main__':
    app = PDFDuplicatesGUI(pdf_duplicates.pdfDuplicates())
    app.mainloop()
