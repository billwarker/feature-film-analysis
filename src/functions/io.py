import os

class ModuleFileReader:
    
    def __init__(self, module):
        self.module = module
        
    def read(self, filename):
        module_path = self.module.__path__[0]
        file_path = os.path.join(module_path, filename)
        file = open(file_path, 'r')
        return file.read()