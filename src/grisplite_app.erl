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
  % ?PAUSE3,
  % grisplite_util:start_timed_apps(),
  % ?PAUSE3,
  % grisplite_util:start_primary_workers(primary_workers),
  % ?PAUSE3,
  % grisplite_util:start_primary_workers(distributed_workers),
  % ?PAUSE3,
  ?PAUSE3,
  grisplite_util:start_timed_apps(),
  ?PAUSE3,
  start_primary_workers(primary_workers),
  ?PAUSE3,
  start_primary_workers(distributed_workers),
  ?PAUSE3,
  ok.


start_primary_workers(Workers) ->
    logger:log(notice, "Starting ~p workers ~n", [Workers]),
    PrimaryWorkers = grisplite_config:get(Workers, []),
    lists:foreach(fun(Worker) ->
                    grisplite_server:start_worker(Worker)
                  end, PrimaryWorkers),
    grisplite_util:printer(PrimaryWorkers, workers).
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
% grisplite_generic_tasks_server:add_task({task2, all, fun () -> lists:foreach(fun(E) -> timer:sleep(10000) lasp:update(atom_to_lasp_identifier(node(),state_orset), {add, pmod_als:raw()}, self()) end, lists:seq(1, 100)).  end }).
% grisplite_generic_tasks_server:add_task({task4, all, fun () -> lists:foreach(fun(E) -> timer:sleep(10000), lasp:update(grisplite_util:atom_to_lasp_identifier(measures,state_orset), {add, {node(), pmod_als:raw()}}, self()) end, lists:seq(1, 100))  end }).
% grisplite_generic_tasks_worker:start_task(task4).
% lasp:query(grisplite_util:atom_to_lasp_identifier(tasks,state_orset)).
% lasp:query(grisplite_util:atom_to_lasp_identifier(set,state_orset)).
% rp(ets:all()).

% net_adm:ping(grisplite@my_grisp_board_2).
% net_adm:ping(grisplite@my_grisp_board_3).
% lasp_peer_service:join(rpc:call(node@my_grisp_board_2, partisan_hyparview_peer_service_manager, myself, [])).
% rpc:call(grisplite@my_grisp_board_3, lasp, query, [{<<"set">>,state_orset}]).
% rpc:call(grisplite@my_grisp_board_3, lasp, query, [{<<"tasks">>,state_orset}]).
% S = rpc:call(grisplite@my_grisp_board_3, erlang, self, []).
% rpc:call(grisplite@my_grisp_board_3, lasp, update, [{<<"set">>,state_orset}, {add, 3}, S]).

% lasp:update({<<"set">>, state_orset}, {add, 1}, self()).
% lasp:update({<<"set">>, state_orset}, {add, 3}, S).

% grisplite_util:start_primary_workers(primary_workers).

% rpc:call(grisplite@my_grisp_board_3, grisplite_util, start_primary_workers, [primary_workers]).
% rpc:call(grisplite@my_grisp_board_3, grisplite_util, start_primary_workers, [distributed_workers]).

% rpc:call(grisplite@my_grisp_board_1, grisplite_util, start_primary_workers, [primary_workers]).
% rpc:call(grisplite@my_grisp_board_1, grisplite_util, start_primary_workers, [distributed_workers]).

% Identifier = grisplite_util:atom_to_lasp_identifier(node(), state_orset).
% Identifier3 = grisplite_util:atom_to_lasp_identifier(grisplite@my_grisp_board_3, state_orset).
% {ok, Set2} = lasp:query(Identifier).
% {ok, Set3} = lasp:query(Identifier3).
% L = sets:to_list(Set2).
% list_to_integer(L).
% list_to_integer(L, 16).

% lists:foreach(fun(E) -> timer:sleep(10000) lasp:update(atom_to_lasp_identifier(measures,state_orset), {add, {node(), pmod_als:raw()}}, self()) end, lists:seq(1, 100)).
