class Medicine {
  String name;
  String price;
  int quantity;
  String Exp;
  String ID;
  int profits;
  String note;

  Medicine(
      {this.name, this.price, this.Exp, this.ID, this.profits, this.quantity});

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'quantity': quantity,
        'profits': profits,
        'Exp': Exp,
        'ID': ID,
      };
}
