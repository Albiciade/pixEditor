void saveImage(File image) {
  if (image == null) {
    println("Action annulée.");
  } else {
    String p = image.getAbsolutePath();
    String[] name = split(p, '\\');
    String name1 = name[name.length-1];
    img_edit.save(p);

  }
}