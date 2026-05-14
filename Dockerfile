FROM subosito/flutter:stable
WORKDIR /app
COPY pubspec.yaml l10n.yaml ./
COPY lib ./lib
COPY bin ./bin
RUN flutter pub get
EXPOSE 8080
CMD ["dart", "run", "bin/server.dart"]
