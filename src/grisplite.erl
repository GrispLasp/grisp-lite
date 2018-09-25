% @doc grisplite public API.
% @end
-module(grisplite).

-behavior(application).

% Callbacks
-export([start/2]).
-export([stop/1]).

%--- Callbacks -----------------------------------------------------------------

start(_Type, _Args) -> grisplite_commander:start_link(node).

stop(_State) -> ok.
