#
# service: simple wrapper around start-stop-daemon
#
# Usage: service ACTION EXEC ARGS...
#
# Action:
#   -C	check if EXEC is alive
#   -S	start EXEC, passing it ARGS as its arguments
#   -K	kill EXEC, sending it a TERM signal if not specified otherwise
#
# Environment variables exposed:
#   SERVICE_DAEMONIZE	run EXEC in background
#   SERVICE_WRITE_PID	create a pid-file and use it for matching
#   SERVICE_MATCH_EXEC	use EXEC command-line for matching (default)
#   SERVICE_MATCH_NAME	use EXEC process name for matching
#   SERVICE_USE_PID	assume EXEC create its own pid-file and use it for matching
#   SERVICE_NAME	process name to use (default to EXEC file part)
#   SERVICE_PID_FILE	pid file to use (default to /var/run/$SERVICE_NAME.pid)
#   SERVICE_SIG		signal to send when using -K
#   SERVICE_SIG_RELOAD	default signal used when reloading
#   SERVICE_SIG_STOP	default signal used when stopping
#   SERVICE_STOP_TIME	time to wait for a process to stop gracefully before killing it
#   SERVICE_UID		user EXEC should be run as
#   SERVICE_GID		group EXEC should be run as
#
#   SERVICE_DEBUG	don't do anything, but show what would be done
#   SERVICE_QUIET	don't print anything
#

SERVICE_QUIET=1
SERVICE_SIG_RELOAD="HUP"
SERVICE_SIG_STOP="TERM"
SERVICE_STOP_TIME=5
SERVICE_MATCH_EXEC=1

