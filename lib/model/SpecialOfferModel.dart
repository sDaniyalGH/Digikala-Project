class SpecialOfferModel {
  var _id;
  var _name;
  var _price;
  var _discount;
  var _offPrice;
  var _imgurl;

  SpecialOfferModel(this._id, this._name, this._price, this._discount,
      this._offPrice, this._imgurl);

  get imgurl => _imgurl;
  get offPrice => _offPrice;
  get discount => _discount;
  get price => _price;
  get name => _name;
  get id => _id;

}