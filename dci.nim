# This is an attempt to immitate the DCI (Data Context Interaction) paradigm in the Nim language.


# Roles
type Speaker = tuple [
    speaker_role: bool, # Necessary to enforce type checking
    name: string
]

type Listener = tuple [
    listener_role: bool, # Necessary to enforce type checking
    name: string
]


# Speaker Behaviours
proc speak_to(speaker: Speaker, listener: Listener, words: string) =
    echo(speaker.name & " says '" & words & "' to " & listener.name)


# Listener Behaviours
proc listen_to(listener: Listener, speaker: Speaker, words: string) =
    echo(listener.name & " hears " & speaker.name & " say '" & words & "'")


# Conversation Context
type Conversation = object
    speaker: Speaker
    listener: Listener
    words: string

proc occur(conversation: Conversation) =
    conversation.speaker.speak_to(conversation.listener, conversation.words)
    conversation.listener.listen_to(conversation.speaker, conversation.words)


# A type that implements the Speaker and the Listener roles
type Person = object
    name: string

proc implement_speaker(person: Person): Speaker =
  return (
    speaker_role: true,
    name: person.name
  )

proc implement_listener(person: Person): Listener =
  return (
    listener_role: true,
    name: person.name
  )



# Using the Conversation context on the Person type
let person1 = Person(name: "James")
let person2 = Person(name: "Frank")

let conversation = Conversation(
    speaker: person1.implement_speaker(),
    listener: person2.implement_listener(),
    words: "Hello My Friend"
)

conversation.occur()
