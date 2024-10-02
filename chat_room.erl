-module(chat_room).
-export([start/0, join/2, leave/2, send_message/2]).  % Changed join/1 and leave/1 to join/2 and leave/2

start() ->
    spawn(fun() -> loop([]) end).

loop(Users) ->
    receive
        {join, UserPid} ->
            io:format("User joined: ~p~n", [UserPid]),
            loop([UserPid | Users]);
        {leave, UserPid} ->
            io:format("User left: ~p~n", [UserPid]),
            loop(lists:delete(UserPid, Users));
        {send, Message} ->
            lists:foreach(fun(User) -> User ! {send, Message} end, Users),
            loop(Users)
    end.

% Updated to accept two parameters
join(ChatRoomPid, UserPid) ->
    ChatRoomPid ! {join, UserPid}.

% Updated to accept two parameters
leave(ChatRoomPid, UserPid) ->
    ChatRoomPid ! {leave, UserPid}.

send_message(ChatRoomPid, Message) ->
    ChatRoomPid ! {send, Message}.
