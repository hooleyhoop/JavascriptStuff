/* DO NOT MODIFY. This file was compiled Thu, 02 Jun 2011 18:00:53 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/shit.coffee
 */

(function() {
  ABoo.FirstGo = HooWidget.extend({
    _imgItems: void 0,
    _view: void 0,
    _count: 0,
    init: function() {
      this._super();
      this._imgItems = this.div$.find("img");
      this._imgItems.remove();
      this._view = SC.View.create();
      return this.constructTemplate();
    },
    parentDidResize: function() {
      this._count++;
      return this.constructTemplate();
    },
    constructTemplate: function() {
      var newHeight, newWidth, template, templateText;
      newWidth = this.div$.width();
      newHeight = this.div$.height();
      this._view.remove();
      templateText = "** This text compiled from template **		<div style='width:100px; height:100px; background-color:blue;'><div>		";
      template = SC.Handlebars.compile(templateText);
      this._view.set("template", template);
      return this._view.appendTo(this.div$);
    }
  });
  ABoo.HooSCLargeTextField = SC.TextField.extend({
    defaultTemplate: (function() {
      var templateText, type;
      type = SC.get(this, 'type');
      templateText = '<input type="%@" {{bindAttr value="value" placeholder="placeholder"}} width=100>';
      return SC.Handlebars.compile(templateText.fmt(type));
    }).property()
  });
  ABoo.HooSCLargeButton = SC.Button.extend({
    _count: 0
  });
  ABoo.HooSCCheckBox = SC.Checkbox.extend({
    _count: 0
  });
}).call(this);
