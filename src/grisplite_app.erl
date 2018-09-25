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
    % ?PAUSE3,
    % grisplite_util:start_timed_apps(),
    % ?PAUSE3,
    % grisplite_util:start_primary_workers(primary_workers),
    % ?PAUSE3,
    % grisplite_util:start_primary_workers(distributed_workers),
    ok = run(),
    % LEDs = [1, 2],
    % [grisp_led:flash(L, aqua, 500) || L <- LEDs],
    % grisp_led:color(1,aqua).
    {ok, Supervisor}.

%%--------------------------------------------------------------------

stop(_State) ->
    logger:log(notice, "Application Master has stopped app~n"), ok.

%%====================================================================
%% Internal functions
%%====================================================================
run() ->
  ?PAUSE3,
  grisplite_util:start_timed_apps(),
  ?PAUSE3,
  grisplite_util:start_primary_workers(primary_workers),
  ?PAUSE3,
  grisplite_util:start_primary_workers(distributed_workers),
  ?PAUSE3,
  ok.

% erlang:memory().
% lasp_peer_service:manager().
% lasp_peer_service:members().
% ets:match(node(),'$1').
% grisplite_util:start_timed_apps().
% grisplite_util:start_primary_workers(primary_workers).
% grisplite_util:start_primary_workers(distributed_workers).

% M = rpc:call(grisplite@my_grisp_board_1, lasp_peer_service, manager, []).
% R = rpc:call(grisplite@my_grisp_board_1, M, myself, []).
% R = rpc:call(grisplite@my_grisp_board_2, partisan_hyparview_peer_service_manager, myself, []).
% ok = lasp_peer_service:join(R).

% grisplite_generic_tasks_server:add_task({task1, all, fun () -> grisplite_generic_tasks_functions:task_model_test_function() end }).
% lasp:query(grisplite_util:atom_to_lasp_identifier(tasks,state_orset)).
% rp(ets:all()).
