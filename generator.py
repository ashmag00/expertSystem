#when you run this program the program will ask you if you want to run the template-based-generator or the grammar-based-generator
import random

grammar = {
    "sentence":[("init", "VP")],
    "NP":[("det", "N"), ("det", "adj", "N")],
    "VP":[("V"), ("V", "adV"), ("V", "NP"), ("adV", "V"), ("adV", "V", "NP"), ("VP", "and", "VP")],
    "init":[("self", "MO", "trans")],
    "self":["Our", "Our company's", "Our organization's", "My", "My organization's"],
    "MO":["mission", "goal", "vision", "desire", "wish"],
    "trans":["has always been to", "is to", "will be to", "has been to", "will always be to"],
    #"N":["farm", "child", "plan", "client's need"],
    "N":["farms", "clients", "plans", "clients' needs", "problems"],
    #"det(S)":["the", "our", "a", "their", "your"],
    "det":["the", "our", "all", "those", "their"],
    "V":["help", "inspire", "craft", "drive", "aggregate", "compile"],
    "adj":["prosperous", "orderly", "clean", "friendly", "nice"],
    "adV":["creatively", "effeciently", "quickly", "correctly", "cleanly"]
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
        finishedPhrase = finishedPhrase[:-1]
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
        if chosenGenerator == "T" or  chosenGenerator == "t":
            template()
            break
        elif chosenGenerator == "G" or chosenGenerator == "g":
            print(generation("sentence"))
            break
    
main()
