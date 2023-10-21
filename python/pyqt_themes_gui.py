from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QPushButton, QLabel, QComboBox, QStyleFactory, QFileDialog, QMessageBox
import sys
import pdf_duplicates

class PDFDuplicatesGUI(QWidget):
    def __init__(self, pdf_duplicates_instance):
        super().__init__()
        self.pdf_duplicates = pdf_duplicates_instance

        layout = QVBoxLayout()

        self.label = QLabel("Select a directory to find duplicates")
        layout.addWidget(self.label)

        self.browse_button = QPushButton("Browse")
        self.browse_button.clicked.connect(self.browse_directory)
        layout.addWidget(self.browse_button)

        self.run_button = QPushButton("Find Duplicates")
        self.run_button.clicked.connect(self.run_duplicates_finder)
        layout.addWidget(self.run_button)

        # Stil-Auswahl
        self.style_label = QLabel("Select Style:")
        layout.addWidget(self.style_label)
        self.style_combobox = QComboBox()
        self.style_combobox.addItems(QStyleFactory.keys())
        self.style_combobox.currentTextChanged.connect(self.change_style)
        layout.addWidget(self.style_combobox)

        self.setLayout(layout)
        self.setWindowTitle("PDF Duplicates Finder")
        self.resize(400, 200)

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

    def change_style(self, style_name):
        QApplication.setStyle(style_name)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = PDFDuplicatesGUI(pdf_duplicates.pdfDuplicates())
    window.show()
    sys.exit(app.exec_())
