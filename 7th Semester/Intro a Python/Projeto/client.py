import time
import paho.mqtt.client as mqtt

client = mqtt.Client()

broker_address = "broker.emqx.io"
broker_port = 1883

client.connect(broker_address, broker_port)


topic = "testtopic/abc"
payload = "your_message5"
qos = 1

client.subscribe(topic, qos)


client.publish(topic, payload, qos)

client.publish(topic, "abcasdsa", qos)
time.sleep(1)
