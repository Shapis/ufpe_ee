import time
import paho.mqtt.client as mqtt
import threading
from clp import CLP


client = mqtt.Client()

# Configura o nivel de qos.
qos = 1

meuCLP = CLP("CLP 1")


def checarInstrumentos():
    while True:
        time.sleep(2)
        print("Checando instrumentos...")
        enviar_dados()


thread = threading.Thread(target=checarInstrumentos)
thread.start()


def enviar_dados():
    for instrumento in meuCLP.instrumentos:
        client.publish(instrumento.topico, instrumento.valor, qos)
    pass


# Lida com mensagens recebidas.
def on_message(client, userdata, msg):
    print(f"Mensagem recebida no topico {msg.topic}: {msg.payload.decode()}")


client.on_message = on_message

# Conecta ao servidor.
broker_address = "broker.emqx.io"
broker_port = 1883

client.connect(broker_address, broker_port)

# Da tempo para o cliente se conectar. o metodo client.is_connected() esta sempre retornando falso, mesmo se o cliente estiver conectado, nao tenho certeza de por que.
time.sleep(1)


topico1_1 = "instrumentos/termometros/termometro_interno"
topico1_2 = "instrumentos/termometros/termometro_externo"
topico2 = "instrumentos/presenciometros"
topico3 = "aparelhos/portas"
topico4_1 = "aparelhos/ventiladores/ventilador_1"
topico4_2 = "aparelhos/ventiladores/ventilador_2"
topico5 = "aparelhos/termometros"


client.subscribe("instrumentos/#", qos)


client.publish(topic, payload, qos)

client.publish(topic, "abcasdsa", qos)

client.loop_forever()
