from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QPushButton, QFileDialog, QLabel, QMessageBox
import sys
import pdf_duplicates

class PDFDuplicatesGUI(QWidget):
    def __init__(self, pdf_duplicates_instance):
        super().__init__()
        self.pdf_duplicates = pdf_duplicates_instance

        # Set up the GUI layout and components
        layout = QVBoxLayout()

        self.label = QLabel("Select a directory to find duplicates")
        layout.addWidget(self.label)

        self.browse_button = QPushButton("Browse")
        self.browse_button.clicked.connect(self.browse_directory)
        layout.addWidget(self.browse_button)

        self.run_button = QPushButton("Find Duplicates")
        self.run_button.clicked.connect(self.run_duplicates_finder)
        layout.addWidget(self.run_button)

        self.setLayout(layout)
        self.setWindowTitle("PDF Duplicates Finder")
        self.resize(300, 150)

    def browse_directory(self):
        folder_selected = QFileDialog.getExistingDirectory(self, "Select Directory")
        if folder_selected:
            self.pdf_duplicates.destination = folder_selected

    def run_duplicates_finder(self):
        if not self.pdf_duplicates.destination:
            QMessageBox.warning(self, "Warning", "Please select a directory first!")
            return
        self.pdf_duplicates.run()
        QMessageBox.information(self, "Info", "Operation completed")

if __name__ == "__main__":
    app = QApplication(sys.argv)
    app.setStyle("Fusion")
    window = PDFDuplicatesGUI(pdf_duplicates.pdfDuplicates())
    window.show()
    sys.exit(app.exec_())
