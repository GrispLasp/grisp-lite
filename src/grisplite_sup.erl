% @doc grisplite top level supervisor.
% @end
-module(grisplite_sup).

-behavior(supervisor).

%% API
-export([start_link/0]).

-export([start_link/1]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_link(Args) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, Args).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    SupFlags = #{strategy => one_for_all, intensity => 1,
		 period => 20},
    ChildSpecs = [#{id => grisplite_server,
		    start => {grisplite_server, start_link, [self()]},
		    restart => permanent, type => worker, shutdown => 5000,
		    modules => [grisplite_server]}],
    {ok, {SupFlags, ChildSpecs}};
init(_Args) ->
    SupFlags = #{strategy => one_for_all, intensity => 1,
		 period => 20},
    ChildSpecs = [#{id => grisplite_server,
		    start => {grisplite_server, start_link, [self(), _Args]},
		    restart => permanent, type => worker, shutdown => 5000,
		    modules => [grisplite_server]}],
    {ok, {SupFlags, ChildSpecs}}.
