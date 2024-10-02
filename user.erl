-module(user).
-export([start/1, send_message/2]).  % Removed receive_message/0 from export

% Starts a new user process with the given name
start(Name) ->
    spawn(fun() -> loop(Name) end).

% Loop to handle incoming messages
loop(Name) ->
    receive
        {send, Message} ->
            io:format("User ~p received message: ~p~n", [Name, Message]),
            loop(Name);
        _Other ->
            io:format("User ~p received unknown message.~n", [Name]),
            loop(Name)
    end.

% Sends a message to the user process
send_message(UserPid, Message) ->
    UserPid ! {send, Message}.
