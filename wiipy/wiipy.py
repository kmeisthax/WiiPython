import ogc, video
xfb = ogc.Init()
import sys
sys.path = ['/']
print 'Running "run.py"...'
import run
	
print 'Returning to the menu...'

for i in range(60*5):
	video.WaitVSync()
