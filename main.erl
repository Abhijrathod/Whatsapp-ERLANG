-module(main).
-export([start/0]).

start() ->
    ChatRoom = chat_room:start(),

    User1 = user:start("Alice"),
    User2 = user:start("Bob"),
    User3 = user:start("Charlie"),

    chat_room:join(ChatRoom, User1),
    chat_room:join(ChatRoom, User2),
    chat_room:join(ChatRoom, User3),

    chat_room:send_message(ChatRoom, "Hello everyone!"),
    user:send_message(User1, "Hey, Bob!"),
    user:send_message(User2, "Hello, Alice!").
