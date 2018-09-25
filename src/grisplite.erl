% @doc grisplite public API.
% @end
-module(grisplite).

% Callbacks
-export([start/2]).
-export([start/1]).
-export([stop/1]).

%--- Callbacks -----------------------------------------------------------------

start(_Type, _Args) -> grisplite_commander:start_link(node).

start(node) ->
    logger:log(info, "Starting Node~n"),
    grisplite_commander:start_link(node).

stop(_State) -> ok.
