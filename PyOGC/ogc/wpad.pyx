"""
WPAD Subsystem (support for wiimote)
currently, only buttons support.
"""

cdef extern from "wiiuse/wpad.h":
	signed long WPAD_Init()
	signed long WPAD_DroppedEvents(signed long chan)
	signed long WPAD_Flush(signed long chan)
	signed long WPAD_SetDataFormat(signed long chan, signed long fmt)
	signed long WPAD_SetVRes(signed long chan,unsigned long xres,unsigned long yres)
	signed long WPAD_GetStatus()
	signed long WPAD_Probe(signed long chan,unsigned long *type)
	signed long WPAD_Disconnect(signed long chan)
	void WPAD_Shutdown()
	void WPAD_SetIdleTimeout(unsigned long seconds)
	signed long WPAD_ScanPads()
	signed long WPAD_Rumble(signed long chan, int status)
	signed long WPAD_SetIdleThresholds(signed long chan, signed long btns, signed long ir, signed long accel, signed long js)
	unsigned long WPAD_ButtonsUp(int chan)
	unsigned long WPAD_ButtonsDown(int chan)
	unsigned long WPAD_ButtonsHeld(int chan)

WPAD_CHAN_ALL = -1,
WPAD_CHAN_0=0
WPAD_CHAN_1=1
WPAD_CHAN_2=2
WPAD_CHAN_3=3
WPAD_MAX_WIIMOTES=4
											
WPAD_BUTTON_2=							0x0001
WPAD_BUTTON_1=							0x0002
WPAD_BUTTON_B=							0x0004
WPAD_BUTTON_A	=						0x0008
WPAD_BUTTON_MINUS=						0x0010
WPAD_BUTTON_HOME=						0x0080
WPAD_BUTTON_LEFT=						0x0100
WPAD_BUTTON_RIGHT=						0x0200
WPAD_BUTTON_DOWN=						0x0400
WPAD_BUTTON_UP=							0x0800
WPAD_BUTTON_PLUS=						0x1000
WPAD_BUTTON_UNKNOWN=						0x8000
											
WPAD_NUNCHUK_BUTTON_Z=					(0x0001<<16)
WPAD_NUNCHUK_BUTTON_C=					(0x0002<<16)
											
WPAD_CLASSIC_BUTTON_UP=					(0x0001<<16)
WPAD_CLASSIC_BUTTON_LEFT=				(0x0002<<16)
WPAD_CLASSIC_BUTTON_ZR=					(0x0004<<16)
WPAD_CLASSIC_BUTTON_X=					(0x0008<<16)
WPAD_CLASSIC_BUTTON_A=					(0x0010<<16)
WPAD_CLASSIC_BUTTON_Y=					(0x0020<<16)
WPAD_CLASSIC_BUTTON_B=					(0x0040<<16)
WPAD_CLASSIC_BUTTON_ZL=					(0x0080<<16)
WPAD_CLASSIC_BUTTON_FULL_R=				(0x0200<<16)
WPAD_CLASSIC_BUTTON_PLUS=				(0x0400<<16)
WPAD_CLASSIC_BUTTON_HOME=				(0x0800<<16)
WPAD_CLASSIC_BUTTON_MINUS=				(0x1000<<16)
WPAD_CLASSIC_BUTTON_FULL_L=				(0x2000<<16)
WPAD_CLASSIC_BUTTON_DOWN=				(0x4000<<16)
WPAD_CLASSIC_BUTTON_RIGHT=				(0x8000<<16)

WPAD_GUITAR_HERO_3_BUTTON_STRUM_UP=		(0x0001<<16)
WPAD_GUITAR_HERO_3_BUTTON_YELLOW=		(0x0008<<16)
WPAD_GUITAR_HERO_3_BUTTON_GREEN=			(0x0010<<16)
WPAD_GUITAR_HERO_3_BUTTON_BLUE=			(0x0020<<16)
WPAD_GUITAR_HERO_3_BUTTON_RED=			(0x0040<<16)
WPAD_GUITAR_HERO_3_BUTTON_ORANGE=		(0x0080<<16)
WPAD_GUITAR_HERO_3_BUTTON_PLUS=			(0x0400<<16)
WPAD_GUITAR_HERO_3_BUTTON_MINUS=			(0x1000<<16)
WPAD_GUITAR_HERO_3_BUTTON_STRUM_DOWN=	(0x4000<<16)


buttons = ['2', '1', 'B', 'A', '-','+','HOME','LEFT','RIGHT','DOWN','UP','PLUS','UNKNOWN']

ERR_NONE          =	 0
ERR_NO_CONTROLLER =	-1
ERR_NOT_READY     =	-2
ERR_TRANSFER      =	-3


# Call PAD_Init whenever this module is inited
WPAD_Init()

class WPAD:
	"""
	WPAD class, let you get info from, and control a specific wii controller
	Initialize the object with the channel number
	Button/Stick states can be accessed by padObj['A'] or padObj['LStick']
	"""
	def __init__(self, chanNum):
		self.chanNum = chanNum
		self.buttons = 0
		self.update()
	def __getitem__(self, b):
		return self._dict[b]
	
	def update(self):
		WPAD_ScanPads();
		# Called to update the pad state
		self.buttons = WPAD_ButtonsDown(self.chanNum)
		self._dict = { 'A'      : self.buttons & WPAD_BUTTON_A,
			       'B'      : self.buttons & WPAD_BUTTON_B,
			       '-'      : self.buttons & WPAD_BUTTON_MINUS,
			       '+'      : self.buttons & WPAD_BUTTON_PLUS,
			       'HOME'   : self.buttons & WPAD_BUTTON_HOME,
			       '2'      : self.buttons & WPAD_BUTTON_2,
			       '1'      : self.buttons & WPAD_BUTTON_2,
			       'Up'     : self.buttons & WPAD_BUTTON_UP,
			       'Down'   : self.buttons & WPAD_BUTTON_DOWN,
			       'Left'   : self.buttons & WPAD_BUTTON_LEFT,
			       'Right'  : self.buttons & WPAD_BUTTON_RIGHT
			       }
		
	
	def rumble_start(self):
		WPAD_Rumble(self.chanNum, 1)
	def rumble_stop(self):
		WPAD_Rumble(self.chanNum, 0)
	def rumble_stop_hard(self):
		WPAD_Rumble(self.chanNum, 2)

