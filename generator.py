import random

grammar = {
    "sentence":[("init", "VP")],
    "NP":[("det", "N"), ("det", "adj", "N")],
    "VP":[("V"), ("V", "adV"), ("V", "NP"), ("adV", "V"), ("adV", "V", "NP")],
    "init":["Our mission is to", "Our company's goal is to"],
    #"N":["farm", "child", "plan", "client's need"],
    "N":["farms", "children", "plans", "clients' needs"],
    #"det":["the", "our", "a", "their", "your"],
    "det":["the", "our", "all", "those", "their"],
    "V": ["help", "inspire", "craft", "drive", "aggregate", "compile"],
    "adj": ["poor", "sick", "disordered", "clean", "friendly", "nice"],
    "adV": ["creatively", "effeciently", "quickly", "correctly", "cleanly"]
}

def generation(token):
    if token in grammar:
        return generation(grammar[token][(random.randrange(0, len(grammar[token])))])
    if isinstance(token, list):
        return generation(token[random.randrange(0,len(token))])
    if isinstance(token, tuple):
        finishedPhrase = ""
        for phrase in token:
            finishedPhrase += generation(phrase) + " "
        return finishedPhrase
    return token

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

def main():
    while True:
        chosenGenerator = input("Which generator do you want? (T or G): ")
        if chosenGenerator == "T":
            template()
            break
        elif chosenGenerator == "G":
            print(generation("sentence"))
            break
    
main()
