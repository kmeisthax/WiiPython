import ogc, video
xfb = ogc.Init()
import sys
sys.path = ['/wiipy']

#@todo not sure if this is the proper way not to use all cpu.
def home_return_thread(ign):
	print 'Press Home to return to hbc.'
	pad = ogc.wpad.WPAD(0)
	while True:
		pad.update()
		if pad["HOME"]:
			ogc.Reload()
		video.WaitVSync()
ogc.lwp.Thread(home_return_thread,('hello',))
print 'Running "/wiipy/run.py"...'
try: 
        import run
except:
        import traceback
        traceback.print_exc()
	print "failed!, falling back on telnetd"
	try: 
		import telnetd
		telnetd.telnetd()
	except: 
		traceback.print_exc()
print 'press A to return to the menu...'

pad = ogc.wpad.WPAD(0)
while True:
	pad.update()
	if pad["A"]:
		ogc.Reload()
	my_thread.yield_thread()
	video.WaitVSync()
for i in range(60*5):
	video.WaitVSync()
