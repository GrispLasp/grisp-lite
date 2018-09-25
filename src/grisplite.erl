% @doc grisplite public API.
% @end
-module(grisplite).

-behavior(application).

% Callbacks
-export([start/2]).
-export([stop/1]).

%--- Callbacks -----------------------------------------------------------------

start(_Type, _Args) -> grisplite_sup:start_link().

stop(_State) -> ok.
