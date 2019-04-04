import random

def randNoun():
    r = random.randrange(0, 3) 
    if r == 0:
        return "animals"
    elif r == 1:
        return "children"
    elif r == 2:
        return "those in need"

def randAdv():
    r = random.randrange(0, 3) 
    if r == 0:
        return "efficiently"
    elif r == 1:
        return "kindly"
    elif r == 2:
        return "creatively"

def randVerbPhrase():
    r = random.randrange(0, 4) 
    if r == 0:
        return "protect"
    elif r == 1:
        return "build homes for"
    elif r == 2:
        return "inspire"
    elif r == 3:
        return "create equal opportunities for"

def template():
    r = random.randrange(0, 4)
    if r == 0:
        print("Our company's purpose is to " + randAdv() + " " + randVerbPhrase() + " " + randNoun())
    elif r == 1:
        print("Our vision is to " + randAdv() + " " + randVerbPhrase() + " " + randNoun())
    elif r == 2:
        print("Our company exists to " + randAdv() + " " + randVerbPhrase() + " " + randNoun())
    elif r == 3:
        print("We can be relied upon to " + randAdv() + " " + randVerbPhrase() + " " + randNoun())
    else:
        print("Fail")

template()
