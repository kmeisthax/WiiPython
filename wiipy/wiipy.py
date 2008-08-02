import ogc, video
xfb = ogc.Init()
import sys
sys.path = ['/wiipy']
try: 
	print 'Running "/wiipy/run.py"...'
        import run
except:
        import traceback
        traceback.print_exc()
	print "failed!, falling back on telnetd"
	try: 
		import telnetd
	except: 
		traceback.print_exc()
print 'Returning to the menu...'

for i in range(60*5):
	video.WaitVSync()
