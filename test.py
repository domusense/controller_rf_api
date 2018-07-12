from rpi_rf import RFDevice

GPIO = 17
TX_PROTO = 1
TX_REPEAT = 8
TX_PULSELENGTH = None


# init the gpio device
rfdevice = RFDevice(gpio=GPIO,
	tx_proto=TX_PROTO,
        tx_pulselength = TX_PULSELENGTH,
        tx_repeat=TX_REPEAT)
        #tx_length=24,
        #rx_tolerance=80)

# send code
rfdevice.enable_tx()
rfdevice.tx_code(123456789)
rfdevice.cleanup()

