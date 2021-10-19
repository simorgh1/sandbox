import pyttsx3
import PyPDF2

# Reading a pdf eBook
# Copy a pdf file to the current folder and update the name
bookName = 'cc.pdf'
book = open(bookName, 'rb')
pdfReader = PyPDF2.PdfFileReader(book)
pages = pdfReader.numPages

# change this to the page number you want to use
page = pdfReader.getPage(1)
text = page.extractText()

# Initializing the tts engine
engine = pyttsx3.init()
# default voice id
# default_voice_id = engine.getProperty('voice')

# en_voice_id = "HKEY_LOCAL_MACHINE\SOFTWARE\\Microsoft\Speech\\Voices\\Tokens\\TTS_MS_EN-US_DAVID_11.0"
# engine.setProperty('voice', en_voice_id)

engine.say('The book named cc.pdf has ' + str(pages) + ' pages')
engine.say(text)

# engine.setProperty('voice', default_voice_id)

# export page content to audio file (mp3 format)
# engine.save_to_file(text, 'text.mp3')

'''
# printing system voice configuration
voices = engine.getProperty('voices')
for voice in voices:
    print("Voice:")
    print(" - ID: %s" % voice.id)
    print(" - Name: %s" % voice.name)
    print(" - Languages: %s" % voice.languages)
    print(" - Gender: %s" % voice.gender)
    print(" - Age: %s" % voice.age)
    engine.setProperty('voice', voice.id)
    engine.say("My voice name is %s" % voice.name)
'''

engine.runAndWait()