-module(grisplite_config).

-export([get/1,get/2]).

get(Key) ->
    {ok, Value} = application:get_env(grisplite, Key), Value.

get(Key, Default) -> application:get_env(grisplite, Key, Default).
