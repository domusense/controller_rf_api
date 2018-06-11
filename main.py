import falcon
from rpi_rf import RFDevice
import logging

logger = logging.getLogger(__name__)

GPIO = 22
TX_PROTO = 1
TX_PULSELENGTH = None

def transmit_code(code):
    """tx RF code"""
    # init the gpio device
    rfdevice = RFDevice(gpio=GPIO,
                    tx_proto=TX_PROTO,
                    tx_pulselength = TX_PULSELENGTH,
                    tx_repeat=repeats)
                    #tx_length=24,
                    #rx_tolerance=80)

    # send code
    rfdevice.enable_tx()
    rfdevice.tx_code(code)
    rfdevice.cleanup()

class tx(object):
    def on_get(self, req, res,code, repeats = 8):
        """Handles all GET requests."""
        res.status = falcon.HTTP_200  # ok
        transmit_code(int(code))
        res.body = ('Code transmitted: ' + code)

# Create the Falcon application object
app = falcon.API()

# Add a route tos serve the resource
app.add_route('/tx/{code}/{repeats}', tx())
