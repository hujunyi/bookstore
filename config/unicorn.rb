APP_PATH = "/var/www/depot"
working_directory APP_PATH
pid APP_PATH+"/tmp/pids/unicorn.pid"
stderr_path APP_PATH+"/log/unicorn_stderr.log"
stdout_path APP_PATH+"/log/unicorn_stdout.log"

listen "/tmp/unicorn.depot.sock"
worker_processes 2
timeout 30
