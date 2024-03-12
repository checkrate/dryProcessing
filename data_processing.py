class DataProcessor:
    def __init__(self, MainWindow):
        self.MainWindow = MainWindow

    def txt_data(self):
        path_txt = self.MainWindow.path_txt
        print(path_txt)

    def csv_data(self):
        path_csv = self.MainWindow.path_csv
        print(path_csv)