#!/usr/bin/python2

__author__ = 'aaron'
from wxPython.wx import *

from PyCrust.shell import Shell

class ShellFrame(wxFrame):
    def __init__(self, parent=None, id=-1, title='PyCrust Minimus'):
        wxFrame.__init__(self, parent, id, title)
        self.shell = Shell(parent=self)

class App(wxApp):
    def OnInit(self):
        self.frame = ShellFrame()
        self.frame.Show(true)
        self.SetTopWindow(self.frame)
        return true

def main():
    application = App(0)
    application.MainLoop()

if __name__ == '__main__':
    main()