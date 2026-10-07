# Runnable gateway image for the BVD/VBD-Ocelot F115 benchmark.
# Builds the gateway (samples/Basic) against the modified Ocelot engine in src/.
# This runs the normal gateway; it contains no exploit code. The injected
# weaknesses are documented in GROUND_TRUTH.csv (the answer key) and BENCHMARK.md.

FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY src/ src/
COPY samples/Basic/ samples/Basic/
COPY samples/Web/ samples/Web/
RUN dotnet restore samples/Basic/Ocelot.Samples.Basic.csproj
RUN dotnet publish samples/Basic/Ocelot.Samples.Basic.csproj \
    -c Release -f net9.0 -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app ./
ENV ASPNETCORE_URLS=http://0.0.0.0:5555
EXPOSE 5555
ENTRYPOINT ["dotnet", "Ocelot.Samples.Basic.dll"]
