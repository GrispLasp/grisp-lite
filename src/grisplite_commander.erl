-module(grisplite_commander).

-behavior(supervisor).

%% API
-export([delete_child/1,stop_child/1]).
-export([start_link/0]).
-export([start_link/1]).
-export([stop_and_delete_child/1]).

%% Supervisor callbacks
-export([init/1]).

%% Macros

-define(NODE_SPEC,
	#{id => grisplite_sup, start => {grisplite_sup, start_link, []},
	  restart => permanent, type => supervisor,
	  shutdown => 15000, modules => [grisplite_sup]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, grisplite}, ?MODULE, []).

start_link(Args) ->
    supervisor:start_link({local, grisplite}, ?MODULE, Args).

stop_child(Name) ->
    supervisor:terminate_child(grisplite, Name).

delete_child(Name) ->
    supervisor:delete_child(grisplite, Name).

stop_and_delete_child(Name) ->
    supervisor:terminate_child(grisplite, Name),
    supervisor:delete_child(grisplite, Name).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    SupFlags = #{strategy => rest_for_one, intensity => 1,
		 period => 20},
    {ok, {SupFlags, []}};

init(node) ->
    SupFlags = #{strategy => one_for_one, intensity => 1,
		 period => 10},
    {ok, {SupFlags, [?NODE_SPEC]}}.
