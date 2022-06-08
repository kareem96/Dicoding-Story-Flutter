class DataHelper {
  final String? title;
  final String? desc;
  bool isSelected;
  final String? iconPath;
  final String? icon;
  final String? type;
  final int? id;

  DataHelper(
      {this.title,
      this.desc,
      this.isSelected = false,
      this.iconPath,
      this.icon,
      this.type,
      this.id});
}
