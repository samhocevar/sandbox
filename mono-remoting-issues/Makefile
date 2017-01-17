all: shared.dll server.exe client.exe

ARGS = /debug+ /r:System.Runtime.Remoting.dll

shared.dll: shared.cs
	mcs $(ARGS) /target:library /out:shared.dll shared.cs

server.exe: server.cs
	mcs $(ARGS) /r:shared.dll server.cs

client.exe: client.cs server.exe
	mcs $(ARGS) /r:shared.dll /r:server.exe client.cs

