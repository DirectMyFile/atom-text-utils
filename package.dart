import "package:atom/builder.dart";

Menu textMenu = menu("text-utils", contextMenu: true, selector: "atom-workspace")
  .createMenu("Text Utilities");

void main() {
  package("text-utils", "1.0.0", description: "Text Utilities");

  addTextModifier("Reverse", "reverse");
  addTextModifier("Base64 Encode", "encode_base64");
  addTextModifier("Base64 Decode", "decode_base64");
  addTextModifier("Uppercase", "uppercase");
  addTextModifier("Lowercase", "lowercase");
  addTextModifier("Switchcase", "switchcase");

  build();
}

void addTextModifier(String name, String cmd) {
  textMenu.createCommand(name, "text-utils:${cmd}");
}
