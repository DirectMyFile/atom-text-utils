import "dart:convert";

import "packages/atom/atom.dart";
import "packages/crypto/crypto.dart";

typedef void TextReplacer(String text);
typedef void SelectionModifier(Selection selection, String text, TextReplacer replace);

void addTextModifier(String name, SelectionModifier handler) {
  atom.commands.add("atom-workspace", "text-utils:${name}", (e) {
    var editor = atom.workspace.activeTextEditor;
    var selection = editor.lastSelection;

    if (selection.obj == null) {
      console.error("No Selection");
      return;
    }

    handler(selection, selection.text, (m) => selection.insertText(m));
  });
}

void main() {
  onPackageActivated(activate);
}

void activate() {
  addTextModifier("reverse", (selection, text, replace) {
    replace(new String.fromCharCodes(text.codeUnits.reversed));
  });

  addTextModifier("encode_base64", (selection, text, replace) {
    replace(CryptoUtils.bytesToBase64(UTF8.encode(text)));
  });

  addTextModifier("decode_base64", (selection, text, replace) {
    replace(UTF8.decode(CryptoUtils.base64StringToBytes(text)));
  });

  addTextModifier("lowercase", (selection, String text, replace) {
    replace(text.toLowerCase());
  });

  addTextModifier("uppercase", (selection, String text, replace) {
    replace(text.toUpperCase());
  });

  addTextModifier("switchcase", (selection, text, replace) {
    var x = new List<String>.generate(text.length, (i) => text[i])
    .map((it) => it.toUpperCase() == it ? it.toLowerCase() : it.toUpperCase())
    .join();

    replace(x);
  });

  addTextModifier("uppercase", (selection, text, replace) {
    replace(text.toUpperCase());
  });
}
