# Play sound in terminal (with interactive python)

# No modo interativo de python:
   # On terminal:
      `pip3 install playsound`  # To install module
      `python3`                 # To enter into interactive python

   # On interactive python:
      >>> from playsound import playsound
      >>> playsound('/home/dv_msi/Repositories/DRYa/all/etc/sounds/example-sound-completion-bell.wav')
      >>> exit()


# No modo script python (sem entrar na consola de python)
   # Definir uma variavel
      `SOM=/home/dv_msi/Repositories/DRYa/all/etc/sounds/example-sound-completion-bell.wav`

   # Reproduzir o som
      `python -c "from playsound import playsound; playsound('$SOM')"`

   # Abreviar o mais possivel:
      SOM="/caminho/para/o/arquivo/som.mp3"
      CODE="from playsound import playsound; playsound('$SOM')"
      python -c "$CODE"

   # Para saber se o modulo 'playsound' esta instalado (com um bloco try-except)
      python -c "try: import playsound; print('playsound está instalado'); except ImportError: print('playsound não está instalado')"
