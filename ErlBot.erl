-module(bot).
-author("QUT Code").
-export([connect/2, loop/1]).
-define(nickname, "MyNameIsErlBot").
-define(channel, "#qutcode").

% Connect to an IRC server with a given Host and Port.
connect(Host, Port) ->
        {ok, Sock} = gen_tcp:connect(Host, Port, [{packet, line}]),
        % According to RFC1459, we need to tell the server our nickname and username
        gen_tcp:send(Sock, "NICK " ++ ?nickname ++ "\r\n"),
        gen_tcp:send(Sock, "USER " ++ ?nickname ++ " Erlang IRC BOT Blah\r\n"),
        loop(Sock).
        
% Parse TCP messages 
loop(Sock) ->
        receive
                {tcp, Sock, Data} ->
                        io:format("[~w] Received: ~s", [Sock, Data]),
                        parse_line(Sock, string:tokens(Data, ": ")),
                        loop(Sock);
                quit ->
                        io:format("[~w] Received quit message, exiting...~n", [Sock]),
                        gen_tcp:close(Sock),
                        exit(stopped)
        end.


parse_line(Sock, [User,"PRIVMSG",Channel,?nickname|_]) ->
        Nick = lists:nth(1, string:tokens(User, "!")),
        irc_privmsg(Sock, Channel, "ARE YOU, TALKING TO ME? Well , " ++ Nick ++ " are you?");


% Prevent Timeout
parse_line(Sock, ["PING"|Rest]) ->
        gen_tcp:send(Sock, "PONG " ++ Rest ++ "\r\n");

% 376 indicates End of MOTD.
parse_line(Sock, [_,"376"|_]) ->
        gen_tcp:send(Sock, "JOIN :" ++ ?channel ++ "\r\n");

parse_line(_, _) ->
        0.

% Send a private mesage
irc_privmsg(Sock, To, Message) ->
        gen_tcp:send(Sock, "PRIVMSG " ++ To ++ " :" ++ Message ++ "\r\n").
