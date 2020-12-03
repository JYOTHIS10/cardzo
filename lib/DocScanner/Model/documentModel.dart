//document model for storing name,path,share link etc...

class DocumentModel{
  String name;
  String shareLink;
  String documentPath;
  DateTime dateTime;
  String pdfPath;
  DocumentModel({
    this.name,
    this.shareLink="",
    this.documentPath,
    this.dateTime,
    this.pdfPath
  });
}