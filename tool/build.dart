import "package:atom/build.dart" as build;

main(List<String> args) async {
  build.options.scanForScripts = false;
  build.scripts.addAll([
    "index.dart"
  ]);

  await build.main(args);
}
