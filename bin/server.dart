import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;

void main() async {
  final app = Router();

  app.get('/generated.zip', (Request req) async {
    // Exécuter flutter gen-l10n
    final result = await Process.run('flutter', ['gen-l10n'], workingDirectory: '/app');
    if (result.exitCode != 0) {
      return Response.internalServerError(body: 'Generation failed: ${result.stderr}');
    }

    final generatedDir = Directory('/app/lib/generated');
    if (!await generatedDir.exists()) {
      return Response.internalServerError(body: 'Generated directory not found');
    }

    final archive = Archive();
    await for (var entity in generatedDir.list(recursive: true)) {
      if (entity is File) {
        final relativePath = p.relative(entity.path, from: '/app/lib');
        final bytes = await entity.readAsBytes();
        archive.addFile(ArchiveFile(relativePath, bytes.length, bytes));
      }
    }
    final zipBytes = ZipEncoder().encode(archive);
    if (zipBytes == null) return Response.internalServerError(body: 'Zip encoding failed');

    return Response.ok(zipBytes, headers: {
      'Content-Type': 'application/zip',
      'Content-Disposition': 'attachment; filename="generated.zip"',
    });
  });

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await io.serve(app, '0.0.0.0', port);
  print('Server running on http://0.0.0.0:$port');
}
