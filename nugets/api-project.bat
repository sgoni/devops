@echo off
echo Instalando paquetes NuGet...

REM Instalación de Autofac y sus extensiones para ASP.NET Core
dotnet add package Autofac
dotnet add package Autofac.Extensions.DependencyInjection

REM Instalación de AutoMapper
dotnet add package AutoMapper

REM Instalación de FluentValidation para ASP.NET Core
dotnet add package FluentValidation.AspNetCore

REM Instalación de MediatR
dotnet add package MediatR

REM Instalación de Microsoft.Extensions.Configuration.Json
dotnet add package Microsoft.Extensions.Configuration.Json

REM Instalación de Newtonsoft.Json
dotnet add package Newtonsoft.Json

REM Instalación de Serilog y sus configuraciones
dotnet add package Serilog.AspNetCore
dotnet add package Serilog.Settings.Configuration
dotnet add package Serilog.Sinks.Async
dotnet add package Serilog.Sinks.Console
dotnet add package Serilog.Sinks.File

REM Instalación de Swashbuckle y sus anotaciones
dotnet add package Swashbuckle.AspNetCore
dotnet add package Swashbuckle.AspNetCore.Annotations

REM Instalación de System.Configuration.ConfigurationManager
dotnet add package System.Configuration.ConfigurationManager

REM Instalación de HealthChecks y sus configuraciones
dotnet add package AspNetCore.HealthChecks.ApplicationStatus 
dotnet add package AspNetCore.HealthChecks.SendGrid
dotnet add package AspNetCore.HealthChecks.SqlServer
dotnet add package AspNetCore.HealthChecks.UI
dotnet add package AspNetCore.HealthChecks.UI.Client 
dotnet add package AspNetCore.HealthChecks.UI.InMemory.Storage

echo Paquetes NuGet instalados con éxito.
pause