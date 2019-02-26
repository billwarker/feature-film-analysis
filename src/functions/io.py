import os
from dotenv import load_dotenv, find_dotenv
dotenv_path = find_dotenv()
load_dotenv(dotenv_path)


class ModuleFileReader:
    """
    Reads non-python files in other modules.
    Used to access SQL files in the queries directory.
    """
    def __init__(self, module):
        self.module = module
        
    def read(self, filename):
        """
        Returns a file's contents in read mode from the directory.
        """
        module_path = self.module.__path__[0]
        file_path = os.path.join(module_path, filename)
        file = open(file_path, 'r')
        return file.read()

def save_to_figures(filename):
    """
    Concatenate a plot's filename to the FIGURE_PATH
    in the .env variable, saving plots in the directory
    where figures will be stored.
    """ 
    figure_path = os.environ.get("FIGURE_PATH")
    file_path = os.path.join(figure_path, filename)
    return file_path
