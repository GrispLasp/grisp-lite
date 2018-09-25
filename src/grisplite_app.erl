%%%-------------------------------------------------------------------
%% @doc node application public API
%% @end
%%%-------------------------------------------------------------------

-module(grisplite_app).

-behaviour(application).

-include("grisplite.hrl").

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================
% TODO : find a way to exclude lager everywhere?, see commit below
% https://github.com/lasp-lang/lasp/pull/295/commits/e2f948f879145a5ff31cf5458201768ca97b406b

start(_StartType, _StartArgs) ->
    logger:log(notice, "Application Master starting Node app ~n"),
    {ok, Supervisor} = grisplite:start(node),
    % application:ensure_all_started(os_mon),
    % node_util:set_platform(),
    ?PAUSE3,
    % start_timed_apps(),
    grisplite_util:start_primary_workers(primary_workers),
    % start_primary_workers(distributed_workers),

    LEDs = [1, 2],
    [grisp_led:flash(L, aqua, 500) || L <- LEDs],
    % grisp_led:color(1,aqua).
    {ok, Supervisor}.

%%--------------------------------------------------------------------

stop(_State) ->
    logger:log(notice, "Application Master has stopped app~n"), ok.

%%====================================================================
%% Internal functions
%%====================================================================

% lasp_peer_service:manager().
% lasp_peer_service:members().
% ets:match(node(),'$1').
% grisplite_util:start_primary_workers(primary_workers).
