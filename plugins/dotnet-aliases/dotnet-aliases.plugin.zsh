alias dnn="dotnet new"
alias dni="dotnet new -i $1"

alias dntap="dotnet add package $1";
alias dntb="dotnet build";
alias dntc="dotnet clean";
alias dntsdks="dotnet --list-skds";
alias dntgt="dotnet tool install --global $1";
alias dnti="dotnet tool install $1";
alias dntl="dotnet tool list";
alias dntrp="dotnet remove package $1";
alias dntr="dotnet restore";
alias dntt="dotnet test $1";
alias dntpub="dotnet publish $1";
alias dntpack="dotnet pack $1";
alias dntrun="dotnet run $1";

alias dn-ef="dotnet ef"
alias dn-efdbup="dotnet ef database update";
alias dn-efdbdrop="dotnet ef database drop";

alias dn-efctx="dotnet ef context";
alias dn-efctxinfo="dotnet ef context info";
alias dn-efctxlist="dotnet ef context list";
alias dn-efctxscaff="dotnet ef context scaffold";
alias dn-efctxscript="dotnet ef context script";

alias dn-efadd="dotnet ef migrations add";
alias dn-eflist="dotnet ef migrations list";
alias dn-efrm="dotnet ef migrations remove";
alias dn-efscript="dotnet ef migrations script";

alias dnn-sln="dotnet new sln";
alias dnn-lib="dotnet new classlib";
alias dnn-console="dotnet new console";
alias dnn-razor="dotnet new razorclasslib";
alias dnn-grpc="dotnet new grpc";
alias dnn-web="dotnet new web";
alias dnn-webapp="dotnet new webapp";
alias dnn-mvc="dotnet new mvc";
alias dnn-api="dotnet new webapi";
alias dnn-httpapi="dotnet new httpapi";
alias dnn-gi="dotnet new gitignore";
alias dnn-nuget="dotnet new nugetconfig";
alias dnn-xunit="dotnet new xunit";
alias dnn-nunit="dotnet new nunit";
alias dnn-editor="dotnet new editorconfig";
alias dnn-ga="dotnet new gitattributes";

alias fn-dur="dotnet new durable";
alias fn-kafka-out="dotnet new kafkao";
alias fn-kafka-in="dotnet new kafka";
alias fn-sendg="dotnet new sendgrid";
alias fn-blob="dotnet new blob";
alias fn-cosmos="dotnet new cosmos";
alias fn-evtgrid="dotnet new eventgrid";
alias fn-evthub="dotnet new eventhub";
alias fn-http="dotnet new http";
alias fn-httpoas="dotnet new httpOpenApi";
alias fn-signalr="dotnet new signalr";
alias fn-iothub="dotnet new iothub";
alias fn-rmq="dotnet new rqueue";
alias fn-sbq="dotnet new squeue";
alias fn-sbt="dotnet new stopic";
alias fn-que="dotnet new queue";
alias fn-timer="dotnet new timer";
alias fn-azure="dotnet new func";
