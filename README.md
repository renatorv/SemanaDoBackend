A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

## Rodar o app, duas formas:
# 1 forma
dart bin\backend.dart

# 2 forma
em debug => create a launch.json file => no arquivo launch.json adicionar:
"program": "bin/backend.dart"
assim o F5 estará habilitado
------------------------------------------------------------------------------------------------------------------------------------------
## Liberar porta do windows
netstat -ano | findstr <PORTA>
netstat -ano | findstr 4469

taskkill /PID <PORTA> /F
taskkill /PID 17180 /F

-------------------------------------------------------------------------------------------------------------------------------------------
"# SemanaDoBackend" 
