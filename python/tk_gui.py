import tkinter as tk 
from tkinter import filedialog, messagebox
import pdf_duplicates

class PDFDuplicatesGUI(tk.Tk):
    def __init__(self, pdf_duplicates_instance):
        super().__init__()
        self.pdf_duplicates = pdf_duplicates_instance
        
        self.title("PDF Duplicates Finder")
        self.geometry("300x150")
        self.label = tk.Label(self, text="Select a directory to find duplicates")
        self.label.pack(pady=20)
        
        self.browse_button = tk.Button(self, text="Browse", command=self.browse_directory)
        self.browse_button.pack()

        self.run_button = tk.Button(self, text="Find Duplicates", command=self.pdf_duplicates.run)
        self.run_button.pack(pady=20)


    def browse_directory(self):
        folder_selected = filedialog.askdirectory()
        if folder_selected:
            self.pdf_duplicates.destination = folder_selected
    def run_duplicates_finder(self):
        if not self.pdf_duplicates.destination:
            messagebox.showwarning("Warning", "Please select a directory first!")
        self.pdf_duplicates.run()
        messagebox.showinfo("Info", "Operation completed")

if __name__ == '__main__':
    app = PDFDuplicatesGUI(pdf_duplicates.pdfDuplicates())
    app.mainloop()