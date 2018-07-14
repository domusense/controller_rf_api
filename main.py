import falcon
from rpi_rf import RFDevice
import logging
import pigpio
import time
import random
from Signal import Signal

TX_GPIO1 = 24
TX_GPIO2 = 17
TX_HIGH = "008081FF"
TX_LOW = "000081FF"

wave_forms = [
              [Signal(800, TX_LOW),
              Signal(400, TX_HIGH)],
              [Signal(400, TX_LOW),
              Signal(800, TX_HIGH)]
          ]
# show the code in stdout
#for i in range(0, 48, 2):
#    if (code[i].length == 800 and code[i].state == TX_LOW):
#        print("0", end='')
#    else:
#        print("1", end='')

#print(2)

tx(code)

logger = logging.getLogger(__name__)

GPIO = 22
TX_PROTO = 1
TX_PULSELENGTH = None


class Signal:
   'Signal object'

   def __init__(self, length, state):
      self.state = state
      self.length = length

   def get_wave_form(self):
      return wave_form

def transmit_curtain_code(pulses):
    square = []

    # init pigpio
    pi = pigpio.pi()

    pi = pigpio.pi()             # exit script if no connection
    if not pi.connected:
       print("pigpio not ready")
       exit()

    #build the wave pattern by pulses
    # signal[0] - timestamp, signal[1] - GPIO state
    for s in pulses:
        if str(s.state.rstrip()) == "008081FF":
            square.append(pigpio.pulse(1<<TX_GPIO, 0, s.length))
        else:
            square.append(pigpio.pulse(0,1<<TX_GPIOTX, s.length))

    pi.set_mode(TX_GPIO, pigpio.OUTPUT) # set output mode on select GPIO
    pi.wave_add_generic(square) # add the generated wave from
    wid = pi.wave_create()
    if wid >= 0:
       pi.wave_send_repeat(wid)
       time.sleep(1)
       pi.wave_tx_stop()
       pi.wave_delete(wid)

    pi.stop()

def transmit_1way_code(code, repeats):
    """tx RF code"""
    # init the gpio device
    rfdevice = RFDevice(gpio=GPIO,
                    tx_proto=TX_PROTO,
                    tx_pulselength = TX_PULSELENGTH,
                    tx_repeat = repeats)
                    #tx_length=24,
                    #rx_tolerance=80)

    # send code
    rfdevice.enable_tx()
    rfdevice.tx_code(code)
    rfdevice.cleanup()

def transmit_2way_code(code, repeats):
    """tx RF code"""
    # init the gpio device
    rfdevice = RFDevice(gpio=GPIO,
                    tx_proto=TX_PROTO,
                    tx_pulselength = TX_PULSELENGTH,
                    tx_repeat = repeats)
                    #tx_length=24,
                    #rx_tolerance=80)

    # send code
    rfdevice.enable_tx()
    rfdevice.tx_code(code)
    rfdevice.cleanup()

class tx_1way(object):
    def on_get(self, req, res,code, repeats):
        """Handles all GET requests."""
        res.status = falcon.HTTP_200  # ok
        transmit_1way_code(int(code), int(repeats))
        res.body = ('Code transmitted: ' + code)

class tx_2way(object):
    def on_get(self, req, res,code, repeats):
        """Handles all GET requests."""
        res.status = falcon.HTTP_200  # ok
        transmit_2way_code(int(code), int(repeats))
        res.body = ('Code transmitted: ' + code)

class tx_yolanda(object):
    def on_get(self, req, res,code, repeats):
        """Handles all GET requests."""
        res.status = falcon.HTTP_200  # ok
        transmit_curtain_code(int(code), int(repeats))
        res.body = ('Code transmitted: ' + code)

# Create the Falcon application object
app = falcon.API()

# Add a route tos serve the resource
app.add_route('/tx/1way/{code}/{repeats}', tx_1way())
#app.add_route('/tx/2way/{code}/{repeats}', tx_2way())
app.add_route('/tx/curtain/{code}/{repeats}', tx_yolanda())
